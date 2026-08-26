-- chunkname: @modules/logic/versionactivity1_4/dungeon/model/VersionActivity1_4DungeonModel.lua

module("modules.logic.versionactivity1_4.dungeon.model.VersionActivity1_4DungeonModel", package.seeall)

local VersionActivity1_4DungeonModel = class("VersionActivity1_4DungeonModel", ListScrollModel)

function VersionActivity1_4DungeonModel:onInit()
	self:reInit()
end

function VersionActivity1_4DungeonModel:reInit()
	return
end

function VersionActivity1_4DungeonModel:setSelectEpisodeId(episodeId)
	self._selectEpisodeId = episodeId

	VersionActivity1_4DungeonController.instance:dispatchEvent(VersionActivity1_4DungeonEvent.OnSelectEpisodeId)
end

function VersionActivity1_4DungeonModel:getSelectEpisodeId()
	return self._selectEpisodeId
end

function VersionActivity1_4DungeonModel:getEpisodeState(episodeId)
	local episodeState = {}
	local value = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_4_DungeonAnim), "")
	local list = GameUtil.splitString2(value, true)

	if list then
		for k, v in pairs(list) do
			episodeState[v[1]] = v[2] or 0
		end
	end

	return episodeState[episodeId] or 0
end

function VersionActivity1_4DungeonModel:setEpisodeState(episodeId, state)
	local episodeState = {}
	local value = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_4_DungeonAnim), "")
	local list = GameUtil.splitString2(value, true)

	if list then
		for k, v in pairs(list) do
			episodeState[v[1]] = v[2] or 0
		end
	end

	episodeState[episodeId] = state

	local states = {}

	for k, v in pairs(episodeState) do
		table.insert(states, string.format("%s#%s", k, v))
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_4_DungeonAnim), table.concat(states, "|"))
end

VersionActivity1_4DungeonModel.instance = VersionActivity1_4DungeonModel.New()

return VersionActivity1_4DungeonModel
