-- chunkname: @modules/logic/activity/model/chessmap/Activity109ChessModel.lua

module("modules.logic.activity.model.chessmap.Activity109ChessModel", package.seeall)

local Activity109ChessModel = class("Activity109ChessModel", BaseModel)

function Activity109ChessModel:onInit()
	return
end

function Activity109ChessModel:reInit()
	return
end

function Activity109ChessModel:setEpisodeId(episodeId)
	self._currentEpisodeId = episodeId

	if not episodeId then
		self._currentMapId = nil

		return
	end

	local episodeCfg = Activity109Config.instance:getEpisodeCo(self._activityId, episodeId)

	if episodeCfg then
		self._currentMapId = episodeCfg.mapId
	else
		logError("activity109_episode not found! id = " .. tostring(episodeId) .. ", in act = " .. tostring(self._activityId))

		self._currentMapId = nil
	end
end

function Activity109ChessModel:setActId(actId)
	self._activityId = actId
end

function Activity109ChessModel:getActId()
	return self._activityId
end

function Activity109ChessModel:getEpisodeId()
	return self._currentEpisodeId
end

function Activity109ChessModel:getMapId()
	return self._currentMapId
end

Activity109ChessModel.instance = Activity109ChessModel.New()

return Activity109ChessModel
