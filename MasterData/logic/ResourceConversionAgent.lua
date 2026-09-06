-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/agent/ResourceConversionAgent.lua

module("logic.extensions.resourceconversion.agent.ResourceConversionAgent", package.seeall)

local ResourceConversionAgent = class("ResourceConversionAgent", BaseAgent)

function ResourceConversionAgent:ctor()
	return
end

function ResourceConversionAgent:setExtId(extId)
	ResourceConversionAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ResourceConversionAgent:sendPM_RCQualityConvertReq(qualityItemList_pb_Ary)
	local req = ResourceConversionExtension_pb.PM_RCQualityConvertReq()

	if qualityItemList_pb_Ary ~= nil then
		for i, v1 in ipairs(qualityItemList_pb_Ary) do
			local qualityItemList = req.qualityItemList:add()

			qualityItemList:ParseFromString(v1:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function ResourceConversionAgent:handlePM_RCQualityConvertRes(status, msg)
	if status == 0 then
		ItemRecycleController.instance:handlePM_ResourceConvertGetInfoRes(msg)
	end
end

function ResourceConversionAgent:sendPM_RCDefineConvertReq(defineItemList_pb_Ary)
	local req = ResourceConversionExtension_pb.PM_RCDefineConvertReq()

	if defineItemList_pb_Ary ~= nil then
		for i, v2 in ipairs(defineItemList_pb_Ary) do
			local defineItemList = req.defineItemList:add()

			defineItemList:ParseFromString(v2:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function ResourceConversionAgent:handlePM_RCDefineConvertRes(status, msg)
	if status == 0 then
		ItemRecycleController.instance:handlePM_ResourceConvertGetInfoRes(msg)
	end
end

function ResourceConversionAgent:sendPM_ResourceConvertGetInfoReq()
	local req = ResourceConversionExtension_pb.PM_ResourceConvertGetInfoReq()

	self:sendMsg(req)
end

function ResourceConversionAgent:handlePM_ResourceConvertGetInfoRes(status, msg)
	if status == 0 then
		ItemRecycleController.instance:handlePM_ResourceConvertGetInfoRes(msg)
	end
end

ResourceConversionAgent.instance = ResourceConversionAgent.New()

return ResourceConversionAgent
