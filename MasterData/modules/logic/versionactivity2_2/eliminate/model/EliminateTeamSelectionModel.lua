-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/EliminateTeamSelectionModel.lua

module("modules.logic.versionactivity2_2.eliminate.model.EliminateTeamSelectionModel", package.seeall)

local EliminateTeamSelectionModel = class("EliminateTeamSelectionModel", BaseModel)

function EliminateTeamSelectionModel:onInit()
	self:reInit()
end

function EliminateTeamSelectionModel:reInit()
	self._selectedEpisodeId = nil
	self._selectedCharacterId = nil
	self._episodeConfig = nil
	self._warEpisodeConfig = nil
	self._isPreset = nil
	self._presetCharacter = nil
	self._presetSoldierList = nil
	self._isRestart = false
end

function EliminateTeamSelectionModel:setRestart(value)
	self._isRestart = value
end

function EliminateTeamSelectionModel:getRestart()
	return self._isRestart
end

function EliminateTeamSelectionModel:setSelectedEpisodeId(episodeId)
	self:setRestart(false)

	self._selectedEpisodeId = episodeId
	self._episodeConfig = lua_eliminate_episode.configDict[episodeId]

	local warChessId = self._episodeConfig.warChessId

	self._warEpisodeConfig = lua_war_chess_episode.configDict[warChessId]
	self._presetCharacter = nil
	self._presetSoldierList = nil
	self._isPreset = self._warEpisodeConfig.preset == 1

	if not self._isPreset then
		return
	end

	self._presetCharacter = self._warEpisodeConfig.presetCharacter
	self._rawPresetSoldier = self._warEpisodeConfig.presetSoldier
	self._presetSoldierList = {}

	for i, v in ipairs(self._rawPresetSoldier) do
		self._presetSoldierList[v] = v
	end
end

function EliminateTeamSelectionModel:isPreset()
	return self._isPreset
end

function EliminateTeamSelectionModel:getPresetSoldier()
	return self._rawPresetSoldier
end

function EliminateTeamSelectionModel:getPresetCharacter()
	return self._presetCharacter
end

function EliminateTeamSelectionModel:isPresetCharacter(characterId)
	return self._isPreset and self._presetCharacter == characterId
end

function EliminateTeamSelectionModel:isPresetSoldier(pieceId)
	return self._isPreset and self._presetSoldierList[pieceId] ~= nil
end

function EliminateTeamSelectionModel:hasCharacterOrPreset(characterId)
	return self:isPresetCharacter(characterId) or EliminateOutsideModel.instance:hasCharacter(characterId)
end

function EliminateTeamSelectionModel:hasChessPieceOrPreset(pieceId)
	return self:isPresetSoldier(pieceId) or EliminateOutsideModel.instance:hasChessPiece(pieceId)
end

function EliminateTeamSelectionModel:getSelectedEpisodeId()
	return self._selectedEpisodeId
end

function EliminateTeamSelectionModel:setSelectedCharacterId(characterId)
	self._selectedCharacterId = characterId
end

function EliminateTeamSelectionModel:getSelectedCharacterId()
	return self._selectedCharacterId
end

function EliminateTeamSelectionModel:getCharacterList()
	local list = tabletool.copy(lua_teamchess_character.configList)

	table.sort(list, function(a, b)
		local a_isUnlock = EliminateTeamSelectionModel.instance:hasCharacterOrPreset(a.id)
		local b_isUnlock = EliminateTeamSelectionModel.instance:hasCharacterOrPreset(b.id)

		if a_isUnlock == b_isUnlock then
			return a.id < b.id
		else
			return a_isUnlock
		end
	end)

	return list
end

EliminateTeamSelectionModel.instance = EliminateTeamSelectionModel.New()

return EliminateTeamSelectionModel
