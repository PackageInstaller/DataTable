-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/config/VersionActivity1_2NoteConfig.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.config.VersionActivity1_2NoteConfig", package.seeall)

local VersionActivity1_2NoteConfig = class("VersionActivity1_2NoteConfig", BaseConfig)

function VersionActivity1_2NoteConfig:ctor()
	return
end

function VersionActivity1_2NoteConfig:reqConfigNames()
	return {
		"activity121_note",
		"activity121_story",
		"activity121_clue"
	}
end

function VersionActivity1_2NoteConfig:onConfigLoaded(configName, configTable)
	if configName == "activity121_note" then
		self:_initNoteConfig()
	elseif configName == "activity121_story" then
		self:_initStoryConfig()
	end
end

function VersionActivity1_2NoteConfig:_initNoteConfig()
	self._episodeId2Config = {}
	self._noteCount = 0

	for i, v in ipairs(lua_activity121_note.configList) do
		self._episodeId2Config[v.episodeId] = self._episodeId2Config[v.episodeId] or {}

		table.insert(self._episodeId2Config[v.episodeId], v)

		self._noteCount = self._noteCount + 1
	end
end

function VersionActivity1_2NoteConfig:getConfigList(episodeId)
	return self._episodeId2Config and self._episodeId2Config[episodeId]
end

function VersionActivity1_2NoteConfig:_initStoryConfig()
	self._storyList = {}

	for i, v in ipairs(lua_activity121_story.configList) do
		self._storyList[v.id] = v
	end

	table.sort(self._storyList, function(item1, item2)
		return item1.id < item2.id
	end)
end

function VersionActivity1_2NoteConfig:getStoryList()
	return self._storyList
end

function VersionActivity1_2NoteConfig:getAllNoteCount()
	return self._noteCount
end

VersionActivity1_2NoteConfig.instance = VersionActivity1_2NoteConfig.New()

return VersionActivity1_2NoteConfig
