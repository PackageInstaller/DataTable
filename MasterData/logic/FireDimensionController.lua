-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firedimension/controller/FireDimensionController.lua

module("logic.extensions.firedimension.controller.FireDimensionController", package.seeall)

local FireDimensionController = class("FireDimensionController", BaseController)
local viewGroup = {
	{
		root = ViewName.FireDimensionView,
		level = ViewName.FireDimensionLevelView
	},
	{
		root = ViewName.DivineMiXiXiView,
		level = ViewName.DivineMiXiXiLevelView
	}
}

function FireDimensionController:ctor()
	self._curViewGroup = 1
end

function FireDimensionController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.FireDimensionClgFightEndRes, self._onFightEndRes, self)
	GlobalDispatcher:addListener("enterfiredimensionview", self._enterFireDimensEventOpenView, self)
end

function FireDimensionController:showMissionView(activityId, stageId, teamId)
	local customFmtMo = FireDimensionModel.instance:getCustomFmtMo()

	customFmtMo:initParams(activityId, stageId, teamId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function FireDimensionController:_onFightEndRes(msg)
	if not msg.nextStage then
		-- block empty
	else
		UIJumper.instance:removeTopState(self:getView("level"))
	end

	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId)

	if isAoqiGodProcessType and self:_isAllPass(msg.activityId) then
		local activityType = ActivityDefineController.instance:getActTypeByActId(msg.activityId)

		AoqiGodController.instance:doHandleChallengeFinishReady(activityType, msg.activityId)
	end
end

function FireDimensionController:setCurRoot(viewName)
	for i, v in ipairs(viewGroup) do
		if v.root == viewName then
			self._curViewGroup = i

			break
		end
	end
end

function FireDimensionController:setCurGroup(groupId)
	self._curViewGroup = groupId
end

function FireDimensionController:getView(viewTag)
	return viewGroup[self._curViewGroup][viewTag]
end

function FireDimensionController:_enterFireDimensEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.FireDimensionView, actId)
end

function FireDimensionController:_isAllPass(activityId)
	local isAllPass = true
	local bigStagCfgs = FireDimensionConfig.instance:getBigStageCfgList(activityId)

	for i, v in ipairs(bigStagCfgs) do
		if not FireDimensionModel.instance:isStagePass(activityId, v.stageId) then
			isAllPass = false

			break
		end
	end

	return isAllPass
end

FireDimensionController.instance = FireDimensionController.New()

return FireDimensionController
