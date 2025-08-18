-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\TestDragDlg.lua

local DragObject = require("UI/Control/Com/DragObject")
local strClassName = "DragDlg"
local DragDlg = Class(strClassName, UIControls.Window)

function DragDlg:ctor()
	self.senser = UIControls.Panel(self, "Button")
	self.senser.idx = 1

	self.senser:addEventDragOnGet(self.onDragGet)

	self.objects = {}
end

function DragDlg:onDragGet(sender)
	local obj = DragObject()

	self.objects[sender.idx] = obj
end

return DragDlg
