-- chunkname: @modules/logic/versionactivity1_5/dungeon/rpc/VersionActivity1_5DungeonRpc.lua

module("modules.logic.versionactivity1_5.dungeon.rpc.VersionActivity1_5DungeonRpc", package.seeall)

local VersionActivity1_5DungeonRpc = class("VersionActivity1_5DungeonRpc", BaseRpc)

function VersionActivity1_5DungeonRpc:sendGet139InfosRequest(callback, cbObj)
	local req = Activity139Module_pb.Get139InfosRequest()

	req.activityId = VersionActivity1_5Enum.ActivityId.DungeonExploreTask

	return self:sendMsg(req, callback, cbObj)
end

function VersionActivity1_5DungeonRpc:onReceiveGet139InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_5RevivalTaskModel.instance:updateExploreTaskInfo(msg.gainedExploreReward)
	VersionActivity1_5RevivalTaskModel.instance:updateHeroTaskInfos(msg.heroTaskInfos)
	VersionActivity1_5DungeonModel.instance:addDispatchInfos(msg.dispatchInfos)
end

function VersionActivity1_5DungeonRpc:sendAct139DispatchRequest(dispatchId, heroIds, callback, callbackObj)
	local req = Activity139Module_pb.Act139DispatchRequest()

	req.activityId = VersionActivity1_5Enum.ActivityId.DungeonExploreTask
	req.id = dispatchId

	for _, heroId in ipairs(heroIds) do
		req.heroIds:append(heroId)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function VersionActivity1_5DungeonRpc:onReceiveAct139DispatchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local serverTimeStamp = tonumber(msg.startTime)
	local serverTimeStampSecond = math.floor(serverTimeStamp / 1000)

	ServerTime.update(serverTimeStampSecond)
	VersionActivity1_5DungeonModel.instance:addOneDispatchInfo(msg.id, msg.endTime, msg.heroIds)
end

function VersionActivity1_5DungeonRpc:sendAct139InterruptDispatchRequest(dispatchId)
	local req = Activity139Module_pb.Act139InterruptDispatchRequest()

	req.activityId = VersionActivity1_5Enum.ActivityId.DungeonExploreTask
	req.id = dispatchId

	return self:sendMsg(req)
end

function VersionActivity1_5DungeonRpc:onReceiveAct139InterruptDispatchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_5DungeonModel.instance:removeOneDispatchInfo(msg.id)
end

function VersionActivity1_5DungeonRpc:sendAct139GainSubHeroTaskRewardRequest(subTaskId)
	local req = Activity139Module_pb.Act139GainSubHeroTaskRewardRequest()

	req.id = subTaskId

	return self:sendMsg(req)
end

function VersionActivity1_5DungeonRpc:onReceiveAct139GainSubHeroTaskRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_5RevivalTaskModel.instance:gainedSubTaskReward(msg.id)
end

function VersionActivity1_5DungeonRpc:sendAct139GainHeroTaskRewardRequest(heroTaskId)
	local req = Activity139Module_pb.Act139GainHeroTaskRewardRequest()

	req.id = heroTaskId

	return self:sendMsg(req)
end

function VersionActivity1_5DungeonRpc:onReceiveAct139GainHeroTaskRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_5RevivalTaskModel.instance:gainedHeroTaskReward(msg.id)
end

function VersionActivity1_5DungeonRpc:sendAct139GainExploreRewardRequest()
	local req = Activity139Module_pb.Act139GainExploreRewardRequest()

	req.activityId = VersionActivity1_5Enum.ActivityId.DungeonExploreTask

	return self:sendMsg(req)
end

function VersionActivity1_5DungeonRpc:onReceiveAct139GainExploreRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_5RevivalTaskModel.instance:gainedExploreTaskReward(msg.id)
end

function VersionActivity1_5DungeonRpc:sendGet140InfosRequest(callback, callbackObj)
	local req = Activity140Module_pb.Get140InfosRequest()

	req.activityId = VersionActivity1_5Enum.ActivityId.DungeonBuilding

	return self:sendMsg(req, callback, callbackObj)
end

function VersionActivity1_5DungeonRpc:onReceiveGet140InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_5BuildModel.instance:initBuildInfoList(msg.info)
end

function VersionActivity1_5DungeonRpc:sendAct140BuildRequest(buildId)
	local req = Activity140Module_pb.Act140BuildRequest()

	req.activityId = VersionActivity1_5Enum.ActivityId.DungeonBuilding
	req.id = buildId

	return self:sendMsg(req)
end

function VersionActivity1_5DungeonRpc:onReceiveAct140BuildReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_5BuildModel.instance:addHadBuild(msg.id)
end

function VersionActivity1_5DungeonRpc:sendAct140SelectBuildRequest(buildIdList)
	local req = Activity140Module_pb.Act140SelectBuildRequest()

	req.activityId = VersionActivity1_5Enum.ActivityId.DungeonBuilding

	for _, buildId in ipairs(buildIdList) do
		table.insert(req.ids, buildId)
	end

	return self:sendMsg(req)
end

function VersionActivity1_5DungeonRpc:onReceiveAct140SelectBuildReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_5BuildModel.instance:updateSelectBuild(msg.ids)
end

function VersionActivity1_5DungeonRpc:sendAct140GainProgressRewardRequest()
	local req = Activity140Module_pb.Act140GainProgressRewardRequest()

	req.activityId = VersionActivity1_5Enum.ActivityId.DungeonBuilding

	return self:sendMsg(req)
end

function VersionActivity1_5DungeonRpc:onReceiveAct140GainProgressRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_5BuildModel.instance:updateGainedReward(true)
end

VersionActivity1_5DungeonRpc.instance = VersionActivity1_5DungeonRpc.New()

return VersionActivity1_5DungeonRpc
