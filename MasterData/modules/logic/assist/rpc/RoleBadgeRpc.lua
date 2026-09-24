-- chunkname: @modules/logic/assist/rpc/RoleBadgeRpc.lua

module("modules.logic.assist.rpc.RoleBadgeRpc", package.seeall)

local RoleBadgeRpc = class("RoleBadgeRpc", BaseRpc)

function RoleBadgeRpc:sendRoleBadgeGetInfoRequest()
	local req = RoleBadgeModule_pb.RoleBadgeGetInfoRequest()

	return self:sendMsg(req)
end

function RoleBadgeRpc:onReceiveRoleBadgeGetInfoReply(resultCode, msg)
	if resultCode == 0 then
		RoleBadgeModel.instance:setBadgeInfo(msg.info)
	end
end

function RoleBadgeRpc:sendRoleBadgeWearRequest(heroUid, position, badgeId)
	local req = RoleBadgeModule_pb.RoleBadgeWearRequest()

	req.heroUid = heroUid
	req.wear.position = position
	req.wear.badgeId = badgeId

	return self:sendMsg(req)
end

function RoleBadgeRpc:onReceiveRoleBadgeWearReply(resultCode, msg)
	if resultCode == 0 then
		local badgeInfoMo = RoleBadgeModel.instance:getBadgeInfo()

		if badgeInfoMo then
			local recordMo = badgeInfoMo:getRecordMo(msg.heroUid)

			if recordMo then
				recordMo:updateWears(msg.wears)
				AssistController.instance:dispatchEvent(AssistEvent.UpdateWearBadges, msg.heroUid)
			end
		end
	end
end

function RoleBadgeRpc:onReceiveRoleBadgeUpdatePush(resultCode, msg)
	if resultCode == 0 then
		local badgeInfoMo = RoleBadgeModel.instance:getBadgeInfo()

		if badgeInfoMo then
			badgeInfoMo:updateRecordMos(msg.records)
		end
	end
end

RoleBadgeRpc.instance = RoleBadgeRpc.New()

return RoleBadgeRpc
