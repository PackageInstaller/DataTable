-- chunkname: @modules/logic/investigate/config/InvestigateConfig.lua

module("modules.logic.investigate.config.InvestigateConfig", package.seeall)

local InvestigateConfig = class("InvestigateConfig", BaseConfig)

function InvestigateConfig:reqConfigNames()
	return {
		"investigate_info",
		"investigate_clue",
		"investigate_reward"
	}
end

function InvestigateConfig:onConfigLoaded(configName, configTable)
	if configName == "investigate_info" then
		self:_initInvestigateInfo()
	elseif configName == "investigate_clue" then
		self:_initInvestigateClue()
	end
end

function InvestigateConfig:_initInvestigateClue()
	self._investigateAllClueInfos = {}
	self._investigateRelatedClueInfos = {}
	self._investigateMapElementInfos = {}

	for i, v in ipairs(lua_investigate_clue.configList) do
		self._investigateAllClueInfos[v.infoID] = self._investigateAllClueInfos[v.infoID] or {}

		table.insert(self._investigateAllClueInfos[v.infoID], v)

		self._investigateRelatedClueInfos[v.infoID] = self._investigateRelatedClueInfos[v.infoID] or {}

		table.insert(self._investigateRelatedClueInfos[v.infoID], v)

		if v.mapElement > 0 then
			self._investigateMapElementInfos[v.mapElement] = v
		end
	end
end

function InvestigateConfig:getInvestigateClueInfoByElement(mapElement)
	return self._investigateMapElementInfos[mapElement]
end

function InvestigateConfig:getInvestigateAllClueInfos(group)
	return self._investigateAllClueInfos[group]
end

function InvestigateConfig:getInvestigateRelatedClueInfos(group)
	return self._investigateRelatedClueInfos[group]
end

function InvestigateConfig:_initInvestigateInfo()
	self._roleEntranceInfos = {}
	self._roleGroupInfos = {}

	for i, v in ipairs(lua_investigate_info.configList) do
		self._roleEntranceInfos[v.entrance] = self._roleEntranceInfos[v.entrance] or v

		if not self._roleGroupInfos[v.group] then
			local list = {}

			table.insert(list, v)

			self._roleGroupInfos[v.group] = list
		end
	end
end

function InvestigateConfig:getRoleEntranceInfos()
	return self._roleEntranceInfos
end

function InvestigateConfig:getRoleGroupInfoList(groupId)
	return self._roleGroupInfos[groupId]
end

InvestigateConfig.instance = InvestigateConfig.New()

return InvestigateConfig
