-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/config/JieShenEventConfig.lua

module("logic.extensions.jieshenevent.config.JieShenEventConfig", package.seeall)

local JieShenEventConfig = class("JieShenEventConfig", BaseConfig)

function JieShenEventConfig:getNames()
	return {
		"jie_shen_event_clue_tab",
		"jie_shen_event_clue",
		"jie_shen_event_informer",
		"jie_shen_event_timeline",
		"jie_shen_event_stage",
		"jie_shen_event_map",
		"jie_shen_event_activity",
		"jie_shen_event_place"
	}
end

function JieShenEventConfig:handleConfig(name, content)
	if name == "jie_shen_event_clue_tab" then
		self._jie_shen_event_clue_tab = content
	elseif name == "jie_shen_event_clue" then
		self._jie_shen_event_clue = content

		self:handleClueCombo()
	elseif name == "jie_shen_event_informer" then
		self._jie_shen_event_informer = content
	elseif name == "jie_shen_event_timeline" then
		self._jie_shen_event_timeline = content
	elseif name == "jie_shen_event_stage" then
		self._jie_shen_event_stage = content
	elseif name == "jie_shen_event_map" then
		self._jie_shen_event_map = content
	elseif name == "jie_shen_event_activity" then
		self._jie_shen_event_activity = content
	elseif name == "jie_shen_event_place" then
		self._jie_shen_event_place = content
	end
end

function JieShenEventConfig:getActivityCfg(activityId)
	return self._jie_shen_event_activity[activityId]
end

function JieShenEventConfig:getInformerCfg(activityId, informerId)
	return self._jie_shen_event_informer[activityId][informerId]
end

function JieShenEventConfig:getPlaceCfgs(activityId)
	return self._jie_shen_event_place[activityId]
end

function JieShenEventConfig:getPlaceCfg(activityId, placeId)
	return self._jie_shen_event_place[activityId][placeId]
end

function JieShenEventConfig:getTimelineCfgs(activityId)
	return self._jie_shen_event_timeline[activityId]
end

function JieShenEventConfig:getTimelineCfg(activityId, timelineId)
	return self._jie_shen_event_timeline[activityId][timelineId]
end

function JieShenEventConfig:getClueTabCfgs(activityId)
	return self._jie_shen_event_clue_tab[activityId]
end

function JieShenEventConfig:getClueTabCfg(activityId, tabId)
	return self._jie_shen_event_clue_tab[activityId][tabId]
end

function JieShenEventConfig:getClueCfgs(activityId)
	return self._jie_shen_event_clue[activityId]
end

function JieShenEventConfig:getClueCfg(activityId, clueId)
	return self._jie_shen_event_clue[activityId][clueId]
end

function JieShenEventConfig:getClueCfgsByTab(activityId, tabId)
	self._clueTabInfo = self._clueTabInfo or {}

	if not self._clueTabInfo[activityId] then
		self._clueTabInfo[activityId] = {}

		local tabCfgs = self:getClueTabCfgs(activityId)
		local clueCfgs = self:getClueCfgs(activityId)

		for i, tabCfg in ipairs(tabCfgs) do
			self._clueTabInfo[activityId][tabCfg.tabId] = {}

			for j, clueId in ipairs(tabCfg.clueIds) do
				table.insert(self._clueTabInfo[activityId][tabCfg.tabId], clueCfgs[clueId])
			end
		end
	end

	return self._clueTabInfo[activityId][tabId]
end

function JieShenEventConfig:getStageCfg(stageId)
	return self._jie_shen_event_stage[stageId]
end

function JieShenEventConfig:getMapCfg(mapId)
	return self._jie_shen_event_map[mapId]
end

function JieShenEventConfig:handleClueCombo()
	self._comboInfo = {}

	for i, cfg in ipairs(self._jie_shen_event_clue.dataList) do
		self._comboInfo[cfg.activityId] = self._comboInfo[cfg.activityId] or {}

		if cfg.clueIds then
			for j, clueId in ipairs(cfg.clueIds) do
				self._comboInfo[cfg.activityId][clueId] = self._comboInfo[cfg.activityId][clueId] or {}
				self._comboInfo[cfg.activityId][clueId][cfg.clueId] = true
			end
		end
	end
end

function JieShenEventConfig:getClueComboInfo(activityId, clueId)
	return self._comboInfo[activityId][clueId]
end

JieShenEventConfig.instance = JieShenEventConfig.New()

return JieShenEventConfig
