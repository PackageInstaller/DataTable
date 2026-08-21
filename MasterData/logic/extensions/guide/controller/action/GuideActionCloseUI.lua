-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionCloseUI.lua

module("logic.extensions.guide.controller.action.GuideActionCloseUI", package.seeall)

local M = class("GuideActionCloseUI", BaseGuideAction)

function M:ctor(guideId, stepId, guideStepCO)
	M.super.ctor(self, guideId, stepId, guideStepCO)

	self._uiId = false

	if not string.nilorempty(guideStepCO.guideControlParam) then
		self._uiId = tonumber(guideStepCO.guideControlParam)
	end
end

function M:onEnter(context)
	M.super.onEnter(self, context)

	if self._uiId then
		local jumpInfo = SystemJumpConfig.instance:getJumpInfo(self._uiId)

		if jumpInfo then
			ViewMgr.instance:close(jumpInfo.viewName)
		end
	end

	self:onDone(WorkResult.Succeed)
end

function M:onExit()
	M.super.onExit(self)
end

return M
