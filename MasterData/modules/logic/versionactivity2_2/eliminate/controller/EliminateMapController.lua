-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/EliminateMapController.lua

module("modules.logic.versionactivity2_2.eliminate.controller.EliminateMapController", package.seeall)

local EliminateMapController = class("EliminateMapController", BaseController)

function EliminateMapController:onInit()
	return
end

function EliminateMapController:onInitFinish()
	return
end

function EliminateMapController:addConstEvents()
	return
end

function EliminateMapController:reInit()
	return
end

function EliminateMapController:enterEpisode(episodeId)
	EliminateTeamSelectionModel.instance:setSelectedEpisodeId(episodeId)

	if not EliminateLevelModel.instance:selectSoliderIsUnLock() then
		EliminateMapController.instance:enterLevel(episodeId)

		return
	end

	EliminateMapController.instance:openEliminateSelectRoleView(episodeId)
end

function EliminateMapController:openEliminateMapView(param, isImmediate)
	EliminateRpc.instance:sendGetMatch3WarChessFacadeInfoRequest(function()
		ViewMgr.instance:openView(ViewName.EliminateMapView, param, isImmediate)
	end)
end

function EliminateMapController:openEliminateSelectRoleView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.EliminateSelectRoleView, param, isImmediate)
end

function EliminateMapController:openEliminateSelectChessMenView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.EliminateSelectChessMenView, param, isImmediate)
end

function EliminateMapController:enterLevel(episodeId)
	local characterId

	if EliminateTeamSelectionModel.instance:isPreset() then
		characterId = EliminateTeamSelectionModel.instance:getPresetCharacter()
	else
		local characterList = EliminateTeamSelectionModel.instance:getCharacterList()

		characterId = characterList[1].id
	end

	EliminateSelectChessMenListModel.instance:initList()

	local list = EliminateSelectChessMenListModel.instance:getAutoList()

	EliminateLevelController.instance:enterLevel(episodeId, characterId, list)
end

function EliminateMapController.hasOnceActionKey(type, id)
	local key = EliminateMapController._getKey(type, id)

	return PlayerPrefsHelper.hasKey(key)
end

function EliminateMapController.setOnceActionKey(type, id)
	local key = EliminateMapController._getKey(type, id)

	PlayerPrefsHelper.setNumber(key, 1)
end

function EliminateMapController.getPrefsString(type, defaultValue)
	local key = EliminateMapController._getKey(type, type)

	return (PlayerPrefsHelper.getString(key, defaultValue or ""))
end

function EliminateMapController.setPrefsString(type, value)
	local key = EliminateMapController._getKey(type, type)

	return PlayerPrefsHelper.setString(key, value)
end

function EliminateMapController._getKey(type, id)
	return (string.format("%s%s_%s_%s", PlayerPrefsKey.EliminateOnceAnim, PlayerModel.instance:getPlayinfo().userId, type, id))
end

EliminateMapController.instance = EliminateMapController.New()

return EliminateMapController
