-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\CommonCell\\BtnChooseEquipSet.lua

local ResEquipSuit = require("ClientData/ResEquipSuit")
local BtnChooseEquipSet = Class("BtnChooseEquipSet", UIControls.Child)

function BtnChooseEquipSet:ctor()
	self:initUI()
end

function BtnChooseEquipSet:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.txtName = UIControls.Label(self, "TextName")
	self.imgSelf = UIControls.Image(self, "Icon")
end

function BtnChooseEquipSet:onBtnSelfClick()
	if self.mEventClick then
		self.mEventClick(self)
	end
end

function BtnChooseEquipSet:setSuitInfo(suitId)
	self.suitInfo = ResEquipSuit[suitId]

	self.txtName:setText(self.suitInfo.name)
	self.imgSelf:setImage(UIConst.COMMON_ICON_PATH .. self.suitInfo.big_icon_path, self.suitInfo.big_icon)
end

return BtnChooseEquipSet
