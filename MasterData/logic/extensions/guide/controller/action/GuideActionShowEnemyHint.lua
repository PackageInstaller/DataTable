-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionShowEnemyHint.lua

module("logic.extensions.guide.controller.action.GuideActionShowEnemyHint", package.seeall)

local M = class("GuideActionShowEnemyHint", BaseGuideAction)

function M:ctor(guideId, stepId, guideStepCO)
	M.super.ctor(self, guideId, stepId, guideStepCO)

	self._uiId = false

	if not string.nilorempty(guideStepCO.guideControlParam) then
		self._uiId = tonumber(guideStepCO.guideControlParam)
	end
end

function M:onEnter(context)
	M.super.onEnter(self, context)

	if self.guideStepCO.guideControlType then
		ViewMgr.instance:open(ViewName.ToolTipsEnemyFirstHintView, self.guideStepCO.guideControlType, self._finish, self)
	else
		self:onDone(WorkResult.Succeed)
	end
end

function M:_finish()
	self:onDone(WorkResult.Succeed)
end

function M:onExit()
	M.super.onExit(self)
end

return M
