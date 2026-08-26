-- chunkname: @modules/logic/versionactivity3_1/yeshumei/controller/YeShuMeiGameController.lua

module("modules.logic.versionactivity3_1.yeshumei.controller.YeShuMeiGameController", package.seeall)

local YeShuMeiGameController = class("YeShuMeiGameController", BaseController)

function YeShuMeiGameController:onInit()
	return
end

function YeShuMeiGameController:reInit()
	return
end

function YeShuMeiGameController:onInitFinish()
	return
end

function YeShuMeiGameController:addConstEvents()
	return
end

function YeShuMeiGameController:enterGame(episodeId)
	self:reInit()

	self.episodeId = episodeId
	self._episodeconfig = YeShuMeiConfig.instance:getYeShuMeiEpisodeConfigById(VersionActivity3_1Enum.ActivityId.YeShuMei, episodeId)

	local gameId = self._episodeconfig.gameId
	local episodeIndex = YeShuMeiModel.instance:getEpisodeIndex(episodeId)

	YeShuMeiModel.instance:setCurEpisode(episodeIndex, episodeId)
	self:reallyEnterGame(gameId)
end

function YeShuMeiGameController:reallyEnterGame(gameId)
	YeShuMeiGameModel.instance:initGameData(gameId)
	YeShuMeiStatHelper.instance:enterGame()
	ViewMgr.instance:openView(ViewName.YeShuMeiGameView, self.episodeId)
end

function YeShuMeiGameController:restartGame()
	self:reInit()

	local curGameId = YeShuMeiGameModel.instance:getCurGameId()

	YeShuMeiGameModel.instance:clear()
	YeShuMeiGameModel.instance:initGameData(curGameId)
end

function YeShuMeiGameController:finishGame()
	ViewMgr.instance:openView(ViewName.YeShuMeiResultView)
end

YeShuMeiGameController.instance = YeShuMeiGameController.New()

return YeShuMeiGameController
