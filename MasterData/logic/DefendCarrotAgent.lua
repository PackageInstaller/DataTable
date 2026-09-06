-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/agent/DefendCarrotAgent.lua

module("logic.extensions.defendcarrot.agent.DefendCarrotAgent", package.seeall)

local DefendCarrotAgent = class("DefendCarrotAgent", BaseAgent)

function DefendCarrotAgent:sendPM_DefendCarrotInfoReq(activityId)
	local req = DefendCarrotExtension_pb.PM_DefendCarrotInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DefendCarrotAgent:handlePM_DefendCarrotInfoRes(status, msg)
	if status == 0 then
		DefendCarrotController.instance:handleGetInfo(msg)
	end
end

function DefendCarrotAgent:sendPM_DefendCarrotUpgradeWeaponReq(activityId, weaponId)
	local req = DefendCarrotExtension_pb.PM_DefendCarrotUpgradeWeaponReq()

	req.activityId = activityId
	req.weaponId = weaponId

	self:sendMsg(req)
end

function DefendCarrotAgent:handlePM_DefendCarrotUpgradeWeaponRes(status, msg)
	if status == 0 then
		DefendCarrotController.instance:handleUpgradeWeapon(msg)
	end
end

function DefendCarrotAgent:sendPM_DefendCarrotStartGameReq(activityId, stageId, clientKey)
	local req = DefendCarrotExtension_pb.PM_DefendCarrotStartGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function DefendCarrotAgent:handlePM_DefendCarrotStartGameRes(status, msg)
	if status == 0 then
		DefendCarrotController.instance:handleStartGame(msg)
	end
end

function DefendCarrotAgent:sendPM_DefendCarrotEndGameReq(activityId, stageId, isPass, encryptedKey, kills_pb_Ary, history_pb_Ary, last_pb_Ary)
	local req = DefendCarrotExtension_pb.PM_DefendCarrotEndGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.isPass = isPass
	req.encryptedKey = encryptedKey

	if kills_pb_Ary ~= nil then
		for i, v1 in ipairs(kills_pb_Ary) do
			local kills = req.kills:add()

			kills.weaponId = v1.weaponId
			kills.killNum = v1.killNum
		end
	end

	if history_pb_Ary ~= nil then
		for i, v2 in ipairs(history_pb_Ary) do
			local history = req.history:add()

			history.weaponId = v2.weaponId
			history.buildNum = v2.buildNum
		end
	end

	if last_pb_Ary ~= nil then
		for i, v2 in ipairs(last_pb_Ary) do
			local last = req.last:add()

			last.weaponId = v2.weaponId
			last.buildNum = v2.buildNum
		end
	end

	self:sendMsg(req)
end

function DefendCarrotAgent:handlePM_DefendCarrotEndGameRes(status, msg)
	if status == 0 then
		DefendCarrotController.instance:handleEndGame(msg)
	end
end

function DefendCarrotAgent:sendPM_DefendCarrotGainPrizeReq(activityId, prizeId)
	local req = DefendCarrotExtension_pb.PM_DefendCarrotGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DefendCarrotAgent:handlePM_DefendCarrotGainPrizeRes(status, msg)
	if status == 0 then
		DefendCarrotController.instance:handleGainPrize(msg)
	end
end

function DefendCarrotAgent:sendPM_DefendCarrotMaterialClgStartGameReq(activityId, stageId, clientKey)
	local req = DefendCarrotExtension_pb.PM_DefendCarrotMaterialClgStartGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function DefendCarrotAgent:handlePM_DefendCarrotMaterialClgStartGameRes(status, msg)
	if status == 0 then
		DefendCarrotController.instance:handleStartMaterialGame(msg)
	end
end

function DefendCarrotAgent:sendPM_DefendCarrotMaterialClgEndGameReq(activityId, stageId, isPass, encryptedKey, finishWaveId)
	local req = DefendCarrotExtension_pb.PM_DefendCarrotMaterialClgEndGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.isPass = isPass
	req.encryptedKey = encryptedKey
	req.finishWaveId = finishWaveId

	self:sendMsg(req)
end

function DefendCarrotAgent:handlePM_DefendCarrotMaterialClgEndGameRes(status, msg)
	if status == 0 then
		DefendCarrotController.instance:handleEndMaterialGame(msg)
	end
end

function DefendCarrotAgent:sendPM_DefendCarrotRankInfoReq(activityId)
	local req = DefendCarrotExtension_pb.PM_DefendCarrotRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DefendCarrotAgent:handlePM_DefendCarrotRankInfoRes(status, msg)
	if status == 0 then
		DefendCarrotController.instance:handleGetRankInfo(msg)
	end
end

DefendCarrotAgent.instance = DefendCarrotAgent.New()

return DefendCarrotAgent
