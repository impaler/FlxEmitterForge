package forge.states;

import flixel.FlxG;
import flixel.FlxState;
import forge.ForgeController;

class ForgeState extends FlxState
{

	override public function create():Void
	{
        // FlxG.cameras.bgColor = flixel.util.FlxColor.WHITE;
		FlxG.cameras.bgColor = 0xff131c1b;

        FlxG.mouse.useSystemCursor = true;
        FlxG.mouse.show();

        ForgeController.init();

        FlxG.log.add(flash.Lib.current.stage.numChildren);

        // var current = flash.Lib.current.stage.getChildAt(0);
        // flash.Lib.current.stage.setChildIndex(current, flash.Lib.current.stage.numChildren-1);
	}

    override public function update():Void
    {
        ForgeController.instance.update();

        super.update();
    }   

	override public function destroy():Void
	{
		ForgeController.destroy();
	}

}


