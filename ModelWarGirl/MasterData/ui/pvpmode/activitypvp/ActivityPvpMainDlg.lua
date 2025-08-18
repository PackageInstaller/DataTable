-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\ActivityPVP\\ActivityPvpMainDlg.lua

local PVPRankListPanel = require("UI/PVPMode/PVPRankListPanel")
local PVPCommon = require("Logic/PVP/PVPCommon")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local strClassName = "ActivityPvpMainDlg"
local ActivityPvpMainDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityPvpMainDlg, ActivityPanelMixin)

function ActivityPvpMainDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnChallenge = UIControls.Button(self, "MainInfoPanel/SelfInfoPanel/BtnChallenge")

	self.btnChallenge:addEventClick(self.onBtnChallengeClick)

	self.btnDefendTeam = UIControls.Button(self, "MainInfoPanel/SelfInfoPanel/BtnDefendTeam")

	self.btnDefendTeam:addEventClick(self.onBtnDefendTeamClick)

	self.btnAward = UIControls.Button(self, "MainInfoPanel/ZoneInfoPanel/BtnAward")

	self.btnAward:addEventClick(self.onBtnAwardClick)

	self.btnTopRank = UIControls.Button(self, "MainInfoPanel/ZoneInfoPanel/BtnTopRank")

	self.btnTopRank:addEventClick(self.onBtnTopRankClick)

	self.btnZoneUp = UIControls.Button(self, "MainInfoPanel/SelfInfoPanel/BtnZoneUp")

	self.btnZoneUp:addEventClick(self.onBtnZoneUpClick)

	self.btnRecord = UIControls.Button(self, "MainInfoPanel/SelfInfoPanel/BtnRecord")

	self.btnRecord:addEventClick(self.onBtnRecordClick)

	self.btnStore = UIControls.Button(self, "MainInfoPanel/SelfInfoPanel/BtnStore")

	self.btnStore:addEventClick(self.onBtnStoreClick)

	self.btnHelp = UIControls.Button(self, "MainInfoPanel/SelfInfoPanel/BtnChallenge/BtnHelp")

	self.btnHelp:addEventClick(self.onBtnHelpClick)

	self.btnTip = UIControls.Button(self, "BtnTips")

	self.btnTip:addEventClick(self.onBtnTipClick)

	self.btnPartAward = UIControls.Button(self, "MainInfoPanel/SelfInfoPanel/BtnRankAward")

	self.btnPartAward:addEventClick(self.onBtnPartAwardClick)

	self.txtRankZone = UIControls.Label(self, "MainInfoPanel/ZoneInfoPanel/TextZone")
	self.txtTime = UIControls.Label(self, "MainInfoPanel/ZoneInfoPanel/TextTime")
	self.txtPlayerName = UIControls.Label(self, "MainInfoPanel/SelfInfoPanel/TextPlayerName")
	self.txtRank = UIControls.Label(self, "MainInfoPanel/SelfInfoPanel/TextRank")
	self.txtScore = UIControls.Label(self, "MainInfoPanel/SelfInfoPanel/TextScore")
	self.txtZoneName = UIControls.Label(self, "MainInfoPanel/SelfInfoPanel/TextZone")
	self.txtLv = UIControls.Label(self, "MainInfoPanel/SelfInfoPanel/TextLv")
	self.txtPower = UIControls.Label(self, "MainInfoPanel/SelfInfoPanel/TextPower")
	self.txtLeftTimes = UIControls.Label(self, "MainInfoPanel/SelfInfoPanel/BtnChallenge/TextNum")
	self.redFormation = UIControls.RedDot(self, "MainInfoPanel/SelfInfoPanel/BtnDefendTeam/IconAbsent")

	self.redFormation:addHint({
		UIConst.RD_HINT_OPACTPVP_FORMATION
	})

	self.redChallenge = UIControls.RedDot(self, "MainInfoPanel/SelfInfoPanel/BtnChallenge/IconNew")

	self.redChallenge:addHint({
		UIConst.RD_HINT_OPACTPVP_CHALLENGE
	})

	self.redRecord = UIControls.RedDot(self, "MainInfoPanel/SelfInfoPanel/BtnRecord/IconNew")

	self.redRecord:addHint({
		UIConst.RD_HINT_OPACTPVP_REPORT
	})

	self.imgZoneUpTip = UIControls.Image(self, "MainInfoPanel/SelfInfoPanel/BtnZoneUp/IconNew")
	self.imgZoneDec = UIControls.Image(self, "MainInfoPanel/SelfInfoPanel/BtnZoneUp/ImgDec")
	self.imgZoneMax = UIControls.Image(self, "MainInfoPanel/SelfInfoPanel/BtnZoneUp/ImgMax")
	self.panelRankList = PVPRankListPanel(self, "MainInfoPanel/RankList")

	self.panelRankList:setPvpType(Const.PVP_RANK_TYPE_OPACT)

	self.panelMainInfo = UIControls.Panel(self, "MainInfoPanel")
	self.imgRankNone = UIControls.Image(self, "MainInfoPanel/SelfInfoPanel/ImgRankNone")
	self.rankUIData = {}

	local uiNames = {
		"/IconRankLv",
		"/IconRankLv/BgRankLv",
		"/IconRankLv/BgRankLvS",
		"/IconRankLv/IconRankLvS"
	}
	local path = "MainInfoPanel/SelfInfoPanel"

	for i, name in ipairs(uiNames) do
		self.rankUIData[i] = UIControls.Image(self, path .. name)
	end

	self.typeRank = Const.RANK_TYPE_OPACTPVP

	self:checkLeague()
	self:getRankData()
end

function ActivityPvpMainDlg:onOpen(...)
	ActivityPvpMainDlg.super.onOpen(self)
	self:checkPartChange()
end

function ActivityPvpMainDlg:getRankData(...)
	local actData = CurAvatar:getPVPArenaActivityData()

	if actData == nil or actData.opened == 0 then
		return
	end

	self.panelRankList:clear()
	CurAvatar:onClearRankList()
	CurAvatar:onRankListRequestNextPage(self.typeRank)
end

function ActivityPvpMainDlg:checkPartChange()
	local arenaData = CurAvatar:getPVPArenaActivityData()

	if arenaData == nil or arenaData.enrolled == 0 then
		return
	end

	local dan = arenaData.award_dan
	local actData = CurAvatar:getPVPArenaActData()

	if actData and actData:getPreDan() then
		dan = actData:getPreDan()
	end

	local info = PVPCommon.getPartInfoByScore(arenaData.score)

	if dan ~= info.dan then
		UIManager.getUI("activityPvpRankChangeDlg", true):show()
	end
end

function ActivityPvpMainDlg:checkWelcome(typeStr)
	UIManager.getUI("activityPvpWelcomeDlg", true):show(typeStr)
end

function ActivityPvpMainDlg:_setData(...)
	self.txtPlayerName:setText(CurAvatar:getPlayerName())
	self.txtLv:setText(CurAvatar:getLevel())
	self:refreshUI()
end

function ActivityPvpMainDlg:checkLeague(...)
	local league = 4
	local actData = CurAvatar:getPVPArenaActivityData()

	if actData then
		league = actData.league
	end

	self.panelMainInfo:playAnimator("ActivityPVPZone" .. league)
end

function ActivityPvpMainDlg:refreshUI()
	self:refreshPower()

	local league = 0
	local actData = CurAvatar:getPVPArenaActivityData()

	if actData then
		league = actData.league
	end

	local zoneInfo = PVPCommon.getZoneInfo(league)

	if zoneInfo then
		self.txtZoneName:setText(zoneInfo.name)
		self.txtRankZone:setText(zoneInfo.name)
	end

	self:refreshScore()
	self.txtLeftTimes:setText(utils.format(Lang.get(30651), PVPCommon.getLeftChallengeTimes(), PVPCommon.getTotalChallengeTimes()))

	if league ~= 1 then
		self.btnTopRank:setVisible(true)
		self.btnAward:setVisible(false)
	else
		self.btnTopRank:setVisible(false)
		self.btnAward:setVisible(true)
	end

	self:refreshTimeDown()
end

function ActivityPvpMainDlg:refreshPower(...)
	local power = PVPCommon.getOpactPvpDefendPower()

	self.txtPower:setText(power)
end

function ActivityPvpMainDlg:refreshZoneButtonState(...)
	local league = 0
	local actData = CurAvatar:getPVPArenaActData()
	local arenaData = CurAvatar:getPVPArenaActivityData()

	if arenaData then
		league = arenaData.league
	end

	if league == 1 then
		self.imgZoneDec:setVisible(false)
		self.imgZoneMax:setVisible(true)
		self.imgZoneUpTip:setVisible(false)

		return
	end

	self.imgZoneMax:setVisible(false)

	if actData and actData:canUpgradeZone() then
		self.imgZoneDec:setVisible(false)
		self.imgZoneUpTip:setVisible(true)
	else
		self.imgZoneDec:setVisible(true)
		self.imgZoneUpTip:setVisible(false)
	end
end

function ActivityPvpMainDlg:refreshScore(...)
	local score = 0
	local actData = CurAvatar:getPVPArenaActivityData()

	if actData then
		score = actData.score
	end

	local info, isLast = PVPCommon.getPartInfoByScore(score)

	if info then
		PVPCommon.setRankUI(self.rankUIData, info)

		if score > info.high_score or isLast then
			self.txtScore:setText(score)
		else
			self.txtScore:setText(score .. "/" .. info.high_score + 1)
		end
	end

	self:refreshRank()
	self:refreshRankList(true)
	self:refreshZoneButtonState()
end

function ActivityPvpMainDlg:refreshRank(...)
	if CurAvatar.opactPvpRank == nil or CurAvatar.opactPvpRank == 0 then
		self.imgRankNone:setVisible(true)
		self.txtRank:setText("")
	else
		self.imgRankNone:setVisible(false)
		self.txtRank:setText(CurAvatar.opactPvpRank)
	end
end

function ActivityPvpMainDlg:refreshTimeDown(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	local leftTime = 0
	local actData = CurAvatar:getPVPArenaActData()

	if actData then
		leftTime = actData:getLeftTimeToFreeze()
	end

	if leftTime > 0 then
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48654), nil, nil)
	else
		self.txtTime:setText(Lang.get(30121))
	end
end

function ActivityPvpMainDlg:emptyRankData()
	return
end

function ActivityPvpMainDlg:setSelfRankCell(...)
	return
end

function ActivityPvpMainDlg:refreshRankList(isSort)
	if isSort then
		self.panelRankList:checkSort()
	end

	self.panelRankList:refreshRankScroll()
end

function ActivityPvpMainDlg:onNewDay(...)
	self:refreshUI()
end

function ActivityPvpMainDlg:onLeagueChange(isEnrollResp)
	if not isEnrollResp then
		self:getRankData()
		self:checkWelcome("leagueChange")
	end

	self:refreshUI()
	self:checkLeague()
end

function ActivityPvpMainDlg:onFormationChange(...)
	local power = PVPCommon.getOpactPvpDefendPower()

	self.txtPower:setText(power)
	self:refreshRankList()
end

function ActivityPvpMainDlg:onWelcomeColse(...)
	self:playAni("ChangeActivityPVPMain", nil, true)
end

function ActivityPvpMainDlg:destroy(...)
	ActivityPvpMainDlg.super.destroy(self)
	CurAvatar:onClearRankList()
end

function ActivityPvpMainDlg:onBtnPartAwardClick(...)
	UIManager.getUI("activityPvpPartAwardDlg", true)
end

function ActivityPvpMainDlg:onBtnTipClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_OPACTPVP)
end

function ActivityPvpMainDlg:onBtnHelpClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(94)
end

function ActivityPvpMainDlg:onBtnStoreClick(...)
	UIManager.getUI("activityMallDlg", true):onShow(52, Const.JUMPSHOPTYPE_OPACTPVP)
end

function ActivityPvpMainDlg:onBtnRecordClick(...)
	local result, hint = PVPCommon.isOpactPvpEnd()

	if result then
		MsgManager.notice(hint)

		return
	end

	if CurAvatar.opactNextGetReportTime > ClientUtils.getServerTime() and ClientUtils.record.opactPvpReports then
		UIManager.getUI("activityPvpRecordDlg", true):show()
	else
		local actId = CurAvatar:getPVPArenaActivityOpId(...)

		if actId then
			RPC.opactArenaReportGet(actId)
		end
	end
end

function ActivityPvpMainDlg:onBtnZoneUpClick()
	local result, hint = PVPCommon.isOpactPvpValid()

	if not result then
		MsgManager.notice(hint)

		return
	end

	local canUpgrade = false
	local reason
	local actData = CurAvatar:getPVPArenaActData()

	if actData then
		canUpgrade, reason = actData:canUpgradeZone()
	end

	if canUpgrade then
		local function yesFunc(...)
			local actId = CurAvatar:getPVPArenaActivityOpId(...)

			if actId then
				RPC.opactArenaUpgradeLeague(actId)

				local score = 0
				local arenaData = CurAvatar:getPVPArenaActivityData()

				if arenaData then
					score = arenaData.score
				end

				local info = PVPCommon.getPartInfoByScore(score)

				actData:savePreDan(info.dan)
			end
		end

		local content = reason

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, yesFunc, nil, nil)
	elseif reason then
		MsgManager.notice(reason)
	end
end

function ActivityPvpMainDlg:onBtnTopRankClick(...)
	CurAvatar:sendOpactPvpTopRankReq()
end

function ActivityPvpMainDlg:onBtnAwardClick(...)
	UIManager.getUI("rankingAwardDlg", true):show(CurAvatar.opactPvpRank or 0, Const.RANK_AWARD_TYPE_OPACTPVP)
end

function ActivityPvpMainDlg:onBtnDefendTeamClick(...)
	local result, hint = PVPCommon.isOpactPvpValid()

	if not result then
		MsgManager.notice(hint)

		return
	end

	local formation = CurAvatar:getNowFormation(Const.FORMATION_OPACTPVP_DEFEND_1)

	if formation == nil or next(formation) == nil then
		local BattleConst = require("Common/FrameBattle/BattleConst")
		local battleData = {}

		battleData.opactPvpData = {}

		local actObj = CurAvatar:getPVPArenaActivity()

		if actObj then
			battleData.opactPvpData.actId = actObj.actId
		end

		CurAvatar:enterFormation(10001, BattleConst.FORMATION_TYPE_OPACT_PVP, battleData)
	else
		UIManager.getUI("activityPvpCheckTeamDlg", true):show(BattleConst.FORMATION_TYPE_OPACT_PVP)
	end
end

function ActivityPvpMainDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function ActivityPvpMainDlg:onBtnChallengeClick(...)
	local result, hint = PVPCommon.isOpactPvpValid()

	if not result then
		MsgManager.notice(hint)

		return
	end

	local formation = CurAvatar:getNowFormation(Const.FORMATION_MULTIPVP_DEFEND_1)

	if formation == nil or next(formation) == nil then
		formation = CurAvatar:getNowFormation(Const.FORMATION_OPACTPVP_DEFEND_1)

		if formation == nil or next(formation) == nil then
			MsgManager.clientNotice(326)

			return
		end
	end

	local todayStart = ClientUtils.getServerTimeTodayStart()
	local actData = CurAvatar:getPVPArenaActivityData()

	if actData and todayStart > actData.match_tick then
		local id = CurAvatar:getPVPArenaActivityOpId()

		if id then
			RPC.opactArenaMatch(id)
		end
	elseif actData and actData.match_result then
		CurAvatar:checkAndGetOpactPvpMatchInfo(actData.match_result)
	end

	UIManager.getUI("activityPvpEnemyDlg", true):show()
end

return ActivityPvpMainDlg
