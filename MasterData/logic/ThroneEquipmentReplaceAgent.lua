-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfareequiprecycle/agent/ThroneEquipmentReplaceAgent.lua

module("logic.extensions.throneequipmentreplace.agent.ThroneEquipmentReplaceAgent", package.seeall)

local ThroneEquipmentReplaceAgent = class("ThroneEquipmentReplaceAgent", BaseAgent)

function ThroneEquipmentReplaceAgent:ctor()
	return
end

function ThroneEquipmentReplaceAgent:setExtId(extId)
	ThroneEquipmentReplaceAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ThroneEquipmentReplaceAgent:sendPM_ThroneEquipmentReplaceReq(activityId, itemMap)
	local req = ThroneEquipmentReplaceExtension_pb.PM_ThroneEquipmentReplaceReq()

	req.activityId = activityId

	for k, arr in pairs(itemMap) do
		local item = req.items:add()

		item.materialType = checknumber(k)

		for i, id in ipairs(arr) do
			item.itemIds:append(id)
		end
	end

	self:sendMsg(req)
end

function ThroneEquipmentReplaceAgent:handlePM_ThroneEquipmentReplaceRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OnWelfareRecycleUpdate)
	end
end

ThroneEquipmentReplaceAgent.instance = ThroneEquipmentReplaceAgent.New()

return ThroneEquipmentReplaceAgent
