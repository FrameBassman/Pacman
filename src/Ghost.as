package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.Shape;
	
	import flash.geom.*;
	
	public class Ghost extends Sprite
	{
		public var ghostY:Number = 210;
		public var ghostX:Number = 210;
		private var start:Number = 200;
		
		private var directX:Number = 1;
		private var directY:Number = 0;
		private var size:Number = 30;
		
		private var map:MapMatrix;
		
		public function Ghost(map:MapMatrix) 
		{
			this.map = map;

			this.addEventListener(Event.ENTER_FRAME, this.moveMob);
		}

		public function moveMob(event:Event):void {
			var x:Number = Math.random();
			var y:Number = Math.random();
			this.graphics.clear();
			this.start -= 0.1;
			this.ghostX -= 10;
			this.ghostY -= 10;

			var speed:Number = 1;
			
			// перешли в следующую клетку
			if ((this.ghostX % 20 < 1) && (this.ghostY % 20 < 1)) {
				
				var currentX:Number = this.ghostX * 30 / 20;
				var currentY:Number = (this.ghostY / 20) % 30;
				var top:Number = currentX + currentY + speed;
				var bottom:Number = currentX + currentY - speed;
				var right:Number = currentX + currentY + speed * this.size;
				var left:Number = currentX + currentY - speed * this.size;
				
				left = left < 0 ? 30 : left;
				bottom = bottom < 0 ? 30 : bottom;

				top = this.map.matrix[top] < 0.5 ? top : currentX + currentY;
				bottom = this.map.matrix[bottom] < 0.5 ? bottom : currentX + currentY;
				right = this.map.matrix[right] < 0.5 ? right : currentX + currentY;
				left = this.map.matrix[left] < 0.5 ? left : currentX + currentY;
				
				this.map.matrix[currentX + currentY] = this.map.matrix[currentX + currentY] > 0 ? 10: this.map.matrix[currentX + currentY] - 1;
				
				var nextPos:Number = Math.max(this.map.matrix[top], this.map.matrix[bottom], this.map.matrix[right], this.map.matrix[left]);
				
				if (top != currentX + currentY && Math.abs(nextPos - this.map.matrix[top]) < 0.001) {
					this.directX = 0;
					this.directY = speed;
				} else if (bottom != currentX + currentY && Math.abs(nextPos - this.map.matrix[bottom]) < 0.001) {
					this.directX = 0;
					this.directY = -speed;
				} else if (left != currentX + currentY && Math.abs(nextPos - this.map.matrix[left]) < 0.001) {
					this.directX = -speed;
					this.directY = 0;
				} else if (right != currentX + currentY && Math.abs(nextPos - this.map.matrix[right]) < 0.001) {
					this.directX = speed;
					this.directY = 0;
				}
			}
			this.ghostX += 10;
			this.ghostY += 10;
			this.ghostX += this.directX * 2;
			this.ghostX = this.ghostX < 30 ? 30 : this.ghostX < this.size * 20 - 30 ? this.ghostX : this.size * 20 - 30;
			this.ghostY += this.directY * 2;
			this.ghostY = this.ghostY < 30 ? 30 : this.ghostY < this.size * 20 - 30 ? this.ghostY : this.size * 20 - 30;
			if (Math.abs(this.ghostY / 20 % 30 - (this.size - 1)) < 0.001) {
				this.directY *= -1;
			}
			if (Math.abs(this.ghostX / 20 - (this.size - 1)) < 0.001) {
				this.directX *= -1;
			}
			this.graphics.beginFill(0x12300a1);
			this.graphics.drawCircle(this.ghostX, this.ghostY, 10);
			this.graphics.endFill();
		}
		
		private function changeDirect(z:Number):Number {
			var a:Number = z - 1;
			
			a = z < 0 ? 1: z - 1;
						
			return a;
		}
	}
}