-- chunkname: @modules/logic/guide/controller/action/BaseGuideAction.lua

module("modules.logic.guide.controller.action.BaseGuideAction", package.seeall)

local BaseGuideAction = class("BaseGuideAction", BaseWork)

function BaseGuideAction:ctor(guideId, stepId, actionParam)
	self.guideId = guideId
	self.stepId = stepId
	self.actionParam = actionParam
end

function BaseGuideAction:checkGuideLock()
	local lockGuideId = GuideModel.instance:getLockGuideId()

	if not lockGuideId then
		return false
	end

	return lockGuideId ~= self.guideId
end

function BaseGuideAction:onStart(context)
	logNormal(string.format("<color=#EA00B3>start guide_%d_%d %s</color>", self.guideId, self.stepId, self.__cname))
	GuideBlockMgr.instance:startBlock()

	self.context = context
	self.status = WorkStatus.Running
end

function BaseGuideAction:onDestroy()
	logNormal(string.format("<color=#EA00B3>destroy guide_%d_%d %s</color>", self.guideId, self.stepId, self.__cname))
	GuideBlockMgr.instance:startBlock()
	BaseGuideAction.super.onDestroy(self)
end

return BaseGuideAction
