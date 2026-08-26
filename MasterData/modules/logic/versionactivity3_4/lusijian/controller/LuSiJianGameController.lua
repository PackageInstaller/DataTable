-- chunkname: @modules/logic/versionactivity3_4/lusijian/controller/LuSiJianGameController.lua

module("modules.logic.versionactivity3_4.lusijian.controller.LuSiJianGameController", package.seeall)

local LuSiJianGameController = class("LuSiJianGameController", BaseController)

function LuSiJianGameController:onInit()
	return
end

function LuSiJianGameController:reInit()
	return
end

function LuSiJianGameController:onInitFinish()
	return
end

function LuSiJianGameController:addConstEvents()
	return
end

function LuSiJianGameController:enterGame(episodeId)
	self:reInit()

	self.episodeId = episodeId
	self._episodeconfig = LuSiJianConfig.instance:getLuSiJianEpisodeConfigById(VersionActivity3_4Enum.ActivityId.LuSiJian, episodeId)

	local gameId = self._episodeconfig.gameId
	local episodeIndex = LuSiJianModel.instance:getEpisodeIndex(episodeId)

	LuSiJianModel.instance:setCurEpisode(episodeIndex, episodeId)
	self:reallyEnterGame(gameId)
end

function LuSiJianGameController:reallyEnterGame(gameId)
	LuSiJianGameModel.instance:initGameData(gameId)
	LuSiJianStatHelper.instance:enterGame()
	ViewMgr.instance:openView(ViewName.LuSiJianGameView, self.episodeId)
end

function LuSiJianGameController:enterTestGame(gameId)
	LuSiJianGameModel.instance:testGameData(gameId)
	ViewMgr.instance:openView(ViewName.LuSiJianGameView)
end

function LuSiJianGameController:restartGame()
	self:reInit()

	local curGameId = LuSiJianGameModel.instance:getCurGameId()

	LuSiJianGameModel.instance:clear()
	LuSiJianGameModel.instance:initGameData(curGameId)
end

function LuSiJianGameController:finishGame()
	ViewMgr.instance:openView(ViewName.LuSiJianResultView)
end

LuSiJianGameController.instance = LuSiJianGameController.New()

return LuSiJianGameController
