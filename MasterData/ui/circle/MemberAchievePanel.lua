-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\MemberAchievePanel.lua

local strClassName = "MemberAchievePanel"
local MemberAchievePanel = Class(strClassName, UIControls.Panel)

function MemberAchievePanel:ctor()
	self:initUI()
end

function MemberAchievePanel:initUI()
	self.cells = {}
	self.scrollAchieve = UIControls.ScrollViewLoopV(self, self.mPath .. "/GetList")

	self.scrollAchieve:addEventCellChanged(self.onAchieveChanged)
end

function MemberAchievePanel:onAchieveChanged(sender, targetCell, newIdx)
	targetCell = targetCell or PointGetCell(sender, "System/CircleBattle/PointGetCell", newIdx)

	if not self.scrollDataList or #self.scrollDataList == 0 then
		return
	end

	if self.scrollDataList[newIdx] ~= nil then
		targetCell:setData(self.scrollDataList[newIdx], newIdx)
	end

	self.cells[newIdx] = targetCell
end

return MemberAchievePanel
