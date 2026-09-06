-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/party/controller/PartyController.lua

module("logic.extensions.party.controller.PartyController", package.seeall)

local PartyController = class("PartyController", BaseController)

function PartyController:ctor()
	return
end

function PartyController:getInfo(actId)
	PartyAgent.instance:sendPM_PartyGetInfoReq(actId)
end

function PartyController:handleGetInfo(msg)
	PartyModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PartyPrizeGainStatusUpdate)
end

function PartyController:gainPrize(actId)
	PartyAgent.instance:sendPM_PartyGainPrizeReq(actId)
end

function PartyController:handleGainPrize(msg)
	PartyModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PartyPrizeGainStatusUpdate)
end

PartyController.instance = PartyController.New()

return PartyController
