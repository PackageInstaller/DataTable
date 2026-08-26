-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/config/HuiDiaoLanConfig.lua

module("modules.logic.versionactivity3_2.huidiaolan.config.HuiDiaoLanConfig", package.seeall)

local HuiDiaoLanConfig = class("HuiDiaoLanConfig", BaseConfig)

function HuiDiaoLanConfig:ctor()
	self.mergeRecoverInfo = {}
	self.allEpisodeCoList = {}
end

function HuiDiaoLanConfig:reqConfigNames()
	return
end

function HuiDiaoLanConfig:onConfigLoaded(configName, configTable)
	return
end

function HuiDiaoLanConfig:getConstConfig(constId, isString)
	local actId = VersionActivity3_2Enum.ActivityId.HuiDiaoLan

	return Activity220Config.instance:getConstConfigValue(actId, constId, isString)
end

function HuiDiaoLanConfig:getMergeRecoverEnergy(level, mergeCount)
	if not self.mergeRecoverInfo or not next(self.mergeRecoverInfo) or not self.mergeRecoverInfo[level] or not self.mergeRecoverInfo[level][mergeCount] then
		self.mergeRecoverInfo = {}
		self.mergeRecoverInfo[level] = self.mergeRecoverInfo[level] or {}

		local configStr = ""

		if level == 1 and mergeCount == 3 then
			configStr = self:getConstConfig(HuiDiaoLanEnum.ConstId.OneLevelTreeMergeRecover, true)
		elseif level == 1 and mergeCount == 4 then
			configStr = self:getConstConfig(HuiDiaoLanEnum.ConstId.OneLevelFourMergeRecover, true)
		elseif level == 1 and mergeCount == 5 then
			configStr = self:getConstConfig(HuiDiaoLanEnum.ConstId.OneLevelFiveMergeRecover, true)
		elseif level == 1 and mergeCount >= 6 then
			configStr = self:getConstConfig(HuiDiaoLanEnum.ConstId.OneLevelSixMergeRecover, true)
		elseif level == 2 and mergeCount == 3 then
			configStr = self:getConstConfig(HuiDiaoLanEnum.ConstId.TwoLevelTreeMergeRecover, true)
		elseif level == 2 and mergeCount >= 4 then
			configStr = self:getConstConfig(HuiDiaoLanEnum.ConstId.TwoLevelFourMergeRecover, true)
		end

		local infoList = string.splitToNumber(configStr, "#")

		self.mergeRecoverInfo[level][mergeCount] = infoList[3]
	end

	return self.mergeRecoverInfo[level][mergeCount]
end

function HuiDiaoLanConfig:getChangeColorSkillInfo()
	local configStr = self:getConstConfig(HuiDiaoLanEnum.ConstId.ChangeColorSkillInfo, true)
	local infoList = string.splitToNumber(configStr, "#")
	local costEnergy = infoList[1]
	local cd = infoList[2]

	return costEnergy, cd
end

function HuiDiaoLanConfig:getExchangePosSkillInfo()
	local configStr = self:getConstConfig(HuiDiaoLanEnum.ConstId.ExchangePosSkillInfo, true)
	local infoList = string.splitToNumber(configStr, "#")
	local costEnergy = infoList[1]
	local cd = infoList[2]

	return costEnergy, cd
end

function HuiDiaoLanConfig:getEpisodeConfig(episodeId)
	return Activity220Config.instance:getEpisodeConfig(VersionActivity3_2Enum.ActivityId.HuiDiaoLan, episodeId)
end

function HuiDiaoLanConfig:getAllEpisodeConfigList()
	if next(self.allEpisodeCoList) then
		return self.allEpisodeCoList
	end

	local allEpisodeCoMap = Activity220Config.instance:getAllEpisodeConfigMap(VersionActivity3_2Enum.ActivityId.HuiDiaoLan)

	for _, config in pairs(allEpisodeCoMap) do
		table.insert(self.allEpisodeCoList, config)
	end

	table.sort(self.allEpisodeCoList, function(a, b)
		return a.episodeId < b.episodeId
	end)

	return self.allEpisodeCoList
end

function HuiDiaoLanConfig:getNextEpisodeCo(episodeId)
	local allEpisodeCoList = self:getAllEpisodeConfigList()

	for i, episodeCo in ipairs(allEpisodeCoList) do
		if episodeCo.preEpisodeId == episodeId then
			return episodeCo
		end
	end
end

HuiDiaoLanConfig.instance = HuiDiaoLanConfig.New()

return HuiDiaoLanConfig
