-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/controller/GoddessController.lua

module("logic.extensions.goddess.controller.GoddessController", package.seeall)

local GoddessController = class("GoddessController", BaseController)

function GoddessController:onInit()
	self:onReset()
end

function GoddessController:onReset()
	self._encryptedKey = 0
end

function GoddessController:sendPM_GoddessStartGameReq()
	local activityId = GoddessModel.instance:getCurrActId()

	if activityId > 0 then
		GoddessModel.instance:updateReliveTimes(0)

		self._clientKey = math.random(1, 99)

		GoddessModel.instance:setClientKey(self._clientKey)
		GoddessAgent.instance:sendPM_GoddessStartGameReq(activityId, self._clientKey)
	end
end

function GoddessController:handlePM_GoddessStartGameRes(status, msg)
	if status == 0 then
		self._encryptedKey = msg.encryptedKey

		GoddessModel.instance:setServerKey(self._encryptedKey)
		GlobalDispatcher:dispatch(GlobalNotify.GoddessStartGame)
	end
end

function GoddessController:sendPM_GoddessEndGameReq(raceId, scale, clicks)
	local activityId = GoddessModel.instance:getCurrActId()

	if activityId > 0 then
		local clientEncryptedKey = GoddessModel.instance:getEncryptedKey(scale)

		GoddessAgent.instance:sendPM_GoddessEndGameReq(activityId, raceId, scale, clientEncryptedKey)
	end
end

function GoddessController:getInfo()
	local actId = GoddessModel.instance:getActId()

	GoddessModel.instance:onReset()
	GoddessModel.instance:setActId(actId)
	GoddessAgent.instance:sendPM_GoddessGetInfoReq(actId)
end

function GoddessController:handleGetInfo(msg)
	GoddessModel.instance:updateGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessInfoUpdate)
end

function GoddessController:touchGoddess(raceId)
	local actId = GoddessModel.instance:getActId()

	GoddessAgent.instance:sendPM_GoddessTouchReq(actId, raceId)
end

function GoddessController:handleTouch(msg)
	GoddessModel.instance:updateTouch(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessInfoUpdate)
end

function GoddessController:sendFlower(raceId, flowerId, num)
	local actId = GoddessModel.instance:getActId()

	GoddessAgent.instance:sendPM_GoddessSendFlowerReq(actId, raceId, flowerId, num)
end

function GoddessController:handleSendFlower(msg)
	GoddessModel.instance:updateSendFlower(msg)
end

function GoddessController:gainGoodFeelingPrize(raceId, id)
	local actId = GoddessModel.instance:getActId()

	GoddessAgent.instance:sendPM_GoddessGainPrizeReq(actId, raceId, id)
end

function GoddessController:handleGainGoodFeelingPrize(msg)
	GoddessModel.instance:updateGainGoodFeelingPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessInfoUpdate)
end

function GoddessController:handleReliveRes(reliveTimes)
	GoddessModel.instance:updateReliveTimes(reliveTimes)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessReliveGame)
end

function GoddessController:handleEndGameRes(msg)
	GoddessModel.instance:updateEndGameData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessEndGame)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessRefresMainView)
end

function GoddessController:handleChatRes(msg)
	GoddessModel.instance:updateChatData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessRefresMainView)
end

GoddessController.instance = GoddessController.New()

return GoddessController
