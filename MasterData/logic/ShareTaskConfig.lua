-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/config/ShareTaskConfig.lua

module("logic.extensions.sharetask.config.ShareTaskConfig", package.seeall)

local ShareTaskConfig = class("ShareTaskConfig", BaseConfig)

function ShareTaskConfig:onInit()
	ShareTaskConfig.super.onInit(self)

	self.bossBaseCfgs = nil
	self.bossTeamCfgs = nil
	self.teamPosCfgs = nil
	self.commonCfgs = nil
	self.bossLevelCfgs = nil
end

function ShareTaskConfig:getNames()
	return {
		"share_task",
		"assist_team_upgrade",
		"share_task_team",
		"share_task_creeps",
		"share_task_common",
		"share_task_level"
	}
end

function ShareTaskConfig:handleConfig(name, content)
	if name == "share_task" then
		self.bossBaseCfgs = content
	elseif name == "share_task_team" then
		self.bossTeamCfgs = content
	elseif name == "share_task_creeps" then
		self.teamPosCfgs = content
	elseif name == "share_task_common" then
		self.commonCfgs = {}

		if content.FUNCTION_OPEN_ID then
			self.commonCfgs.funOpenId = tonumber(content.FUNCTION_OPEN_ID.value)
		end

		if content.CHALLENGE_LIMIT then
			self.commonCfgs.maxChallengeCount = tonumber(content.CHALLENGE_LIMIT.value)
		end

		if content.HELP_LIMIT then
			self.commonCfgs.maxHelpCount = tonumber(content.HELP_LIMIT.value)
		end

		if content.FREE_HELP_LIMIT then
			self.commonCfgs.maxFreehelpCount = tonumber(content.FREE_HELP_LIMIT.value)
		end

		if content.SPECIAL_PERIOD then
			self.commonCfgs.timerStr = content.SPECIAL_PERIOD.value
		end

		if content.BOSS_EXIST_TIME then
			self.commonCfgs.bossShowTime = tonumber(content.BOSS_EXIST_TIME.value)
		end

		if content.MY_BOSS_CHALLENGE_LIMIT then
			self.commonCfgs.oneBossChallCount = tonumber(content.MY_BOSS_CHALLENGE_LIMIT.value)
		end
	elseif name == "share_task_level" then
		self.bossLevelCfgs = content
	end
end

function ShareTaskConfig:GetBossBaseCfg(typeId)
	if checknumber(typeId) < 1 or self.bossBaseCfgs == nil then
		return
	end

	return self.bossBaseCfgs[typeId]
end

function ShareTaskConfig:GetBossTeamCfg(creepsMasterId)
	if checknumber(creepsMasterId) < 1 or self.bossTeamCfgs == nil then
		return
	end

	return self.bossTeamCfgs[creepsMasterId]
end

function ShareTaskConfig:GetBossTeamPosCfgs(enemyId)
	if checknumber(enemyId) < 1 or self.teamPosCfgs == nil then
		return
	end

	return self.teamPosCfgs[enemyId]
end

function ShareTaskConfig:GetCommonCfgs()
	return self.commonCfgs
end

function ShareTaskConfig:GetFuncOpenId()
	if self.commonCfgs then
		return self.commonCfgs.funOpenId
	end

	return 8
end

function ShareTaskConfig:GetBossShowTime()
	if self.commonCfgs then
		return self.commonCfgs.bossShowTime
	end

	return 3600
end

function ShareTaskConfig:GetBossSpecialTime()
	if self.commonCfgs then
		return self.commonCfgs.timerStr
	end
end

function ShareTaskConfig:GetBossSpecialTimeList()
	if self.commonCfgs == nil or self.commonCfgs.timerList == nil then
		self.commonCfgs = self.commonCfgs or {}
		self.commonCfgs.timerList = {}

		local list = string.split(self.commonCfgs.timerStr, "#")

		if list and #list > 0 then
			for i = 1, #list do
				local aa = string.split(list[i], "-")

				if aa and #aa == 2 then
					table.insert(self.commonCfgs.timerList, {
						startTime = aa[1],
						endTime = aa[2]
					})
				end
			end
		end
	end

	return self.commonCfgs.timerList
end

function ShareTaskConfig:GetBossLevelCfg(level)
	level = level or 1

	if self.bossLevelCfgs == nil then
		return
	end

	return self.bossLevelCfgs[level]
end

ShareTaskConfig.instance = ShareTaskConfig.New()

return ShareTaskConfig
