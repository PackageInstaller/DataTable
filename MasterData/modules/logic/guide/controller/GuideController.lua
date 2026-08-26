-- chunkname: @modules/logic/guide/controller/GuideController.lua

module("modules.logic.guide.controller.GuideController", package.seeall)

local GuideController = class("GuideController", BaseController)

GuideController.EnableLog = true
GuideController.FirstGuideId = 101

function GuideController:onInit()
	self._toStartGuides = {}
	self._enableGuides = true
	self._forbidGuides = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewForbidGuide) == 1
	self._sendingStartGuideIdDict = {}
	self._statDict = nil

	GuideConfigChecker.instance:onInit()
end

function GuideController:addConstEvents()
	LuaSocketMgr.instance:registerPreSender(self)
	GuideController.instance:registerCallback(GuideEvent.StartGuide, self._onReceiveStartGuide, self)
	GuideConfigChecker.instance:addConstEvents()
end

function GuideController:reInit()
	self._enableGuides = true
	self._sendingStartGuideIdDict = {}
	self._guideContinueEvent = nil

	GuideConfigChecker.instance:reInit()
end

function GuideController:_onReceiveStartGuide(guideId)
	if self._sendingStartGuideIdDict and self._sendingStartGuideIdDict[guideId] then
		self._sendingStartGuideIdDict[guideId] = nil
	end
end

function GuideController:disableGuides()
	self._enableGuides = false

	GuideStepController.instance:clearStep()
end

function GuideController:enableGuides()
	self._enableGuides = true

	local list = GuideModel.instance:getDoingGuideIdList()

	if list then
		for i = #list, 1, -1 do
			local guideCO = GuideConfig.instance:getGuideCO(list[i])

			if guideCO.parallel == 1 then
				self:execNextStep(list[i])
				table.remove(list, i)
			end
		end

		local highestGuideId = GuideConfig.instance:getHighestPriorityGuideId(list)

		if highestGuideId then
			self:execNextStep(highestGuideId)
		end
	end
end

function GuideController:isGuiding()
	if self._forbidGuides then
		return false
	end

	if GuideModel.instance:getDoingGuideId() then
		return true
	else
		return GuideTriggerController.instance:hasSatisfyGuide()
	end
end

function GuideController:hideGuideUIs()
	local view = ViewMgr.instance:getContainer(ViewName.GuideView)

	if view and not gohelper.isNil(view.viewGO) then
		transformhelper.setLocalScale(view.viewGO.transform, 0, 0, 0)
	end

	view = ViewMgr.instance:getContainer(ViewName.GuideView2)

	if view and not gohelper.isNil(view.viewGO) then
		transformhelper.setLocalScale(view.viewGO.transform, 0, 0, 0)
	end
end

function GuideController:showGuideUIs()
	local view = ViewMgr.instance:getContainer(ViewName.GuideView)

	if view and not gohelper.isNil(view.viewGO) then
		transformhelper.setLocalScale(view.viewGO.transform, 1, 1, 1)
	end

	view = ViewMgr.instance:getContainer(ViewName.GuideView2)

	if view and not gohelper.isNil(view.viewGO) then
		transformhelper.setLocalScale(view.viewGO.transform, 1, 1, 1)
	end
end

function GuideController:isForbidGuides()
	return self._forbidGuides
end

function GuideController:tempForbidGuides(isForbid)
	self._forbidGuides = isForbid

	logError("is forbid " .. (self._forbidGuides and "true" or "false"))
end

function GuideController:forbidGuides(isForbid)
	if self._forbidGuides then
		self._forbidGuides = false

		GameFacade.showToast(ToastEnum.GuideForbid)
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewForbidGuide, 0)
	else
		self._forbidGuides = true

		GameFacade.showToast(ToastEnum.GuideUnForbid)
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewForbidGuide, 1)
	end
end

function GuideController:oneKeyFinishGuide(guideId, isException)
	GuideModel.instance:clearFlagByGuideId(guideId)
	self:statFinishAllStep(true)

	local stepId
	local guideMO = GuideModel.instance:getById(guideId)

	if guideMO == nil then
		GuideModel.instance:addEmptyGuide(guideId)

		guideMO = GuideModel.instance:getById(guideId)
		stepId = GuideConfig.instance:getStepList(guideId)[1].id
	else
		stepId = guideMO.currStepId
	end

	local stepList = GuideConfig.instance:getStepList(guideId)

	if guideMO.isFinish then
		guideMO:setClientStep(-1)
	else
		guideMO.isJumpPass = true

		local hasKeyStep = false

		for j = #stepList, 1, -1 do
			local stepCO = stepList[j]

			if stepCO.keyStep == 1 then
				self._toFinishGuides = self._toFinishGuides or {}

				table.insert(self._toFinishGuides, {
					guideId,
					stepCO.stepId
				})
				TaskDispatcher.runRepeat(self._onFrameFinishGuides, self, 0.1)

				hasKeyStep = true

				break
			end
		end

		if not hasKeyStep then
			logError(string.format("GuideController oneKeyFinishGuide guide:%s no keyStep", guideId))
		end
	end

	GuideStepController.instance:clearFlow(guideId)
end

function GuideController:_onFrameFinishGuides()
	if self._toFinishGuides and #self._toFinishGuides > 0 then
		local oneGuide = table.remove(self._toFinishGuides, 1)
		local guideId = oneGuide[1]
		local stepId = oneGuide[2]

		logNormal("One key finish guide " .. guideId)
		GuideRpc.instance:sendFinishGuideRequest(guideId, stepId)
	end

	if not self._toFinishGuides or #self._toFinishGuides == 0 then
		self._toFinishGuides = nil

		TaskDispatcher.cancelTask(self._onFrameFinishGuides, self)
	end
end

function GuideController:oneKeyFinishGuides()
	self:statFinishAllStep(true)

	local list = GuideModel.instance:getList()
	local finishGuides

	for i = 1, #list do
		local guideMO = list[i]

		if guideMO.isFinish then
			guideMO:setClientStep(-1)
		else
			guideMO.isJumpPass = true

			local stepList = GuideConfig.instance:getStepList(guideMO.id)

			logNormal("One key finish guides")

			for j = #stepList, 1, -1 do
				local stepCO = stepList[j]

				if stepCO.keyStep == 1 then
					finishGuides = finishGuides or {}

					table.insert(finishGuides, guideMO.id)
					GuideRpc.instance:sendFinishGuideRequest(guideMO.id, stepCO.stepId)

					break
				end
			end
		end
	end

	if finishGuides then
		GuideController.instance:dispatchEvent(GuideEvent.OneKeyFinishGuides, finishGuides)
	end
end

function GuideController:toStartGudie(guideId)
	local isSendingGuide = not not self._sendingStartGuideIdDict[guideId]

	if GuideController.EnableLog then
		logNormal("to start guide: " .. guideId .. ", is sending guide: " .. (isSendingGuide and "true" or "false") .. debug.traceback("", 2))
	end

	if not isSendingGuide then
		table.insert(self._toStartGuides, guideId)

		local delay = GameSceneMgr.instance:getCurSceneType() == SceneType.Fight and 1 or 0.1

		UIBlockMgr.instance:startBlock(UIBlockKey.Guide)
		TaskDispatcher.runDelay(self._selectOneGuideToStart, self, delay)
	end
end

function GuideController:_selectOneGuideToStart()
	UIBlockMgr.instance:endBlock(UIBlockKey.Guide)
	TaskDispatcher.cancelTask(self._selectOneGuideToStart, self)

	local guideId = GuideConfig.instance:getHighestPriorityGuideId(self._toStartGuides)

	self._toStartGuides = {}

	if guideId then
		self:startGudie(guideId)
	end
end

function GuideController:startGudie(guideId)
	local guideCO = GuideConfig.instance:getGuideCO(guideId)

	if not guideCO then
		logError("guide config not exist " .. guideId)

		return
	end

	if GuideInvalidController.instance:isInvalid(guideId) then
		local existGuideMO = GuideModel.instance:getById(guideId)

		if not existGuideMO or not existGuideMO.isFinish then
			self:oneKeyFinishGuide(guideId, true)
		end
	else
		if GuideController.EnableLog then
			logNormal("send start guide: " .. guideId .. debug.traceback("", 2))
		end

		if not self._sendingStartGuideIdDict[guideId] then
			self._sendingStartGuideIdDict[guideId] = true

			GuideRpc.instance:sendFinishGuideRequest(guideId, 0)
		end
	end
end

function GuideController:checkStartFirstGuide()
	if self._enableGuides and self._forbidGuides == false then
		local guideMO = GuideModel.instance:getById(GuideController.FirstGuideId)

		if guideMO and guideMO.isFinish then
			return false
		elseif GuideInvalidController.instance:isInvalid(GuideController.FirstGuideId) then
			self:oneKeyFinishGuide(GuideController.FirstGuideId, true)

			return false
		else
			if guideMO then
				self:execNextStep(GuideController.FirstGuideId)
			else
				self:startGudie(GuideController.FirstGuideId)
			end

			return true
		end
	else
		return false
	end
end

function GuideController:startStep(guideId, stepId, againGuideId)
	self:statStartStep(againGuideId or guideId, stepId)
end

function GuideController:finishStep(guideId, stepId, force, isException, againGuideId)
	self:statFinishStep(guideId, stepId, isException)

	if isException then
		self:_tLogEndGuide(guideId, stepId, isException and 2 or 1)
	end

	local guideMO = GuideModel.instance:getById(guideId)

	if not guideMO then
		return
	end

	local guideStepCO = guideMO:getCurStepCO()

	if not guideStepCO then
		return
	end

	if guideStepCO.keyStep == 1 then
		self._targetAdditionCmd = guideStepCO.additionCmd

		if force == true or string.nilorempty(self._targetAdditionCmd) then
			GuideRpc.instance:sendFinishGuideRequest(guideId, guideMO.currStepId)
		elseif not string.nilorempty(self._targetAdditionCmd) and self._targetAdditionCmd ~= self._hasSendAdditionCmd then
			self._guideId = guideId
			self._stepId = stepId

			TaskDispatcher.runDelay(self._delayCheckSendProtoAdditionException, self, 2)
		end
	else
		GuideModel.instance:clientFinishStep(guideId, guideMO.currStepId)
		GuideStepController.instance:clearFlow(guideId)
		GuideController.instance:dispatchEvent(GuideEvent.FinishStep, guideId, guideMO.clientStepId)
		self:execNextStep(guideId)
	end

	self._hasSendAdditionCmd = nil
end

function GuideController:_delayCheckSendProtoAdditionException()
	if self._targetAdditionCmd then
		GuideController.instance:oneKeyFinishGuide(self._guideId, true)
		logError(string.format("出bug了，附加协议没发出去，把指引结束吧 guide_%d_%d", self._guideId, self._stepId))
	end
end

function GuideController:execNextStep(guideId)
	if self._enableGuides and self._forbidGuides == false then
		local guideMO = GuideModel.instance:getById(guideId)

		GuideController.instance:dispatchEvent(GuideEvent.ExecuteGuideStep, guideMO.id, guideMO.currStepId)

		if guideMO.currStepId > 0 then
			GuideModel.instance:execStep(guideMO.currGuideId, guideMO.currStepId)
			GuideStepController.instance:execStep(guideId, guideMO.currStepId, guideMO.currGuideId)
		elseif guideMO.isFinish then
			GuideController.instance:dispatchEvent(GuideEvent.FinishGuideLastStep, guideMO.id)
		end
	else
		logNormal("disable guides, can't exec step")
	end
end

function GuideController:preSendProto(cmd, proto, socketId)
	local doingGuideIdList = GuideModel.instance:getDoingGuideIdList()

	if doingGuideIdList then
		for i = 1, #doingGuideIdList do
			local guideMO = GuideModel.instance:getById(doingGuideIdList[i])
			local guideStepCO = GuideConfig.instance:getStepCO(guideMO.id, guideMO.currStepId)

			if guideStepCO and not string.nilorempty(guideStepCO.additionCmd) then
				local additionKeys = string.split(guideStepCO.additionKey, ":")
				local targetStepId = #additionKeys >= 2 and tonumber(additionKeys[2])

				logNormal(string.format("<color=red>指引_%d_%d, 附加协议_%d</color>", guideMO.id, guideMO.currStepId, cmd))
				logNormal(string.format("<color=red>目标步骤_%d</color>", targetStepId or guideStepCO.stepId))

				if targetStepId then
					proto.guideIdE = guideMO.id
					proto.stepIdE = targetStepId
				else
					proto.guideId = guideMO.id
					proto.stepId = guideStepCO.stepId
				end

				self._hasSendAdditionCmd = cmd

				TaskDispatcher.cancelTask(self._delayCheckSendProtoAdditionException, self)
			end
		end
	end
end

function GuideController:statStartStep(guideId, stepId)
	local guideConfig = GuideConfig.instance:getStepCO(guideId, stepId)

	if guideConfig.stat and guideConfig.stat <= 0 then
		return
	end

	self._statDict = self._statDict or {}
	self._statDict[guideId] = self._statDict[guideId] or {}
	self._statDict[guideId][stepId] = ServerTime.now()

	StatController.instance:track(StatEnum.EventName.GuideStart, {
		[StatEnum.EventProperties.GuideId] = guideId,
		[StatEnum.EventProperties.StepId] = stepId
	})
end

function GuideController:statFinishStep(guideId, stepId, isException)
	self._statDict = self._statDict or {}
	self._statDict[guideId] = self._statDict[guideId] or {}

	if self._statDict[guideId][stepId] then
		local duration = ServerTime.now() - self._statDict[guideId][stepId]

		StatController.instance:track(StatEnum.EventName.GuideEnd, {
			[StatEnum.EventProperties.GuideId] = guideId,
			[StatEnum.EventProperties.StepId] = stepId,
			[StatEnum.EventProperties.UseTime] = duration,
			[StatEnum.EventProperties.IsException] = isException and true or false
		})
	end

	self._statDict[guideId][stepId] = nil
end

function GuideController:statFinishAllStep(isException)
	self._statDict = self._statDict or {}

	for guideId, statGuideDict in pairs(self._statDict) do
		for stepId, time in pairs(statGuideDict) do
			local duration = ServerTime.now() - time

			StatController.instance:track(StatEnum.EventName.GuideEnd, {
				[StatEnum.EventProperties.GuideId] = guideId,
				[StatEnum.EventProperties.StepId] = stepId,
				[StatEnum.EventProperties.UseTime] = duration,
				[StatEnum.EventProperties.IsException] = isException and true or false
			})
		end
	end
end

function GuideController:shouldBlockDungeonBack()
	if self:isForbidGuides() then
		return false
	end

	return not DungeonModel.instance:hasPassLevel(CommonConfig.instance:getConstNum(ConstEnum.NewbieTermEpisode))
end

function GuideController:shouldPlayStory()
	if self:isForbidGuides() then
		return false
	end

	local config = DungeonConfig.instance:getEpisodeCO(CommonConfig.instance:getConstNum(ConstEnum.NewbieTermEpisode))

	return config and config.afterStory > 0 and not StoryModel.instance:isStoryFinished(config.afterStory)
end

function GuideController:GuideFlowPauseAndContinue(varKey, pauseEvent, continueEvent, callback, callbackObj, p1, p2, p3)
	local guideParam = GuideModel.instance:getGuideParam()

	GuideController.instance:dispatchEvent(pauseEvent, guideParam, p1, p2, p3)

	if guideParam[varKey] then
		guideParam[varKey] = false

		if self._guideContinueEvent then
			logError("guiding event: " .. self._guideContinueEvent .. ", try to replase with: " .. continueEvent)
			GuideController.instance:unregisterCallback(self._guideContinueEvent, self._continueCallback, self)
		end

		self._guideContinueEvent = continueEvent
		self._guideCallback = callback
		self._guideCallbackObj = callbackObj

		GuideController.instance:registerCallback(self._guideContinueEvent, self._continueCallback, self)

		return true
	else
		callback(callbackObj)

		if self._guideContinueEvent == pauseEvent then
			GuideController.instance:unregisterCallback(self._guideContinueEvent, self._continueCallback, self)

			self._guideContinueEvent = nil
			self._guideCallback = nil
			self._guideCallbackObj = nil
		end
	end

	return false
end

function GuideController:_continueCallback()
	if self._guideContinueEvent then
		GuideController.instance:unregisterCallback(self._guideContinueEvent, self._continueCallback, self)
	end
end

function GuideController:isAnyGuideRunning()
	return ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.GuideView2)
end

GuideController.instance = GuideController.New()

return GuideController
