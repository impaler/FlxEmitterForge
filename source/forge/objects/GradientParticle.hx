
package forge.objects;

import flash.geom.Matrix;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.SpreadMethod;
import flash.display.InterpolationMethod;

import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;
import flixel.effects.particles.FlxParticle;

class GradientParticle extends FlxParticle
{
    public function new(?size:Int)
    {
        super();

        if(size==null)
            size=300;

        var tempBitmap:flash.display.Bitmap = new Bitmap(new BitmapData(size, size, true,  FlxColor.TRANSPARENT));
        var matrix = new Matrix();
        // tempBitmap.bitmapData.perlinNoise(20,20,3,4,true,true);
        tempBitmap.bitmapData.draw(radialGradientCircle(size),matrix,null,null,null,true);
        this.loadGraphic(tempBitmap.bitmapData);
    }

    public static function radialGradientCircle(radius:Float):Sprite
    {
        var gradient_mc=new Sprite();
        var color = FlxColorUtil.getRandomColor();
        var colors = [color, color, color];
        var alphas = [100, 10, 0];
        var ratios = [0, 1, 255];
        var fillType = GradientType.RADIAL; 
        var spreadMethod = SpreadMethod.PAD;
        var interpolationMethod = InterpolationMethod.RGB;
        var focalPointRatio = 0;

        var matrix = new Matrix();
        matrix.createGradientBox(radius, radius, 0, 0, 0);

        gradient_mc.graphics.beginGradientFill(
            fillType, colors, alphas, ratios, matrix, 
            spreadMethod, interpolationMethod, focalPointRatio
        );

        gradient_mc.graphics.drawCircle(0,0,radius*2);
        gradient_mc.graphics.endFill();

        return gradient_mc;
    }
}