-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/controller/PlanetariumController.lua

module("logic.extensions.planetarium.controller.PlanetariumController", package.seeall)

local PlanetariumController = class("PlanetariumController", BaseController)

function PlanetariumController:ctor()
	return
end

function PlanetariumController:onInit()
	self:onReset()
end

function PlanetariumController:onReset()
	return
end

function PlanetariumController:sendPM_PlanetariumGameInfoReq(activityId)
	PlanetariumGameAgent.instance:sendPM_PlanetariumGameInfoReq(activityId)
end

function PlanetariumController:handlePM_PlanetariumGameInfoRes(status, msg)
	PlanetariumModel.instance:setGameInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PlanetariumGameInfoRes, msg)
end

function PlanetariumController:sendPM_PlanetariumGameStartGameReq(activityId, clientKey)
	PlanetariumGameAgent.instance:sendPM_PlanetariumGameStartGameReq(activityId, clientKey)
end

function PlanetariumController:handlePM_PlanetariumGameStartGameRes(status, msg)
	PlanetariumModel.instance:setServerKey(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PlanetariumGameStartGameRes, msg)
end

function PlanetariumController:sendPM_PlanetariumGameEndGameReq(activityId, isPass, encryptedKey)
	PlanetariumGameAgent.instance:sendPM_PlanetariumGameEndGameReq(activityId, isPass, encryptedKey)
end

function PlanetariumController:handlePM_PlanetariumGameEndGameRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.PlanetariumGameEndGameRes, msg)
end

function PlanetariumController:sendPM_PlanetariumGameGainPrizeReq(activityId, prizeId)
	PlanetariumGameAgent.instance:sendPM_PlanetariumGameGainPrizeReq(activityId, prizeId)
end

function PlanetariumController:handlePM_PlanetariumGameGainPrizeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.PlanetariumGameGainPrizeRes, msg)
end

function PlanetariumController:getPrizeState(prizeId, passNum)
	if PlanetariumModel.instance:isGainPrize(prizeId) then
		return 3
	elseif passNum <= PlanetariumModel.instance:getFinishNum() then
		return 2
	else
		return 1
	end
end

function PlanetariumController:isHasPrizeCanReceive(activityId)
	local finishNum = PlanetariumModel.instance:getFinishNum()
	local prizeCfg = PlanetariumConfig.instance:getPrizeCfgById(activityId)

	if finishNum > 0 then
		for _, v in ipairs(prizeCfg) do
			local state = self:getPrizeState(v.prizeId, v.passNum)

			if state == 2 then
				return true
			end
		end
	end

	return false
end

PlanetariumController.instance = PlanetariumController.New()

return PlanetariumController
