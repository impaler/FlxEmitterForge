
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
	public var emitters:FlxTypedGroup<FlxEmitterExt>;

	public var blend:BlendMode;
	public var particleCount:Int;
	public var position:String;
	public var particleSize:Int;
	public var particleType:Class<FlxParticle>;
	public var availableBlendModes:ArrayDataSource;
	public var distance:Float;
	public var distanceRange:Float;
	public var explode:Bool;
	public var startScale:Bounds<Float>;
	public var endScale:Bounds<Float>;
	public var startAlpha:Bounds<Float>;
	public var endAlpha:Bounds<Float>;

	public function new():Void 
	{
		emitters=new FlxTypedGroup<FlxEmitterExt>();
		FlxG.state.add(emitters);

		blend = BlendMode.ADD;
		particleCount=100;
		particleSize=120;
		position="center";
		particleType = forge.objects.GradientParticle;
		availableBlendModes=getBlendModes();
		startScale = new Bounds<Float>(1, 1);
		endScale = new Bounds<Float>(1, 1);
		startAlpha = new Bounds<Float>(1, 1);
		endAlpha = new Bounds<Float>(0, 0);

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

		emitter.startAlpha = startAlpha;
		emitter.endAlpha = endAlpha;
		emitter.setXSpeed(-40, 40);
		emitter.setYSpeed(40, 40);
		emitter.distance=distance;
		emitter.distanceRange=distanceRange;
		emitter.startScale=startScale;
		emitter.endScale=endScale;
        
        var i = 0;
        while (i < particleCount)
        {
        	var particle= cast (Type.createInstance(particleType, [particleSize]), FlxParticle);
        	particle.useFading=true;
        	particle.useScaling=true;
        	particle.useColoring=true;

            emitter.add(particle);

            i++;
        }

		emitters.add(emitter);

        return emitter;
	}

	public function removeEmitter(?name:String):Void 
	{
		for ( emitter in emitters.members )
		{
			emitters.remove(emitter);
			emitter.destroy();
			emitter=null;
		}
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
		blend = mode;

		if (emitters.members[0]!=null)
		{		
			for ( emitter in emitters.members )
			{
				emitter.blend = blend;
			}
		}
	}

	public function changeStartScale(min:Float, max:Float):Void 
	{
		startScale.min = min;
		startScale.max = max;

		if (emitters.members[0]!=null)
		{		
			for ( emitter in emitters.members )
			{
				emitter.startScale.min=min;
				emitter.startScale.max=max;
			}
		}
	}

	public function changeEndScale(min:Float, max:Float):Void 
	{
		endScale.min = min;
		endScale.max = max;

		if (emitters.members[0]!=null)
		{		
			for ( emitter in emitters.members )
			{
				emitter.endScale.min=min;
				emitter.endScale.max=max;
			}
		}
	}

	public function changeEndAlpha(min:Float, max:Float):Void 
	{
		endAlpha.min = min;
		endAlpha.max = max;

		if (emitters.members[0]!=null)
		{		
			for ( emitter in emitters.members )
			{
				emitter.endAlpha.min=min;
				emitter.endAlpha.max=max;
			}
		}
	}

	public function changeStartAlpha(min:Float, max:Float):Void 
	{
		startAlpha.min = min;
		startAlpha.max = max;

		if (emitters.members[0]!=null)
		{		
			for ( emitter in emitters.members )
			{
				emitter.startAlpha.min=min;
				emitter.startAlpha.max=max;
			}
		}
	}

	public function changeExplode(value:Bool):Void 
	{
		explode = value;
	}

	public function chageParticleSize(value:Int):Void 
	{
		particleSize=value;
	}

	public function changeDistance(distance:Float):Void 
	{
		this.distance = distance;

		if (emitters.members[0]!=null)
		{		
			for ( emitter in emitters.members )
			{
				emitter.distance = distance;
			}
		}
	}

	public function changeDistanceRange(distance:Float):Void 
	{
		this.distanceRange = distance;

		if (emitters.members[0]!=null)
		{		
			for ( emitter in emitters.members )
			{
				emitter.distanceRange = distance;
			}
		}
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