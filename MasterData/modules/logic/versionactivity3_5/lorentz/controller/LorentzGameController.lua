-- chunkname: @modules/logic/versionactivity3_5/lorentz/controller/LorentzGameController.lua

module("modules.logic.versionactivity3_5.lorentz.controller.LorentzGameController", package.seeall)

local LorentzGameController = class("LorentzGameController", BaseController)

function LorentzGameController:onInit()
	return
end

function LorentzGameController:reInit()
	return
end

function LorentzGameController:onInitFinish()
	return
end

function LorentzGameController:addConstEvents()
	return
end

function LorentzGameController:enterGame(episodeId)
	self:reInit()

	self.episodeId = episodeId
	self._episodeconfig = LorentzConfig.instance:getLorentzEpisodeConfigById(VersionActivity3_5Enum.ActivityId.Lorentz, episodeId)

	local gameId = self._episodeconfig.gameId
	local episodeIndex = LorentzModel.instance:getEpisodeIndex(episodeId)

	LorentzModel.instance:setCurEpisode(episodeIndex, episodeId)
	self:reallyEnterGame(gameId)
end

function LorentzGameController:reallyEnterGame(gameId)
	LorentzGameModel.instance:initGameData(gameId)
	LorentzStatHelper.instance:enterGame()
	ViewMgr.instance:openView(ViewName.LorentzGameView, self.episodeId)
end

function LorentzGameController:restartGame()
	self:reInit()

	local curGameId = LorentzGameModel.instance:getCurGameId()

	LorentzGameModel.instance:clear()
	LorentzGameModel.instance:initGameData(curGameId)
end

function LorentzGameController:finishGame()
	ViewMgr.instance:openView(ViewName.LorentzResultView)
end

LorentzGameController.instance = LorentzGameController.New()

return LorentzGameController
