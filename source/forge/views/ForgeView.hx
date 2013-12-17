package forge.views;

import haxe.ui.toolkit.util.GUICut;
import haxe.ui.toolkit.data.ArrayDataSource;
import haxe.ui.toolkit.data.IDataSource;
import haxe.ui.toolkit.controls.selection.List;
import haxe.ui.toolkit.controls.HSlider; 
import haxe.ui.toolkit.controls.CheckBox; 

import flash.display.BlendMode;
import forge.ForgeController;
import flixel.FlxG;

class ForgeView 
{
	private var gui:GUICut;

	public function new():Void 
	{
		gui = new GUICut ( "FlxEmitter Forge" );

		gui.addColumn("Emitters");

		gui.addButton( "Add", ForgeController.instance.addEmitter );
		
		gui.addButton( "Remove", ForgeController.instance.removeEmitter );


		gui.addDropDown("Blend Modes", ForgeController.instance.model.blend.getName(), ForgeController.instance.model.getBlendModes(), changeBlendMode);

		gui.addHSlider(0,600,"Size", changeParticleSize).pos = ForgeController.instance.model.particleSize;
		// gui.addCheckBox("Explode", changeExplode);
		
		gui.addNumericStepper( "Start Size" , 1 , 0 , 100 , 0.1 , changeStartScale );
		gui.addNumericStepper( "End Size" , 1 , 0 , 100 , 0.1 , changeEndScale );

		gui.addNumericStepper( "Distance" , 40 , 0 , 100 , 1 , changeDistance );
		gui.addNumericStepper( "Distance Range" , 40 , 0 , 100 , 1 , changeDistanceRange );

		gui.addNumericStepper( "Start Alpha" , 1 , 0 , 100 , 0.1 , changeStartAlpha );
		gui.addNumericStepper( "End Alpha" , 1 , 0 , 100 , 0.1 , changeEndAlpha );

	}

	public function addedEmitter(emitter:flixel.effects.particles.FlxEmitterExt):Void 
	{
		
		//FlxG.log.add(emitter.length);

		// emitter.start( false, 2, 0.1, 300 );
		//emitter.start( ForgeController.instance.model.explode, 0, 0.1, 300 );
		// emitter.start( ?Explode : Bool , ?Lifespan : Float , ?Frequency : Float , ?Quantity : Int , ?LifespanRange : Float )
		


		// emitter.start(false, 3, .01);
		// emitter.start( ?Explode : Bool , ?Lifespan : Float , ?Frequency : Float , ?Quantity : Int , ?LifespanRange : Float );
		
		emitter.start(false, 10, .01);
		// emitter.start( ?Explode : Bool , ?Lifespan : Float , ?Frequency : Float , ?Quantity : Int , ?LifespanRange : Float );
	}

	private inline function changeEndScale(value:Float):Void 
	{
		ForgeController.instance.changeEndScale( value, value );
	}

	private inline function changeStartScale(value:Float):Void 
	{
		ForgeController.instance.changeStartScale( value, value );
	}

	private inline function changeEndAlpha(value:Float):Void 
	{
		ForgeController.instance.changeEndAlpha( value, value );
	}

	private inline function changeStartAlpha(value:Float):Void 
	{
		ForgeController.instance.changeStartAlpha( value, value );
	}

	private inline function changeDistance(value:Float):Void 
	{
		ForgeController.instance.changeDistance( value );
	}

	private inline function changeDistanceRange(value:Float):Void 
	{
		ForgeController.instance.changeDistance( value );
	}

	private inline function changeExplode(checkBox:CheckBox):Void 
	{
		ForgeController.instance.changeExplode ( checkBox.selected );
	}

	private inline function changeBlendMode(list:List):Void 
	{
		for ( item in list.selectedItems )
		{
			forge.ForgeController.instance.changeBlendMode(item.data.data);
		}
	}

	private inline function changeParticleSize(slider:HSlider):Void 
	{
		ForgeController.instance.chageParticleSize(Std.int(slider.pos));
	}


}