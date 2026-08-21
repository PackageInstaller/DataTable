-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\StepTower\\StepTowerRewardPanel.lua

local ResTowerLayerAward = require("ClientData/ResTowerLayerAward")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "StepTowerRewardPanel"
local StepTowerRewardPanel = Class(strClassName, UIControls.Panel)

function StepTowerRewardPanel:ctor()
	self:initUI()
end

function StepTowerRewardPanel:initUI()
	self.txtStarNum = UIControls.Label(self, self.mPath .. "/TextNum")
	self.imgIconNew = UIControls.Image(self, self.mPath .. "/IconNew")
	self.imgIconDone = UIControls.Image(self, self.mPath .. "/IconDone")
end

function StepTowerRewardPanel:setLayerData(layerData, idx)
	self.layerData, self.idx = layerData, idx

	local rewardData = ResTowerLayerAward[self.layerData.resData[1].layer].awards[idx]

	self.txtStarNum:setText(rewardData.star_num)

	local randItem = ResRandClient[rewardData.award]

	if self.awardGrid then
		self.awardGrid:destroy()

		self.awardGrid = nil
	end

	self.awardGrid = UIControls.ItemGridChild(self, self.mPath .. "/GridBox", "System/Common/Grid/GridMaterialItem", 0, 0, true)

	local gridItem = BaseObject.GetObject(randItem.show_ids[1])

	if randItem.show_nums and randItem.show_nums[1] then
		gridItem.num = randItem.show_nums[1]
	else
		gridItem.num = 1
	end

	self.awardGrid:setObj(gridItem)

	self.awardGeted = self.layerData.svrData.award_get[self.idx] == true
	self.canGet = not self.awardGeted and rewardData.star_num <= self.layerData.svrData.star_count

	self.imgIconDone:setVisible(self.awardGeted)
	self.imgIconNew:setVisible(self.canGet)
	self.awardGrid.btnSensor:clearEventClick()

	if self.canGet then
		self.awardGrid.btnSensor:addEventClick(Slot(self.onGetStarAward, self))
	else
		self.awardGrid.btnSensor:addEventClick(self.awardGrid.onGridClick)
	end
end

function StepTowerRewardPanel:onGetStarAward()
	if self.canGet then
		RPC.towerStarAwardGet(self.layerData.resData[1].layer, self.idx)
	end
end

return StepTowerRewardPanel
