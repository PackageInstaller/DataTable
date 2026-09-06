-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattlemainView.lua

module("logic.extensions.glorybattle.view.GlorybattlemainView", package.seeall)

local GlorybattlemainView = class("GlorybattlemainView", ViewComponent)

function GlorybattlemainView:buildUI()
	GlorybattlemainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump4 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4")
	self._btnAdd = self:getBtn("btnAdd")
	self._goPreBattle = self:getGo("preBattle")
	self._btnStart = self:getBtn("preBattle/btnStart")
	self._btnGiveUp = self:getBtn("inbattlecon/btnGiveUp")
	self._btnContinue = self:getBtn("inbattlecon/btnContinue")
	self._inbattleconGo = self:getGo("inbattlecon")
	self._txtPlayTime = self:getTxt("txtPlayTime")
	self._txtScore = self:getGo("txtScore"):GetComponent(ComponentType.UIImgNumeralText)
	self._txtRank = self:getTxt("txtRank")
	self._tablecellhpGo = self:getGo("inbattlecon/tablecellhp")
	self._tableviewwinGo = self:getGo("inbattlecon/tableviewwin")
	self._tablecellwinGo = self:getGo("inbattlecon/tablecellwin")
	self._tableviewhpGo = self:getGo("inbattlecon/tableviewhp")
	self._scrollerListHp = ScrollerList.create(self._tableviewhpGo, self._tablecellhpGo, GameUtil.handler(self._updateHpCell, self), GameUtil.handler(self._clearHpCell, self))
	self._scrollerListWin = ScrollerList.create(self._tableviewwinGo, self._tablecellwinGo, GameUtil.handler(self._updateWinCell, self), GameUtil.handler(self._clearWinCell, self))
	self._glodbarGo = self:getGo("glodbar")
	self._redPointGo4 = self:getGo("jumpBtnCol/btnJump4/redPoint")
end

function GlorybattlemainView:bindEvents()
	GlorybattlemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStr3"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStr4"))
	self._btnAdd:AddClickListener(self._onClickbtnAdd, self)
	self._btnStart:AddClickListener(self._onClickbtnStart, self)
	self._btnGiveUp:AddClickListener(self._onClickbtnGiveUp, self)
	self._btnContinue:AddClickListener(self._onClickbtnContinue, self)
end

function GlorybattlemainView:unbindEvents()
	GlorybattlemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	self._btnAdd:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnGiveUp:RemoveClickListener()
	self._btnContinue:RemoveClickListener()
end

function GlorybattlemainView:onEnter()
	GlorybattlemainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GloryBattleInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.GloryBattleGiveUpRes, self._onGloryBattleGiveUpRes, self)
	self.addGEvent(self, GlobalNotify.GloryBattleBuyTimesRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.GloryBattleRankViewRes, self._updateUI, self)

	self._activityType = GameEnum.ActivityType.GloryBattle
	self._activityId = self:_getActivityId()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	GlorybattleModel.instance:setCurrActivityId(self._activityId)

	if self._activityId <= 0 then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindowNoX("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actCfg = GlorybattleConfig.instance:getActCfg(self._activityId)
	self._params = GameUtil.jsonToTable(self._actCfg.paramStr)

	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = self._actCfg.showBar
	})
	MainUIController.instance:showGlodBar(self._glodbarGo, self._viewPresentor, btn_list, false)
	GloryBattleAgent.instance:sendPM_GloryBattleInfoReq(self._activityId)
	GloryBattleAgent.instance:sendPM_GloryBattleRankViewReq(self._activityId)
	RedPointController.instance:regRedPoint(self._redPointGo4, 739)
	self:_playEffect()
end

function GlorybattlemainView:onExit()
	GlorybattlemainView.super.onExit(self)
	self._scrollerListHp:dispose()
	self._scrollerListWin:dispose()
	RedPointController.instance:unregRedPoint(self._redPointGo4)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function GlorybattlemainView:_onClickBtnJump(key)
	local jumpToStr = self._params[key]

	GotoMgr.gotoByString(jumpToStr)
end

function GlorybattlemainView:_onClickBtnTip()
	local ruleKey = "glorybattlemain"

	TipsFacade.instance:openRulesView(ruleKey)
end

function GlorybattlemainView:_updateUI()
	local info = GlorybattleModel.instance:getInfo(self._activityId)

	if not info then
		return
	end

	local dailyTime = GlorybattleConfig.instance:getCommonValue("DAILY_CLG_TIMES", true)
	local leftTime = dailyTime + info.todayBuyTimes - info.todayChallengeTimes
	local genreId = info.challengeInfo.genreId
	local hasBattle = genreId > 0
	local opponent = GlorybattleModel.instance:getOpponent(self._activityId)

	self._txtPlayTime.text = leftTime > 0 and string.format("%s/%s", leftTime, dailyTime) or "∞"

	self._txtScore:SetNum(info.totalScore)
	goutil.setActive(self._btnStart.gameObject, not hasBattle)
	goutil.setActive(self._inbattleconGo, hasBattle)
	goutil.setActive(self._goPreBattle, not hasBattle)

	if hasBattle then
		self:_updateBattleUI()
	end

	if opponent and opponent.headInfo then
		GlorybattleController.instance:enterMission(self._activityId)
	end

	local rankMsg = GlorybattleModel.instance:getRankViewMsg()

	self._txtRank.text = rankMsg and (rankMsg.myRank > 0 and string.format("（第%s名）", rankMsg.myRank) or "（未上榜）") or "（未上榜）"
end

function GlorybattlemainView:_updateBattleUI()
	self._info = GlorybattleModel.instance:getInfo(self._activityId)

	local info = self._info

	if not info then
		return
	end

	local totalRound = GlorybattleConfig.instance:getCommonValue("END_NEED_WIN_TIMES", true)
	local bloodNum = GlorybattleConfig.instance:getCommonValue("ORIGIN_BLOOD", true)
	local decBloodNum = info.challengeInfo.decBloodNum
	local winTime = info.challengeInfo.curRound - info.challengeInfo.decBloodNum
	local winList = {}
	local hpList = {}

	for i = 1, totalRound do
		table.insert(winList, {
			winIdx = i,
			isGray = winTime < i
		})
	end

	for i = 1, bloodNum do
		table.insert(hpList, {
			hpIdx = i,
			isGray = i > bloodNum - decBloodNum
		})
	end

	self._scrollerListHp:reloadData(hpList)
	self._scrollerListWin:reloadData(winList)
end

function GlorybattlemainView:_getActivityId()
	local params = self:getOpenParam() or {}

	return (checknumber(params[1]))
end

function GlorybattlemainView:_onClickbtnAdd()
	local info = GlorybattleModel.instance:getInfo(self._activityId)

	if not info then
		return
	end

	local buyTimeLimit = GlorybattleConfig.instance:getCommonValue("BUY_TIMES_LIMIT", true)

	if buyTimeLimit <= info.todayBuyTimes then
		FloatWordMgr.instance:show("达今日购买次数上限")

		return
	end

	local buyCost = GlorybattleConfig.instance:getCommonValue("BUY_TIMES_COST")
	local matName = MaterialMgr.getMaterialsNameByCfg(buyCost)

	if not MaterialMgr.getMatEnough(buyCost) then
		FloatWordMgr.instance:show(string.format("购买消耗的%s不足", matName))

		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(buyCost)
	local content = string.format("是否消耗%s%s购买次数", matNum, matName)

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
		GloryBattleAgent.instance:sendPM_GloryBattleBuyTimesReq(self._activityId, 1)
	end)
end

function GlorybattlemainView:_onClickbtnStart()
	local info = GlorybattleModel.instance:getInfo(self._activityId)

	if not info then
		return
	end

	local dailyTime = GlorybattleConfig.instance:getCommonValue("DAILY_CLG_TIMES", true)

	UIStateManager.instance:push(ViewName.GlorybattleselectteamView, self._activityId)
end

function GlorybattlemainView:_onClickbtnGiveUp()
	local score = GlorybattleConfig.instance:getCommonValue("GIVE_UP_DEC_SCORE", true)
	local content = string.format("是否放弃本局，放弃后将会结算本局且扣除本次挑战次数")

	TipsFacade.instance:openPopupWindow("提示", content, function()
		GloryBattleAgent.instance:sendPM_GloryBattleGiveUpReq(self._activityId)
	end)
end

function GlorybattlemainView:_onClickbtnContinue()
	UIStateManager.instance:push(ViewName.GlorybattleshopView, self._activityId)
end

function GlorybattlemainView:_updateHpCell(view, cell, data, tag)
	GameUtil.SetGray(cell.gameObject, data.isGray)
end

function GlorybattlemainView:_clearHpCell(cell)
	return
end

function GlorybattlemainView:_updateWinCell(view, cell, data, tag)
	local goBg = goutil.findChild(cell.gameObject, "bg")
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	goutil.setActive(goIcon, not data.isGray)
end

function GlorybattlemainView:_clearWinCell(cell)
	return
end

function GlorybattlemainView:_onGloryBattleGiveUpRes()
	GloryBattleAgent.instance:sendPM_GloryBattleInfoReq(self._activityId)

	local key = "GlorybattleController_" .. self._activityId

	GameUtil.saveUserData(key, 0)
end

function GlorybattlemainView:_playEffect()
	local effName = "20251024/pvp/fx_ui_jiemian1_pvp.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

return GlorybattlemainView
