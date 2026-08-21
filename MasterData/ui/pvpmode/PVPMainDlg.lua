-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\PVPMainDlg.lua

local strClassName = "PVPMainDlg"
local PVPMainDlg = Class(strClassName, UIControls.Window)
local PVPRankListPanel = require("UI/PVPMode/PVPRankListPanel")
local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local ResColor = require("ClientData/ResColor")
local ResPVP = require("ClientData/ResAsyncPVPMisc")
local BattleConst = require("Common/FrameBattle/BattleConst")
local sweepItem = ResPVP[1].sweep_item
local AsynItemId = ResPVP[1].async_item_id
local BATTLE_NO = ResPVP[1].pve_id

function PVPMainDlg:ctor()
	self:initUI()
end

function PVPMainDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onTipClick)

	self.btnRankAward = UIControls.Button(self, "MainInfoPanel/BtnAward")

	self.btnRankAward:addEventClick(self.onBtnRankAwardClick)

	self.panelRankList = PVPRankListPanel(self, "MainInfoPanel/RankList")
	self.imgEmpty = UIControls.Image(self, "MainInfoPanel/NoContent")

	local path = "MainInfoPanel/SelfInfoPanel/"

	self.imgRank = UIControls.Image(self, path .. "ImgRank")
	self.imgBgRank = UIControls.Image(self, path .. "BgRank")
	self.rankTxt = UIControls.Label(self, path .. "TextRank")
	self.scoreTxt = UIControls.Label(self, path .. "TextScore")
	self.playerNameTxt = UIControls.Label(self, path .. "TextPlayerName")
	self.powerTxt = UIControls.Label(self, path .. "TextPowerTitle/TextPower")
	self.btnDefendTeam = UIControls.Button(self, path .. "BtnDefendTeam")

	self.btnDefendTeam:addEventClick(self.onBtnDefendTeamClick)

	self.redFormation = UIControls.RedDot(self, path .. "BtnDefendTeam/IconAbsent")

	self.redFormation:addHint({
		UIConst.RD_HINT_PVP_FORMATION
	})

	self.btnRecord = UIControls.Button(self, path .. "BtnRecord")

	self.btnRecord:addEventClick(self.onBtnRecordClick)

	self.redHint = UIControls.RedDot(self, path .. "BtnRecord/IconNew")

	self.redHint:addHint({
		UIConst.RD_HINT_PVP_RECORD
	})

	self.btnChallenge = UIControls.Button(self, path .. "BtnChallenge")

	self.btnChallenge:addEventClick(self.onBtnChallengeClick)

	self.btnStore = UIControls.Button(self, path .. "BtnStore")

	self.btnStore:addEventClick(self.onBtnStoreClick)

	self.imgBg = UIControls.Image(self, path .. "Bg")
	self.txtLevel = UIControls.Label(self, path .. "TextLvTitle/TextLv")
	self.timeTxt = UIControls.Label(self, "MainInfoPanel/TextTime")

	self:refreshTime()
end

function PVPMainDlg:onOpen(...)
	PVPMainDlg.super.onOpen(self)
	self:initMyLocalInfo()
	self.panelRankList:refreshRankScroll()
end

function PVPMainDlg:refreshTime(...)
	local leftTime = CurAvatar:getAsyncPvpLeftTime()

	ClientTimerManager.RemoveSecondTickUI(self.timeTxt)
	ClientTimerManager.AddSecondFormatTickUI(self.timeTxt, leftTime, nil, Lang.get(30645))
end

function PVPMainDlg:show()
	self.typeRank = Const.RANK_TYPE_ASYNCPVP

	CurAvatar:onRankListRequestNextPage(self.typeRank)
end

function PVPMainDlg:emptyRankData()
	self.imgEmpty:setVisible(true)
end

local ICON_PATH = "Atlas/OtherBattleAtlas/AsynPVPRankAtlas"
local ICON_PATH1 = "Atlas/OtherBattleAtlas/AsynPVPAtlas"
local color = {
	ResColor.ORANGEBTN,
	ResColor.QUALITYPURPLE,
	ResColor.QUALITYBLUE,
	ResColor.GREYLIGHT
}

function PVPMainDlg:initMyInfo(rank)
	CurAvatar.pvpRank = rank
	ClientUtils.record.pvpRank = rank

	if rank <= 3 and rank > 0 then
		self.imgRank:setVisible(true)
		self.imgBgRank:setImage(ICON_PATH .. rank, "BgRankL" .. rank)
		self.imgRank:setImage(ICON_PATH1, "IconRankL" .. rank)
		self.imgBg:setObjColor(color[rank])
		self.rankTxt:setVisible(false)
	elseif rank > 0 then
		self.rankTxt:setVisible(true)
		self.rankTxt:setText(rank)
		self.imgBgRank:setImage(ICON_PATH .. "0", "BgRankL0")
		self.imgRank:setVisible(false)
		self.imgBg:setObjColor(color[4])
	else
		self.rankTxt:setVisible(false)
		self.imgRank:setVisible(true)
		self.imgBgRank:setImage(ICON_PATH .. "0", "BgRankL0")
		self.imgRank:setImage(ICON_PATH1, "IconRankL0")
		self.imgBg:setObjColor(color[4])
	end
end

function PVPMainDlg:initMyLocalInfo(...)
	self.txtLevel:setText(CurAvatar:getLevel())
	self.playerNameTxt:setText(CurAvatar:getPlayerName() or "")
	self.scoreTxt:setText(CurAvatar:getPvpScore())
	self:refreshUI()
end

function PVPMainDlg:refreshUI(...)
	self.powerTxt:setText(CurAvatar:getAsyncPVPFormationCapacity())
end

function PVPMainDlg:setSelfRankCell(selfData)
	if selfData.rank <= 0 then
		RPC.rankIndexGet(Const.RANK_TYPE_ASYNCPVP)

		return
	end

	self:initMyInfo(selfData.rank)
end

function PVPMainDlg:onUpdateAttrChanged()
	self.scoreTxt:setText(CurAvatar:getPvpScore())
end

function PVPMainDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = PVPRankCell(sender, "System/AsynPVP/BtnPVPRank", newIdx, 0, 0)
	else
		targetCell.mIndex = newIdx
	end

	targetCell:initData(self.rankDatas[newIdx])
end

function PVPMainDlg:onBtnStoreClick()
	UIManager.createAndFunc("mallDlg", "showShop", Const.JUMPSHOPTYPE_PVPSHOP)
end

function PVPMainDlg:onBtnChallengeClick()
	if utils.getTableElemCount(CurAvatar.asyncPVPDefendFormation) == 0 then
		local ResClientNotice = require("ClientData/ResClientNotice")

		if ResClientNotice then
			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ResClientNotice[110].notice)

			return
		end
	end

	local isTimeOut = CurAvatar.nextMatchTick < ClientUtils.getServerTime()

	if isTimeOut or ClientUtils.record.allOpponent == nil then
		ClientUtils.record.allOpponent = nil
		ClientUtils.record.pvpMatchedUids = {}

		RPC.asyncPVPMatch()
		UIManager.getUI("pvpEnemyDlg", true, true)
	else
		UIManager.getUI("pvpEnemyDlg", true, true):show()
	end
end

function PVPMainDlg:onBtnRecordClick()
	if ClientUtils.nextGetReportTick < ClientUtils.getServerTime() or not ClientUtils.record.pvpReport or not CurAvatar.asyncPvpSysData or ClientUtils.nextGetReportSeasonId ~= CurAvatar.asyncPvpSysData.season then
		ClientUtils.record.pvpReport = nil

		RPC.asyncPVPReportGet()
		UIManager.getUI("pvpRecordDlg", true)
	else
		UIManager.getUI("pvpRecordDlg", true):show()
	end
end

function PVPMainDlg:onBtnDefendTeamClick()
	local formation = CurAvatar:getNowFormation(Const.FORMATION_ASYNC_DEFEND)

	if not formation or next(formation) == nil then
		CurAvatar:enterDefendFormation(BATTLE_NO, BattleConst.FORMATION_TYPE_ASYNC_PVP, {})
	else
		UIManager.getUI("asycPvpCheckTeamDlg", true):show()
	end
end

function PVPMainDlg:onBtnRankAwardClick()
	UIManager.getUI("pvpRankAwardDlg", true):show()
end

function PVPMainDlg:onCloseClick()
	self:setVisible(false)
end

function PVPMainDlg:destroy()
	if self.timer then
		self.timer:Stop()
	end

	PVPMainDlg.super.destroy(self)
	CurAvatar:onClearRankList()
end

function PVPMainDlg:onTipClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_ASYNCPVP)
end

return PVPMainDlg
