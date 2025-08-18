-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\PVPRankListPanel.lua

local RankListPanel = require("UI/MainState/Rank/RankListPanel")
local SeniorPvpRankCell = require("UI/PVPMode/SeniorPVP/SeniorPvpRankCell")
local OpactPvpRankCell = require("UI/PVPMode/ActivityPVP/OpactPvpRankCell")
local PVPRankCell = require("UI/PVPMode/PVPRankCell")
local strClassName = "PVPRankListPanel"
local PVPRankListPanel = Class(strClassName, RankListPanel)

function PVPRankListPanel:initUI()
	PVPRankListPanel.super.initUI(self)

	self.cellType = Const.PVP_RANK_TYPE_ASYNC
	self.extendIdx = 0
end

function PVPRankListPanel:onRankCellChanged(sender, targetCell, newIdx)
	if not targetCell then
		if self.cellType == Const.PVP_RANK_TYPE_MULTI then
			targetCell = SeniorPvpRankCell(sender, "System/AsynPVP/BtnSeniorPVPRank", newIdx)
		elseif self.cellType == Const.PVP_RANK_TYPE_OPACT then
			targetCell = OpactPvpRankCell(sender, "System/ActivityPVP/BtnActivityPVPRank", newIdx)
		else
			targetCell = PVPRankCell(sender, "System/AsynPVP/BtnPVPRank", newIdx)
		end
	end

	if not self.dataList or #self.dataList == 0 then
		return
	end

	if self.dataList[newIdx] ~= nil then
		targetCell:setData(self.dataList[newIdx], newIdx)
		targetCell:extend(newIdx == self.extendIdx)
	else
		CurAvatar:onRankListRequestNextPage(self.mWindow.typeRank)
	end

	self.cells[newIdx] = targetCell
end

function PVPRankListPanel:extendCell(extendIdx)
	if self.extendIdx ~= extendIdx then
		self.extendIdx = extendIdx
	else
		self.extendIdx = 0
	end

	self:refreshRankScroll()
end

function PVPRankListPanel:setPvpType(cellType)
	self.cellType = cellType
end

function PVPRankListPanel:setExtendCellFormation()
	local rankCell = self.cells[self.extendIdx or 1]

	if rankCell and CurAvatar.rankFormation[rankCell.data.data.comm.uid] then
		rankCell.formation:initData(CurAvatar.rankFormation[rankCell.data.data.comm.uid].formation)
		rankCell:refreshPower()
	end
end

return PVPRankListPanel
