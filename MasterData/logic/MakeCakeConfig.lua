-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/config/MakeCakeConfig.lua

module("logic.extensions.anniversarycake.config.MakeCakeConfig", package.seeall)

local MakeCakeConfig = class("MakeCakeConfig", BaseConfig)

function MakeCakeConfig:onInit()
	MakeCakeConfig.super.onInit(self)

	self.anniversary_cake_activity = nil
	self.anniversary_cake_make_cake_stage = nil
	self.anniversary_cake_level = nil
	self.anniversary_cake_prize = nil
	self.anniversary_cake_const = nil
end

function MakeCakeConfig:getNames()
	return {
		"anniversary_cake_activity",
		"anniversary_cake_make_cake_stage",
		"anniversary_cake_level",
		"anniversary_cake_prize",
		"anniversary_cake_const"
	}
end

function MakeCakeConfig:handleConfig(name, content)
	if name == "anniversary_cake_activity" then
		self.anniversary_cake_activity = content
	elseif name == "anniversary_cake_make_cake_stage" then
		self.anniversary_cake_make_cake_stage = content
	elseif name == "anniversary_cake_level" then
		self.anniversary_cake_level = content

		if Framework.OSDef.isEditor then
			self:checkStageCorrectness(content)
		end
	elseif name == "anniversary_cake_prize" then
		self.anniversary_cake_prize = content
	elseif name == "anniversary_cake_const" then
		self.anniversary_cake_const = content
	end
end

function MakeCakeConfig:checkStageCorrectness(content)
	local str = "有问题的关卡(配置检查，可忽略)：\n"
	local isExistError = false

	for stageId, list in pairs(content) do
		if type(stageId) == "number" then
			local recordList = {}

			for id, cfg in ipairs(list) do
				recordList[cfg.Pos1] = not recordList[cfg.Pos1] and 1 or recordList[cfg.Pos1] + 1
				recordList[cfg.Pos2] = not recordList[cfg.Pos2] and 1 or recordList[cfg.Pos2] + 1
				recordList[cfg.Pos3] = not recordList[cfg.Pos3] and 1 or recordList[cfg.Pos3] + 1
				recordList[cfg.Pos4] = not recordList[cfg.Pos4] and 1 or recordList[cfg.Pos4] + 1
			end

			for k, v in pairs(recordList) do
				if k ~= 0 and v ~= 4 then
					isExistError = true
					str = str .. "stageId = " .. stageId .. "-> id = " .. k .. "\n"

					break
				end
			end
		end
	end

	if isExistError then
		printError(str)
	end
end

function MakeCakeConfig:getActivityCfg(activityId)
	return self.anniversary_cake_activity[activityId]
end

function MakeCakeConfig:getStageCfgList(stagePlanId)
	return self.anniversary_cake_make_cake_stage[stagePlanId] or {}
end

function MakeCakeConfig:getStageCfg(stagePlanId, stageId)
	if self.anniversary_cake_make_cake_stage[stagePlanId] then
		return self.anniversary_cake_make_cake_stage[stagePlanId][stageId]
	end
end

function MakeCakeConfig:getLevelCfgList(stageId)
	return self.anniversary_cake_level[stageId] or {}
end

function MakeCakeConfig:getPrizeCfgList(prizePlanId)
	return self.anniversary_cake_prize[prizePlanId]
end

function MakeCakeConfig:getPrizeMaxScore(prizePlanId)
	local cfgs = self.anniversary_cake_prize[prizePlanId]
	local maxScore = 1

	if cfgs then
		for i, v in ipairs(self.anniversary_cake_prize[prizePlanId]) do
			maxScore = v.needScore
		end
	end

	return maxScore
end

function MakeCakeConfig:getConstValue(key)
	if self.anniversary_cake_const[key] then
		return self.anniversary_cake_const[key].value
	end

	return ""
end

MakeCakeConfig.instance = MakeCakeConfig.New()

return MakeCakeConfig
