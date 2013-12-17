package forge.states;

import flixel.FlxG;
import flixel.FlxState;
import forge.ForgeController;

class ForgeState extends FlxState
{

	override public function create():Void
	{
		FlxG.cameras.bgColor = 0xff131c1b;

        FlxG.mouse.useSystemCursor = true;

        ForgeController.init();
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


