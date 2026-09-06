-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyparty/view/FamilyPartyMainView.lua

module("logic.extensions.familyparty.view.FamilyPartyMainView", package.seeall)

local FamilyPartyMainView = class("FamilyPartyMainView", ViewComponent)

function FamilyPartyMainView:ctor()
	FamilyPartyMainView.super.ctor(self)

	self._uiFlyTweenParam = UIFlyTweenParam.New()
end

function FamilyPartyMainView:buildUI()
	FamilyPartyMainView.super.buildUI(self)

	self._sliderActTime = self:getSlider("actTime/slider")
	self._txtActTimeDesc = self:getTxt("actTime/txtDesc")
	self._txtActTimeCountdown = self:getTxt("actTime/txtTime")
	self._sliderBoxReward = self:getSlider("reward/boxReward/slider")
	self._txtBoxRewardDesc = self:getTxt("reward/boxReward/txtDesc")
	self._txtWeekly = self:getTxt("reward/txtWeekly")
	self._btnAnswer = self:getBtn("btnAnswer")
	self._txtAnswer = self:getTxt("txtAnswer")
	self._answerGo = self:getGo("answer")
	self._btnHide = self:getBtn("answer/btnHide")
	self._txtQuestion = self:getTxt("answer/txtQuestion")
	self._txtCountdown = self:getTxt("answer/countdown/txt")
	self._answerList = {}

	for i = 1, 4 do
		local go = self:getGo("answer/answer" .. i)
		local element = {}

		element.go = go
		element.txtDesc = goutil.findChildTextComponent(go, "btn/txtDesc")
		element.txtNum = goutil.findChildTextComponent(go, "btn/txtDesc/txtNum")
		element.btn = Framework.ButtonAdapter.GetFrom(go, "btn")
		element.groupChange = element.btn.gameObject:GetComponent(ComponentType.UIChangeGroup)
		self._answerList[i] = element
	end

	self._rewardList = {}

	for i = 1, 3 do
		local go = self:getGo("reward/reward" .. i)
		local element = {}

		element.go = go
		element.effect = goutil.findChild(go, "effect")
		element.node = goutil.findChild(go, "node")
		self._rewardList[i] = element
	end

	self._rectTrans = self.mainGO:GetComponent(goutil.Type_RectTransform)
end

function FamilyPartyMainView:bindEvents()
	FamilyPartyMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnAnswer, self._onClickOpenAnswer, self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHideAnswer, self)

	for i = 1, 4 do
		self._answerList[i].btn:AddClickListener(function()
			self:_onClickAnswer(i)
		end)
	end
end

function FamilyPartyMainView:unbindEvents()
	FamilyPartyMainView.super.unbindEvents(self)

	for i = 1, 4 do
		self._answerList[i].btn:RemoveClickListener()
	end
end

function FamilyPartyMainView:_activeJoyStick()
	return
end

function FamilyPartyMainView:onEnter()
	FamilyPartyMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FamilyPartyGainIdlePrizeRes, self._onGainIdlePrizeRes, self)
	self.addGEvent(self, GlobalNotify.FamilyPartyAnswerQuestionRes, self._onAnswerQuestionRes, self)
	self.addGEvent(self, GlobalNotify.FamilyPartyNotifyNextQuestionRes, self._onNotifyNextQuestionRes, self)
	self.addGEvent(self, GlobalNotify.FamilyPartyNotifyQuestionResultRes, self._onNotifyQuestionResultRes, self)
	self.addGEvent(self, GlobalNotify.FamilyPartyNotifyOptionInfoChangeRes, self._onNotifyOptionInfoChangeRes, self)
	self.addGEvent(self, GlobalNotify.FamilySceneNotifyJoinResultRes, self._onNotifyJoinResultRes, self)

	self._startTimestamp = FamilyPartyModel.instance:getPartyStartTime()
	self._endTimestamp = FamilyPartyModel.instance:getPartyEndTime()
	self._duration = self._endTimestamp - self._startTimestamp
	self._maxRewardCount = checknumber(FamilyPartyConfig.instance:getCommonValue("IDLE_PRIZE_LIMIT"))
	self._rewardDuration = checknumber(FamilyPartyConfig.instance:getCommonValue("IDLE_PRIZE_PERIOD"))
	self._maxQuestionNum = checknumber(FamilyPartyConfig.instance:getCommonValue("QUESTION_COUNT"))
	self._answerShowTime = checknumber(FamilyPartyConfig.instance:getCommonValue("QUESTION_CORRECT_ANSWER_SHOW"))
	self._answerQuestionTime = checknumber(FamilyPartyConfig.instance:getCommonValue("QUESTION_ANSWER_SEC"))
	self._weeklyIdlePrizeLimit = 10
	self._predictCanGetNum = 0

	printInfo("test FamilyPartyMainView:onEnter", self._startTimestamp, self._endTimestamp, self._duration)
	self:_initRewards()
	self:_updateAnswerQuestionState()
	self:_initQuestionCountdown()
	settimer(0, self._onUpdate, self)
end

function FamilyPartyMainView:onExit()
	FamilyPartyMainView.super.onExit(self)
	removetimer(self._onUpdate, self)
	self:_clearRewards()
	self:_clearTween()
end

function FamilyPartyMainView:onEnterFinished()
	FamilyPartyMainView.super.onEnterFinished(self)

	self._answerPos = GameUtil.getPos(self._answerGo)
	self._answerScale = GameUtil.getLocalScale(self._answerGo)
end

function FamilyPartyMainView:onExitFinished()
	GameUtil.setPos(self._answerGo, self._answerPos.x, self._answerPos.y, self._answerPos.z)
	GameUtil.setLocalScale(self._answerGo, self._answerScale.x, self._answerScale.y, self._answerScale.z)
end

function FamilyPartyMainView:_onClickOpenAnswer()
	if FamilyPartyModel.instance:isAnswerQuestioning() then
		local activeSelf = GameUtil.GetActive(self._answerGo)

		if activeSelf then
			self:_playHideAnswerAnimation(function()
				GameUtil.SetActive(self._answerGo, false)
			end)
		else
			GameUtil.SetActive(self._answerGo, true)
			self:_playShowAnswerAnimation()
		end
	elseif FamilyPartyModel.instance:isAnswerEnd() then
		FloatWordMgr.instance:show("答题已结束")
	else
		FloatWordMgr.instance:show("答题未开始")
	end
end

function FamilyPartyMainView:_onClickHideAnswer()
	self:_playHideAnswerAnimation(function()
		GameUtil.SetActive(self._answerGo, false)
	end)
end

function FamilyPartyMainView:_onClickAnswer(answerIndex)
	if FamilyPartyModel.instance:isAnswerQuestioning() then
		if FamilyPartyModel.instance:isCanAnswerQuestionState() then
			local partyTimeMillis = FamilyPartyModel.instance:getPartyTimeMillis()
			local questionIndex = FamilyPartyModel.instance:getAnswerQuestionCurIndex()
			local oldAnswerIndex = FamilyPartyModel.instance:getAnswerQuestionInfo(questionIndex)

			if oldAnswerIndex ~= answerIndex then
				FamilyPartyAgent.instance:sendPM_FamilyParty_AnswerQuestionReq(partyTimeMillis, questionIndex, answerIndex)
			end
		elseif FamilyPartyModel.instance:isAnswerEnd() then
			FloatWordMgr.instance:show("答题已结束")
		else
			FloatWordMgr.instance:show("公示答案中")
		end
	else
		FloatWordMgr.instance:show("答题已结束")
	end
end

function FamilyPartyMainView:_onClickReward(index, rewardStr, go)
	local getedNum = FamilyPartyModel.instance:getHasGainIdlePrizeCount()
	local canGetNum = FamilyPartyModel.instance:getAccIdlePrizeCount()
	local startTimestamp = FamilyPartyModel.instance:getStartIdleTimestamp()
	local duration = startTimestamp > 0 and ServerTime.now() - startTimestamp or 0

	duration = duration > 0 and duration or 0

	local predictNum = math.floor(duration / self._rewardDuration)
	local matType, id, matNum = MaterialMgr.getMatParams(rewardStr)

	if getedNum < self._maxRewardCount then
		if canGetNum + predictNum > 0 then
			local leftWeekNum = self._weeklyIdlePrizeLimit - FamilyPartyModel.instance:getWeeklyGainPrizeCount()

			if leftWeekNum > 0 then
				local partyTimeMillis = FamilyPartyModel.instance:getPartyTimeMillis()

				FamilyPartyAgent.instance:sendPM_FamilyParty_GainIdlePrizeReq(partyTimeMillis, index)
			else
				CommonTipsMgr.instance:openMaterialTips(go, matType, id, 0)
			end
		else
			CommonTipsMgr.instance:openMaterialTips(go, matType, id, 0)
		end
	else
		CommonTipsMgr.instance:openMaterialTips(go, matType, id, 0)
	end
end

function FamilyPartyMainView:_onGainIdlePrizeRes()
	return
end

function FamilyPartyMainView:_onAnswerQuestionRes()
	self:_updateAnswerQuestionState()
end

function FamilyPartyMainView:_onNotifyNextQuestionRes()
	self:_updateAnswerQuestionState(true)

	local curIndex = FamilyPartyModel.instance:getAnswerQuestionCurIndex()

	if curIndex == 1 then
		-- block empty
	end

	if curIndex > 0 then
		self:_setQuestionCountdown(ServerTime.now() + self._answerQuestionTime)
	end
end

function FamilyPartyMainView:_onNotifyQuestionResultRes()
	self:_updateAnswerQuestionState()

	local curIndex = FamilyPartyModel.instance:getAnswerQuestionCurIndex()

	if curIndex > 0 then
		self:_setQuestionCountdown(ServerTime.now() + self._answerShowTime)
	end

	printInfo("test FamilyPartyMainView:_onNotifyQuestionResultRes 1", FamilyPartyModel.instance:isAnswerEnd())

	if FamilyPartyModel.instance:isAnswerEnd() then
		self:_playTween()
	end
end

function FamilyPartyMainView:_playTween()
	self._tweenDelay = TweenUtil.DoDelay(self._answerShowTime, function()
		self._tweenDelay = nil

		if not goutil.isNil(self._answerGo) then
			GameUtil.SetActive(self._answerGo, false)
		end
	end)
end

function FamilyPartyMainView:_clearTween()
	if self._tweenDelay then
		self._tweenDelay:Kill()

		self._tweenDelay = nil
	end

	if self._flyTween then
		self._flyTween:Kill(true)

		self._flyTween = nil
	end
end

function FamilyPartyMainView:_onNotifyOptionInfoChangeRes()
	self:_updateAnswerQuestionState()
end

function FamilyPartyMainView:_onNotifyJoinResultRes()
	return
end

function FamilyPartyMainView:_onUpdate()
	self:_updateActTime()
	self:_updateBoxReward()
	self:_updateAnswerCountdownAndProgress()
	self:_updateCountdown()
end

function FamilyPartyMainView:_updateActTime()
	local curTime = ServerTime.now()
	local leftTime = self._endTimestamp - curTime

	leftTime = leftTime > 0 and leftTime or 0

	local leftPercent = leftTime / self._duration

	self._sliderActTime:SetValue(leftPercent)

	self._txtActTimeCountdown.text = GameUtil.FormatTimeWords(leftTime, true)
end

function FamilyPartyMainView:_updateBoxReward()
	local getedNum = FamilyPartyModel.instance:getHasGainIdlePrizeCount()
	local canGetNum = FamilyPartyModel.instance:getAccIdlePrizeCount()
	local startTimestamp = FamilyPartyModel.instance:getStartIdleTimestamp()
	local duration = startTimestamp > 0 and ServerTime.now() - startTimestamp or 0

	duration = duration > 0 and duration or 0

	local predictNum = math.floor(duration / self._rewardDuration)
	local progress = duration % self._rewardDuration + 1
	local predictCanGetNum = canGetNum + predictNum

	predictCanGetNum = predictCanGetNum > self._maxRewardCount and self._maxRewardCount or predictCanGetNum
	self._txtBoxRewardDesc.text = string.format("本场剩余次数：%d/%d", predictCanGetNum, self._maxRewardCount)

	local leftWeekNum = self._weeklyIdlePrizeLimit - FamilyPartyModel.instance:getWeeklyGainPrizeCount()

	leftWeekNum = leftWeekNum > 0 and leftWeekNum or 0
	self._txtWeekly.text = string.format("本周剩余次数：<color=%s>%d</color>", (leftWeekNum > 0 or nil) and (ColorConst.White or ColorConst.Red), leftWeekNum)

	local totalNum = getedNum + canGetNum + predictNum

	totalNum = totalNum > self._maxRewardCount and self._maxRewardCount or totalNum

	local percent = totalNum >= self._maxRewardCount and 1 or progress / self._rewardDuration

	self._sliderBoxReward:SetValue(percent)
	self:_updateRewards(predictCanGetNum)
end

function FamilyPartyMainView:_updateAnswerCountdownAndProgress()
	if not FamilyPartyModel.instance:isStartAnswerQuestion() then
		local startTimestamp = FamilyPartyModel.instance:getStartAnswerQuestionTime()
		local leftTime = startTimestamp - ServerTime.now()

		leftTime = leftTime > 0 and leftTime or 0
		self._txtAnswer.text = string.format("开始倒计时\n%s", GameUtil.FormatTimeWords(leftTime, true))
	else
		local curIndex = FamilyPartyModel.instance:getAnswerQuestionCurIndex()

		self._txtAnswer.text = not FamilyPartyModel.instance:isAnswerEnd() and string.format("题目数量\n%d/%d", curIndex == 0 and 0 or curIndex > 0 and curIndex or self._maxQuestionNum, self._maxQuestionNum) or "答题结束"
	end
end

function FamilyPartyMainView:_initRewards()
	self._uiEffects = {}

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	for i, v in ipairs(self._rewardList) do
		local rewardStr = FamilyPartyConfig.instance:getCommonValue("PARTY_IDLE_PRIZE_" .. i)
		local proxy = MaterialMgr.setCellByCfg(rewardStr, v.node)

		proxy.binder:setAutoTips(false)
		proxy:setCallBack(function()
			self:_onClickReward(i, rewardStr, v.node)
		end)
		GameUtil.SetActive(v.effect, false)

		local uiEffect = UIEffectManager.instance:playEffect(self, effPath, v.effect.transform, 0, 0, true, false, nil, function(target, eff)
			if not goutil.isNil(self._rectTrans) then
				eff:setClipping(self._rectTrans)
			end
		end)

		uiEffect:setParent(v.effect.transform)
		uiEffect:setLocalPos(0, 0, 0)
		uiEffect:setScale(1)
		table.insert(self._uiEffects, uiEffect)
	end
end

function FamilyPartyMainView:_updateRewards(predictCanGetNum)
	self._predictCanGetNum = predictCanGetNum

	local leftWeekNum = self._weeklyIdlePrizeLimit - FamilyPartyModel.instance:getWeeklyGainPrizeCount()

	for i, v in ipairs(self._rewardList) do
		GameUtil.SetActive(v.effect, self._predictCanGetNum > 0 and leftWeekNum > 0)
	end
end

function FamilyPartyMainView:_clearRewards()
	for i, v in ipairs(self._rewardList) do
		MaterialMgr.resetAll(v.node)
	end

	if self._uiEffects then
		for i, v in ipairs(self._uiEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._uiEffects = nil
	end
end

function FamilyPartyMainView:_updateAnswerQuestionState(isShow)
	local answerGameInfo = FamilyPartyModel.instance:getAnswerGameInfo()

	if not answerGameInfo then
		GameUtil.SetActive(self._answerGo, false)

		return
	end

	if answerGameInfo.currentIndex <= 0 then
		GameUtil.SetActive(self._answerGo, false)
	else
		if isShow then
			GameUtil.SetActive(self._answerGo, isShow)
		end

		local cfg = FamilyPartyConfig.instance:getQuestionCfg(answerGameInfo.currentQuestionId)

		if cfg then
			local curIndex = FamilyPartyModel.instance:getAnswerQuestionCurIndex()

			self._txtQuestion.text = string.format("(%d/%d)", answerGameInfo.currentIndex, self._maxQuestionNum) .. cfg.question

			for i, v in ipairs(self._answerList) do
				v.txtDesc.text = cfg["option" .. i]
				v.txtNum.text = langPara("(%d人)", FamilyPartyModel.instance:getUserCount(i))

				if i == answerGameInfo.mySelectOptionId then
					if answerGameInfo.state == 2 then
						if answerGameInfo.correctOptionId == answerGameInfo.mySelectOptionId then
							FloatWordMgr.instance:show("回答正确")
							v.groupChange:SetState(3)
						else
							FloatWordMgr.instance:show("回答错误")
							v.groupChange:SetState(2)
						end
					else
						v.groupChange:SetState(1)
					end
				elseif answerGameInfo.state == 2 then
					if answerGameInfo.correctOptionId == i then
						v.groupChange:SetState(3)
					else
						v.groupChange:SetState(0)
					end
				else
					v.groupChange:SetState(0)
				end
			end
		else
			self._txtQuestion.text = "配置不存在"
		end
	end
end

function FamilyPartyMainView:_playHideAnswerAnimation(onCompleteCallback)
	self:_clearTween()
	GameUtil.setPos(self._answerGo, self._answerPos.x, self._answerPos.y, self._answerPos.z)
	GameUtil.setLocalScale(self._answerGo, self._answerScale.x, self._answerScale.y, self._answerScale.z)
	self._uiFlyTweenParam:reset()

	self._uiFlyTweenParam.targetGo = self._answerGo
	self._uiFlyTweenParam.endPosition = GameUtil.getPos(self._btnAnswer.gameObject)
	self._uiFlyTweenParam.endScale = Vector3.New(0, 0, 0)
	self._uiFlyTweenParam.onCompleteCallback = onCompleteCallback
	self._uiFlyTweenParam.isKeepFinalResult = true
	self._flyTween = UIFlyTween.instance:doFlyTween(self._uiFlyTweenParam)
end

function FamilyPartyMainView:_playShowAnswerAnimation(onCompleteCallback)
	self:_clearTween()

	local position = GameUtil.getPos(self._btnAnswer.gameObject)

	GameUtil.setPos(self._answerGo, position.x, position.y, position.z)
	GameUtil.setLocalScale(self._answerGo, 0, 0, 0)
	self._uiFlyTweenParam:reset()

	self._uiFlyTweenParam.targetGo = self._answerGo
	self._uiFlyTweenParam.endPosition = self._answerPos
	self._uiFlyTweenParam.endScale = Vector3.New(1, 1, 1)
	self._uiFlyTweenParam.onCompleteCallback = onCompleteCallback
	self._uiFlyTweenParam.isKeepFinalResult = true
	self._flyTween = UIFlyTween.instance:doFlyTween(self._uiFlyTweenParam)
end

function FamilyPartyMainView:_initQuestionCountdown()
	local answerGameInfo = FamilyPartyModel.instance:getAnswerGameInfo()

	if answerGameInfo then
		local startTime = checknumber(answerGameInfo.stateStartMillis) / 1000

		startTime = Mathf.Floor(startTime)

		if answerGameInfo.state == 1 then
			if startTime > 0 then
				self:_setQuestionCountdown(startTime + self._answerQuestionTime)
			else
				self:_setQuestionCountdown(ServerTime.now())
			end
		elseif startTime > 0 then
			self:_setQuestionCountdown(startTime + self._answerShowTime)
		else
			self:_setQuestionCountdown(ServerTime.now())
		end
	else
		self:_setQuestionCountdown(ServerTime.now())
	end
end

function FamilyPartyMainView:_setQuestionCountdown(endTimestamp)
	self._endQuestionTime = endTimestamp
end

function FamilyPartyMainView:_updateCountdown()
	local leftTime = self._endQuestionTime - ServerTime.now()

	leftTime = leftTime > 0 and leftTime or 0
	self._txtCountdown.text = Mathf.Ceil(leftTime)
end

return FamilyPartyMainView
