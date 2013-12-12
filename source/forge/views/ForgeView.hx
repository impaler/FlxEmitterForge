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
		gui.addDropDown("Blend Modes", ForgeController.instance.model.getBlendModes(), changeBlendMode);
		gui.addHSlider(0,600,"Size", changeParticleSize).pos = ForgeController.instance.model.particleSize;
		// gui.addCheckBox("Explode", changeExplode);

	}

	public function addedEmitter(emitter:flixel.effects.particles.FlxEmitterExt):Void 
	{
		FlxG.state.add(emitter);
		FlxG.log.add(emitter.length);

		// emitter.start( false, 2, 0.1, 300 );
		emitter.start( ForgeController.instance.model.explode, 0, 0.1, 300 );

		// emitter.emitParticle()

		// FlxG.state.add(forgeEmitter.emitter);
	}

	public function removedEmitter(emitter:Dynamic):Void 
	{
		// FlxG.state.remove(forgeEmitter.emitter);
	}	







	private inline function changeExplode(checkBox:CheckBox):Void 
	{
		ForgeController.instance.model.explode=checkBox.selected;
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
		ForgeController.instance.model.particleSize=Std.int(slider.pos);
	}


}