-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleAchievePanel.lua

local CircleBattleAchieveGetCell = require("UI/Circle/CircleBattleAchieveGetCell")
local strClassName = "CircleAchievePanel"
local CircleAchievePanel = Class(strClassName, UIControls.Panel)

function CircleAchievePanel:ctor()
	self:initUI()
end

function CircleAchievePanel:initUI()
	self.cells = {}
	self.scrollAchieve = UIControls.ScrollViewLoopV(self, self.mPath .. "/GetList")

	self.scrollAchieve:addEventCellChanged(self.onAchieveChanged)
end

function CircleAchievePanel:setAchieveType(achieveType)
	self.achieveType = achieveType
end

function CircleAchievePanel:playAchieveGetAniShow(achieveId)
	for _, cell in pairs(self.cells) do
		if cell.achieveCellData.resData.id == achieveId then
			cell:playFlyAward()

			break
		end
	end
end

function CircleAchievePanel:refreshPanelData()
	if self.achieveType then
		if self.achieveType == Const.CIRCLE_ACHIEVE_TYPE.CIRCLE then
			self.achieveDataList = CurAvatar.myCircle:getBattleCircleAchieveList()
		else
			self.achieveDataList = CurAvatar.myCircle:getBattleMemberAchieveList()
		end

		self.scrollAchieve:setTotalCount(#self.achieveDataList, 1)
	end
end

function CircleAchievePanel:onAchieveChanged(sender, targetCell, newIdx)
	targetCell = targetCell or CircleBattleAchieveGetCell(sender, "System/CircleBattle/PointGetCell", newIdx)

	if not self.achieveDataList or #self.achieveDataList == 0 then
		return
	end

	if self.achieveDataList[newIdx] ~= nil then
		targetCell:setAchieveCellData(self.achieveDataList[newIdx], newIdx)
	end

	self.cells[newIdx] = targetCell
end

return CircleAchievePanel
