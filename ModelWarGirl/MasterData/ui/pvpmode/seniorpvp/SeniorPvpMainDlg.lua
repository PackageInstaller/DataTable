-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\SeniorPVP\\SeniorPvpMainDlg.lua

local PVPCommon = require("Logic/PVP/PVPCommon")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local PVPRankListPanel = require("UI/PVPMode/PVPRankListPanel")
local strClassName = "SeniorPvpMainDlg"
local SeniorPvpMainDlg = Class(strClassName, UIControls.Window)
local STATE = {
	EMPTY = 1,
	FULL = 2
}

function SeniorPvpMainDlg:ctor(...)
	self:initUI()
	self:initData()
end

function SeniorPvpMainDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTip = UIControls.Button(self, "BtnTips")

	self.btnTip:addEventClick(self.onBtnTipClick)

	self.btnAward = UIControls.Button(self, "MainInfoPanel/BtnAward")

	self.btnAward:addEventClick(self.onBtnAwardClick)

	self.btnDefendTeam = UIControls.Button(self, "MainInfoPanel/SelfInfoPanel/BtnDefendTeam")

	self.btnDefendTeam:addEventClick(self.onBtnDefendTeamClick)

	self.btnRecord = UIControls.Button(self, "MainInfoPanel/SelfInfoPanel/BtnRecord")

	self.btnRecord:addEventClick(self.onBtnRecordClick)

	self.btnStore = UIControls.Button(self, "MainInfoPanel/SelfInfoPanel/BtnStore")

	self.btnStore:addEventClick(self.onBtnStoreClick)

	self.btnChallenge = UIControls.Button(self, "MainInfoPanel/SelfInfoPanel/BtnChallenge")

	self.btnChallenge:addEventClick(self.onBtnChallengeClick)

	self.btnAwardTip = UIControls.Button(self, "MainInfoPanel/BtnAward/AwardSpeedPanel/TextNum/BtnHelp")

	self.btnAwardTip:addEventClick(self.onBtnAwardTipClick)

	self.redFormation = UIControls.RedDot(self, "MainInfoPanel/SelfInfoPanel/BtnDefendTeam/IconAbsent")

	self.redFormation:addHint({
		UIConst.RD_HINT_SENIORPVP_FORMATION
	})

	self.redRecord = UIControls.RedDot(self, "MainInfoPanel/SelfInfoPanel/BtnRecord/IconNew")

	self.redRecord:addHint({
		UIConst.RD_HINT_SENIORPVP_RECORD
	})

	self.redAward = UIControls.RedDot(self, "MainInfoPanel/BtnAward/IconNew")

	self.redAward:addHint({
		UIConst.RD_HINT_SENIORPVP_AWARD
	})

	self.txtTime = UIControls.Label(self, "MainInfoPanel/TextTime")
	self.txtAwardSpeed = UIControls.Label(self, "MainInfoPanel/BtnAward/AwardSpeedPanel/TextNum")
	self.txtAwardTotal = UIControls.Label(self, "MainInfoPanel/BtnAward/AwardTotalPanel/TextNum")
	self.txtRank = UIControls.Label(self, "MainInfoPanel/SelfInfoPanel/TextRankTitle/TextRank")
	self.txtPlayerName = UIControls.Label(self, "MainInfoPanel/SelfInfoPanel/TextPlayerName")
	self.txtLv = UIControls.Label(self, "MainInfoPanel/SelfInfoPanel/TextLvTitle/TextLv")
	self.txtPower = UIControls.Label(self, "MainInfoPanel/SelfInfoPanel/TextPowerTitle/TextPower")
	self.txtScore = UIControls.Label(self, "MainInfoPanel/SelfInfoPanel/TextScore")
	self.imgAwardSpeed = UIControls.Image(self, "MainInfoPanel/BtnAward/AwardSpeedPanel/Icon")
	self.imgAwardTotal = UIControls.Image(self, "MainInfoPanel/BtnAward/AwardTotalPanel/Icon")
	self.imgAwardIcon = UIControls.Image(self, "MainInfoPanel/BtnAward/Icon")
	self.imgSelfInfoPanel = UIControls.Image(self, "MainInfoPanel/SelfInfoPanel")
	self.imgLine = UIControls.Image(self, "MainInfoPanel/SelfInfoPanel/ImgLine")
	self.panelRankList = PVPRankListPanel(self, "MainInfoPanel/RankList")

	self.panelRankList:setPvpType(Const.PVP_RANK_TYPE_MULTI)

	self.aniAward = UIControls.UIAni(self, "MainInfoPanel/BtnAward/Icon")
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
end

function SeniorPvpMainDlg:initData(...)
	local iconPath = PVPCommon.getSeniorPvpAwardIcon()

	self.imgAwardSpeed:setImage(iconPath[1], iconPath[2])
	self.imgAwardTotal:setImage(iconPath[1], iconPath[2])
	self:initMyInfo()
	self:refreshTimeDown()
	self:refreshUI()

	self.typeRank = Const.RANK_TYPE_MULTIPVP

	CurAvatar:onRankListRequestNextPage(self.typeRank)
end

function SeniorPvpMainDlg:onOpen(...)
	SeniorPvpMainDlg.super.onOpen(self)
end

function SeniorPvpMainDlg:show(...)
	return
end

function SeniorPvpMainDlg:awardGetTimer(refresh)
	local info = PVPCommon.getRankPartInfo(CurAvatar.seniorPvpData.rank)

	self.awardSpeed = info.award_speed
	self.initAwardNum = CurAvatar.seniorPvpData.awrad_num
	self.initAwardTick = CurAvatar.seniorPvpData.award_tick

	if refresh then
		if self._timer then
			self._timer:Stop()
		end

		self._timer = nil
	end

	if self._timer == nil then
		self._timer = Timer.New(Slot(self._awardGetTimer, self), 5, -1)

		self._timer:Start()
	end

	self:_awardGetTimer()
end

function SeniorPvpMainDlg:_awardGetTimer(...)
	local num = self.initAwardNum + self.awardSpeed * (ClientUtils.getServerTime() - self.initAwardTick) / 600

	num = math.max(0, math.floor(num))
	self.awardNumNow = num

	local total = PVPCommon.getAwardLimit()

	self.txtAwardTotal:setText(math.min(total, num) .. "/" .. total)
	self:_refreshAwardIcon(num)
	RedDotManager.setKeyState(UIConst.RD_HINT_SENIORPVP_AWARD, num > 0 and num >= total * 0.5)
end

function SeniorPvpMainDlg:pointGetTimer(point, tick, refresh)
	local info = PVPCommon.getRankPartInfo(CurAvatar.seniorPvpData.rank)

	self.pointSpeed = info.score_speed
	self.initPoint = point
	self.initPointTick = tick

	self:_pointGetTimer()

	if refresh then
		if self._timerPoint then
			self._timerPoint:Stop()
		end

		self._timerPoint = nil
	end

	if self._timerPoint == nil then
		self._timerPoint = Timer.New(Slot(self._pointGetTimer, self), 5, -1)

		self._timerPoint:Start()
	end
end

function SeniorPvpMainDlg:_pointGetTimer(...)
	local num = self.initPoint + self.pointSpeed * (ClientUtils.getServerTime() - self.initPointTick) / 600

	self.txtScore:setText(num)
end

function SeniorPvpMainDlg:initMyInfo(...)
	self.txtPlayerName:setText(CurAvatar:getPlayerName())
	self.txtLv:setText(CurAvatar:getLevel())
end

function SeniorPvpMainDlg:refreshUI(...)
	local power = PVPCommon.getMySeniorPvpPower()

	self.txtPower:setText(power)
	self:refreshRankData(nil, CurAvatar.seniorPvpData.rank)
	self:_refreshAwardIcon(CurAvatar.seniorPvpData.awrad_num)
	self:awardGetTimer()
end

function SeniorPvpMainDlg:_refreshAwardIcon(num)
	if self.awardState == nil then
		if num > 0 then
			self.imgAwardIcon:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2", "IconGift1")

			self.awardState = STATE.FULL

			self.aniAward:startAniLoop("LoopAwardGet")
		else
			self.imgAwardIcon:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2", "IconGift2")

			self.awardState = STATE.EMPTY

			self.aniAward:stopAni("LoopAwardGet")
		end
	elseif self.awardState == STATE.EMPTY then
		if num > 0 then
			self.imgAwardIcon:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2", "IconGift1")

			self.awardState = STATE.FULL

			self.aniAward:startAniLoop("LoopAwardGet")
		end
	elseif num <= 0 then
		self.imgAwardIcon:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2", "IconGift2")

		self.awardState = STATE.EMPTY

		self.aniAward:stopAni("LoopAwardGet")
	end
end

function SeniorPvpMainDlg:refreshRankData(score, rank)
	local info = PVPCommon.getRankPartInfo(rank)

	if rank == 0 or rank > Const.SENIORPVP_RANK_COUNT then
		self.txtRank:setText(Lang.get(499))
	else
		self.txtRank:setText(rank)
	end

	PVPCommon.setRankUI(self.rankUIData, info)

	local index = tonumber(info.big_rank_idx)

	index = index or 1

	self.imgSelfInfoPanel:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPBgAtlas" .. index, "BgRank" .. index)
	self.imgLine:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPBgAtlas" .. index, "Line" .. index)
	self.txtAwardSpeed:setText(PVPCommon.getSpeedStr(info.award_speed))
end

function SeniorPvpMainDlg:setRankData(data, isLastPage)
	self.panelRankList:setDataList(data, isLastPage)
end

function SeniorPvpMainDlg:refreshRankList(...)
	self.panelRankList:refreshRankScroll()
end

function SeniorPvpMainDlg:refreshTimeDown(...)
	local leftTime = PVPCommon.getSeniorPvpLeftTime()

	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48654), nil, nil)
end

function SeniorPvpMainDlg:destroy(...)
	SeniorPvpMainDlg.super.destroy(self)

	if self._timer then
		self._timer:Stop()
	end

	self._timer = nil

	if self._timerPoint then
		self._timerPoint:Stop()
	end

	self._timerPoint = nil

	CurAvatar:onClearRankList()
end

function SeniorPvpMainDlg:emptyRankData()
	return
end

function SeniorPvpMainDlg:setSelfRankCell(selfData)
	CurAvatar.seniorPvpData.rank = selfData.rank

	self:refreshRankData(selfData.data.score, selfData.rank)
end

function SeniorPvpMainDlg:onBtnAwardTipClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_MULTIPVP_AWRAD_RULE)
end

function SeniorPvpMainDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function SeniorPvpMainDlg:onBtnTipClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_MULTIPVP)
end

function SeniorPvpMainDlg:onBtnAwardClick(...)
	if self.awardNumNow > 0 then
		RPC.multiPVPAwardGet()
		FlyIconUtils.sendFlyEvent(self.imgAwardIcon, PVPCommon.getAwardId(), self.awardNumNow)
	else
		MsgManager.notice(Lang.get(30659))
	end
end

function SeniorPvpMainDlg:onBtnDefendTeamClick(...)
	local formation = CurAvatar:getNowFormation(Const.FORMATION_MULTIPVP_DEFEND_1)

	if formation == nil or next(formation) == nil then
		local BattleConst = require("Common/FrameBattle/BattleConst")
		local battleData = {}

		battleData.multiPvpData = {}

		CurAvatar:enterFormation(10001, BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM, battleData)
	else
		UIManager.getUI("seniorPvpCheckTeamDlg", true):show(BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM)
	end
end

function SeniorPvpMainDlg:onBtnRecordClick(...)
	if ClientUtils.record.seniorPvpReports == nil or ClientUtils.getServerTime() > (ClientUtils.record.seniorPvpNextReportGetTime or 0) then
		RPC.multiPVPReportGet()
	elseif ClientUtils.record.seniorPvpReports then
		UIManager.getUI("seniorPvpRecordDlg", true):show()
	else
		RPC.multiPVPReportGet()
	end
end

function SeniorPvpMainDlg:onBtnStoreClick(...)
	UIManager.createAndFunc("mallDlg", "showShop", Const.JUMPSHOPTYPE_PVPSHOP)
end

function SeniorPvpMainDlg:onBtnChallengeClick(...)
	if PVPCommon.isMultiPvpFormationEmpty() then
		MsgManager.clientNotice(260)

		return
	end

	if ClientUtils.getServerTime() > (ClientUtils.record.seniorPvpNextMatchTime or 0) then
		RPC.multiPVPMatch()
	elseif ClientUtils.record.seniorPvpMatchData then
		UIManager.getUI("seniorPvpEnemyDlg", true):show()
	else
		RPC.multiPVPMatch()
	end
end

return SeniorPvpMainDlg
