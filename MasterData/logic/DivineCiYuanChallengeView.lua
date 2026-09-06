-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/view/DivineCiYuanChallengeView.lua

module("logic.extensions.divineciyuan.view.DivineCiYuanChallengeView", package.seeall)

local DivineCiYuanChallengeView = class("DivineCiYuanChallengeView", ViewComponent)

function DivineCiYuanChallengeView:ctor()
	DivineCiYuanChallengeView.super.ctor(self)
end

function DivineCiYuanChallengeView:unbindEvents()
	DivineCiYuanChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge_1)
	GameUtil.rmClickHandler(self._btnChallenge_2)
	GameUtil.rmClickHandler(self._btnEvolution)
	GameUtil.rmClickHandler(self._btnGift)
	GameUtil.rmClickHandler(self._btnPassport)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnReceive1)
	GameUtil.rmClickHandler(self._btnReceive2)
end

function DivineCiYuanChallengeView:bindEvents()
	DivineCiYuanChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge_1, self._onClickChallenge1, self)
	GameUtil.addClickHandler(self._btnChallenge_2, self._onClickChallenge2, self)
	GameUtil.addClickHandler(self._btnEvolution, self._onClickEvolution, self)
	GameUtil.addClickHandler(self._btnGift, self._onClickGift, self)
	GameUtil.addClickHandler(self._btnPassport, self._onClickPassport, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnReceive1, GameUtil.handler(self._onClickReceive, self, 2))
	GameUtil.addClickHandler(self._btnReceive2, GameUtil.handler(self._onClickReceive, self, 1))
end

function DivineCiYuanChallengeView:buildUI()
	DivineCiYuanChallengeView.super.buildUI(self)

	self._rare = self:getGo("petInfo/rare")
	self._petCon = self:getGo("con")
	self._goChallenge1 = self:getGo("btnChallenge_1")
	self._rewardGo2 = self:getGo("btnChallenge_2/reward")
	self._reward1 = self:getGo("btnChallenge_1/reward/pointItem")
	self._reward2 = self:getGo("btnChallenge_2/reward/pointItem")
	self._effectParent1 = self:getGo("btnChallenge_1/reward/effect")
	self._effectParent2 = self:getGo("btnChallenge_2/reward/effect")
	self._receive1 = self:getGo("btnChallenge_1/reward/receive")
	self._receive2 = self:getGo("btnChallenge_2/reward/receive")
	self._challengeRd1 = self:getGo("btnChallenge_1/btn/redPoint")
	self._challengeRd2 = self:getGo("btnChallenge_2/btn/redPoint")
	self._timeGo = self:getGo("time")
	self._txtTime = self:getTxt("time/txt")
	self._txtName = self:getTxt("petInfo/txtName")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnChallenge_1 = self:getBtn("btnChallenge_1/btn")
	self._btnChallenge_2 = self:getBtn("btnChallenge_2/btn")
	self._btnEvolution = self:getBtn("btnEvolution")
	self._btnGift = self:getBtn("btnGift")
	self._btnPassport = self:getBtn("btnPassport")
	self._btnRank = self:getBtn("btnRank")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnReceive1 = self:getBtn("btnChallenge_1/reward/btnReceive")
	self._btnReceive2 = self:getBtn("btnChallenge_2/reward/btnReceive")

	self:_recordGoDefaultActive(self._timeGo)
	self:_recordGoDefaultActive(self._goChallenge1)
	self:_recordGoDefaultActive(self._btnEvolution.gameObject)
	self:_recordGoDefaultActive(self._btnGift.gameObject)
	self:_recordGoDefaultActive(self._btnPassport.gameObject)
	self:_recordGoDefaultActive(self._btnRank.gameObject)
	self:_recordGoDefaultActive(self._rewardGo2.gameObject)
end

function DivineCiYuanChallengeView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function DivineCiYuanChallengeView:_isActiveInDefault(go)
	self._goDefaultActives = self._goDefaultActives or {}

	return self._goDefaultActives[go]
end

function DivineCiYuanChallengeView:_refreshDefaultActive(go)
	GameUtil.SetActive(go, self:_isActiveInDefault(go))
end

function DivineCiYuanChallengeView:onExit()
	DivineCiYuanChallengeView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._loader)
	MaterialMgr.resetAll(self._rare)
	MaterialMgr.resetAll(self._reward1)
	MaterialMgr.resetAll(self._reward2)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	if self._effectList then
		for _, effect in ipairs(self._effectList) do
			if effect then
				UIEffectManager.instance:stopEffect(effect)
			end
		end
	end

	RedPointController.instance:unregRedPoint(self._challengeRd1)
	RedPointController.instance:unregRedPoint(self._challengeRd2)
end

function DivineCiYuanChallengeView:onEnter()
	DivineCiYuanChallengeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivineCiYuanController.instance:getActivityId()
	end

	self._activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local isInTime = DivineCiYuanController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.DivineCiYuanGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.DivineCiYuanGainPrizeRes, self._sendGetInfoReq, self)
	RedPointController.instance:regRedPoint(self._challengeRd1, RedPointModel.ID_DIVINECIYUAN)
	RedPointController.instance:regRedPoint(self._challengeRd2, RedPointModel.ID_O21)
	self:_sendGetInfoReq()
	self:_initUI()
	self:_initAoqiGodUI()

	self._isPassExtreme = false
	self._isPassUniversal = false
end

function DivineCiYuanChallengeView:_sendGetInfoReq()
	DivineCiYuanController.instance:sendPM_DivineCiYuanGetInfoReq(self._activityId)
end

function DivineCiYuanChallengeView:_initUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DivineCiYuan, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))
	self._actCfg = DivineCiYuanConfig.instance:getActCfgById(self._activityId)

	local x, y, scale = 0, 0, 1

	self._raceId = self._actCfg.raceId
	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, self._raceId, self._petCon, scale, nil, true, x, y)

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rare)
	MaterialMgr.setCellByCfg(self._actCfg.universalPassPrize, self._reward1)
	MaterialMgr.setCellByCfg(self._actCfg.extremePassPrize, self._reward2)

	self._txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, self._raceId)

	self:_playIdleEffect()
end

function DivineCiYuanChallengeView:_initAoqiGodUI()
	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._timeGo, false)
		GameUtil.SetActive(self._goChallenge1, false)
		GameUtil.SetActive(self._btnEvolution.gameObject, false)
		GameUtil.SetActive(self._btnGift.gameObject, false)
		GameUtil.SetActive(self._btnPassport.gameObject, false)
		GameUtil.SetActive(self._btnRank.gameObject, false)
		GameUtil.SetActive(self._rewardGo2.gameObject, false)
	else
		self:_refreshDefaultActive(self._timeGo)
		self:_refreshDefaultActive(self._goChallenge1)
		self:_refreshDefaultActive(self._btnEvolution.gameObject)
		self:_refreshDefaultActive(self._btnGift.gameObject)
		self:_refreshDefaultActive(self._btnPassport.gameObject)
		self:_refreshDefaultActive(self._btnRank.gameObject)
		self:_refreshDefaultActive(self._rewardGo2.gameObject)
	end
end

function DivineCiYuanChallengeView:_refresh()
	local tabCfg = DivineCiYuanConfig.instance:getUniversalAllStageCfg(self._activityId)

	self._isPassChallenge = true
	self._isAllSign = true
	self._remainTimes = 0

	local isLight = false

	for tabId, _ in ipairs(tabCfg) do
		local isPassChallenge = DivineCiYuanController.instance:isPassUniversalTab(tabId)
		local isUnLock = DivineCiYuanController.instance:isUnLockUniversalTab(tabId)

		if not isPassChallenge and isUnLock then
			self._isPassChallenge = false

			local challengeTimes = DivineCiYuanModel.instance:getTodayChallengeTimes(tabId)
			local remainTimes = Mathf.Clamp(self._actCfg.universalDailyTimes - challengeTimes, 0, self._actCfg.universalDailyTimes)

			if remainTimes > 0 then
				isLight = true
			end
		end

		local allSign = DivineCiYuanController.instance:isAllSign(self._activityId, tabId)

		if not allSign then
			self._isAllSign = false
		end

		local signRd = DivineCiYuanController.instance:isLightSignRd()

		if signRd then
			isLight = true
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DIVINECIYUAN, isLight)

	self._isPassUniversal = self._isPassChallenge and self._isAllSign
	self._isPassExtreme = DivineCiYuanController.instance:isPassExtremeChallenge(self._activityId)

	local isGainNational = DivineCiYuanModel.instance:isGainUniversalPrize()
	local isGainExtreme = DivineCiYuanModel.instance:isGainExtremePrize()

	GameUtil.SetActive(self._btnReceive1, self._isPassUniversal)
	GameUtil.SetActive(self._btnReceive2, self._isPassExtreme)
	GameUtil.SetActive(self._receive1, isGainNational)
	GameUtil.SetActive(self._receive2, isGainExtreme)

	if self._effectList then
		for _, effect in ipairs(self._effectList) do
			if effect then
				UIEffectManager.instance:stopEffect(effect)
			end
		end
	end

	local path = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	if self._isPassUniversal and not isGainNational then
		self:_playEffect(path, self._effectParent1)
	end

	if self._isPassExtreme and not isGainExtreme then
		self:_playEffect(path, self._effectParent2)
	end
end

function DivineCiYuanChallengeView:_playIdleEffect()
	local effectPath = "20230929/shenyaociyuanlong/fx_ui_shenyaociyuanlong_fw2.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effectPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function DivineCiYuanChallengeView:_playEffect(path, parent)
	local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	self._effectList = {}

	local effect = UIEffectManager.instance:playEffect(self, effectPath, parent, 0, 0, true, nil, nil, function(target, eff)
		eff:setClipping(parent:GetComponent(goutil.Type_RectTransform))
	end, self)

	effect:setParent(parent.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)
	table.insert(self._effectList, effect)
end

function DivineCiYuanChallengeView:_onClickTip()
	local key = DivineCiYuanConfig.instance:getActRuleKey(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function DivineCiYuanChallengeView:_onClickChallenge1()
	if self._isAoqiGodProcessType then
		return
	end

	if self._isPassUniversal then
		FloatWordMgr.instance:show("已通关~")

		return
	end

	UIStateManager.instance:push(ViewName.DivineCiYuanNationalView, self._activityId)
end

function DivineCiYuanChallengeView:_onClickChallenge2()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	if self._isPassExtreme then
		FloatWordMgr.instance:show("已通关~")

		return
	end

	UIStateManager.instance:push(ViewName.DivineCiYuanExtremeView, self._activityId)
end

function DivineCiYuanChallengeView:_onClickReceive(type)
	DivineCiYuanController.instance:sendPM_DivineCiYuanGainPrizeReq(self._activityId, type)
end

function DivineCiYuanChallengeView:_onClickEvolution()
	GotoMgr.gotoByString(self._actCfg.jump_evolution)
end

function DivineCiYuanChallengeView:_onClickGift()
	GotoMgr.gotoByString(self._actCfg.jump_gift)
end

function DivineCiYuanChallengeView:_onClickPassport()
	GotoMgr.gotoByString(self._actCfg.jump_passport)
end

function DivineCiYuanChallengeView:_onClickRank()
	GotoMgr.gotoByString(self._actCfg.jump_rank)
end

function DivineCiYuanChallengeView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function DivineCiYuanChallengeView:_onClickSkill()
	PetbookController.instance:previewBattle(self._raceId, self._raceId)
end

return DivineCiYuanChallengeView
