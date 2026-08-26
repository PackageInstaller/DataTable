-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionFindGO.lua

module("modules.logic.guide.controller.action.impl.GuideActionFindGO", package.seeall)

local GuideActionFindGO = class("GuideActionFindGO", BaseGuideAction)

GuideActionFindGO.FindGameObjectSeconds = 5

function GuideActionFindGO:ctor(guideId, stepId, actionParam)
	GuideActionFindGO.super.ctor(self, guideId, stepId, actionParam)

	self._goPath = actionParam
end

function GuideActionFindGO:onStart(context)
	GuideActionFindGO.super.onStart(self, context)

	local targetGO = self:_findGO(self._goPath)

	if targetGO then
		context.targetGO = targetGO

		self:_setGlobalTouchGO()
		self:onDone(true)
	else
		local stepCO = GuideConfig.instance:getStepCO(self.guideId, self.stepId)

		if stepCO.notForce == 0 then
			self:_startBlock()
		end

		TaskDispatcher.runRepeat(self._findGOToStartGuide, self, 0.1)

		self._startTime = Time.time
		self._realStartTime = Time.realtimeSinceStartup
	end
end

function GuideActionFindGO:onDestroy()
	GuideActionFindGO.super.onDestroy(self)
	self:_endBlock()
end

function GuideActionFindGO:_setGlobalTouchGO()
	local guideStepCO = GuideConfig.instance:getStepCO(self.guideId, self.stepId)

	if not string.nilorempty(guideStepCO.touchGOPath) then
		local touchGO = gohelper.find(guideStepCO.touchGOPath)

		self.context.touchGO = touchGO and touchGO:GetComponent("TouchEventMgr") or nil
	end
end

function GuideActionFindGO:_findGOToStartGuide()
	local openViewAnimStartTime = BaseViewContainer.openViewAnimStartTime

	if openViewAnimStartTime and openViewAnimStartTime < Time.time then
		local diffTime = Time.time - openViewAnimStartTime

		if diffTime <= BaseViewContainer.openViewAnimLength then
			return
		end
	end

	local targetGO = self:_findGO(self._goPath)

	if not gohelper.isNil(targetGO) and targetGO.activeInHierarchy then
		self:_endBlock()

		self.context.targetGO = targetGO

		self:_setGlobalTouchGO()
		self:onDone(true)
	else
		local elapsedTime = Time.time - self._startTime
		local realElapsedTime = Time.realtimeSinceStartup - self._realStartTime
		local stepCO = GuideConfig.instance:getStepCO(self.guideId, self.stepId)
		local maxTime = GuideActionFindGO.FindGameObjectSeconds

		if stepCO.notForce == 0 and maxTime < elapsedTime and maxTime < realElapsedTime then
			local isLoadingView = UIBlockMgr.instance:isKeyBlock(UIBlockKey.ViewOpening)

			if isLoadingView then
				if not self._loadingWaitingFlag then
					self._loadingWaitingFlag = true

					logError("Guide findGO time out, is loading view, waiting!!")
				end

				return
			end

			self:_endBlock()
			GuideStepController.instance:clearFlow(self.guideId)
			GuideModel.instance:clearFlagByGuideId(self.guideId)

			local msgCount = #ConnectAliveMgr.instance:getUnresponsiveMsgList()
			local guideMO = GuideModel.instance:getById(self.guideId)

			if guideMO and msgCount == 0 then
				guideMO:exceptionFinishGuide()
			end

			GuideActionFindGO._exceptionFindLog(self.guideId, self.stepId, self._goPath, "[ActionFind]")
		end
	end
end

function GuideActionFindGO._exceptionFindLog(guideId, stepId, goPath, prefixStr)
	local msgCount = #ConnectAliveMgr.instance:getUnresponsiveMsgList()
	local exceptionDesc = "找不到" .. tostring(goPath)
	local msgCountStr = "msgCount_" .. tostring(msgCount)
	local execStepStr = GuideModel.instance:getStepExecStr()
	local currScene = "scene_" .. tostring(GameSceneMgr.instance:getCurSceneType())
	local openViewNames = ViewMgr.instance:getOpenViewNameList()
	local openViewsStr = "views:" .. tostring(table.concat(openViewNames, ","))
	local guideCO = GuideConfig.instance:getGuideCO(guideId)
	local stepCO = GuideConfig.instance:getStepCO(guideId, stepId)

	logNormal(string.format("<color=#FFFF00>%s%s guide_%d_%d, %s-%s %s %s %s %s</color>", prefixStr or "", exceptionDesc, guideId, stepId, guideCO.desc, stepCO.desc, msgCountStr, currScene, openViewsStr, execStepStr))
	GuideController.instance:dispatchEvent(GuideEvent.InterruptGuide, guideId)
end

function GuideActionFindGO:_startBlock()
	UIBlockMgr.instance:startBlock(UIBlockKey.GuideActionFindGO)
end

function GuideActionFindGO:_endBlock()
	TaskDispatcher.cancelTask(self._findGOToStartGuide, self)
	UIBlockMgr.instance:endBlock(UIBlockKey.GuideActionFindGO)
end

function GuideActionFindGO:_findGO(paths)
	local goPaths = string.split(paths, "###")

	for i = 1, #goPaths do
		local targetGO = GuideUtil.findGo(goPaths[i])

		if GuideUtil.isGOShowInScreen(targetGO) then
			return targetGO
		end
	end
end

return GuideActionFindGO
