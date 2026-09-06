-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstannualwelfare/agent/FirstAnnualWelfareAgent.lua

module("logic.extensions.firstannualwelfare.agent.FirstAnnualWelfareAgent", package.seeall)

local FirstAnnualWelfareAgent = class("FirstAnnualWelfareAgent", BaseAgent)

function FirstAnnualWelfareAgent:ctor()
	return
end

function FirstAnnualWelfareAgent:sendPM_FirstAnnualWelfareGetInfoReq(activityId)
	local req = FirstAnnualWelfareExtension_pb.PM_FirstAnnualWelfareGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FirstAnnualWelfareAgent:handlePM_FirstAnnualWelfareGetInfoRes(status, msg)
	if status == 0 then
		FirstAnnualWelfareController.instance:onHandleFirstAnnualWelfareGetInfoRes(msg)
	end
end

function FirstAnnualWelfareAgent:sendPM_FirstAnnualWelfareGainFreeGoldenCardReq(activityId)
	local req = FirstAnnualWelfareExtension_pb.PM_FirstAnnualWelfareGainFreeGoldenCardReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FirstAnnualWelfareAgent:handlePM_FirstAnnualWelfareGainFreeGoldenCardRes(status, msg)
	if status == 0 then
		FirstAnnualWelfareController.instance:onHandleFirstAnnualWelfareGainFreeGoldenCardRes(msg)
	end
end

function FirstAnnualWelfareAgent:sendPM_FirstAnnualWelfareExchangeReq(activityId, exchangeIndex, choiceId, costIds)
	local req = FirstAnnualWelfareExtension_pb.PM_FirstAnnualWelfareExchangeReq()

	req.activityId = activityId
	req.exchangeIndex = exchangeIndex
	req.choiceId = choiceId

	for _, id in ipairs(costIds) do
		req.costIds:append(id)
	end

	self:sendMsg(req)
end

function FirstAnnualWelfareAgent:handlePM_FirstAnnualWelfareExchangeRes(status, msg)
	if status == 0 then
		FirstAnnualWelfareController.instance:onHandleFirstAnnualWelfareExchangeRes(msg)
	end
end

function FirstAnnualWelfareAgent:sendPM_FirstAnnualWelfareGainPetSkinReq(activityId, skinId)
	local req = FirstAnnualWelfareExtension_pb.PM_FirstAnnualWelfareGainPetSkinReq()

	req.activityId = activityId
	req.skinId = skinId

	self:sendMsg(req)
end

function FirstAnnualWelfareAgent:handlePM_FirstAnnualWelfareGainPetSkinRes(status, msg)
	if status == 0 then
		FirstAnnualWelfareController.instance:onHandleFirstAnnualWelfareGainPetSkinRes(msg)
	end
end

FirstAnnualWelfareAgent.instance = FirstAnnualWelfareAgent.New()

return FirstAnnualWelfareAgent
