-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/controller/OriginWeiLeiTaController.lua

module("logic.extensions.originweileita.controller.OriginWeiLeiTaController", package.seeall)

local OriginWeiLeiTaController = class("OriginWeiLeiTaController", BaseController)

function OriginWeiLeiTaController:ctor()
	return
end

function OriginWeiLeiTaController:onInit()
	self:onReset()
end

function OriginWeiLeiTaController:onReset()
	return
end

function OriginWeiLeiTaController:onNormalChallengeRes(msg)
	if not msg.win then
		return false
	end

	local lastScore = OriginWeiLeiTaModel.instance:getNorStageMaxScore(msg.activityId, msg.stageId)
	local maxScore = math.max(lastScore or 0, (not msg.score or nil) and 0)

	OriginWeiLeiTaModel.instance:onNormalChallengeRes(msg)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:push(ViewName.OriginweileitanorresultView, msg.score, maxScore)

		return true
	end)
end

function OriginWeiLeiTaController:onExtremeChallengeRes(msg)
	OriginWeiLeiTaModel.instance:onExtremeChallengeRes(msg)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:push(ViewName.OriginweileitaextresultView, msg)

		return true
	end)
end

function OriginWeiLeiTaController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(280)
end

OriginWeiLeiTaController.instance = OriginWeiLeiTaController.New()

return OriginWeiLeiTaController
