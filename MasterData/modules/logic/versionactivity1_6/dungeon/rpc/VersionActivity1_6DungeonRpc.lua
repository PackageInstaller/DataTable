-- chunkname: @modules/logic/versionactivity1_6/dungeon/rpc/VersionActivity1_6DungeonRpc.lua

module("modules.logic.versionactivity1_6.dungeon.rpc.VersionActivity1_6DungeonRpc", package.seeall)

local VersionActivity1_6DungeonRpc = class("VersionActivity1_6DungeonRpc", BaseRpc)

function VersionActivity1_6DungeonRpc:sendGet149InfoRequest(callback, cbObj)
	local req = Activity149Module_pb.Get149InfoRequest()

	req.activityId = VersionActivity1_6Enum.ActivityId.DungeonBossRush

	return self:sendMsg(req, callback, cbObj)
end

function VersionActivity1_6DungeonRpc:onReceiveGet149InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_6DungeonBossModel.instance:onReceiveInfos(msg)
	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.DungeonBossInfoUpdated)
end

function VersionActivity1_6DungeonRpc:sendAct149GetScoreRewardsRequest(callback, cbObj)
	local req = Activity149Module_pb.Act149GetScoreRewardsRequest()

	req.activityId = VersionActivity1_6Enum.ActivityId.DungeonBossRush

	return self:sendMsg(req, callback, cbObj)
end

function VersionActivity1_6DungeonRpc:onReceiveAct149GetScoreRewardsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_6DungeonBossModel.instance:onReceiveScoreInfos(msg)
end

function VersionActivity1_6DungeonRpc:sendAct149GainDailyBonusRequest(callback, cbObj)
	local req = Activity149Module_pb.Act149GainDailyBonusRequest()

	req.activityId = VersionActivity1_6Enum.ActivityId.DungeonBossRush

	return self:sendMsg(req, callback, cbObj)
end

function VersionActivity1_6DungeonRpc:onReceiveAct149GainDailyBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actId = msg.activityId

	if actId ~= 0 then
		VersionActivity1_6DungeonBossModel.instance:SetOpenBossViewWithDailyBonus(true)
	end
end

function VersionActivity1_6DungeonRpc:sendGet148InfoRequest(callback, cbObj)
	local req = Activity148Module_pb.Get148InfoRequest()

	req.activityId = VersionActivity1_6Enum.ActivityId.DungeonSkillTree

	return self:sendMsg(req, callback, cbObj)
end

function VersionActivity1_6DungeonRpc:onReceiveGet148InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_6DungeonSkillModel.instance:onReceiveInfos(msg)
end

function VersionActivity1_6DungeonRpc:sendAct148UpLevelRequest(skillType, callback, cbObj)
	local req = Activity148Module_pb.Act148UpLevelRequest()

	req.activityId = VersionActivity1_6Enum.ActivityId.DungeonSkillTree
	req.type = skillType

	return self:sendMsg(req, callback, cbObj)
end

function VersionActivity1_6DungeonRpc:onReceiveAct148UpLevelReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local skillInfo = msg.skillTree
	local level = skillInfo.level

	VersionActivity1_6DungeonSkillModel.instance:onReceiveLevelUpReply(msg)
	VersionActivity1_6DungeonController.instance:dispatchEvent(Act148Event.SkillLvUp, level)
end

function VersionActivity1_6DungeonRpc:sendAct148DownLevelRequest(skillType, callback, cbObj)
	local req = Activity148Module_pb.Act148DownLevelRequest()

	req.activityId = VersionActivity1_6Enum.ActivityId.DungeonSkillTree
	req.type = skillType

	return self:sendMsg(req, callback, cbObj)
end

function VersionActivity1_6DungeonRpc:onReceiveAct148DownLevelReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local skillInfo = msg.skillTree
	local level = skillInfo.level

	VersionActivity1_6DungeonSkillModel.instance:onReceiveLevelDownReply(msg)
	VersionActivity1_6DungeonController.instance:dispatchEvent(Act148Event.SkillLvDown, level)
end

function VersionActivity1_6DungeonRpc:sendAct148ResetRequest(callback, cbObj)
	local req = Activity148Module_pb.Act148ResetRequest()

	req.activityId = VersionActivity1_6Enum.ActivityId.DungeonSkillTree

	return self:sendMsg(req, callback, cbObj)
end

function VersionActivity1_6DungeonRpc:onReceiveAct148ResetReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity1_6DungeonSkillModel.instance:onResetSkillInfos(msg)
	VersionActivity1_6DungeonController.instance:dispatchEvent(Act148Event.SkillReset)
end

VersionActivity1_6DungeonRpc.instance = VersionActivity1_6DungeonRpc.New()

return VersionActivity1_6DungeonRpc
