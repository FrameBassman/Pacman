var http = require('http');
var fs = require('fs');
//var redis = require('redis');

var context = (function(){
  var SaveLoadKey = "SaveLoadGameKey";
  var client = redis.createClient();
  var self = this;
  var userName;

  client.on('error', function(err){
    console.log('Error: ' + err);
  });

  var addGamer = function(name){
    client.set('string key', name, redis.print);
  };

  var _addScore = function(name, score){
    if (name == SaveLoadKey){
      return;
    }

    console.log('Info: add ' + name + ':' + score);
    client.set(name, score);
  };

  var _setUserName = function(name){
    userName = name;
  }

  var _getTableResults = function(callback){
    var result = '';

    client.keys('*', function(err, keys){
      console.log('result table: \n');
      
      keys.forEach(function(key, i){
        client.get(key, function (err, reply){
          if (err){
            console.log('Error: ' + err);
          }

          if (key != SaveLoadKey){
            result += key + ' : ' + reply + '\n';
        
            console.log(result + '\n');
            if (i + 2 == keys.length) {
              callback(result);
            }
          }
        });
      });
  
    });
  };

  var _onSaveGameHandler = function(gameStateJSON, callback){
    console.log('Info[save game]: ' + gameStateJSON);
    client.set(SaveLoadKey + userName, gameStateJSON);
    callback('');
  };

  var _onLoadGameHandler = function(callback){
    var a = client.get(SaveLoadKey + userName, function(key_null, value){
      console.log('Info[load game]: ' + value);

      callback(value ? value : '');
    });
      console.log('Info[load game](a): ' + a);

  };

  return {
    addScore: _addScore,
    getTableResults: _getTableResults,
    saveGame: _onSaveGameHandler,
    loadGame: _onLoadGameHandler,
    setUserName: _setUserName
  };
});

var server = http.createServer(function (req, res) {
  
  console.log(req.url);
    fs.readFile(__dirname + req.url, function(err, data){
      console.log('error: ' + err);
      
      console.log('file: ' + req.url + ' loading..');
      console.log('file/: ' + req.url.split('/') + ' loading..');
      console.log('file:[0] ' + req.url.split('/')[1] + ' loading..');
     
      var callback = function (table){

            console.log("/result: " + table + ':' + table.length);
            res.writeHead(200, {
              'Content-Length': table.length,
              'Content-Type': 'text/plain' });
  
            res.end(table, 'utf8');            
      };

      switch(req.url.split('/')[1]){
        case "img":///game-over-black-wallpaper.jpg" :
          res.writeHead(200, {
          'Content-Length': 151781,
          'Content-Type': 'image/jpg'});

          res.end(data);
          break;
        case "map.txt":
          res.writeHead(200, {
            'Content-Length': 2729,
            'Content-Type': 'text/plain' });
 
          res.end(data, 'utf8');
          break;

        case "result":
          context.getTableResults(callback);
          break;

        case "add":
          context.addScore(req.url.split('/')[2], req.url.split('/')[3], function(){
            context.getTableResults(callback);
          });
            context.getTableResults(callback);
          break;
        case "save":
          context.setUserName(req.url.split('/')[3]);
          context.saveGame(req.url.split('/')[2], callback);
          break;
        case "load":
          console.log('Info[start loading game]: ');
          context.setUserName(req.url.split('/')[2]);

          context.loadGame(callback);
          break;
        default:{         
          res.writeHead(200, { 'Content-Length': 0 });
          res.end();
        }
      }
    });
});

server.listen(1444);
console.log('server started on 1444 port');