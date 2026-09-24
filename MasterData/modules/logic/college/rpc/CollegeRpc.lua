-- chunkname: @modules/logic/college/rpc/CollegeRpc.lua

module("modules.logic.college.rpc.CollegeRpc", package.seeall)

local CollegeRpc = class("CollegeRpc", BaseRpc)

function CollegeRpc:sendCollegeSceneInfo(callback, callobj)
	local req = CollegeModule_pb.CollegeSceneInfoRequest()

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeSceneInfoReply(resultCode, msg)
	if resultCode == 0 then
		CollegeModel.instance:updateSceneMo(msg)
	end
end

function CollegeRpc:sendCollegeCharacterUpgrade(uid, callback, callobj)
	local req = CollegeModule_pb.CollegeCharacterUpgradeRequest()

	req.uid = uid

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeCharacterUpgradeReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeCharacterDismiss(uid, callback, callobj)
	local req = CollegeModule_pb.CollegeCharacterDismissRequest()

	req.uid = uid

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeCharacterDismissReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeBuildingUpgrade(id, callback, callobj)
	local req = CollegeModule_pb.CollegeBuildingUpgradeRequest()

	req.id = id

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeBuildingUpgradeReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeBuildingSlotOper(id, uids, callback, callobj)
	local req = CollegeModule_pb.CollegeBuildingSlotOperRequest()

	req.id = id

	if uids then
		for _, v in ipairs(uids) do
			table.insert(req.uid, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeBuildingSlotOperReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeBuildingRecruitment(callback, callobj)
	local req = CollegeModule_pb.CollegeBuildingRecruitmentRequest()

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeBuildingRecruitmentReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeBuildingRecruitmentConfirm(type, index, callback, callobj)
	local req = CollegeModule_pb.CollegeBuildingRecruitmentConfirmRequest()

	req.type = type
	req.index = index

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeBuildingRecruitmentConfirmReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeBuildingLockEntry(uid, entryIndex, lock, callback, callobj)
	local req = CollegeModule_pb.CollegeBuildingLockEntryRequest()

	req.uid = uid
	req.entryIndex = entryIndex
	req.lock = lock

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeBuildingLockEntryReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeBuildingRefined(uid, callback, callobj)
	local req = CollegeModule_pb.CollegeBuildingRefinedRequest()

	req.uid = uid

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeBuildingRefinedReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeBuildingConfirmEntry(type, callback, callobj)
	local req = CollegeModule_pb.CollegeBuildingConfirmEntryRequest()

	req.type = type

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeBuildingConfirmEntryReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeWorldMapSlotOper(areaId, uid, callback, callobj)
	local req = CollegeModule_pb.CollegeWorldMapSlotOperRequest()

	req.areaId = areaId

	if uid then
		for _, v in ipairs(uid) do
			table.insert(req.uid, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeWorldMapSlotOperReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeEndRound(callback, callobj)
	local req = CollegeModule_pb.CollegeEndRoundRequest()

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeEndRoundReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeEventOption(eventId, optionIndex, callback, callobj)
	local req = CollegeModule_pb.CollegeEventOptionRequest()

	req.eventId = eventId
	req.optionIndex = optionIndex

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeEventOptionReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeMilestoneActiveNode(id, callback, callobj)
	local req = CollegeModule_pb.CollegeMilestoneActiveNodeRequest()

	req.id = id

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeMilestoneActiveNodeReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeMilestoneClaim(callback, callobj)
	local req = CollegeModule_pb.CollegeMilestoneClaimRequest()

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeMilestoneClaimReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeClientDataUpdate(clientData, callback, callobj)
	local req = CollegeModule_pb.CollegeClientDataUpdateRequest()

	req.clientData = clientData

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeClientDataUpdateReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeMilestoneReadState(id, callback, callobj)
	local req = CollegeModule_pb.CollegeMilestoneReadStateRequest()

	req.id = id

	CollegeModel.instance:updateCharacterState(id)
	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateCharacterState, id)

	local refreshlist = {
		[RedDotEnum.DotNode.CollegeRelation] = true
	}

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, refreshlist)

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeMilestoneReadStateReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:onReceiveCollegePushs(resultCode, msg)
	if resultCode == 0 then
		CollegeModel.instance:updatePushs(msg.pushs)
	end
end

function CollegeRpc:sendCollegeHotfix1(intParams, strParams, callback, callobj)
	local req = CollegeModule_pb.CollegeHotfix1Request()

	if intParams then
		for _, v in ipairs(intParams) do
			table.insert(req.intParams, v)
		end
	end

	if strParams then
		for _, v in ipairs(strParams) do
			table.insert(req.strParams, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeHotfix1Reply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeHotfix2(intParams, strParams, callback, callobj)
	local req = CollegeModule_pb.CollegeHotfix2Request()

	if intParams then
		for _, v in ipairs(intParams) do
			table.insert(req.intParams, v)
		end
	end

	if strParams then
		for _, v in ipairs(strParams) do
			table.insert(req.strParams, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeHotfix2Reply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function CollegeRpc:sendCollegeHotfix3(intParams, strParams, callback, callobj)
	local req = CollegeModule_pb.CollegeHotfix3Request()

	if intParams then
		for _, v in ipairs(intParams) do
			table.insert(req.intParams, v)
		end
	end

	if strParams then
		for _, v in ipairs(strParams) do
			table.insert(req.strParams, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function CollegeRpc:onReceiveCollegeHotfix3Reply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

CollegeRpc.instance = CollegeRpc.New()

return CollegeRpc
