-- chunkname: @modules/logic/sp02/atomic/config/AtomicConfig.lua

module("modules.logic.sp02.atomic.config.AtomicConfig", package.seeall)

local AtomicConfig = class("AtomicConfig", BaseConfig)

function AtomicConfig:reqConfigNames()
	return {
		"atomic_const",
		"atomic_talent",
		"atomic_talent_branch",
		"atomic_library",
		"atomic_avg_game",
		"atomic_anime"
	}
end

function AtomicConfig:onInit()
	return
end

function AtomicConfig:onConfigLoaded(configName, configTable)
	if configName == "atomic_talent" then
		self._talentConfig = configTable
	elseif configName == "atomic_talent_branch" then
		self._talentBranchConfig = configTable
	elseif configName == "atomic_const" then
		self._constConfig = configTable
	elseif configName == "atomic_library" then
		self._libraryConfig = configTable
	elseif configName == "atomic_avg_game" then
		self._avgGameConfig = configTable
	elseif configName == "atomic_anime" then
		self._animeConfig = configTable
	end
end

function AtomicConfig:getConstValue(constId, isNum, isLang)
	local config = self._constConfig.configDict[constId]

	if isLang then
		if not config.value2 then
			local value = config.value

			return isNum and not isLang and tonumber(value) or value
		end
	end
end

function AtomicConfig:initTalentList()
	if not self._talentDict then
		self._talentDict = {}

		for i, config in ipairs(self._talentConfig.configList) do
			local branch = config.branchId

			self._talentDict[branch] = self._talentDict[branch] or {}

			table.insert(self._talentDict[branch], config)
		end
	end
end

function AtomicConfig:getTalentList(branchId)
	self:initTalentList()

	return self._talentDict[branchId] or {}
end

function AtomicConfig:getBranchList()
	return self._talentBranchConfig.configList
end

function AtomicConfig:getTalentConfig(nodeId)
	return self._talentConfig.configDict[nodeId]
end

function AtomicConfig:getLibraryList()
	return self._libraryConfig.configList
end

function AtomicConfig:getLibraryConfig(libraryId)
	return self._libraryConfig.configDict[libraryId]
end

function AtomicConfig:getAvgGameList()
	return self._avgGameConfig.configList
end

function AtomicConfig:getEpisodeAnimConfig(episodeId)
	if not self._atomicAnimDict then
		self._atomicAnimDict = {}

		for _, config in ipairs(self._animeConfig.configList) do
			local episodes = string.splitToNumber(config.levelid, "|")

			for _, levelId in ipairs(episodes) do
				self._atomicAnimDict[levelId] = config.animeid
			end
		end
	end

	local animId = self._atomicAnimDict[episodeId]

	if not animId then
		return
	end

	return self._animeConfig.configDict[animId]
end

AtomicConfig.instance = AtomicConfig.New()

return AtomicConfig
