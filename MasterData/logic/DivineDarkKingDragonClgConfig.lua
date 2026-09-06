-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/config/DivineDarkKingDragonClgConfig.lua

module("logic.extensions.divinedarkkingdragonclg.config.DivineDarkKingDragonClgConfig", package.seeall)

local DivineDarkKingDragonClgConfig = class("DivineDarkKingDragonClgConfig", BaseConfig)

function DivineDarkKingDragonClgConfig:getNames()
	return {
		"divine_dark_king_dragon_clg_creeps",
		"divine_dark_king_dragon_clg_activity",
		"divine_dark_king_dragon_clg_stage",
		"divine_dark_king_dragon_clg_angle",
		"divine_dark_king_dragon_clg_buff",
		"divine_dark_king_dragon_clg_phase",
		"divine_dark_king_dragon_clg_master"
	}
end

function DivineDarkKingDragonClgConfig:handleConfig(name, content)
	if name == "divine_dark_king_dragon_clg_creeps" then
		self._divine_dark_king_dragon_clg_creeps = content
	elseif name == "divine_dark_king_dragon_clg_activity" then
		self._divine_dark_king_dragon_clg_activity = content
	elseif name == "divine_dark_king_dragon_clg_stage" then
		self._divine_dark_king_dragon_clg_stage = content
	elseif name == "divine_dark_king_dragon_clg_angle" then
		self._divine_dark_king_dragon_clg_angle = content
	elseif name == "divine_dark_king_dragon_clg_buff" then
		self._divine_dark_king_dragon_clg_buff = content

		self:_handleBuffCfg()
	elseif name == "divine_dark_king_dragon_clg_phase" then
		self._divine_dark_king_dragon_clg_phase = content
	elseif name == "divine_dark_king_dragon_clg_master" then
		self._divine_dark_king_dragon_clg_master = content
	end
end

function DivineDarkKingDragonClgConfig:getActCfgById(activityId)
	return self._divine_dark_king_dragon_clg_activity[activityId]
end

function DivineDarkKingDragonClgConfig:getPhaseCfgsByActId(activityId)
	return self._divine_dark_king_dragon_clg_phase[activityId]
end

function DivineDarkKingDragonClgConfig:getPhaseCfgsByPhaseId(activityId, phaseId)
	if self._divine_dark_king_dragon_clg_phase[activityId] then
		return self._divine_dark_king_dragon_clg_phase[activityId][phaseId]
	end
end

function DivineDarkKingDragonClgConfig:getStageCfgsByPhaseId(activityId, phaseId)
	if self._divine_dark_king_dragon_clg_stage[activityId] then
		return self._divine_dark_king_dragon_clg_stage[activityId][phaseId]
	end
end

function DivineDarkKingDragonClgConfig:getStageCfgByStageId(activityId, phaseId, stageId)
	if self._divine_dark_king_dragon_clg_stage[activityId] and self._divine_dark_king_dragon_clg_stage[activityId][phaseId] then
		return self._divine_dark_king_dragon_clg_stage[activityId][phaseId][stageId]
	end
end

function DivineDarkKingDragonClgConfig:getStageMapsByActivityId(activityId)
	return self._divine_dark_king_dragon_clg_stage[activityId]
end

function DivineDarkKingDragonClgConfig:_handleBuffCfg()
	self._buffCfgs = {}

	for i, v in ipairs(self._divine_dark_king_dragon_clg_buff.dataList) do
		self._buffCfgs[v.activityId] = self._buffCfgs[v.activityId] or {}

		table.insert(self._buffCfgs[v.activityId], v)
	end
end

function DivineDarkKingDragonClgConfig:getBuffCfgList(activityId)
	return self._buffCfgs[activityId]
end

function DivineDarkKingDragonClgConfig:getCreepCfgs(creepsMasterId)
	return self._divine_dark_king_dragon_clg_creeps[creepsMasterId]
end

function DivineDarkKingDragonClgConfig:getTeamCfg(creepsMasterId)
	return self._divine_dark_king_dragon_clg_master[creepsMasterId]
end

function DivineDarkKingDragonClgConfig:getAngleByPhaseIdAndNum(activityId, phaseId, num)
	local angle = 0

	if self._divine_dark_king_dragon_clg_angle[activityId] then
		local phaseCfgs = self._divine_dark_king_dragon_clg_angle[activityId][phaseId]

		if phaseCfgs then
			for i, v in ipairs(phaseCfgs) do
				if num < v.num then
					break
				else
					angle = v.angle
				end
			end
		end
	end

	return angle
end

DivineDarkKingDragonClgConfig.instance = DivineDarkKingDragonClgConfig.New()

return DivineDarkKingDragonClgConfig
