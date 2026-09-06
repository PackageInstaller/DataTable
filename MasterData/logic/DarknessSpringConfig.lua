-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darknessspring/config/DarknessSpringConfig.lua

module("logic.extensions.darknessspring.config.DarknessSpringConfig", package.seeall)

local DarknessSpringConfig = class("DarknessSpringConfig", BaseConfig)

function DarknessSpringConfig:getNames()
	return {
		"darkness_spring_activity",
		"darkness_spring_stage1_unlock_item",
		"darkness_spring_progress_prize"
	}
end

function DarknessSpringConfig:handleConfig(name, content)
	if name == "darkness_spring_activity" then
		self.darkness_spring_activity = content
	elseif name == "darkness_spring_stage1_unlock_item" then
		self.darkness_spring_stage1_unlock_item = content
	elseif name == "darkness_spring_progress_prize" then
		self.darkness_spring_progress_prize = content
	end
end

function DarknessSpringConfig:getActivityCfgByActId(activityId)
	return self.darkness_spring_activity[activityId]
end

function DarknessSpringConfig:getStageOneGameCfgByActivityId(activityId)
	local actCfg = self:getActivityCfgByActId(activityId)

	return FirePowerContestConfig.instance:getGameActivityConf(actCfg.stage1ActId)
end

function DarknessSpringConfig:getStageOnePrizeCfgByActivityId(activityId)
	local actCfg = self:getActivityCfgByActId(activityId)
	local stage1Cfg = FirePowerContestConfig.instance:getGameActivityConf(actCfg.stage1ActId)

	return FirePowerContestConfig.instance:getGamePrizeConfs(stage1Cfg)
end

function DarknessSpringConfig:getStageOneUnlockCfgByActId(activityId)
	return self.darkness_spring_stage1_unlock_item[activityId]
end

function DarknessSpringConfig:getStageTwoProgressCfgByActId(activityId)
	return self.darkness_spring_progress_prize[activityId]
end

function DarknessSpringConfig:getStageTwoLiHuiCfgByActId(activityId)
	local progCfg = self:getStageTwoProgressCfgByActId(activityId)
	local lihuiCfg = {}

	for i, v in ipairs(progCfg) do
		if not string.nilorempty(v.characterPath) then
			table.insert(lihuiCfg, {
				prizeId = v.prizeId,
				characterPath = v.characterPath
			})
		end
	end

	return lihuiCfg
end

DarknessSpringConfig.instance = DarknessSpringConfig.New()

return DarknessSpringConfig
