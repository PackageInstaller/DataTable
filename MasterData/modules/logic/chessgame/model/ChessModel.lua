-- chunkname: @modules/logic/chessgame/model/ChessModel.lua

module("modules.logic.chessgame.model.ChessModel", package.seeall)

local ChessModel = class("ChessModel", BaseModel)

function ChessModel:onInit()
	return
end

function ChessModel:reInit()
	return
end

function ChessModel:setEpisodeId(episodeId)
	self._currentEpisodeId = episodeId

	if not episodeId then
		self._currentMapId = nil

		return
	end

	local episodeCfg = ChessConfig.instance:getEpisodeCo(self._activityId, episodeId)

	if episodeCfg then
		if episodeCfg.mapIds then
			self._currentMapId = episodeCfg.mapIds
		elseif episodeCfg.mapIds then
			local mapIds = string.split(episodeCfg.mapIds, "#")

			self._currentMapId = tonumber(mapIds[1])
		end
	else
		self._currentMapId = nil
	end
end

function ChessModel:setActId(actId)
	self._activityId = actId
end

function ChessModel:getActId()
	return self._activityId
end

function ChessModel:getEpisodeId()
	return self._currentEpisodeId
end

function ChessModel:getCurrMapId()
	return self._currentMapId
end

function ChessModel:setNowMapIndex(mapIndex)
	self._currMapIndex = mapIndex
end

function ChessModel:getNowMapIndex()
	return self._currMapIndex
end

function ChessModel:getEpisodeData(episodeId)
	local modelIns = self:_getModelIns(self._activityId)

	if modelIns then
		return modelIns:getEpisodeData(episodeId)
	end
end

ChessModel.instance = ChessModel.New()

return ChessModel
