-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/config/DreamIslandConfig.lua

module("logic.extensions.accumulategift.config.DreamIslandConfig", package.seeall)

local DreamIslandConfig = class("DreamIslandConfig", BaseConfig)

function DreamIslandConfig:onInit()
	DreamIslandConfig.super.onInit(self)

	self._allTaskCfgs = nil
	self._dayTaskCfgs = nil
	self._scorePrizeCfgs = nil
	self._dayPetInfoCfgs = nil
	self._paramsCfgs = nil
end

function DreamIslandConfig:getNames()
	return {
		"dream_island_task",
		"dream_island_prize",
		"dream_island_pet",
		"dream_island_params"
	}
end

function DreamIslandConfig:handleConfig(name, content)
	if name == "dream_island_task" then
		self:_ClassificationWeekTaskCfgs(content.dataList)
	elseif name == "dream_island_prize" then
		self:_ClassificationScorePrizeCfgs(content.dataList)
	elseif name == "dream_island_pet" then
		self._dayPetInfoCfgs = content
	elseif name == "dream_island_params" then
		self._paramsCfgs = content
	end
end

function DreamIslandConfig:_ClassificationWeekTaskCfgs(data)
	self._dayTaskCfgs = {}
	self._allTaskCfgs = {}

	for _, cfg in pairs(data or {}) do
		if cfg and checknumber(cfg.id) > 0 then
			if self._dayTaskCfgs[cfg.activityId] == nil then
				self._dayTaskCfgs[cfg.activityId] = {}
			end

			if self._allTaskCfgs[cfg.activityId] == nil then
				self._allTaskCfgs[cfg.activityId] = {}
			end

			self._allTaskCfgs[cfg.activityId][cfg.id] = cfg

			if self._dayTaskCfgs[cfg.activityId][cfg.day] == nil then
				self._dayTaskCfgs[cfg.activityId][cfg.day] = {}
			end

			if self._dayTaskCfgs[cfg.activityId][cfg.day][cfg.type] == nil then
				self._dayTaskCfgs[cfg.activityId][cfg.day][cfg.type] = {}
			end

			table.insert(self._dayTaskCfgs[cfg.activityId][cfg.day][cfg.type], {
				id = cfg.id,
				type = cfg.type,
				prog = cfg.maxProgress
			})
		end
	end

	for _, actiList in pairs(self._dayTaskCfgs) do
		for k1, dayList in pairs(actiList or {}) do
			for k2, typeList in pairs(dayList or {}) do
				if typeList and #typeList > 1 then
					table.sort(typeList, function(a, b)
						if a.prog == b.prog then
							return a.id < b.id
						end

						return a.prog < b.prog
					end)
				end
			end
		end
	end
end

function DreamIslandConfig:_ClassificationScorePrizeCfgs(data)
	self._scorePrizeCfgs = {}

	for _, cfg in pairs(data or {}) do
		if cfg and checknumber(cfg.needScore) > 0 then
			if self._scorePrizeCfgs[cfg.activityId] == nil then
				self._scorePrizeCfgs[cfg.activityId] = {}
			end

			table.insert(self._scorePrizeCfgs[cfg.activityId], {
				needScore = cfg.needScore,
				goodsList = string.split(cfg.prize, ":")
			})
		end
	end

	for _, list in pairs(self._scorePrizeCfgs) do
		if list and #list > 1 then
			table.sort(list, function(a, b)
				return a.needScore < b.needScore
			end)
		end
	end
end

function DreamIslandConfig:GetDreamIslandTaskCfg(actiId, id)
	if self._allTaskCfgs == nil or self._allTaskCfgs[actiId] == nil then
		return
	end

	return self._allTaskCfgs[actiId][id]
end

function DreamIslandConfig:GetDreamIslandTaskScore(actiId, id)
	local cfg = self:GetDreamIslandTaskCfg(actiId, id)

	if cfg and checknumber(cfg.score) > 0 then
		return cfg.score
	end

	return 0
end

function DreamIslandConfig:GetDayAllTaskCfgs(actiId, dayNum)
	if self._dayTaskCfgs == nil or self._dayTaskCfgs[actiId] == nil then
		return
	end

	return self._dayTaskCfgs[actiId][dayNum]
end

function DreamIslandConfig:GetScorePrizeCfgs(actiId)
	if self._scorePrizeCfgs == nil or self._scorePrizeCfgs[actiId] == nil then
		return {}
	end

	return self._scorePrizeCfgs[actiId]
end

function DreamIslandConfig:GetDayPetInfoCfg(actiId, dayNum)
	if self._dayPetInfoCfgs == nil or self._dayPetInfoCfgs[actiId] == nil then
		return
	end

	return self._dayPetInfoCfgs[actiId][dayNum]
end

function DreamIslandConfig:GetDreamIslandParams(str)
	if self._paramsCfgs == nil or self._paramsCfgs[str] == nil then
		return
	end

	return self._paramsCfgs[str].paramVal
end

DreamIslandConfig.instance = DreamIslandConfig.New()

return DreamIslandConfig
