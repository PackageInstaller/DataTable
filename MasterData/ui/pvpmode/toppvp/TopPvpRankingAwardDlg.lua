-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpRankingAwardDlg.lua

local TopPvpRankingAwardCell = Class("TopPvpRankingAwardCell", UIControls.ScrollViewLoopCell)
local ResBPPvpFinalAward = require("ClientData/ResBPPvpFinalAward")

function TopPvpRankingAwardCell:ctor()
	self:initUI()
end

function TopPvpRankingAwardCell:initUI()
	self.txtNum = UIControls.Label(self, "ContentPanel/TextNum")

	self.txtNum:setVisible(false)

	self.panelTopPVPRank = UIControls.Panel(self, "ContentPanel/TopPVPRankPanel")

	self.panelTopPVPRank:setVisible(true)

	self.txtDes = UIControls.Label(self, "ContentPanel/TopPVPRankPanel/Text")
	self.txtDesNum = UIControls.Label(self, "ContentPanel/TopPVPRankPanel/TextNum")
	self.panelContent = UIControls.Panel(self, "ContentPanel")
	self.awardCells = {}
end

function TopPvpRankingAwardCell:setData(index)
	local data = ResBPPvpFinalAward[index]

	if data.desc == "1" or data.desc == "2" then
		self.txtDes:setVisible(false)
	else
		self.txtDes:setVisible(true)
	end

	self.txtDesNum:setText(data.desc)

	if data.award then
		ClientUtils.CreateBonusGrid(self, self.awardCells, "ContentPanel/AwardPanel", data.award, true, nil, true)

		for i, cell in ipairs(self.awardCells) do
			local spe = ClientUtils.getItemSpeTypeId(cell.object.id)

			if spe then
				cell:setSpe(true, spe)
			else
				cell:setSpe(false)
			end
		end
	end
end

local strClassName = "topPvpRankingAwardDlg"
local TopPvpRankingAwardDlg = Class(strClassName, UIControls.Window)

function TopPvpRankingAwardDlg:ctor(...)
	self:initUI()
end

function TopPvpRankingAwardDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.textTime = UIControls.Label(self, "BgPanel/TextTime")

	self.textTime:setVisible(false)

	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/AwardList", 0, self.onCellChanged)
end

function TopPvpRankingAwardDlg:show(...)
	self:initData()
end

function TopPvpRankingAwardDlg:initData(...)
	self.scrollView:setTotalCount(#ResBPPvpFinalAward)
end

function TopPvpRankingAwardDlg:onBtnCloseClick()
	self:setVisible(false)
end

function TopPvpRankingAwardDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = TopPvpRankingAwardCell(sender, "System/Rank/RankingAwardCell", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	targetCell:setData(newIdx)
end

return TopPvpRankingAwardDlg
