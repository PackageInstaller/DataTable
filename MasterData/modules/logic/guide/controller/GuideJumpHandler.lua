-- chunkname: @modules/logic/guide/controller/GuideJumpHandler.lua

module("modules.logic.guide.controller.GuideJumpHandler", package.seeall)

local GuideJumpHandler = class("GuideJumpHandler")
local NeedFinishingAction = {
	"113#OnGuideFightEndContinue",
	"116#",
	"115#IgorController"
}

function GuideJumpHandler:ctor()
	GuideController.instance:registerCallback(GuideEvent.OneKeyFinishGuides, self._onOneKeyFinishGuides, self)
end

function GuideJumpHandler:reInit()
	return
end

function GuideJumpHandler:_onOneKeyFinishGuides(guideIds)
	self._guideSteps = {}

	for _, guideId in ipairs(guideIds) do
		local guideMO = GuideModel.instance:getById(guideId)
		local stepId = guideMO.currStepId
		local nextStepId = GuideConfig.instance:getNextStepId(guideId, stepId)

		while nextStepId > 0 do
			local nextStepCO = GuideConfig.instance:getStepCO(guideId, nextStepId)
			local actionStrs = string.split(nextStepCO.action, "|")

			for i = 1, #actionStrs do
				local actionStr = actionStrs[i]

				for _, actionPrefix in ipairs(NeedFinishingAction) do
					if string.find(actionStr, actionPrefix) == 1 then
						local action = GuideActionBuilder.buildAction(guideId, stepId, actionStr)

						if action then
							action:onStart()
							action:clearWork()
							logError("跳过指引，执行必要的收尾动作 guide_" .. guideId .. "_" .. nextStepId .. " " .. actionStr)
						end

						break
					end
				end
			end

			nextStepId = GuideConfig.instance:getNextStepId(guideId, nextStepId)
		end
	end
end

return GuideJumpHandler
