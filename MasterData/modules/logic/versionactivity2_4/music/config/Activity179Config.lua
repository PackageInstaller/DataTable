-- chunkname: @modules/logic/versionactivity2_4/music/config/Activity179Config.lua

module("modules.logic.versionactivity2_4.music.config.Activity179Config", package.seeall)

local Activity179Config = class("Activity179Config", BaseConfig)

function Activity179Config:reqConfigNames()
	return {
		"activity179_episode",
		"activity179_beat",
		"activity179_combo",
		"activity179_const",
		"activity179_task",
		"activity179_instrument",
		"activity179_tone",
		"activity179_note"
	}
end

function Activity179Config:onInit()
	return
end

function Activity179Config:onConfigLoaded(configName, configTable)
	if configName == "activity179_episode" then
		self._episodeConfig = configTable
		self._episodeDict = {}

		for _, v in ipairs(self._episodeConfig.configList) do
			self._episodeDict[v.activityId] = self._episodeDict[v.activityId] or {}

			table.insert(self._episodeDict[v.activityId], v)

			if v.episodeType == VersionActivity2_4MusicEnum.EpisodeType.Free then
				self._freeEpisodeId = v.id
			end
		end

		return
	end

	if configName == "activity179_instrument" then
		self._instrumentSwitchList = {}
		self._instrumentNoSwitchList = {}

		for i, v in ipairs(lua_activity179_instrument.configList) do
			if v.switch == 1 then
				table.insert(self._instrumentSwitchList, v)
			else
				table.insert(self._instrumentNoSwitchList, v)
			end
		end

		return
	end

	if configName == "activity179_tone" then
		self._noteDict = {}
		self._noteInstrumentList = {}

		for i, v in ipairs(lua_activity179_tone.configList) do
			if not self._noteInstrumentList[v.instrument] then
				local list = {}

				self._noteInstrumentList[v.instrument] = list

				table.insert(list, v)

				if not self._noteDict[v.instrument] then
					self._noteDict[v.instrument] = self._noteDict[v.instrument]
					self._noteDict[v.instrument][#list] = v
				end
			end
		end

		return
	end

	if configName == "activity179_combo" then
		self._comboDict = {}

		for i, v in ipairs(lua_activity179_combo.configList) do
			if not self._comboDict[v.episodeId] then
				local list = {}

				self._comboDict[v.episodeId] = list

				table.insert(list, v)
			end
		end

		return
	end
end

function Activity179Config:getFreeEpisodeId()
	return self._freeEpisodeId
end

function Activity179Config:getComboList(episodeId)
	return self._comboDict[episodeId]
end

function Activity179Config:getNoteConfig(instrument, index)
	return self._noteDict[instrument][index]
end

function Activity179Config:getInstrumentSwitchList()
	return self._instrumentSwitchList
end

function Activity179Config:getInstrumentNoSwitchList()
	return self._instrumentNoSwitchList
end

function Activity179Config:getEpisodeCfgList(activityId)
	return self._episodeDict[activityId] or {}
end

function Activity179Config:getConstValue(activityId, id)
	local dict = lua_activity179_const.configDict[activityId]
	local config = dict and dict[id]

	return config.value1, config.value2
end

function Activity179Config:getEpisodeConfig(episodeId)
	return lua_activity179_episode.configDict[Activity179Model.instance:getActivityId()][episodeId]
end

function Activity179Config:getBeatConfig(id)
	return lua_activity179_beat.configDict[Activity179Model.instance:getActivityId()][id]
end

Activity179Config.instance = Activity179Config.New()

return Activity179Config
