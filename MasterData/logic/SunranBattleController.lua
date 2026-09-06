-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/controller/SunranBattleController.lua

module("logic.extensions.sunranbattle.controller.SunranBattleController", package.seeall)

local SunranBattleController = class("SunranBattleController", BaseController)

function SunranBattleController:ctor()
	return
end

function SunranBattleController:onInit()
	self:onReset()
end

function SunranBattleController:onReset()
	self._stageId = nil
end

function SunranBattleController:csGetDarkDragonInfoReq()
	DarkDragonAgent.instance:sendPM_DarkDragonInfoReq()
end

function SunranBattleController:scSendDarkDragonInfo(msg)
	SunranBattleModel.instance:scSendDarkDragonInfo(msg)
end

function SunranBattleController:csGetDarkDragonStageInfoReq(stageId)
	self._stageId = stageId

	DarkDragonAgent.instance:sendPM_DarkDragonStageInfoReq(stageId)
end

function SunranBattleController:scSendDarkDragonStageInfo(msg)
	SunranBattleModel.instance:scSendDarkDragonStageInfo(msg, self._stageId)

	self._stageId = nil
end

function SunranBattleController:csDarkDragonChallengeReq(stageId, groupIds)
	DarkDragonAgent.instance:sendPM_DarkDragonChallengeReq(stageId, groupIds)
end

function SunranBattleController:scSendDarkDragonChallenge(msg)
	return
end

function SunranBattleController:csGetDarkDragonRankInfoReq(stageId)
	self._stageId = stageId

	DarkDragonAgent.instance:sendPM_DarkDragonRankInfoReq(stageId)
end

function SunranBattleController:scSendDarkDragonRankInfo(msg)
	SunranBattleModel.instance:scSendDarkDragonRankInfo(msg, self._stageId)

	self._stageId = nil
end

function SunranBattleController:scSendNotifyChallengeEnd(msg)
	SunranBattleModel.instance:scSendNotifyChallengeEnd(msg)
end

SunranBattleController.instance = SunranBattleController.New()

return SunranBattleController
