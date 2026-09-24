-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/model/SpLilyaGameModel.lua

module("modules.logic.versionactivity4_0.sp_lilya.model.SpLilyaGameModel", package.seeall)

local SpLilyaGameModel = class("SpLilyaGameModel", BaseModel)

function SpLilyaGameModel:onInit()
	self:reInit()
end

function SpLilyaGameModel:reInit()
	self:init()
end

function SpLilyaGameModel:init()
	self.actId = nil
	self.episodeId = nil
	self.gameId = nil
	self._gameMO = nil
	self._startTime = nil
end

function SpLilyaGameModel:getCurGameId()
	return self.gameId
end

function SpLilyaGameModel:getCurEpisodeId()
	return self.episodeId
end

function SpLilyaGameModel:initGame(actId, episodeId)
	local gameCo = SpLilyaConfig.instance:getGameCo(actId, episodeId)

	if not gameCo then
		logError(string.format("SpLilyaGameModel:initGame error, no game config, actId:%s, episodeId:%s", tostring(actId), tostring(episodeId)))

		return
	end

	self.actId = actId
	self.episodeId = episodeId
	self.gameId = gameCo.id
	self._startTime = ServerTime.now()

	self:initGameMo(gameCo)
end

function SpLilyaGameModel:initGameMo(gameCo)
	self._gameMO = self._gameMO or SpLilyaGameMO.New()

	self._gameMO:init(gameCo)
end

function SpLilyaGameModel:getGameMO()
	return self._gameMO
end

function SpLilyaGameModel:getStartTime()
	return self._startTime
end

function SpLilyaGameModel:clearGameMO()
	self._gameMO = nil
	self._startTime = nil
end

SpLilyaGameModel.instance = SpLilyaGameModel.New()

return SpLilyaGameModel
