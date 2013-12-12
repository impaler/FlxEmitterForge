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

	public function startEmitter():Void
	{
		
	}


	public function addEmitter(?name:String, ?settings:String):Void 
	{
		// update view gui
		var emit = model.addEmitter();
		view.addedEmitter(emit);
		
	}

	public function getEmitter(?name:String):Void 
	{
		
	}	

	public function changeBlendMode(blend:flash.display.BlendMode):Void
	{	
		model.changeBlendMode(blend);	
	}

	public function update():Void 
	{
		
	}

	public static function destroy():Void
	{
	}

}
