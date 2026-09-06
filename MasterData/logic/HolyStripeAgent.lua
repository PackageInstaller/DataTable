-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/agent/HolyStripeAgent.lua

module("logic.extensions.holystripe.agent.HolyStripeAgent", package.seeall)

local HolyStripeAgent = class("HolyStripeAgent", BaseAgent)

HolyStripeAgent.PM_HolyStripeLoadAllRes = "HolyStripeAgent_PM_HolyStripeLoadAllRes"
HolyStripeAgent.PM_HolyStripeEquipRes = "HolyStripeAgent_PM_HolyStripeEquipRes"
HolyStripeAgent.PM_HolyStripeUnloadRes = "HolyStripeAgent_PM_HolyStripeUnloadRes"
HolyStripeAgent.PM_HolyStripeSmeltRes = "HolyStripeAgent_PM_HolyStripeSmeltRes"
HolyStripeAgent.PM_HolyStripeSetSmeltInfoRes = "HolyStripeAgent_PM_HolyStripeSetSmeltInfoRe"
HolyStripeAgent.PM_HolyStripeStrengthenRes = "PM_HolyStripeStrengthenRes"
HolyStripeAgent.PM_HolyStripeQuenchingRes = "HolyStripeAgent_PM_HolyStripeQuenchingRes"
HolyStripeAgent.PM_HolyStripeUnloadAllRes = "HolyStripeAgent.PM_HolyStripeUnloadAllRes"
HolyStripeAgent.PM_HolyStripeLockOperationRes = "HolyStripeAgent.PM_HolyStripeLockOperationRes"
HolyStripeAgent.PM_HolyStripeChangeReadyToDiscardRes = "HolyStripeAgent.PM_HolyStripeChangeReadyToDiscardRes"
HolyStripeAgent.PM_HolyStripeChangeRes = "HolyStripeAgent.PM_HolyStripeChangeRes"
HolyStripeAgent.PM_HolyStripeReplaceQuenchingDataRes = "HolyStripeAgent.PM_HolyStripeReplaceQuenchingDataRes"
HolyStripeAgent.PM_SuitGetInfoRes = "HolyStripeAgent.PM_SuitGetInfoRes"
HolyStripeAgent.PM_ModifySuitGroupRes = "HolyStripeAgent.PM_ModifySuitGroupRes"
HolyStripeAgent.PM_DeleteSuitGroupRes = "HolyStripeAgent.PM_DeleteSuitGroupRes"
HolyStripeAgent.PM_ModifySuitRes = "HolyStripeAgent.PM_ModifySuitRes"
HolyStripeAgent.PM_DeleteSuitRes = "HolyStripeAgent.PM_DeleteSuitRes"
HolyStripeAgent.PM_HolyStripeWearSuitRes = "HolyStripeAgent.PM_HolyStripeWearSuitRes"
HolyStripeAgent.PM_NotifySuitInfoChangeRes = "HolyStripeAgent.PM_NotifySuitInfoChangeRes"
HolyStripeAgent.PM_NotifySuitGroupInfoChangeRes = "HolyStripeAgent.PM_NotifySuitGroupInfoChangeRes"
HolyStripeAgent.PM_SetHolyStripeAutoDecomposeRes = "HolyStripeAgent.PM_SetHolyStripeAutoDecomposeRes"

function HolyStripeAgent:sendPM_HolyStripeLoadAllReq()
	local req = HolyStripeExtension_pb.PM_HolyStripeLoadAllReq()

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_HolyStripeLoadAllRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeLoadAllRes, status, msg)
	end
end

function HolyStripeAgent:handlePM_HolyStripeChangeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeChangeRes, status, msg)
end

function HolyStripeAgent:sendPM_HolyStripeEquipReq(petId, id)
	local req = HolyStripeExtension_pb.PM_HolyStripeEquipReq()

	req.petId = petId
	req.id = id

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_HolyStripeEquipRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeEquipRes, status, msg)
	end
end

function HolyStripeAgent:sendPM_HolyStripeUnloadReq(petId, id)
	local req = HolyStripeExtension_pb.PM_HolyStripeUnloadReq()

	req.petId = petId
	req.id = id

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_HolyStripeUnloadRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeUnloadRes, status, msg)
	end
end

function HolyStripeAgent:sendPM_HolyStripeSmeltReq(ids)
	local req = HolyStripeExtension_pb.PM_HolyStripeSmeltReq()

	for i, v in ipairs(ids) do
		req.ids:append(v)
	end

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_HolyStripeSmeltRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeSmeltRes, status, msg)
	end
end

function HolyStripeAgent:sendPM_HolyStripeSetSmeltInfoReq(quality, days)
	local req = HolyStripeExtension_pb.PM_HolyStripeSetSmeltInfoReq()

	for i, v in ipairs(quality) do
		req.smeltInfo.qualities:append(v)
	end

	req.smeltInfo.days = days

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_HolyStripeSetSmeltInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeSetSmeltInfoRes, status, msg)
	end
end

function HolyStripeAgent:sendPM_HolyStripeStrengthenReq(id, usingIds, usingMaterials)
	local req = HolyStripeExtension_pb.PM_HolyStripeStrengthenReq()

	req.id = id

	for i, v1 in ipairs(usingIds) do
		req.usingIds:append(v1)
	end

	if usingMaterials ~= nil then
		for i, v1 in ipairs(usingMaterials) do
			local items = req.usingMaterials:add()

			items:ParseFromString(v1:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_HolyStripeStrengthenRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeStrengthenRes, status, msg)
	end
end

function HolyStripeAgent:sendPM_HolyStripeQuenchingReq(id, selectQuenchingIds)
	local req = HolyStripeExtension_pb.PM_HolyStripeQuenchingReq()

	req.id = id

	for i, v1 in ipairs(selectQuenchingIds) do
		req.selectQuenchingIds:append(v1)
	end

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_HolyStripeQuenchingRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeQuenchingRes, status, msg)
	end
end

function HolyStripeAgent:sendPM_HolyStripeUnloadAllReq(petIdList)
	local req = HolyStripeExtension_pb.PM_HolyStripeUnloadAllReq()

	for _, v in ipairs(petIdList) do
		req.petId:append(v)
	end

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_HolyStripeUnloadAllRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeUnloadAllRes, status, msg)
end

function HolyStripeAgent:sendPM_HolyStripeLockOperationReq(ids, lockType)
	local req = HolyStripeExtension_pb.PM_HolyStripeLockOperationReq()

	for i, v1 in ipairs(ids) do
		req.ids:append(v1)
	end

	req.lockType = lockType

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_HolyStripeLockOperationRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeLockOperationRes, status, msg)
end

function HolyStripeAgent:sendPM_HolyStripeChangeReadyToDiscardReq(setIds_i32_Ary, unSetIds_i32_Ary)
	local req = HolyStripeExtension_pb.PM_HolyStripeChangeReadyToDiscardReq()

	for i, v1 in ipairs(setIds_i32_Ary) do
		req.setIds:append(v1)
	end

	for i, v2 in ipairs(unSetIds_i32_Ary) do
		req.unSetIds:append(v2)
	end

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_HolyStripeChangeReadyToDiscardRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeChangeReadyToDiscardRes, status, msg)
end

function HolyStripeAgent:sendPM_HolyStripeReplaceQuenchingDataReq(id)
	local req = HolyStripeExtension_pb.PM_HolyStripeReplaceQuenchingDataReq()

	req.id = id

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_HolyStripeReplaceQuenchingDataRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeReplaceQuenchingDataRes, status, msg)
end

function HolyStripeAgent:sendPM_SuitGetInfoReq()
	local req = HolyStripeExtension_pb.PM_SuitGetInfoReq()

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_SuitGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_SuitGetInfoRes, msg)
	end
end

function HolyStripeAgent:sendPM_ModifySuitGroupReq(groupId, groupName)
	local req = HolyStripeExtension_pb.PM_ModifySuitGroupReq()

	if groupId then
		req.groupId = groupId
	end

	req.groupName = groupName

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_ModifySuitGroupRes(status, msg)
	GlobalDispatcher:dispatch(HolyStripeAgent.PM_ModifySuitGroupRes, msg)
end

function HolyStripeAgent:sendPM_DeleteSuitGroupReq(groupId)
	local req = HolyStripeExtension_pb.PM_DeleteSuitGroupReq()

	req.groupId = groupId

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_DeleteSuitGroupRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_DeleteSuitGroupRes, msg)
	end
end

function HolyStripeAgent:sendPM_ModifySuitReq(suitId, suitName, groupId, wearItemIds)
	local req = HolyStripeExtension_pb.PM_ModifySuitReq()

	if suitId then
		req.suitId = suitId
	end

	if suitName then
		req.suitName = suitName
	end

	if groupId then
		req.groupId = groupId
	end

	for i, v in ipairs(wearItemIds) do
		req.wearItemIds:append(v)
	end

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_ModifySuitRes(status, msg)
	GlobalDispatcher:dispatch(HolyStripeAgent.PM_ModifySuitRes, status, msg)
end

function HolyStripeAgent:sendPM_DeleteSuitReq(suitId)
	local req = HolyStripeExtension_pb.PM_DeleteSuitReq()

	req.suitId = suitId

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_DeleteSuitRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_DeleteSuitRes, msg)
	end
end

function HolyStripeAgent:sendPM_HolyStripeWearSuitReq(petId, suitId)
	local req = HolyStripeExtension_pb.PM_HolyStripeWearSuitReq()

	req.petId = petId
	req.suitId = suitId

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_HolyStripeWearSuitRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_HolyStripeWearSuitRes, msg)
	end
end

function HolyStripeAgent:sendPM_SetHolyStripeAutoDecomposeReq(quality)
	local req = HolyStripeExtension_pb.PM_SetHolyStripeAutoDecomposeReq()

	req.quality = quality

	self:sendMsg(req)
end

function HolyStripeAgent:handlePM_SetHolyStripeAutoDecomposeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_SetHolyStripeAutoDecomposeRes, msg)
	end
end

function HolyStripeAgent:handlePM_NotifySuitInfoChangeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_NotifySuitInfoChangeRes, msg)
	end
end

function HolyStripeAgent:handlePM_NotifySuitGroupInfoChangeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeAgent.PM_NotifySuitGroupInfoChangeRes, msg)
	end
end

HolyStripeAgent.instance = HolyStripeAgent.New()

return HolyStripeAgent
