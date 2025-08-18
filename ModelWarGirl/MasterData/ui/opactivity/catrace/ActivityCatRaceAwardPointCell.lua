-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\ActivityCatRaceAwardPointCell.lua

local strClassName = "ActivityCatRaceAwardPointCell"
local ActivityCatRaceAwardPointCell = Class(strClassName, UIControls.ScrollViewLoopCell)
local AwardState = {}

function ActivityCatRaceAwardPointCell:ctor()
	self:initUI()
end

function ActivityCatRaceAwardPointCell:initUI()
	self.awardStatePanel = UIControls.Panel(self, "BtnShowAward")
end

function ActivityCatRaceAwardPointCell:setData(data, index)
	self.data = data

	self:setVisible(true)
	self.refreshData()
end

function ActivityCatRaceAwardPointCell:refreshData()
	return
end

function ActivityCatRaceAwardPointCell:setSlider()
	return
end

function ActivityCatRaceAwardPointCell:setAwardState(state)
	if self.awardState ~= state then
		self.awardState = state

		self.awardStatePanel:setVisible(self.awardState)
	end
end

return ActivityCatRaceAwardPointCell
