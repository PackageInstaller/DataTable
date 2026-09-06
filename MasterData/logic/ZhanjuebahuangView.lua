-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/ZhanjuebahuangView.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.ZhanjuebahuangView", package.seeall)

local ZhanjuebahuangView = class("ZhanjuebahuangView", ViewComponent)

ZhanjuebahuangView.KEY_ID = 3

function ZhanjuebahuangView:buildUI()
	ZhanjuebahuangView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._ruleBtn = self:getBtn("topleft/btnRule")
	self._silder = self:getSlider("Slider")
	self._phase = {}

	for i = 1, 4 do
		self._phase[i] = {
			txt = goutil.findChildTextComponent(self._silder.gameObject, "phase_" .. i .. "/Text")
		}
		self._phase[i].item = goutil.findChild(self._silder.gameObject, "phase_" .. i .. "/item")
		self._phase[i].received = goutil.findChild(self._silder.gameObject, "phase_" .. i .. "/received")

		if i == 4 then
			self._phase[i].item2 = goutil.findChild(self._silder.gameObject, "phase_" .. i .. "/item2")
			self._phase[i].received2 = goutil.findChild(self._silder.gameObject, "phase_" .. i .. "/received2")
		end
	end

	self._rank = {}

	local rank = self:getGo("rank")

	for i = 1, 3 do
		local path = "cell_" .. i

		self._rank[i] = {
			head = goutil.findChild(rank, path .. "/head"),
			go = goutil.findChild(rank, path)
		}
		self._rank[i].name = goutil.findChildTextComponent(rank, path .. "/txtName")
		self._rank[i].time = goutil.findChildTextComponent(rank, path .. "/txtTime")
	end

	self._rankBtn = self:getBtn("rank/btnRank")
	self._rankEmpty = self:getGo("rank/empty")
	self._challengeBtn = self:getBtn("challengeBtn/btnStart")
	self._challengeBtnText = self:getTxt("challengeBtn/btnStart/Text")
	self._challengeText = self:getTxt("challengeBtn/txt")
	self._challengeTimesText = self:getTxt("challengeBtn/txtCurNum")
	self._role = self:getGo("con")
	self._bubbleGo = self:getGo("bubble")
	self._bubble = self:getTxt("bubble/Text")
	self._hpRect = goutil.findChildComponent(self.mainGO, "hpTip", goutil.Type_RectTransform)
	self._hpText = self:getTxt("hpTip/text")
	self._hpPetIcon = self:getGo("hpTip/petIcon")
	self._buffDesc = self:getTxt("buff/txtDesc")
end

function ZhanjuebahuangView:bindEvents()
	ZhanjuebahuangView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._ruleBtn:AddClickListener(self._onClickRule, self)
	self._rankBtn:AddClickListener(self._onClickRank, self)
	self._challengeBtn:AddClickListener(self._onClickChallenge, self)
end

function ZhanjuebahuangView:unbindEvents()
	ZhanjuebahuangView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._ruleBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._challengeBtn:RemoveClickListener()
end

function ZhanjuebahuangView:onEnter()
	ZhanjuebahuangView.super.onEnter(self)

	self._challengeId = tonumber(TianmanKingConfig.instance:getCommonValueByKey("CHALLENGE_ID"))
	self._linearPassedStage = TianmanKingModel.instance:getLinearPassedStage()

	local contractPets = TianmanKingConfig.instance:getSupportPet()
	local petCo = CharacterConfig.instance:getPetCo(contractPets[1].raceId)

	self._raceId = contractPets[1].raceId

	local displayBagOffset = CharactorFacade.instance:getPetBagModelUIPosAndScale(self._raceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._pet = RoleObjectPool.instance:addRoleToParent(self._pet, petCo.faceIds, self._role, scale, nil, true, x, y)

	GlobalDispatcher:addListener(TianmanKingController.PM_TMWCGetSingleChallengeInfoRes, self._handlePM_TMWCGetSingleChallengeInfoRes, self)
	GlobalDispatcher:addListener(TianmanKingController.PM_TMWCBuyChallengeTimesRes, self._handlePM_TMWCBuyChallengeTimesRes, self)
	GlobalDispatcher:addListener(TianmanKingController.PM_TMWCGainProgressPrizeRes, self._handlePM_TMWCGainProgressPrizeRes, self)
	TianManWangChallengeAgent.instance:sendPM_TMWCGetSingleChallengeInfoReq(3)

	self._challengeEff = UIEffectManager.instance:playEffect(self, "fx_ui_tmwtiaozhan/fx_ui_tmwtiaozhan_daiji.prefab", nil, 0, 0, true, nil, nil, function(_, eff)
		eff:setParent(self._challengeBtn.transform)
		eff:setScale(1)
		eff:setLocalPos()
	end)
end

function ZhanjuebahuangView:onExit()
	ZhanjuebahuangView.super.onExit(self)
	GlobalDispatcher:removeListener(TianmanKingController.PM_TMWCGetSingleChallengeInfoRes, self._handlePM_TMWCGetSingleChallengeInfoRes, self)
	GlobalDispatcher:removeListener(TianmanKingController.PM_TMWCBuyChallengeTimesRes, self._handlePM_TMWCBuyChallengeTimesRes, self)
	GlobalDispatcher:removeListener(TianmanKingController.PM_TMWCGainProgressPrizeRes, self._handlePM_TMWCGainProgressPrizeRes, self)
	UIEffectManager.instance:stopEffect(self._challengeEff)
end

function ZhanjuebahuangView:onExitFinished()
	ZhanjuebahuangView.super.onExitFinished(self)
	RoleObjectPool.instance:removeRole(self._pet)

	self._pet = nil

	UIEffectManager.instance:stopEffect(self._challengeEff)

	for i, v in ipairs(self._phase) do
		if self._phase[i].proxy then
			MaterialMgr.resetAll(self._phase[i].proxy)

			self._phase[i].proxy = nil
		end

		if self._phase[i].eff then
			UIEffectManager.instance:stopEffect(self._phase[i].eff)
		end

		if i == 4 then
			if self._phase[i].proxy2 then
				MaterialMgr.resetAll(self._phase[i].proxy2)

				self._phase[i].proxy2 = nil
			end

			if self._phase[i].eff2 then
				UIEffectManager.instance:stopEffect(self._phase[i].eff2)
			end
		end
	end
end

function ZhanjuebahuangView:_handlePM_TMWCGetSingleChallengeInfoRes(msg)
	self._passedStage = msg.bossChallengeInfo.passedStage
	self._todayChallengeTimes = msg.bossChallengeInfo.todayChallengeTimes
	self._todayChallengeBuyTimes = msg.bossChallengeInfo.todayChallengeBuyTimes
	self._bossMaxHp = msg.bossChallengeInfo.bossMaxHp
	self._bossCurHp = msg.bossChallengeInfo.bossCurHp
	self._progress = self._bossCurHp / self._bossMaxHp

	self._silder:SetValue(self._progress)

	self._hpText.text = TianmanKingController.instance:getText("TEXT_23", math.ceil(self._progress * 100))
	self._progressInfo = TianmanKingController:getProgressInfo(self._progress)

	if self._progressInfo.prizeId <= 1 then
		Framework.TransformUtil.SetAnchoredPos(self._hpRect, -432.17, 232)

		self._challengeBtnText.text = self._phase[1].txt.text
	elseif self._progressInfo.prizeId <= 2 then
		Framework.TransformUtil.SetAnchoredPos(self._hpRect, -432.17, 90)

		self._challengeBtnText.text = self._phase[2].txt.text
	elseif self._progressInfo.prizeId <= 3 then
		Framework.TransformUtil.SetAnchoredPos(self._hpRect, -432.17, -62)

		self._challengeBtnText.text = self._phase[3].txt.text
	else
		Framework.TransformUtil.SetAnchoredPos(self._hpRect, -432.17, -214)

		self._challengeBtnText.text = self._phase[3].txt.text
	end

	if self._progressInfo.bubble then
		goutil.setActive(self._bubbleGo, true)

		self._bubble.text = self._progressInfo.bubble
	else
		goutil.setActive(self._bubbleGo, false)
	end

	self._gainPrizeIds = {}

	for i, v in ipairs(msg.bossChallengeInfo.gainedPrizeIds or {}) do
		self._gainPrizeIds[v] = true
	end

	local prizeCfg = TianmanKingConfig.instance:getProgressPrize()

	for i, v in ipairs(self._phase) do
		self._phase[i].proxy = MaterialMgr.setCellByCfg(prizeCfg[i].prize, self._phase[i].item)

		goutil.setActive(self._phase[i].received, self._gainPrizeIds[i])

		if i <= self._progressInfo.prizeId and not self._gainPrizeIds[i] then
			self._phase[i].proxy.binder:setAutoTips(false)
			self._phase[i].proxy.binder:setCallBack(function()
				self._gainPrizeId = i

				TianManWangChallengeAgent.instance:sendPM_TMWCGainProgressPrizeReq(i)
			end)

			self._phase[i].eff = UIEffectManager.instance:playEffect(self, "fx_ui_longchengmibao/fx_ui_longchengmibao_nd.prefab", nil, 0, 0, true, nil, nil, function(_, eff)
				eff:setParent(self._phase[i].item.transform)
				eff:setScale(1)
				eff:setLocalPos()
			end)
		end

		if i == 4 then
			local list = string.split(prizeCfg[i].prize, "#")

			if list[2] then
				self._phase[i].proxy2 = MaterialMgr.setCellByCfg(list[2], self._phase[i].item2)

				goutil.setActive(self._phase[i].received2, self._gainPrizeIds[i])
			end

			if i <= self._progressInfo.prizeId and not self._gainPrizeIds[i] then
				self._phase[i].proxy2.binder:setAutoTips(false)
				self._phase[i].proxy2.binder:setCallBack(function()
					self._gainPrizeId = i

					TianManWangChallengeAgent.instance:sendPM_TMWCGainProgressPrizeReq(i)
				end)

				self._phase[i].eff2 = UIEffectManager.instance:playEffect(self, "fx_ui_longchengmibao/fx_ui_longchengmibao_nd.prefab", nil, 0, 0, true, nil, nil, function(_, eff)
					eff:setParent(self._phase[i].item2.transform)
					eff:setScale(1)
					eff:setLocalPos()
				end)
			end
		end
	end

	local buffCfg = TianmanKingConfig.instance:getBuffByLevel(msg.buffLevel)

	self._buffDesc.text = buffCfg and TianmanKingController.instance:getText("TEXT_10", msg.buffLevel, buffCfg.des) or ""

	local stageCo = TianmanKingConfig.instance:getStage()
	local typeCfg = TianmanKingConfig.instance:getTypeByType(ZhanjuebahuangView.KEY_ID)

	self._dailyTimes = typeCfg.freeDailyTimes

	local zhanStageCo = stageCo[3]

	if zhanStageCo[self._passedStage + 1] then
		local unlock = string.split(zhanStageCo[self._passedStage + 1].unlockParams, ",")

		if self._linearPassedStage < checknumber(unlock[2]) then
			self._challengeText.text = TianmanKingController.instance:getText("TEXT_18", self._linearPassedStage, checknumber(unlock[2]))
			self._challengeTimesText.text = ""
		else
			self._challengeText.text = ""

			local temp = math.max(0, self._dailyTimes + self._todayChallengeBuyTimes - self._todayChallengeTimes)

			self._challengeTimesText.text = TianmanKingController.instance:getText("TEXT_19", temp, self._dailyTimes)
		end
	else
		self._challengeText.text = ""
		self._challengeTimesText.text = TianmanKingController.instance:getText("TEXT_38")
	end

	local rankInfos = msg.bossChallengeInfo.rankInfos

	if #rankInfos == 0 then
		goutil.setActive(self._rank[1].go, false)
		goutil.setActive(self._rank[2].go, false)
		goutil.setActive(self._rank[3].go, false)
		goutil.setActive(self._rankEmpty, true)
	else
		goutil.setActive(self._rankEmpty, false)

		for i, cell in ipairs(self._rank) do
			if rankInfos[i] then
				goutil.setActive(self._rank[i].go, true)
				HeadItemController.instance:setHeadCellByInfo(self._rank[i].head, rankInfos[i].headInfo)

				self._rank[i].name.text = rankInfos[i].headInfo.userName
				self._rank[i].time.text = GameUtil.formatTimeStamp(TianmanKingController.instance:getText("TEXT_24"), rankInfos[i].gainTime / 1000)
			else
				goutil.setActive(self._rank[i].go, false)
			end
		end
	end
end

function ZhanjuebahuangView:_handlePM_TMWCBuyChallengeTimesRes()
	self._todayChallengeBuyTimes = self._todayChallengeBuyTimes + 1

	local typeCfg = TianmanKingConfig.instance:getTypeByType(ZhanjuebahuangView.KEY_ID)

	self._dailyTimes = typeCfg.freeDailyTimes

	local temp = math.max(0, self._dailyTimes + self._todayChallengeBuyTimes - self._todayChallengeTimes)

	self._challengeTimesText.text = TianmanKingController.instance:getText("TEXT_19", temp, self._dailyTimes)
end

function ZhanjuebahuangView:_handlePM_TMWCGainProgressPrizeRes()
	UIEffectManager.instance:stopEffect(self._phase[self._gainPrizeId].eff)
	self._phase[self._gainPrizeId].proxy.binder:setAutoTips(true)
	self._phase[self._gainPrizeId].proxy.binder:setCallBack()
	goutil.setActive(self._phase[self._gainPrizeId].received, true)

	if self._phase[self._gainPrizeId].eff2 then
		UIEffectManager.instance:stopEffect(self._phase[self._gainPrizeId].eff2)
	end

	if self._phase[self._gainPrizeId].proxy2 then
		self._phase[self._gainPrizeId].proxy2.binder:setAutoTips(true)
		self._phase[self._gainPrizeId].proxy2.binder:setCallBack()
	end

	if self._phase[self._gainPrizeId].received2 then
		goutil.setActive(self._phase[self._gainPrizeId].received2, true)
	end
end

function ZhanjuebahuangView:_onClickRule()
	local ruleKey = TianmanKingConfig.instance:getTypeByType(ZhanjuebahuangView.KEY_ID).ruleKey

	UIStateManager.instance:push(ViewName.RulesView, ruleKey)
end

function ZhanjuebahuangView:_onClickRank()
	UIStateManager.instance:push(ViewName.TianmankingrankView, self._challengeId)
end

function ZhanjuebahuangView:_onClickChallenge()
	if self._bossCurHp <= 0 then
		FloatWordMgr.instance:show(TianmanKingController.instance:getText("TEXT_36"))

		return
	end

	local stageCo = TianmanKingConfig.instance:getStageByTypeAndStage(3, self._progressInfo.prizeId)
	local unlock = string.split(stageCo.unlockParams, ",")

	if self._linearPassedStage < checknumber(unlock[2]) then
		FloatWordMgr.instance:show(TianmanKingController.instance:getText("TEXT_37"))
	elseif self._todayChallengeTimes < self._dailyTimes + self._todayChallengeBuyTimes then
		UIStateManager.instance:push(ViewName.TianmanKingMissionView, 3, self._progressInfo.prizeId)
	else
		self:_onClickBuyTimes()
	end
end

function ZhanjuebahuangView:_onClickBuyTimes()
	local typeCfg = TianmanKingConfig.instance:getTypeByType(ZhanjuebahuangView.KEY_ID)
	local buyTimesPlan = TianmanKingConfig.instance:getBuyTimesByPlan(typeCfg.buyTimesPlanId)

	if buyTimesPlan[self._todayChallengeBuyTimes + 1] then
		local consume = buyTimesPlan[self._todayChallengeBuyTimes + 1].consume
		local matType, matId, matNum = MaterialMgr.getMatParams(consume)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, TianmanKingController.instance:getText("TEXT_14", matNum, MaterialMgr.getContentMatStr(consume, 26, 0, true), #buyTimesPlan, #buyTimesPlan - self._todayChallengeBuyTimes), function()
			TianManWangChallengeAgent.instance:sendPM_TMWCBuyChallengeTimesReq(3)
		end)
	else
		TipsFacade.instance:openTipWindow(lang("tip"), TianmanKingController.instance:getText("TEXT_15", nil, nil, UnityEngine.TextAnchor.MiddleCenter))
	end
end

return ZhanjuebahuangView
