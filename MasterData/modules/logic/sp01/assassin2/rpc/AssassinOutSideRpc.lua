-- chunkname: @modules/logic/sp01/assassin2/rpc/AssassinOutSideRpc.lua

module("modules.logic.sp01.assassin2.rpc.AssassinOutSideRpc", package.seeall)

local AssassinOutSideRpc = class("AssassinOutSideRpc", BaseRpc)

function AssassinOutSideRpc:sendGetAssassinOutSideInfoRequest(actId, cb, cbObj)
	local req = AssassinOutSideModule_pb.GetAssassinOutSideInfoRequest()

	req.activityId = actId

	self:sendMsg(req, cb, cbObj)
end

function AssassinOutSideRpc:onReceiveGetAssassinOutSideInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinController.instance:onGetAssassinOutSideInfo(msg.assassinOutSideInfo)
end

function AssassinOutSideRpc:sendBuildingLevelUpRequest(buildingId, cb, cbObj)
	local req = AssassinOutSideModule_pb.BuildingLevelUpRequest()

	req.buildingId = buildingId

	return self:sendMsg(req, cb, cbObj)
end

function AssassinOutSideRpc:onReceiveBuildingLevelUpReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinController.instance:updateBuildingInfo(msg.building)
	AssassinController.instance:updateCoinNum(msg.coin)
end

function AssassinOutSideRpc:sendInteractiveRequest(questId, cb, cbObj)
	local req = AssassinOutSideModule_pb.InteractiveRequest()

	req.questId = questId

	self:sendMsg(req, cb, cbObj)
end

function AssassinOutSideRpc:onReceiveInteractiveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinOutSideRpc:sendHeroTransferCareerRequest(heroId, careerId, cb, cbObj)
	local req = AssassinOutSideModule_pb.HeroTransferCareerRequest()

	req.heroId = heroId
	req.careerId = careerId

	self:sendMsg(req, cb, cbObj)
end

function AssassinOutSideRpc:onReceiveHeroTransferCareerReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinOutSideRpc:sendEquipHeroItemRequest(heroId, index, itemType, cb, cbObj)
	local req = AssassinOutSideModule_pb.EquipHeroItemRequest()

	req.heroId = heroId
	req.index = index
	req.itemType = itemType

	self:sendMsg(req, cb, cbObj)
end

function AssassinOutSideRpc:onReceiveEquipHeroItemReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinOutSideRpc:onReceiveAssassinOutSideUnlockPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinController.instance:onUnlockQuestContent(msg.unlockMapIds, msg.items, msg.heros, msg.questIds)
	AssassinController.instance:onGetBuildingUnlockInfo(msg.unlockBuildIds)
end

function AssassinOutSideRpc:sendGetAssassinLibraryInfoRequest(activityId, cb, cbObj)
	local req = AssassinOutSideModule_pb.GetAssassinLibraryInfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, cb, cbObj)
end

function AssassinOutSideRpc:onReceiveGetAssassinLibraryInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinLibraryModel.instance:updateLibraryInfos(msg.unlockLibraryIds)
end

function AssassinOutSideRpc:onReceiveAssassinUnlockLibraryPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinLibraryController.instance:onUnlockLibraryIds(msg.unlockLibraryIds)
end

AssassinOutSideRpc.instance = AssassinOutSideRpc.New()

return AssassinOutSideRpc
