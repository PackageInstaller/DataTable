-- chunkname: @modules/logic/versionactivity3_2/beilier/controller/BeiLiErGameController.lua

module("modules.logic.versionactivity3_2.beilier.controller.BeiLiErGameController", package.seeall)

local BeiLiErGameController = class("BeiLiErGameController", BaseController)

function BeiLiErGameController:onInit()
	return
end

function BeiLiErGameController:reInit()
	return
end

function BeiLiErGameController:onInitFinish()
	return
end

function BeiLiErGameController:addConstEvents()
	return
end

function BeiLiErGameController:enterGame(episodeId)
	self:reInit()

	self.episodeId = episodeId
	self._episodeconfig = BeiLiErConfig.instance:getBeiLiErEpisodeConfigById(VersionActivity3_2Enum.ActivityId.BeiLiEr, episodeId)

	local gameId = self._episodeconfig.gameId
	local episodeIndex = BeiLiErModel.instance:getEpisodeIndex(episodeId)

	BeiLiErModel.instance:setCurEpisode(episodeIndex, episodeId)
	self:reallyEnterGame(gameId)
end

function BeiLiErGameController:reallyEnterGame(gameId)
	BeiLiErGameModel.instance:initGameData(gameId)
	BeiLiErStatHelper.instance:enterGame()
	ViewMgr.instance:openView(ViewName.BeiLiErGameView, self.episodeId)
end

function BeiLiErGameController:restartGame()
	self:reInit()

	local curGameId = BeiLiErGameModel.instance:getCurGameId()

	BeiLiErGameModel.instance:clear()
	BeiLiErGameModel.instance:initGameData(curGameId)
end

function BeiLiErGameController:finishGame()
	ViewMgr.instance:openView(ViewName.BeiLiErResultView)
end

function BeiLiErGameController:reInit()
	return
end

BeiLiErGameController.instance = BeiLiErGameController.New()

return BeiLiErGameController
