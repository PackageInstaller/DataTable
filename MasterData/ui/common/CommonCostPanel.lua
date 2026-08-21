-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\CommonCostPanel.lua

local CommonCostPanel = Class("CommonCostPanel", UIControls.Panel)

function CommonCostPanel:ctor()
	self:initUI()
end

function CommonCostPanel:initUI()
	self.imgCostItem = UIControls.Image(self, self.mPath .. "/Icon")
	self.textCost = UIControls.Label(self, self.mPath .. "/TextNum")
end

function CommonCostPanel:setItem(itemID, needNum)
	local nowNum = ClientUtils.getMoney(itemID)

	self.textCost:setText(ClientUtils.getNumShortStr(needNum) .. "/" .. ClientUtils.getNumShortStr(nowNum))

	local itemIcon = BaseObject.getItemIconPath(itemID)

	if itemIcon then
		self.imgCostItem:setImage(itemIcon[1], itemIcon[2])
	end

	self:setVisible(true)
end

return CommonCostPanel
