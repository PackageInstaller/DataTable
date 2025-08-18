-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\MaterialItemGridChild.lua

local GridItemMixin = require("UI/Common/Grid/Mixin/GridItemMixin")
local ResColor = require("ClientData/ResColor")
local MaterialItemAddChild = Class("MaterialItemAddChild", UIControls.Child)

function MaterialItemAddChild:ctor()
	if UIControls.checkControlFunc(self, "Text") then
		self.textAdd = UIControls.Label(self, "Text")
	end
end

local MaterialItemGridChild = Class("MaterialItemGridChild", UIControls.ItemGridChild)

function MaterialItemGridChild:ctor()
	self:ctorMixin()

	self.imgAdd2 = UIControls.Panel(self, "ImgAdd2")
end

function MaterialItemGridChild:setMaterial(materialItemId, needCount)
	local materialItem = BaseObject.GetObject(materialItemId)

	self:setObj(materialItem)

	local curCount = CurAvatar:getItemNumById(materialItemId)

	self.textNum:setText(ClientUtils.getNumShortStr(curCount) .. "/" .. ClientUtils.getNumShortStr(needCount))

	local color = needCount <= curCount and ResColor.BLACK or ResColor.RED

	self.textNum:setFontColor(color)

	return needCount <= curCount
end

function MaterialItemGridChild:setFakeMaterial(materialItemId, count)
	local materialItem = BaseObject.GetObject(materialItemId, count)

	self:setObj(materialItem)
	self.textNum:setText(count)
end

function MaterialItemGridChild:setAddPanel(panelIdx)
	if self.addPanel then
		self.addPanel:destroy()
	end

	self.addPanel = MaterialItemAddChild(self, "ImgAdd2", "System/Common/Grid/AddPanel" .. panelIdx, 0, 0, true)
end

function MaterialItemGridChild:destroyAddPanel()
	if self.addPanel then
		self.addPanel:destroy()
	end
end

function MaterialItemGridChild:setAddPanelRoom()
	if self.addPanel then
		self.addPanel:destroy()
	end

	self.addPanel = UIControls.Child(self, "ImgAdd2", "System/HeroShowRoom/AddPanelShowRoom", 0, 0, true)
	self.addPanelClean = UIControls.Panel(self, "ImgAdd2/AddPanelShowRoom/CleanPanel")
	self.addPanelLock = UIControls.Panel(self, "ImgAdd2/AddPanelShowRoom/LockPanel")
end

return MaterialItemGridChild
