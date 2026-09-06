-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/agent/ClothesAgent.lua

module("logic.extensions.clothes.agent.ClothesAgent", package.seeall)

local ClothesAgent = class("ClothesAgent", BaseAgent)

ClothesAgent.SetMyAvatarRes = "ClothesAgent_SetMyAvatarRes"
ClothesAgent.NotifyClothesChangedRes = "ClothesAgent_NotifyClothesChangedRes"
ClothesAgent.GetOutClothesRes = "ClothesAgent_GetOutClothesRes"
ClothesAgent.GetNoOutClothesRes = "ClothesAgent_GetNoOutClothesRes"

function ClothesAgent:ctor()
	return
end

function ClothesAgent:setExtId(extId)
	ClothesAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ClothesAgent:sendSetMyAvatarReq(wearingClothes_i32_Ary, handler, handlerObj, errHandler)
	local req = ClothesExtension_pb.SetMyAvatarReq()

	for i, v1 in ipairs(wearingClothes_i32_Ary) do
		req.wearingClothes:append(v1)
	end

	self:sendMsg(req)
	self:addEventOnce(ClothesAgent.SetMyAvatarRes, handler, handlerObj, errHandler)
end

function ClothesAgent:handleSetMyAvatarRes(status, msg)
	self:dispatch(ClothesAgent.SetMyAvatarRes, status, msg)
end

function ClothesAgent:handleNotifyClothesChangedRes(status, msg)
	self:dispatch(ClothesAgent.NotifyClothesChangedRes, status, msg)
end

function ClothesAgent:sendGetOutClothesReq(handler, handlerObj, errHandler)
	local req = ClothesExtension_pb.GetOutClothesReq()

	self:sendMsg(req)
	self:addEventOnce(ClothesAgent.GetOutClothesRes, handler, handlerObj, errHandler)
end

function ClothesAgent:handleGetOutClothesRes(status, msg)
	self:dispatch(ClothesAgent.GetOutClothesRes, status, msg)
end

function ClothesAgent:sendGetNoOutClothesReq(handler, handlerObj, errHandler)
	local req = ClothesExtension_pb.GetNoOutClothesReq()

	self:sendMsg(req)
	self:addEventOnce(ClothesAgent.GetNoOutClothesRes, handler, handlerObj, errHandler)
end

function ClothesAgent:handleGetNoOutClothesRes(status, msg)
	self:dispatch(ClothesAgent.GetNoOutClothesRes, status, msg)
end

function ClothesAgent:sendGetClothesPresetReq()
	local req = ClothesExtension_pb.GetClothesPresetReq()

	self:sendMsg(req)
end

function ClothesAgent:handleGetClothesPresetRes(status, msg)
	if status == 0 then
		DressController.instance:handleGetClothesPresetRes(msg)
	end
end

function ClothesAgent:sendUpdateClothesPresetReq(clothesPreset)
	local req = ClothesExtension_pb.UpdateClothesPresetReq()

	req.clothesPreset.presetId = clothesPreset.presetId
	req.clothesPreset.gender = clothesPreset.gender

	local clothes = clothesPreset.clothesIds

	if clothes then
		for _, v in ipairs(clothes) do
			req.clothesPreset.clothesIds:append(v)
		end
	end

	self:sendMsg(req)
end

function ClothesAgent:handleUpdateClothesPresetRes(status, msg)
	if status == 0 then
		DressController.instance:handleUpdateClothesPresetRes(msg)
	end
end

ClothesAgent.instance = ClothesAgent.New()

return ClothesAgent
