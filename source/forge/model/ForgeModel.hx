
package forge.model;

import flixel.group.FlxTypedGroup;
import flixel.effects.particles.FlxTypedEmitter.Bounds;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxEmitterExt;
import flixel.FlxG;
import flash.display.BlendMode;
import haxe.ui.toolkit.data.ArrayDataSource;

class ForgeModel 
{
	public var emitters:FlxTypedGroup<flixel.FlxBasic>;
	public var blend:BlendMode;
	public var particleCount:Int;
	public var position:String;
	public var particleSize:Int;
	public var particleType:Class<FlxParticle>;
	public var availableBlendModes:ArrayDataSource;
	public var distance:Int;
	public var distanceRange:Int;
	public var explode:Bool;

	public function new():Void 
	{
		emitters=new FlxTypedGroup<flixel.FlxBasic>();
		blend = BlendMode.ADD;
		particleCount=100;
		particleSize=120;
		position="center";
		particleType = forge.objects.GradientParticle;
		availableBlendModes=getBlendModes();

		distance=40;
		distanceRange=40;
		explode=false;
	}

	public function addEmitter():FlxEmitterExt
	{

		var xPos:Float = 0;
		var yPos:Float = 0;

		if (position=="center")
		{
			xPos = FlxG.width/2;
			yPos = FlxG.height/2;
		}


		var emitter = new FlxEmitterExt(xPos, yPos, particleCount);
		emitter.blend = blend;

		emitter.startAlpha = new Bounds<Float>(1, 1);
		emitter.endAlpha = new Bounds<Float>(0, 0);
		emitter.setXSpeed(-4, 4);
		emitter.setYSpeed(4, 4);
		emitter.distance=distance;
		emitter.distanceRange=distanceRange;
        
        var i = 0;
        while (i < particleCount)
        {
        	var particle= cast (Type.createInstance(particleType, [particleSize]), FlxParticle);
        	particle.useFading=true;
            emitter.add(particle);

            i++;
        }

		emitters.add(emitter);
        return emitter;
	}

	public function removeEmitter(name:String):Void 
	{
	}

	public function getEmitter(?name:String):FlxEmitterExt 
	{
		if (name==null)
		{
			return cast emitters.getFirstAvailable();
		} else {
			return null;
		}
	}

	public function changeBlendMode(mode:BlendMode, ?emitter:FlxEmitterExt):Void
	{
		if (emitter==null)
		{
			for ( emitter in emitters.members )
			{
				var emitterFlxExt:FlxEmitterExt = cast emitter;
				emitterFlxExt.blend = mode;
			}
		} else {
			emitter.blend = mode;
		}

		blend = mode;

	}

	public function getBlendModes():ArrayDataSource 
	{
		var blendModes = new ArrayDataSource();

		//cpp supported
		blendModes.add( { text:"ADD", data:BlendMode.ADD } );
		blendModes.add( { text:"MULTIPLY", data:BlendMode.MULTIPLY } );
		blendModes.add( { text:"SCREEN", data:BlendMode.SCREEN } );

		#if flash
		blendModes.add( { text:"DARKEN", data:BlendMode.DARKEN } );
		blendModes.add( { text:"DIFFERENCE", data:BlendMode.DIFFERENCE } );
		blendModes.add( { text:"ALPHA", data:BlendMode.ALPHA } );
		blendModes.add( { text:"ERASE", data:BlendMode.ERASE } );
		blendModes.add( { text:"HARDLIGHT", data:BlendMode.HARDLIGHT } );
		blendModes.add( { text:"INVERT", data:BlendMode.INVERT } );
		blendModes.add( { text:"LAYER", data:BlendMode.LAYER } );
		blendModes.add( { text:"LIGHTEN", data:BlendMode.LIGHTEN } );
		blendModes.add( { text:"OVERLAY", data:BlendMode.OVERLAY } );
		blendModes.add( { text:"SHADER", data:BlendMode.SHADER } );
		blendModes.add( { text:"SUBTRACT", data:BlendMode.SUBTRACT } );
		#end

		blendModes.add( { text:"NORMAL", data:BlendMode.NORMAL } );

		return blendModes;
	}



	public function destroy():Void
	{
		emitters.destroy();
	}

}