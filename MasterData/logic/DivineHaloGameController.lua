-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/controller/DivineHaloGameController.lua

module("logic.extensions.divinehalogame.controller.DivineHaloGameController", package.seeall)

local DivineHaloGameController = class("DivineHaloGameController", BaseController)

function DivineHaloGameController:ctor()
	return
end

function DivineHaloGameController:onInit()
	self:onReset()
end

function DivineHaloGameController:onReset()
	return
end

function DivineHaloGameController:sendPM_DivineHaloGameInfoReq(activityId)
	DivineHaloGameAgent.instance:sendPM_DivineHaloGameInfoReq(activityId)
end

function DivineHaloGameController:handlePM_DivineHaloGameInfoRes(msg)
	DivineHaloGameModel.instance:handlePM_DivineHaloGameInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineHaloGameInfoRes)
end

function DivineHaloGameController:sendPM_DivineHaloGameBuyTimesReq(activityId, buyTimes)
	DivineHaloGameAgent.instance:sendPM_DivineHaloGameBuyTimesReq(activityId, buyTimes)
end

function DivineHaloGameController:handlePM_DivineHaloGameBuyTimesRes(msg)
	DivineHaloGameModel.instance:handlePM_DivineHaloGameBuyTimesRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineHaloGameBuyTimesRes)
end

function DivineHaloGameController:sendPM_DivineHaloGameStartGameReq(activityId)
	local clientKey = DivineHaloGameModel.instance:getClientKey(activityId)

	DivineHaloGameAgent.instance:sendPM_DivineHaloGameStartGameReq(activityId, clientKey)
end

function DivineHaloGameController:handlePM_DivineHaloGameStartGameRes(msg)
	DivineHaloGameModel.instance:handlePM_DivineHaloGameStartGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineHaloGameStartGameRes)
end

function DivineHaloGameController:sendPM_DivineHaloGameEndGameReq(activityId, stageId, passOrNot)
	local encryptedKey = DivineHaloGameModel.instance:getEncryptedKey(activityId, passOrNot)

	DivineHaloGameAgent.instance:sendPM_DivineHaloGameEndGameReq(activityId, stageId, passOrNot, encryptedKey)
end

function DivineHaloGameController:handlePM_DivineHaloGameEndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineHaloGameEndGameRes)
end

function DivineHaloGameController:getLocalPos(go, vec)
	local x, y, z = Framework.TransformUtil.GetLocalPos(go.transform, 0, 0, 0)

	vec:Set(x, y, z)

	return vec
end

DivineHaloGameController.instance = DivineHaloGameController.New()

return DivineHaloGameController
