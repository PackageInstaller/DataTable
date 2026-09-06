-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangzhengli/controller/ChuangzhengliController.lua

module("logic.extensions.chuangzhengli.controller.ChuangzhengliController", package.seeall)

local ChuangzhengliController = class("ChuangzhengliController", BaseController)

function ChuangzhengliController:ctor()
	return
end

function ChuangzhengliController:onInit()
	self:onReset()
end

function ChuangzhengliController:onReset()
	return
end

function ChuangzhengliController:getActivityType()
	return GameEnum.ActivityType.ChuangZhengli
end

function ChuangzhengliController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function ChuangzhengliController:enterMission(activityId, stageId, teamIndex, creepsMasterId)
	local mo = ChuangzhengliModel.instance:getFmtMo()

	mo:initParams(activityId, stageId, teamIndex, creepsMasterId)
	CustomFmtController.instance:showMissionView(mo)
end

function ChuangzhengliController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(184)
end

ChuangzhengliController.instance = ChuangzhengliController.New()

return ChuangzhengliController
