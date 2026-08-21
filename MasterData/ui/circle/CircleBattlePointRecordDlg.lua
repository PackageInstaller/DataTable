-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattlePointRecordDlg.lua

local PointRecordCell = require("UI/Circle/PointRecordCell")
local strClassName = "CircleBattlePointRecordDlg"
local CircleBattlePointRecordDlg = Class(strClassName, UIControls.Window)

function CircleBattlePointRecordDlg:ctor()
	self:initUI()
end

function CircleBattlePointRecordDlg:initUI()
	self.cells = {}
	self.scrollRecordList = UIControls.ScrollViewLoopV(self, "Bg/PointRecordList")

	self.scrollRecordList:addEventCellChanged(self.onRecordListChanged)

	self.recordDataList = CurAvatar:tryGetScoreRecordDataList()

	if self.recordDataList then
		self.scrollRecordList:setTotalCount(#self.recordDataList)
	end
end

function CircleBattlePointRecordDlg:setRecordDataList(recordDataList)
	self.recordDataList = recordDataList

	self.scrollRecordList:setTotalCount(#self.recordDataList)
end

function CircleBattlePointRecordDlg:onRecordListChanged(sender, targetCell, newIdx)
	targetCell = targetCell or PointRecordCell(sender, "System/CircleBattle/PointRecordCell", newIdx)

	if not self.recordDataList or #self.recordDataList == 0 then
		return
	end

	if self.recordDataList[newIdx] ~= nil then
		targetCell:setPointRecordData(self.recordDataList[newIdx], newIdx)
	end

	self.cells[newIdx] = targetCell
end

return CircleBattlePointRecordDlg
