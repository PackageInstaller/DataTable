-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/MississiController.lua

module("logic.extensions.timelimitedchallenge.controller.MississiController", package.seeall)

local MississiController = class("MississiController", BaseController)

function MississiController:getInfo()
	local actId = MississiModel.instance:getActId()

	MiXiXiChallengeAgent.instance:sendPM_MiXiXiChallengeInfoReq(actId)
end

function MississiController:handleGetInfo(msg)
	MississiModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MississiInfoUpdate)
end

function MississiController:startChallenge(teamId, form_pb)
	local actId = MississiModel.instance:getActId()

	MiXiXiChallengeAgent.instance:sendPM_MiXiXiChallengeReq(actId, teamId, form_pb)
end

function MississiController:gainBuff()
	local actId = MississiModel.instance:getActId()

	MiXiXiChallengeAgent.instance:sendPM_MiXiXiGainBuffReq(actId)
end

function MississiController:handleGainBuff(msg)
	MississiModel.instance:onGainBuff(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MississiInfoUpdate)
end

function MississiController:handleChanllengeEnd(msg)
	MississiModel.instance:onChallengeEnd(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MississiInfoUpdate)
end

function MississiController:onBattleEnd(tipsKey)
	UIStateManager.instance:push(ViewName.MississiResultView, tipsKey)
	BattleFacade.instance:registerResultHandler(nil, nil)

	return true
end

function MississiController:showMissionView(teamCfg, viewName1, viewName2, tipsKey)
	local mo = MississiModel.instance:getCustomFmtMo()

	mo:initParams(teamCfg, viewName1, viewName2, tipsKey)
	CustomFmtController.instance:showMissionView(mo)
end

MississiController.instance = MississiController.New()

return MississiController
