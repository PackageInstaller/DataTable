-- chunkname: @modules/logic/versionactivity3_8/echosong/model/V3a8EchoSongModel.lua

module("modules.logic.versionactivity3_8.echosong.model.V3a8EchoSongModel", package.seeall)

local V3a8EchoSongModel = class("V3a8EchoSongModel", BaseModel)

function V3a8EchoSongModel:onInit()
	self:clearAllData()
end

function V3a8EchoSongModel:reInit()
	self:clearAllData()
end

function V3a8EchoSongModel:clearAllData()
	self._gameEpisodeId = nil
	self._gameId = nil
	self._sceneNode = nil
	self._ball = nil
	self._hitBall = nil
	self._bgType = nil
end

function V3a8EchoSongModel:initBalls(sceneNode, ball, hitBall)
	self._sceneNode = sceneNode
	self._ball = ball
	self._hitBall = hitBall
end

function V3a8EchoSongModel:getSceneNode()
	return self._sceneNode
end

function V3a8EchoSongModel:getBall()
	return self._ball
end

function V3a8EchoSongModel:getHitBall()
	return self._hitBall
end

function V3a8EchoSongModel:getActId()
	return VersionActivity3_8Enum.ActivityId.EchoSong
end

function V3a8EchoSongModel:onEnterGame(episodeId, gameId)
	self:_setGameEpisodeId(episodeId)
	self:_setGameId(gameId)
end

function V3a8EchoSongModel:getSceneId()
	return self._gameId
end

function V3a8EchoSongModel:_setGameEpisodeId(episodeId)
	self._gameEpisodeId = episodeId
end

function V3a8EchoSongModel:_setGameId(gameId)
	self._gameId = gameId
end

function V3a8EchoSongModel:getGameEpisodeId()
	return self._gameEpisodeId
end

function V3a8EchoSongModel:getGameId()
	return self._gameId
end

function V3a8EchoSongModel:setBgType(type)
	self._bgType = type
end

function V3a8EchoSongModel:getBgType()
	return self._bgType
end

V3a8EchoSongModel.instance = V3a8EchoSongModel.New()

return V3a8EchoSongModel
