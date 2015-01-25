var testCase  = require('nodeunit').testCase;

var assert = require('assert'),
    http = require('http');

describe('/', function () {
  it('should return 200', function (done) {
    http.get('http://localhost:1444/', function (res) {
      assert.equal(200, res.statusCode);
      done();
    });
  });

  it('should have length 2729', function (done) {
    http.get('http://localhost:1444/map.txt', function (res) {
      var data = '';

      res.on('data', function (chunk) {
        data += chunk;
      });

      res.on('end', function () {
        assert.equal(2729, data.length);
        done();
      });
    });
  });

  it('save test', function (done) {
    http.get('http://localhost:1444/save/test/test', function (res) {
        assert.equal(200, res.statusCode);
        done();
    });
  });


  it('save test2', function (done) {
    http.get('http://localhost:1444/save/test2/test2', function (res) {
        assert.equal(200, res.statusCode);
        done();
    });
  });

  it('load test == test', function (done) {
    http.get('http://localhost:1444/load/test', function (res) {
      var data = '';

      res.on('data', function (chunk) {
        data += chunk;
      });

      res.on('end', function () {
        assert.equal('test', data);
        done();
      });
    });
});

  it('load test2 == test2', function (done) {
    http.get('http://localhost:1444/load/test2', function (res) {
      var data = '';

      res.on('data', function (chunk) {
        data += chunk;
      });

      res.on('end', function () {
        assert.equal('test2', data);
        done();
      });
    });
  });  


    it('load test != test', function (done) {
        http.get('http://localhost:1444/load/test', function (res) {
            var data = '';

            res.on('data', function (chunk) {
                data += chunk;
            });

            res.on('end', function () {
                assert.notEqual('test2', data);
                done();
            });
        });
    });

    it('add new result', function (done) {
        http.get('http://localhost:1444/add/test3/1', function (res) {
            assert.equal(200, res.statusCode);
            done();
        });
    });

    it('get result', function (done) {
        http.get('http://localhost:1444/result', function (res) {
            var data = '';

            res.on('data', function (chunk) {
                data += chunk;
            });

            res.on('end', function () {
                assert.notEqual(0, data.length);
                done();
            });
        });
    });    
});