-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleGuessRankingDlg.lua

local BtnPlayerRankCellMine = require("UI/MainState/Rank/BtnPlayerRankCellMine")
local CircleGuessRankCell = Class("CircleGuessRankCell", UIControls.BtnPlayerRankCellLoop)

function CircleGuessRankCell:ctor()
	return
end

function CircleGuessRankCell:setData(data, idx)
	CircleGuessRankCell.super.setData(self, data, idx)
	self.txtScore:setText(string.format(Lang.get(76350), data.count))
end

local CircleGuessRankSelfCell = Class("CircleGuessRankSelfCell", BtnPlayerRankCellMine)

function CircleGuessRankSelfCell:ctor()
	return
end

function CircleGuessRankSelfCell:setData(data, idx)
	CircleGuessRankSelfCell.super.setData(self, data, idx)
	self.txtScore:setText(string.format(Lang.get(76350), data.count))
end

local strClassName = "CircleGuessRankingDlg"
local CircleGuessRankingDlg = Class(strClassName, UIControls.Window)

function CircleGuessRankingDlg:ctor()
	self:initUI()
end

function CircleGuessRankingDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.cells = {}
	self.scrollHonorInfo = UIControls.ScrollViewLoopV(self, "BgPanel/PlayerRankList")

	self.scrollHonorInfo:addEventCellChanged(self.onCellChanged)

	self.cellSelf = CircleGuessRankSelfCell(self, "BgPanel/MyRankInfo", "System/Rank/BtnPlayerRankMine")

	self.cellSelf:setVisible(true)
end

function CircleGuessRankingDlg:onCellChanged(sender, targetCell, newIdx)
	targetCell = targetCell or CircleGuessRankCell(sender, "System/Rank/BtnPlayerRank", newIdx)

	targetCell:setData(self.allData[newIdx])

	self.cells[newIdx] = targetCell
end

local function SortOfGuessMember(dataA, dataB)
	if dataA.count == dataB.count then
		return dataA.guessTick < dataB.guessTick
	else
		return dataA.count > dataB.count
	end
end

function CircleGuessRankingDlg:setData(guessMemberList)
	self.selfData = nil
	self.allData = {}

	for _, mem in ipairs(guessMemberList) do
		local oneData = {}

		oneData.rankType = Const.RANK_TYPE_ONCETOWER
		oneData.data = {}
		oneData.data.comm = mem.base
		oneData.data.tick = 0
		oneData.count = mem.guess_right_cnt or 0
		oneData.data.score = 0
		oneData.guessTick = mem.guess_right_time or 0

		if mem.base.uid == CurAvatar.uid then
			self.selfData = oneData
		end

		table.insert(self.allData, oneData)
	end

	table.sort(self.allData, SortOfGuessMember)

	for index, data in ipairs(self.allData) do
		data.rank = index
	end

	self.scrollHonorInfo:setTotalCount(#self.allData)

	if self.selfData then
		self.cellSelf:setVisible(true)
		self.cellSelf:setData(self.selfData)
	else
		self.cellSelf:setVisible(false)
	end
end

function CircleGuessRankingDlg:onBtnCloseClick()
	self:setVisible(false)
end

return CircleGuessRankingDlg
