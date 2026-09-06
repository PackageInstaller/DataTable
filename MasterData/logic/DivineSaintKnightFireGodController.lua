-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/DivineSaintKnightFireGod/controller/DivineSaintKnightFireGodController.lua

module("logic.extensions.divinesaintknightfiregod.controller.DivineSaintKnightFireGodController", package.seeall)

local DivineSaintKnightFireGodController = class("DivineSaintKnightFireGodController", BaseController)

function DivineSaintKnightFireGodController:ctor()
	return
end

function DivineSaintKnightFireGodController:onInit()
	self:onReset()
end

function DivineSaintKnightFireGodController:onReset()
	return
end

function DivineSaintKnightFireGodController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(232)
end

function DivineSaintKnightFireGodController:isClgPass(activityId)
	local info = DivineSaintKnightFireGodModel.instance:getInfo(activityId)
	local stageCfgs = DivineSaintKnightFireGodConfig.instance:getStageCfgs(activityId)

	return #info.passStageId >= #stageCfgs
end

function DivineSaintKnightFireGodController:isStagePass(activityId, stageId)
	local info = DivineSaintKnightFireGodModel.instance:getInfo(activityId)

	return table.indexof(info.passStageId, stageId)
end

DivineSaintKnightFireGodController.instance = DivineSaintKnightFireGodController.New()

return DivineSaintKnightFireGodController
