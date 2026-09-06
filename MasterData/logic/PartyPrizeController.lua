-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partyprize/controller/PartyPrizeController.lua

module("logic.extensions.partyprize.controller.PartyPrizeController", package.seeall)

local PartyPrizeController = class("PartyPrizeController", BaseController)

function PartyPrizeController:ctor()
	return
end

function PartyPrizeController:onInit()
	self:onReset()
end

function PartyPrizeController:onReset()
	return
end

function PartyPrizeController:getInfo()
	print("PartyPrize's ActID = " .. PartyPrizeConfig.instance:getActId())

	local activityId = PartyPrizeConfig.instance:getActId()

	PartyPrizeAgent.instance:sendPM_PartyPrizeGetInfoReq(activityId)
end

function PartyPrizeController:handleGetInfo(msg)
	PartyPrizeModel.instance:initData(msg)
	self:notify(PartyPrizeController.DATA_CHANGE)
end

function PartyPrizeController:gainPrize(idx)
	local activityId = PartyPrizeConfig.instance:getActId()

	PartyPrizeAgent.instance:sendPM_PartyPrizeGainPrizeReq(activityId, idx)
end

function PartyPrizeController:handleGainPrize(idx, msg)
	PartyPrizeModel.instance:gainPrize(idx, msg)
	self:notify(PartyPrizeController.DATA_CHANGE)
end

function PartyPrizeController:gainAccumulatePrize()
	local activityId = PartyPrizeConfig.instance:getActId()

	PartyPrizeAgent.instance:sendPM_PartyPrizeGainAccumulatePrizeReq(activityId)
end

function PartyPrizeController:handleAccumulatePrize(msg)
	PartyPrizeModel.instance:gainAccumulatePrize(msg)
	self:notify(PartyPrizeController.DATA_CHANGE)
end

function PartyPrizeController:gainDailyPrize(id)
	local activityId = PartyPrizeConfig.instance:getActId()

	PartyPrizeAgent.instance:sendPM_PartyPrizeGainDailyPrizeReq(activityId, id)
end

function PartyPrizeController:handleGainDailyPrize(id, msg)
	PartyPrizeModel.instance:gainDailyPrize(id, msg)
	self:notify(PartyPrizeController.DATA_CHANGE)
end

PartyPrizeController.DATA_CHANGE = "PartyPrizeController_DATA_CHANGE"
PartyPrizeController.instance = PartyPrizeController.New()

return PartyPrizeController
