-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleMainView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleMainView", package.seeall)

local MahjongBattleMainView = class("MahjongBattleMainView", ViewComponent)

function MahjongBattleMainView:ctor()
	MahjongBattleMainView.super.ctor(self)
end

function MahjongBattleMainView:unbindEvents()
	MahjongBattleMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnCardluck)
	GameUtil.rmClickHandler(self._btnGiveUp)
	GameUtil.rmClickHandler(self._btnContinue)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnResetTeach)
	GameUtil.rmClickHandler(self._btnTeach)
end

function MahjongBattleMainView:bindEvents()
	MahjongBattleMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickBtnJump1, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickBtnJump2, self)
	GameUtil.addClickHandler(self._btnJump3, self._onClickBtnJump3, self)
	GameUtil.addClickHandler(self._btnJump4, self._onClickBtnJump4, self)
	GameUtil.addClickHandler(self._btnCardluck, self._onClickCardLuck, self)
	GameUtil.addClickHandler(self._btnGiveUp, self._onClickBtnGiveUp, self)
	GameUtil.addClickHandler(self._btnContinue, self._onClickBtnContinue, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnResetTeach, self._onClickBtnResetTeach, self)
	GameUtil.addClickHandler(self._btnTeach, self._onClickBtnTeach, self)
end

function MahjongBattleMainView:buildUI()
	MahjongBattleMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redPoint4 = self:getGo("jumpBtnCol/btnJump4/redPoint")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._imgNumScore = self:getGo("score/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._btnCardluck = self:getGo("cardluck")
	self._txtCurCardluck = self:getTxt("cardluck/txt")
	self._txtRank = self:getTxt("txtRank")
	self._preBattle = self:getGo("preBattle")
	self._btnStart = self:getGo("preBattle/btnStart")
	self._txtTimePreBattle = self:getTxt("preBattle/txtTime")
	self._inbattlecon = self:getGo("inbattlecon")
	self._btnGiveUp = self:getGo("inbattlecon/btnGiveUp")
	self._btnContinue = self:getGo("inbattlecon/btnContinue")
	self._txtTimeInbattle = self:getTxt("inbattlecon/txtTime")

	local goTabHp = self:getGo("inbattlecon/tableviewhp")
	local goCellhp = self:getGo("inbattlecon/tablecellhp")

	self._tableViewHp = ScrollerList.create(goTabHp, goCellhp, GameUtil.handler(self._updateCellHp, self), GameUtil.handler(self._clearCellHp, self))

	local goTabWin = self:getGo("inbattlecon/tableviewwin")
	local goCellWin = self:getGo("inbattlecon/tablecellwin")

	self._tableViewWin = ScrollerList.create(goTabWin, goCellWin, GameUtil.handler(self._updateCellWin, self), GameUtil.handler(self._clearCellWin, self))
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnResetTeach = self:getGo("btnResetTeach")
	self._btnTeach = self:getGo("btnTeach")
	self._txtBtnTeach = self:getTxt("btnTeach/txt")
end

function MahjongBattleMainView:onExit()
	MahjongBattleMainView.super.onExit(self)
	self._tableViewHp:dispose()
	self._tableViewWin:dispose()
	RedPointController.instance:unregRedPoint(self._redPoint4)
end

function MahjongBattleMainView:onEnter()
	MahjongBattleMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleRankViewRes, self._updateRankUI, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleRandomCardLuckRes, self._handleDrawCardLuck, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleDrawGenreRes, self._handleDrawGenre, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleGiveUpRes, self._handleGiveUp, self)
	self.addGEvent(self, GlobalNotify.MahjongBattleTeachDataChange, self._handleChangeTeachStage, self)
	GuideController.instance:setViewVar("mjbattle", 1)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 571001
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self:_updateTeachMode()
	self:_updateRankUI()
	MahjongBattleController.instance:getInfo(self._activityId)
	MahjongBattleController.instance:requestRankView(self._activityId)
	RedPointController.instance:regRedPoint(self._redPoint4, 768)
end

function MahjongBattleMainView:onEnterFinished()
	MahjongBattleMainView.super.onEnterFinished(self)

	if MahjongBattleController.instance:getIsPlayVideo() then
		MahjongBattleController.instance:playVideo()
	end
end

function MahjongBattleMainView:_updateUIByCfg()
	self._actCfg = MahjongBattleConfig.instance:getActivityCfg(self._activityId)
	self._dailyClgTimes = MahjongBattleConfig.instance:getCommonValueToNumber("DAILY_CLG_TIMES")
	self._maxWinTimesInSameFight = MahjongBattleConfig.instance:getCommonValueToNumber("END_NEED_WIN_TIMES")
	self._winTimesArr = {}

	for i = 1, self._maxWinTimesInSameFight do
		table.insert(self._winTimesArr, i)
	end

	self._maxHp = MahjongBattleConfig.instance:getCommonValueToNumber("ORIGIN_BLOOD")
	self._hpArr = {}

	for i = 1, self._maxHp do
		table.insert(self._hpArr, i)
	end

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local list = {}

	if not self._actCfg.goldBarStr then
		local costItemId = ""
		local attrList = string.split(costItemId, "#")

		for i, v in ipairs(attrList) do
			local data = {}

			data.id = v
			data.showAdd = false
			data.showAddCallBack = nil

			table.insert(list, data)
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end
end

function MahjongBattleMainView:_updateUIByInfo()
	local baseInfo = MahjongBattleModel.instance:getBaseInfoByActId(self._activityId)

	self._hasFinishTeach = false
	self._totalScore = 0
	self._todayChallengeTimes = 0
	self._curDecBloodNum = 0
	self._curRound = 0

	if baseInfo then
		self._totalScore = baseInfo.totalScore or 0
		self._todayChallengeTimes = baseInfo.todayChallengeTimes or 0

		local challengeInfo = baseInfo.challengeInfo

		if challengeInfo then
			self._curDecBloodNum = challengeInfo.decBloodNum or 0
			self._curRound = challengeInfo.curRound or 0
		end

		self._hasFinishTeach = baseInfo.hasFinishTeach or false
	end

	if self._hasFinishTeach then
		self:_finishGuide()
	end

	self._curHp = self._maxHp - self._curDecBloodNum
	self._curWinTimes = self._curRound - self._curDecBloodNum

	self._tableViewHp:reloadData(self._hpArr)
	self._tableViewWin:reloadData(self._winTimesArr)
	self._tableViewWin:setCenterMode(true)

	local leftTime = self._dailyClgTimes - self._todayChallengeTimes

	self._txtTimeInbattle.text = string.format("(<color=#20b376>%d</color>/%d)", leftTime, self._dailyClgTimes)
	self._txtTimePreBattle.text = string.format("(<color=#20b376>%d</color>/%d)", leftTime, self._dailyClgTimes)

	self._imgNumScore:SetNum(self._totalScore)
	self:_updateCardLuckUI()
	self:_handleUpdateState()
end

function MahjongBattleMainView:_updateRankUI()
	self._myRank = -1

	local rankInfo = MahjongBattleModel.instance:getRankInfoByActId(self._activityId)

	if rankInfo then
		self._myRank = rankInfo.myRank or -1
	end

	self._txtRank.text = checknumber(self._myRank) > 0 and string.format("(第%s名)", tostring(self._myRank)) or "(未上榜)"
end

function MahjongBattleMainView:_updateCardLuckUI()
	self._todayCardLuckId = 0

	local baseInfo = MahjongBattleModel.instance:getBaseInfoByActId(self._activityId)

	if baseInfo then
		self._todayCardLuckId = baseInfo.todayCardLuckId or 0
	end

	if self._todayCardLuckId > 0 then
		local cardLuckCfg = MahjongBattleConfig.instance:getCardLuckCfgById(self._activityId, self._todayCardLuckId)

		self._txtCurCardluck.text = cardLuckCfg and (cardLuckCfg.showDesc or "") or lang("未知牌运：ID") .. tostring(self._todayCardLuckId)
	else
		self._txtCurCardluck.text = lang("请抽取今日牌运")
	end
end

function MahjongBattleMainView:_handleDrawCardLuck()
	self:_updateCardLuckUI()
	UIStateManager.instance:push(ViewName.MahjongBattleCardluckView, self._activityId)
end

function MahjongBattleMainView:_handleGiveUp()
	self:_updateUIByInfo()
	self:_handleUpdateState()
end

function MahjongBattleMainView:_handleDrawGenre()
	MahjongBattleController.instance:continueGame(self._activityId)
end

function MahjongBattleMainView:_handleUpdateState()
	self._curState = MahjongBattleModel.instance:getCurStateByActId(self._activityId)

	if self._curState == MahjongBattleModel.PLAYER_STATE.NONE then
		goutil.setActive(self._preBattle, true)
		goutil.setActive(self._inbattlecon, false)
	else
		goutil.setActive(self._preBattle, false)
		goutil.setActive(self._inbattlecon, true)
		goutil.setActive(self._btnGiveUp, self._curState ~= MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_TEAM)
	end

	if MahjongBattleController.instance:getIsTeachMode() then
		goutil.setActive(self._btnGiveUp, false)
	end
end

function MahjongBattleMainView:_handleChangeTeachStage()
	self:_updateTeachMode()
end

function MahjongBattleMainView:_updateTeachMode()
	local curTeachStageId = MahjongBattleController.instance:getTeachStageId(self._activityId)
	local isInTeachMode = curTeachStageId and curTeachStageId ~= 0

	goutil.setActive(self._btnResetTeach, isInTeachMode)

	self._txtBtnTeach.text = isInTeachMode and "继续教学" or "进入教学"

	goutil.setActive(self._btnTeach, false)
	goutil.setActive(self._btnResetTeach, false)
end

function MahjongBattleMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function MahjongBattleMainView:_onClickBtnJump1()
	UIStateManager.instance:push(ViewName.MahjongBattleRankView, self._activityId)
end

function MahjongBattleMainView:_onClickBtnJump2()
	UIStateManager.instance:push(ViewName.MahjongBattleReportView, self._activityId)
end

function MahjongBattleMainView:_onClickBtnJump3()
	local jumpToStr = self._actCfg.gotoShop

	GotoMgr.gotoByString(jumpToStr)
end

function MahjongBattleMainView:_onClickBtnJump4()
	local jumpToStr = self._actCfg.gotoTask

	GotoMgr.gotoByString(jumpToStr)
end

function MahjongBattleMainView:_onClickCardLuck()
	if self._todayCardLuckId > 0 then
		UIStateManager.instance:push(ViewName.MahjongBattleCardluckView, self._activityId)

		return
	end

	MahjongBattleController.instance:randomCardLuck(self._activityId)
end

function MahjongBattleMainView:_onClickBtnGiveUp()
	if self._curState == MahjongBattleModel.PLAYER_STATE.NONE then
		FloatWordMgr.instance:show("当前未参与活动，无需放弃")

		return
	end

	local content = string.format("是否放弃本局，放弃后将会结算本局且扣除本次挑战次数")

	TipsFacade.instance:openPopupWindow("提示", content, function()
		MahjongBattleController.instance:giveUp(self._activityId)
	end)
end

function MahjongBattleMainView:_onClickBtnContinue()
	if not self._hasFinishTeach then
		self:_onClickBtnTeach()

		return
	end

	MahjongBattleController.instance:setTeachMode(false)

	if self._curState == MahjongBattleModel.PLAYER_STATE.NONE then
		FloatWordMgr.instance:show("当前未参与活动，无需继续")

		return
	end

	MahjongBattleController.instance:continueGame(self._activityId)
end

function MahjongBattleMainView:_onClickBtnStart()
	if not self._hasFinishTeach then
		self:_onClickBtnTeach()

		return
	end

	MahjongBattleController.instance:setTeachMode(false)

	local leftTime = self._dailyClgTimes - self._todayChallengeTimes

	if leftTime <= 0 then
		FloatWordMgr.instance:show("今日剩余挑战次数不足")

		return
	end

	if self._todayCardLuckId <= 0 then
		FloatWordMgr.instance:show("请先抽取今日牌运")

		return
	end

	if self._curState ~= MahjongBattleModel.PLAYER_STATE.NONE then
		FloatWordMgr.instance:show("当前已参与活动，无需重复开始")

		return
	end

	MahjongBattleController.instance:startGame(self._activityId)
end

function MahjongBattleMainView:_finishGuide()
	GuideController.instance:setViewVar("mjbattle", 0)
end

function MahjongBattleMainView:_onClickBtnTeach()
	MahjongBattleController.instance:setTeachMode(true)

	local curTeachStageId = MahjongBattleController.instance:getTeachStageId(self._activityId)

	if curTeachStageId and curTeachStageId ~= 0 then
		FloatWordMgr.instance:show("继续教学中...")
		MahjongBattleController.instance:continueGame(self._activityId)
	else
		MahjongBattleController.instance:setTeachStageId(self._activityId, 1)
		FloatWordMgr.instance:show("进入教学中...")
		MahjongBattleController.instance:continueGame(self._activityId)
	end
end

function MahjongBattleMainView:_onClickBtnResetTeach()
	MahjongBattleController.instance:setTeachStageId(self._activityId, 0)
end

function MahjongBattleMainView:_updateCellHp(view, cell, data)
	local go = cell.gameObject
	local heart = goutil.findChild(go, "heart")

	goutil.setActive(heart, data <= self._curHp)
end

function MahjongBattleMainView:_clearCellHp(cell)
	return
end

function MahjongBattleMainView:_updateCellWin(view, cell, data)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	goutil.setActive(goIcon, data <= self._curWinTimes)
end

function MahjongBattleMainView:_clearCellWin(cell)
	return
end

return MahjongBattleMainView
