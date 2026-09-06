-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/controller/DivineXingJiangClgController.lua

module("logic.extensions.divinexingjiangclg.controller.DivineXingJiangClgController", package.seeall)

local DivineXingJiangClgController = class("DivineXingJiangClgController", BaseController)

function DivineXingJiangClgController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.DivineXingJiangClgNotifyFightResultRes, self._notifyFightResultRes, self)
end

function DivineXingJiangClgController:openMissionView(activityId, stageId)
	local customFmtMo = DivineXingJiangClgModel.instance:getCustomFmtMo(activityId)

	customFmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineXingJiangClgController:_notifyFightResultRes(activityId, stageId)
	UIJumper.instance:pushOneStack(ViewName.DivinexjClgMainView, true)
	UIJumper.instance:pushOneStack(ViewName.DivinexjClgLevelView, true, activityId)

	local isPass = DivineXingJiangClgModel.instance:isPassStage(activityId, stageId)

	if not isPass then
		UIJumper.instance:pushOneStack(ViewName.DivinexjClgInfoView, true, activityId, stageId)
	end
end

DivineXingJiangClgController.instance = DivineXingJiangClgController.New()

return DivineXingJiangClgController
