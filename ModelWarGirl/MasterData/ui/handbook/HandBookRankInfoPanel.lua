-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookRankInfoPanel.lua

local MONUMENT_BACK_IMG = {
	"TxtGroup01",
	"TxtGroup02",
	"TxtGroup03",
	"TxtMainBattle",
	"TxtOneTimeTower"
}
local OtherPlayer = require("Common/Object/OtherPlayer")
local HandBookRankInfoCell = require("UI/HandBook/HandBookRankInfoCell")
local HandBookRankContentPanel = require("UI/HandBook/HandBookRankContentPanel")
local strClassName = "HandBookRankInfoPanel"
local HandBookRankInfoPanel = Class(strClassName, UIControls.Child)

function HandBookRankInfoPanel:ctor()
	self:initUI()
end

function HandBookRankInfoPanel:initUI()
	self.contentPanel = HandBookRankContentPanel(self, "RankInfo/Content")
	self.scrollRank = UIControls.ScrollViewLoopV(self, "RankInfoList")

	self.scrollRank:addEventCellChanged(self.onRankCellChanged)

	self.cells = {}
	self.btnRank = UIControls.Button(self, "RankInfo/BtnRanking")

	self.btnRank:addEventClick(self.onBtnRankClick)
end

function HandBookRankInfoPanel:onBtnRankClick()
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(self.data.rankType)
end

function HandBookRankInfoPanel:setData(data, playerInfo)
	self.data = data
	self.playerInfo = playerInfo

	self.contentPanel.imgSelf:setImage("NoAlpha/HandBookRank/" .. MONUMENT_BACK_IMG[self.data.monumentType])
	self.contentPanel:setContentPanel(self.data)
	self.contentPanel:setPlayerInfo(self.playerInfo)
	self:refreshRankCell()
end

local MAX_CONTENT_COUNT = 4

function HandBookRankInfoPanel:refreshRankCell(oriPosRefresh)
	self.data.achieveList = {}

	for _, achieveData in pairs(CurAvatar.rankAchieveDic[self.data.monumentType]) do
		table.insert(self.data.achieveList, utils.deepcopy(achieveData))
	end

	local function sortByStatus(a, b)
		return a.resData.id < b.resData.id
	end

	table.sort(self.data.achieveList, sortByStatus)

	if not oriPosRefresh then
		local maxIdx = #self.data.achieveList - MAX_CONTENT_COUNT

		for idx, achieve in ipairs(self.data.achieveList) do
			if achieve.svrData.status == Const.TASK_STATUS.COMPLETE then
				self.scrollRank:setTotalCount(#self.data.achieveList, idx)

				return
			end
		end

		for idx, achieve in ipairs(self.data.achieveList) do
			if achieve.svrData.status == Const.TASK_STATUS.IN_PROCESS then
				self.scrollRank:setTotalCount(#self.data.achieveList, math.max(idx - 1, 1))

				return
			end
		end

		self.scrollRank:setTotalCount(#self.data.achieveList, 1)
	else
		self.scrollRank:setTotalCount(#self.data.achieveList)
	end
end

function HandBookRankInfoPanel:onRankCellChanged(sender, targetCell, newIdx)
	targetCell = targetCell or HandBookRankInfoCell(sender, "System/HandBook/HandBookRankInfoCell", newIdx)

	if not self.data.achieveList or #self.data.achieveList == 0 then
		return
	end

	if self.data.achieveList[newIdx] ~= nil then
		targetCell:setData(self.data.achieveList[newIdx], newIdx)
	end

	self.cells[newIdx] = targetCell
end

return HandBookRankInfoPanel
