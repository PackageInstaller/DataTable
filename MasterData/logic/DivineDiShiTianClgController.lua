-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/controller/DivineDiShiTianClgController.lua

module("logic.extensions.divinedishitianclg.controller.DivineDiShiTianClgController", package.seeall)

local DivineDiShiTianClgController = class("DivineDiShiTianClgController", BaseController)

function DivineDiShiTianClgController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.NotifyDivineDiShiTianClgNormalFinishRes, self._onNotifyNormalFinishRes, self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyDivineDiShiTianClgExtremeFinishRes, self._onNotifyExtremeFinishRes, self)
end

function DivineDiShiTianClgController:_onNotifyNormalFinishRes(activityId)
	UIJumper.instance:pushOneStack(ViewName.DivineDiShiTianMainView, true)
	UIJumper.instance:pushOneStack(ViewName.DivineDiShiTianNormalView, true, activityId)
end

function DivineDiShiTianClgController:_onNotifyExtremeFinishRes(activityId)
	UIJumper.instance:pushOneStack(ViewName.DivineDiShiTianMainView, true)
	UIJumper.instance:pushOneStack(ViewName.DivineDiShiTianExtremeView, true, activityId)
end

function DivineDiShiTianClgController:openMissionView(activityId, index, creepsMasterId)
	local customFmtMo = DivineDiShiTianClgModel.instance:getNormalFmtMo(activityId)

	customFmtMo:initParams(activityId, index, creepsMasterId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineDiShiTianClgController:openExtremeMissionView(activityId, stepId, stageId)
	if stepId == 1 then
		local customFmtMo = DivineDiShiTianClgModel.instance:getExtremeFmtMo1(activityId)

		customFmtMo:initParams(activityId, stepId, stageId)
		CustomFmtController.instance:showMissionView(customFmtMo)
	else
		local customFmtMo = DivineDiShiTianClgModel.instance:getExtremeFmtMo2(activityId)

		customFmtMo:initParams(activityId, stepId, stageId)
		CustomFmtController.instance:showMissionView(customFmtMo)
	end
end

DivineDiShiTianClgController.instance = DivineDiShiTianClgController.New()

return DivineDiShiTianClgController
