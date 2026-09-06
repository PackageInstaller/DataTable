-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/config/XuChallengeConfig.lua

module("logic.extensions.xuchallenge.config.XuChallengeConfig", package.seeall)

local XuChallengeConfig = class("XuChallengeConfig", BaseConfig)

function XuChallengeConfig:getNames()
	return {
		"xu_challenge_activity",
		"xu_challenge_buff",
		"xu_challenge_creeps",
		"xu_challenge_master",
		"xu_challenge_stage"
	}
end

function XuChallengeConfig:handleConfig(name, content)
	if name == "xu_challenge_activity" then
		self._xu_challenge_activity = content
	elseif name == "xu_challenge_buff" then
		self._xu_challenge_buff = content
	elseif name == "xu_challenge_creeps" then
		self._xu_challenge_creeps = content
	elseif name == "xu_challenge_master" then
		self._xu_challenge_master = content
	elseif name == "xu_challenge_stage" then
		self._xu_challenge_stage = content
	end
end

function XuChallengeConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function XuChallengeConfig:getActivityData(activityId)
	return self:_safeGet(self._xu_challenge_activity, activityId)
end

function XuChallengeConfig:getBuffDatas(activityId)
	return self:_safeGet(self._xu_challenge_buff, activityId)
end

function XuChallengeConfig:getBuffData(activityId, buffId)
	return self:_safeGet(self._xu_challenge_buff, activityId, buffId)
end

function XuChallengeConfig:getBuffDataBySacrificeNum(activityId, sacrificeNum)
	return MmUtil.unorderedSearchInSingleKey(self:getBuffDatas(activityId), "sacrificeNum", checknumber(sacrificeNum))
end

function XuChallengeConfig:getStageDatas(activityId)
	return self:_safeGet(self._xu_challenge_stage, activityId)
end

function XuChallengeConfig:getStageData(activityId, stageId)
	return self:_safeGet(self._xu_challenge_stage, activityId, stageId)
end

function XuChallengeConfig:getStageLayerDatas(activityId)
	local result = {}
	local stageDatas = self:getStageDatas(activityId)
	local layerData

	for _, stageData in ipairs(stageDatas or {}) do
		local stageId = checknumber(stageData.stageId)

		layerData = layerData or {
			stageIds = {},
			startStageId = stageId
		}

		table.insert(layerData.stageIds, stageId)

		layerData.endStageId = stageId

		if not string.nilorempty(stageData.prize) then
			layerData.prize = stageData.prize

			table.insert(result, layerData)

			layerData = nil
		end
	end

	if layerData ~= nil and #layerData.stageIds > 0 then
		printError(string.format("xu_challenge_stage 配置存在未配置层奖励的尾段关卡，activityId = %s, startStageId = %s", activityId, layerData.startStageId))
	end

	return result
end

function XuChallengeConfig:getLastStageLayerData(activityId)
	local layerDatas = self:getStageLayerDatas(activityId)

	return layerDatas[#layerDatas]
end

function XuChallengeConfig:getMasterData(creepsMasterId)
	return self:_safeGet(self._xu_challenge_master, creepsMasterId)
end

function XuChallengeConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._xu_challenge_creeps, creepsMasterId)
end

function XuChallengeConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._xu_challenge_creeps, creepsMasterId, creepsId)
end

XuChallengeConfig.instance = XuChallengeConfig.New()

return XuChallengeConfig
