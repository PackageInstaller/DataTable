-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/controller/DivinelongyanController.lua

module("logic.extensions.divinelongyan.controller.DivinelongyanController", package.seeall)

local DivinelongyanController = class("DivinelongyanController", BaseController)

function DivinelongyanController:ctor()
	return
end

function DivinelongyanController:onInit()
	self:onReset()
end

function DivinelongyanController:onReset()
	return
end

function DivinelongyanController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DivinelongyanController:getActivityType()
	return GameEnum.ActivityType.DivineLongyan
end

function DivinelongyanController:enterMission(actId, clgType, creepsMasterId, stageId)
	local customFmtMo = clgType == GameEnum.DivineLongyanClgType.Power and DivinelongyanModel.instance:getPowerFmtMo() or DivinelongyanModel.instance:getlineFmtMo()

	customFmtMo:initParams(actId, clgType, creepsMasterId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivinelongyanController:getCostMatParams(activityId)
	local actCfg = DivinelongyanConfig.instance:getActCfg(activityId)
	local arr = string.split(actCfg.costMp, ":")
	local matType, matId = checknumber(arr[1]), checknumber(arr[2])

	return matType, matId
end

DivinelongyanController.instance = DivinelongyanController.New()

return DivinelongyanController
