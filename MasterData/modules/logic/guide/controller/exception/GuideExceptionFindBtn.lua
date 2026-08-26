-- chunkname: @modules/logic/guide/controller/exception/GuideExceptionFindBtn.lua

module("modules.logic.guide.controller.exception.GuideExceptionFindBtn", package.seeall)

local GuideExceptionFindBtn = class("GuideExceptionFindBtn")

function GuideExceptionFindBtn:ctor()
	self.guideId = nil
	self.stepId = nil
	self.repeatCount = nil
	self.handlerFuncs = nil
	self.handlerParams = nil
	self.goPath = nil
	self.elapseCount = 0
end

function GuideExceptionFindBtn:startCheck(guideId, stepId, checkerParam, handlerFuncs, handlerParams)
	self.guideId = guideId
	self.stepId = stepId
	self.handlerFuncs = handlerFuncs
	self.handlerParams = handlerParams

	local temp = string.split(checkerParam, "_")
	local interval = tonumber(temp[1])

	self.repeatCount = temp[2] and tonumber(temp[2]) or 1
	self._ignoreLog = temp[3] and tonumber(temp[3]) == 1
	self.goPath = GuideModel.instance:getStepGOPath(guideId, stepId)

	TaskDispatcher.runRepeat(self._onTick, self, interval)

	self.elapseCount = 0
end

function GuideExceptionFindBtn:stopCheck()
	TaskDispatcher.cancelTask(self._onTick, self)

	self.guideId = nil
	self.stepId = nil
	self.handlerFuncs = nil
	self.handlerParams = nil
	self.goPath = nil
	self.elapseCount = 0
end

function GuideExceptionFindBtn:_onTick()
	local targetGO = GuideUtil.findGo(self.goPath)

	if not GuideUtil.isGOShowInScreen(targetGO) then
		local funcs = self.handlerFuncs
		local params = self.handlerParams

		if not self._ignoreLog then
			GuideActionFindGO._exceptionFindLog(self.guideId, self.stepId, self.goPath, "[ExceptionFind]")
		end

		local guideId = self.guideId
		local stepId = self.stepId

		self:stopCheck()

		if funcs then
			for i = 1, #funcs do
				GuideExceptionController.instance:handle(guideId, stepId, funcs[i], params[i])
			end
		end

		return
	end

	if self.elapseCount and self.repeatCount then
		self.elapseCount = self.elapseCount + 1

		if self.elapseCount >= self.repeatCount then
			self:stopCheck()
		end
	end
end

return GuideExceptionFindBtn
