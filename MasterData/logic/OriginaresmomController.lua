-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/controller/OriginaresmomController.lua

module("logic.extensions.originaresmom.controller.OriginaresmomController", package.seeall)

local OriginaresmomController = class("OriginaresmomController", BaseController)

function OriginaresmomController:ctor()
	return
end

function OriginaresmomController:onInit()
	self:onReset()
end

function OriginaresmomController:onReset()
	return
end

function OriginaresmomController:onNormalChallengeRes(msg)
	if not msg.win then
		return false
	end

	local lastScore = OriginaresmomModel.instance:getNormalDailyMaxScore(msg.activityId, msg.teamId)
	local maxScore = math.max(lastScore, msg.dailyMax)

	OriginaresmomModel.instance:onNormalChallengeRes(msg)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:push(ViewName.OriginaresmomnorresultView, msg.dailyMax, maxScore)

		return true
	end)
end

function OriginaresmomController:onExtremeChallengeRes(msg)
	if not msg.win then
		return false
	end

	OriginaresmomModel.instance:onExtremeChallengeRes(msg)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:push(ViewName.OriginaresmomextresultView, msg)

		return true
	end)
end

function OriginaresmomController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(274)
end

OriginaresmomController.instance = OriginaresmomController.New()

return OriginaresmomController
