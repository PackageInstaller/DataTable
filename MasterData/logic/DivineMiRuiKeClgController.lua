-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiruikeclg/controller/DivineMiRuiKeClgController.lua

module("logic.extensions.divinemiruikeclg.controller.DivineMiRuiKeClgController", package.seeall)

local DivineMiRuiKeClgController = class("DivineMiRuiKeClgController", BaseController)

function DivineMiRuiKeClgController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.DivineMiRuiKeClgNotifyFightResultRes, self._onNotifyFightResultRes, self)
end

function DivineMiRuiKeClgController:_onNotifyFightResultRes(msg, activityId)
	UIJumper.instance:pushOneStack(ViewName.DivineMiRuiKeClgMainView, true)
	UIJumper.instance:pushOneStack(ViewName.DivineMiRuiKeClgLevelView, true, activityId)
end

function DivineMiRuiKeClgController:openMissionView(activityId, phaseId, stageId)
	local customFmtMo = DivineMiRuiKeClgModel.instance:getNormalFmtMo(activityId)

	customFmtMo:initParams(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

DivineMiRuiKeClgController.instance = DivineMiRuiKeClgController.New()

return DivineMiRuiKeClgController
