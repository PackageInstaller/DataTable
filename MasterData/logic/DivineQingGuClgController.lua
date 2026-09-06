-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineqingguclg/controller/DivineQingGuClgController.lua

module("logic.extensions.divineqingguclg.controller.DivineQingGuClgController", package.seeall)

local DivineQingGuClgController = class("DivineQingGuClgController", BaseController)

function DivineQingGuClgController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.DivineQingGuClgNotifyFightResultRes, self._onNotifyFightResultRes, self)
end

function DivineQingGuClgController:_onNotifyFightResultRes(activityId)
	UIJumper.instance:pushOneStack(ViewName.DivineQingGuClgMainView, true)
	UIJumper.instance:pushOneStack(ViewName.DivineQingGuClgLevelView, true, activityId)
end

function DivineQingGuClgController:openMissionView(activityId, stageId)
	local customFmtMo = DivineQingGuClgModel.instance:getNormalFmtMo(activityId)

	customFmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

DivineQingGuClgController.instance = DivineQingGuClgController.New()

return DivineQingGuClgController
