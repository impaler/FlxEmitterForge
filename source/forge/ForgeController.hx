package forge;

import forge.views.ForgeView;
import forge.model.ForgeModel;

import flixel.effects.particles.FlxEmitterExt;
import flixel.FlxG;

class ForgeController
{

	public var model:ForgeModel;
	public var view:ForgeView;

	public static var instance:ForgeController;

	public static function init():Void
	{
		if (instance==null)
		{
			instance=new forge.ForgeController();
			instance.model = new ForgeModel();
			instance.view = new ForgeView();
		}
	}

	public function new():Void {}

	public function addEmitter(?name:String, ?settings:String):Void 
	{
		var emit = model.addEmitter();
		view.addedEmitter(emit);
	}

	public function removeEmitter(?name:String):Void 
	{
		model.removeEmitter(name);	
	}	


	/**
	 * The exposed parametors for emitters
	 */

	public function changeBlendMode(blend:flash.display.BlendMode):Void
	{	
		model.changeBlendMode(blend);	
		// view.changeBlendMode(blend);	
	}

	public function changeStartScale(min:Float, ?max:Float):Void 
	{
		if(max==null) max=min;

		ForgeController.instance.model.changeStartScale( min, max );
	}

	public function changeEndScale(min:Float, ?max:Float):Void 
	{
		if(max==null) max=min;
		
		ForgeController.instance.model.changeEndScale( min, max );
	}

	public function changeEndAlpha(min:Float, ?max:Float):Void 
	{
		if(max==null) max=min;
		
		ForgeController.instance.model.changeEndAlpha( min, max );
	}

	public function changeStartAlpha(min:Float, ?max:Float):Void 
	{
		if(max==null) max=min;
		
		ForgeController.instance.model.changeStartAlpha( min, max );
	}

	public function changeExplode(value:Bool):Void 
	{
		ForgeController.instance.model.changeExplode( value );
	}

	public function chageParticleSize(value:Int):Void 
	{
		ForgeController.instance.model.chageParticleSize( value );
	}

	public function changeDistance(distance:Float):Void 
	{
		ForgeController.instance.model.changeDistance( distance );
	}

	public function changeDistanceRange(value:Float):Void 
	{
		ForgeController.instance.model.changeDistanceRange( value );
	}


	public function update():Void 
	{
		
	}

	public static function destroy():Void
	{
	}

}
