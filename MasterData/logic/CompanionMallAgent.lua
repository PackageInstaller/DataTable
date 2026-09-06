-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/agent/CompanionMallAgent.lua

module("logic.extensions.companionmall.agent.CompanionMallAgent", package.seeall)

local CompanionMallAgent = class("CompanionMallAgent", BaseAgent)

function CompanionMallAgent:sendPM_CompanionMallGetInfoReq(activityId)
	local req = CompanionMallExtension_pb.PM_CompanionMallGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CompanionMallAgent:handlePM_CompanionMallGetInfoRes(status, msg)
	if status == 0 then
		CompanionMallController.instance:onGetInfo(msg)
	end
end

function CompanionMallAgent:sendPM_CompanionMallGainCompanionReq(activityId, companionId)
	local req = CompanionMallExtension_pb.PM_CompanionMallGainCompanionReq()

	req.activityId = activityId
	req.companionId = companionId

	self:sendMsg(req)
end

function CompanionMallAgent:handlePM_CompanionMallGainCompanionRes(status, msg)
	if status == 0 then
		CompanionMallController.instance:onGainCompanion(msg)
	end
end

function CompanionMallAgent:sendPM_CompanionMallGetAddressInfoReq(activityId)
	local req = CompanionMallExtension_pb.PM_CompanionMallGetAddressInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CompanionMallAgent:handlePM_CompanionMallGetAddressInfoRes(status, msg)
	if status == 0 then
		CompanionMallController.instance:onGetAddressInfo(msg)
	end
end

function CompanionMallAgent:sendPM_CompanionMallSubmitOrModifyAddressReq(activityId, addressInfo_pb)
	local req = CompanionMallExtension_pb.PM_CompanionMallSubmitOrModifyAddressReq()

	req.activityId = activityId

	if addressInfo_pb ~= nil then
		req.addressInfo:ParseFromString(addressInfo_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function CompanionMallAgent:handlePM_CompanionMallSubmitOrModifyAddressRes(status, msg)
	if status == 0 then
		CompanionMallController.instance:onSubmitAddressInfo(msg)
	end
end

function CompanionMallAgent:sendPM_CompanionMallGetRankInfoReq(activityId, companionId)
	local req = CompanionMallExtension_pb.PM_CompanionMallGetRankInfoReq()

	req.activityId = activityId
	req.companionId = companionId

	self:sendMsg(req)
end

function CompanionMallAgent:handlePM_CompanionMallGetRankInfoRes(status, msg)
	if status == 0 then
		CompanionMallController.instance:onGetRankInfo(msg)
	end
end

function CompanionMallAgent:handlePM_Notify_CompanionMallPaySucResult(status, msg)
	if status == 0 then
		CompanionMallController.instance:onCompanionMallPaySuc(msg)
	end
end

function CompanionMallAgent:sendPM_CompanionMallDeleteAddressReq(activityId, addressId)
	local req = CompanionMallExtension_pb.PM_CompanionMallDeleteAddressReq()

	req.activityId = activityId
	req.addressId = addressId

	self:sendMsg(req)
end

function CompanionMallAgent:handlePM_CompanionMallDeleteAddressRes(status, msg)
	if status == 0 then
		CompanionMallController.instance:handlePM_CompanionMallDeleteAddressRes(msg)
	end
end

function CompanionMallAgent:sendPM_CompanionMallSelectAddressReq(activityId, companionId_i32_Ary, addressId)
	local req = CompanionMallExtension_pb.PM_CompanionMallSelectAddressReq()

	req.activityId = activityId

	for i, v1 in ipairs(companionId_i32_Ary) do
		req.companionId:append(v1)
	end

	req.addressId = addressId

	self:sendMsg(req)
end

function CompanionMallAgent:handlePM_CompanionMallSelectAddressRes(status, msg)
	if status == 0 then
		CompanionMallController.instance:handlePM_CompanionMallSelectAddressRes(msg)
	end
end

CompanionMallAgent.instance = CompanionMallAgent.New()

return CompanionMallAgent
