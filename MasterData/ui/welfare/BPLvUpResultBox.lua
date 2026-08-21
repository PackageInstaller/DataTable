-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\BPLvUpResultBox.lua

local strClassName = "BPLvUpResultBox"
local BPLvUpResultBox = Class(strClassName, UIControls.Window)

function BPLvUpResultBox:ctor()
	self.txtTitle = UIControls.Label(self, "Bg/TextTitle")
	self.txtPre = UIControls.Label(self, "Bg/TextLvPre")
	self.txtNext = UIControls.Label(self, "Bg/TextLvNext")
	self.txtPre1 = UIControls.Label(self, "Bg/TextLvPre1")
	self.txtNext1 = UIControls.Label(self, "Bg/TextLvNext1")
end

function BPLvUpResultBox:onShow(pre, next)
	self.txtPre:setVisible(true)
	self.txtNext:setVisible(true)
	self.txtPre1:setVisible(false)
	self.txtNext1:setVisible(false)
	self.txtPre:setText(pre)
	self.txtNext:setText(next)
end

function BPLvUpResultBox:onShowNewText(title, pre, next)
	self.txtTitle:setText(title)
	self.txtPre:setVisible(false)
	self.txtNext:setVisible(false)
	self.txtPre1:setVisible(true)
	self.txtNext1:setVisible(true)
	self.txtPre1:setText(pre)
	self.txtNext1:setText(next)
end

return BPLvUpResultBox
