-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpKnockoutPanel.lua

local TopPvpTabEliminateMatchCell = Class("TopPvpTabEliminateMatchCell", UIControls.Child)

function TopPvpTabEliminateMatchCell:ctor()
	self:initUI()
end

function TopPvpTabEliminateMatchCell:initUI()
	self.btnTabMatch = UIControls.Button(self, "TabMatch")

	self.btnTabMatch:addEventClick(self.onBtnTabMatchClick)

	self.text = UIControls.Label(self, "TabMatch/Text")
	self.textEng = UIControls.Label(self, "TabMatch/TextEng")
	self.iconNew = UIControls.Image(self, "TabMatch/IconNew")
end

local chineseTabText = {
	Lang.get(76441),
	Lang.get(76458),
	Lang.get(78302),
	Lang.get(78303)
}
local englishTabText = {
	"initial Battle",
	"ultimate Battle",
	"my Schedule",
	"ranking"
}

function TopPvpTabEliminateMatchCell:setData(index)
	self.index = index

	self.text:setText(chineseTabText[index])
	self.textEng:setText(englishTabText[index])
end

function TopPvpTabEliminateMatchCell:onBtnTabMatchClick()
	if self.index == 1 or self.index == 2 then
		self.mParent:refreshUI(self.index)
	else
		self.mParent:refreshUI(self.index)
	end
end

local TopPvpMatchTablePanel = require("UI/PVPMode/TopPVP/TopPvpMatchTablePanel")
local TopPvpMyMatchPanel = require("UI/PVPMode/TopPVP/TopPvpMyMatchPanel")
local TopPvpTopRankingPanel = require("UI/PVPMode/TopPVP/TopPvpTopRankingPanel")
local strClassName = "TopPvpKnockoutPanel"
local TopPvpKnockoutPanel = Class(strClassName, UIControls.Panel)
local ROUND_EIGHT_MODE_NUM = 4
local SHOW_MODE_SIXTY = 1
local SHOW_MODE_EIGHT = 2
local SHOW_MODE_SELF_BATTLE = 3
local SHOW_MODE_RANK = 4

function TopPvpKnockoutPanel:ctor()
	self.actObj = self.mParent.actObj
	self.actData = self.actObj.actData

	self:initUI()
end

function TopPvpKnockoutPanel:initUI()
	self.panelMatchTable = TopPvpMatchTablePanel(self, self.mPath .. "/MatchTablePanel")
	self.panelMyMatch = TopPvpMyMatchPanel(self, self.mPath .. "/MyMatchPanel")
	self.panelTopRanking = TopPvpTopRankingPanel(self, self.mPath .. "/TopRankingPanel")
	self.listTabEliminateMatch = UIControls.Panel(self, self.mPath .. "/ListTabEliminateMatch")
	self.tabCells = {}

	for i = 1, 4 do
		local newCell = TopPvpTabEliminateMatchCell(self, self.mPath .. "/ListTabEliminateMatch", "System/TopPVP/TabEliminateMatch")

		newCell:setVisible(true)
		newCell:setData(i)
		table.insert(self.tabCells, newCell)
	end

	self.index = nil

	self.tabCells[3]:setVisible(self.actData:checkKnockoutQualification())
end

function TopPvpKnockoutPanel:refreshUI(index)
	self.tabCells[3]:setVisible(self.actData:checkKnockoutQualification())

	index = index or self.index

	if index == SHOW_MODE_EIGHT then
		local rank = self.actData:getKnockoutRound()

		if not rank or not (rank >= 4) then
			local ResBPPvpShow = require("ClientData/ResBPPvpShow")
			local resData = ResBPPvpShow[13070017]

			if resData then
				local desc = resData.desc

				if desc then
					MsgManager.notice(desc)

					return
				end
			end
		end

		self.index = SHOW_MODE_EIGHT

		self.panelMatchTable:setVisible(true)
		self.panelMyMatch:setVisible(false)
		self.panelTopRanking:setVisible(false)
		self.panelMatchTable:setMode(SHOW_MODE_EIGHT, self.actObj)
	elseif index == SHOW_MODE_SELF_BATTLE then
		self.index = SHOW_MODE_SELF_BATTLE

		self.panelMatchTable:setVisible(false)
		self.panelMyMatch:setVisible(true)
		self.panelTopRanking:setVisible(false)
		self.panelMyMatch:refreshUI()
	elseif index == SHOW_MODE_RANK then
		self.index = SHOW_MODE_RANK

		self.panelMatchTable:setVisible(false)
		self.panelMyMatch:setVisible(false)
		self.panelTopRanking:setVisible(true)
		self.panelTopRanking:refreshUI()
	elseif index == SHOW_MODE_SIXTY then
		self.index = SHOW_MODE_SIXTY

		self.panelMatchTable:setVisible(true)
		self.panelMyMatch:setVisible(false)
		self.panelTopRanking:setVisible(false)
		self.panelMatchTable:setMode(SHOW_MODE_SIXTY, self.actObj)
	elseif self.actData:checkKnockoutNowRoundQualification() then
		self.index = SHOW_MODE_SELF_BATTLE

		self.panelMatchTable:setVisible(false)
		self.panelMyMatch:setVisible(true)
		self.panelTopRanking:setVisible(false)
		self.panelMyMatch:refreshUI()
	else
		local rank = self.actData:getKnockoutRound()

		if rank and rank >= 4 then
			self.index = SHOW_MODE_EIGHT

			self.panelMatchTable:setVisible(true)
			self.panelMyMatch:setVisible(false)
			self.panelTopRanking:setVisible(false)
			self.panelMatchTable:setMode(SHOW_MODE_EIGHT, self.actObj)
		else
			self.index = SHOW_MODE_SIXTY

			self.panelMatchTable:setVisible(true)
			self.panelMyMatch:setVisible(false)
			self.panelTopRanking:setVisible(false)
			self.panelMatchTable:setMode(SHOW_MODE_SIXTY, self.actObj)
		end
	end

	for i = 1, 4 do
		self.tabCells[i].btnTabMatch:setEnable(i ~= self.index)
	end

	self:refreshRedDot()
end

function TopPvpKnockoutPanel:refreshRedDot()
	for i = 1, #self.tabCells do
		local iconNew = self.tabCells[i].iconNew

		if i == 1 then
			iconNew:setVisible(self.actData:checkKnockoutTab64())
		elseif i == 2 then
			iconNew:setVisible(self.actData:checkKnockoutTab8())
		elseif i == 3 then
			iconNew:setVisible(self.actData:checkKnockoutTabMy())
		end
	end

	self.panelMatchTable:refreshRedDot()
end

function TopPvpKnockoutPanel:setIndex(index)
	if index then
		self.index = index

		self:refreshUI()
	else
		self:refreshUI()
	end
end

return TopPvpKnockoutPanel
