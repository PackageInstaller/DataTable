-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridPetHeadMixin.lua

local GridPetHeadMixin = {}

function GridPetHeadMixin:ctorMixin()
	self.redDot = UIControls.Panel(self, "IconNew")
	self.itemCell = UIControls.ItemGridChild(self, "HeadPanel", "System/Common/Grid/GridMaterialItem")
	self.itemCell.mEnableTips = false
	self.btnAdd = UIControls.Button(self, "")

	self.btnAdd:addEventClick(self.onClickBtnAdd)

	self.slotOnClickBtnAdd = Slot(self.onClickBtnAdd, self)
end

function GridPetHeadMixin:init(clickCb)
	self.clickCb = clickCb
	self.itemCell.mEventClick = self.slotOnClickBtnAdd
end

function GridPetHeadMixin:setData(pet)
	self.pet = pet

	self.itemCell:setVisible(self.pet ~= nil)

	if self.pet then
		self.itemCell:setObj(self.pet)
	end
end

function GridPetHeadMixin:setBtnAddEnable(value)
	self.btnAdd:setEnable(value)
end

function GridPetHeadMixin:setRed(value)
	self.redDot:setVisible(value)
end

function GridPetHeadMixin:onClickBtnAdd()
	if self.clickCb then
		self.clickCb(self)
	end
end

return GridPetHeadMixin
