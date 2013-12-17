
package haxe.ui.toolkit.util;

import haxe.ui.toolkit.core.Component;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.HSlider;
import haxe.ui.toolkit.controls.VSlider;
import haxe.ui.toolkit.controls.selection.List;
import haxe.ui.toolkit.controls.CheckBox;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.core.Toolkit; 
import haxe.ui.toolkit.core.Root; 
import haxe.ui.toolkit.data.ArrayDataSource;
import haxe.ds.IntMap;
import haxe.ui.toolkit.data.ArrayDataSource;
import haxe.ui.toolkit.data.IDataSource;

import flixel.util.FlxColor;

import flash.events.MouseEvent;
import flash.events.Event;

class GUICut 
{
	private var _root:Root;
	private var _container:VBox;
	private var _rowContainer:HBox;
	private var _titleBar:HBox;
	private var _titleBarLabel:Text;
	private var _showHideBtn:Button;

	private var _containers:IntMap<Component>;
	private var _groups:IntMap<Component>;

	private var _currentContainer:Component;

	public function new(?title:String, showBtn:Bool=true):Void 
	{
		Toolkit.init();
		_root=Toolkit.openFullscreen();
		flash.Lib.current.stage.removeChild(_root.sprite);
		flash.Lib.current.stage.addChild(_root.sprite);

		createContainers();
		createTitleBar();

		if (showBtn)
			createShowBtn();
	}

	public function show():Void {
		_container.visible = true;
		_showHideBtn.text = "-";
	}

	public function hide():Void {
		_container.visible = false;
		_showHideBtn.text = "+";
	}

	private function createTitleBar(?title:String):Void
	{
		_titleBar = new HBox();

		if(title != null)
			createTitleBarLabel(title);

		_container.addChild(_titleBar);
	}

	private function createShowBtn():Void{
		_container.x = 30;

		_showHideBtn = new Button();
		_showHideBtn.percentWidth=_showHideBtn.percentHeight=3;
		_root.addChild(_showHideBtn);

		_showHideBtn.addEventListener (
			MouseEvent.CLICK,
			function(e:MouseEvent){
				trace("clicked");
				trace(_container.visible);
				_container.visible ? hide() : show();
				});

		hide();
	}

	private function createContainers():Void
	{
		_containers = new IntMap<Component>();

		_container = new VBox();
		_root.addChild(_container);

		_rowContainer = new HBox();
		_container.addChild(_rowContainer);

		_currentContainer=_rowContainer;
	}

	private function createTitleLabel(title:String):Text
	{
		var label = new Text();
		label.id = "titleLabel";
		label.text = title;
		// label.style.color = FlxColor.WHITE;
		label.style.color = 0xffffff;

		return label;
	}

	private function createTitleBarLabel(title:String):Void
	{
		_titleBarLabel = createTitleLabel(title);

		_titleBar.addChild(_titleBarLabel);
	}


    public function addComponent(type:Class<Component>, title:String, column:Int, group:Int) : Component
    {
    	var comp = Type.createInstance(type, []);

    	//currentContainer = getContainer(title, column, group);

    	return comp;
    }

    public function getContainer(?title:String, ?column:Int, ?group:Int):Component 
	{
    	// _containers.
    	// 
    	return null;
    	
    }

    public function getGroup(?title:String, ?column:Int, ?group:Int):Void {
    	// _groups.
    	
    }






	public function addColumn(?title : String) : VBox
	{
		var column:VBox = new VBox();
		column.style.padding=10;
		column.style.backgroundAlpha=0.2;
		column.style.backgroundColor=0x222521;
		// column.style.backgroundColorGradientEnd=0x484f46;
		// 
		column.paint();


		if(title != null)
			column.addChild( createTitleLabel(title) );

		_rowContainer.addChild(column);

		// _containers.add(column);
		
		_currentContainer=column;

		return column;
	}

    public function addGroup(?title : String) : HBox
    {
		var group = new HBox();

		if(title != null)
			group.addChild( createTitleLabel(title) );
		
		_rowContainer.addChild(group);

		// _groups.add(group);
		
		
		_currentContainer=group;

		return group;
    }


	public function addButton(?title:String, ?onDown:Dynamic):Button 
	{
		var btn = new Button();

		if(onDown!=null)
		{
			btn.addEventListener(
				MouseEvent.CLICK, 
				function (e:flash.events.MouseEvent)
				{
					Reflect.callMethod(this,onDown,[]);
				}
				);
		}

		if(title != null)
			btn.text = title;
			
		_currentContainer.addChild(btn);

		return btn;
	}

	public function addHSlider(min:Float=0, max:Float=100, pos:Float=0, ?title:String, ?onChange:Dynamic):HSlider 
	{
		var sliderHGroup = new HBox();
		sliderHGroup.style.percentWidth = 100;

		var slider = new HSlider();
		slider.min = min;
		slider.max = max;
		slider.pos = pos;
		slider.style.percentWidth = 70;

		var label = createTitleLabel(Std.string(pos));
		label.style.percentWidth = 30;

		if(title != null)
			_currentContainer.addChild(createTitleLabel(title));

		if(onChange!=null)
		{
			slider.addEventListener(
				Event.CHANGE, 
				function (e:Event)
				{
					Reflect.callMethod(this,onChange,[slider]);
					label.text = Std.string(slider.pos);
				}
			);
		}

		sliderHGroup.addChild(label);
		sliderHGroup.addChild(slider);

		_currentContainer.addChild(sliderHGroup);

		return slider;
	}

	public function addCheckBox(title:String, ?onChange:Dynamic):CheckBox {
		var check = new CheckBox();
		check.text = title;
		check.style.width=100;
		check.style.height=100;
		check.style.backgroundColor=0xb7c9b2;

		// if(title != null)
			// _currentContainer.addChild( createTitleLabel(title) );

		if (onChange!=null)
		{
			check.addEventListener(
				Event.CHANGE, 
				function (e:Event)
				{
					Reflect.callMethod(this,onChange,[check]);
				}
			);
		}

		_currentContainer.addChild(check);

		return check;
	}

	public function addDropDown(title:String, defaultItem:String, data:IDataSource, ?onChange:Dynamic):List 
	{
		var title = createTitleLabel(title);
		_currentContainer.addChild(title);

		var list = new List();

		list.text= defaultItem;
		list.width=200;
		
		if (data!=null)
			list.dataSource = data;

		if (onChange!=null)
		{
			list.addEventListener(
				Event.CHANGE, 
				function (e:Event)
				{
					Reflect.callMethod(this,onChange,[list]);
				}
			);
		}

		_currentContainer.addChild(list);

		return list;
	}

	public function addNumericStepper(title:String, current:Int, min:Int, max:Int, step:Float=1, ?onChange:Dynamic):Void 
	{
		var title = createTitleLabel(title);
		_currentContainer.addChild(title);

		var value:Float = current;

		var display = new Text();
		display.text = Std.string(value);
		display.style.percentWidth = 40;
		display.style.color = 0xffffff;

		var increase = new Button();
		increase.style.percentWidth = 30;
		increase.text="+";

		var decrease = new Button();
		decrease.style.percentWidth = 30;
		decrease.text="-";

		var hbox = new HBox();

		hbox.addChild(display);
		hbox.addChild(increase);
		hbox.addChild(decrease);
		
		_currentContainer.addChild(hbox);

		decrease.addEventListener(
			MouseEvent.CLICK, 
			function (e:MouseEvent)
			{
				value-=step;
				display.text = Std.string(value);

				if (onChange!=null)
					Reflect.callMethod(this,onChange,[value]);
			}
		);

		increase.addEventListener(
			MouseEvent.CLICK, 
			function (e:MouseEvent)
			{
				value+=step;
				display.text = Std.string(value);

				if (onChange!=null)
					Reflect.callMethod(this,onChange,[value]);
			}
		);
	}


}