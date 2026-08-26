-- chunkname: @modules/logic/versionactivity3_9/bird/view/game/V3a9BirdGameViewContainer.lua

module("modules.logic.versionactivity3_9.bird.view.game.V3a9BirdGameViewContainer", package.seeall)

local V3a9BirdGameViewContainer = class("V3a9BirdGameViewContainer", BaseViewContainer)

function V3a9BirdGameViewContainer:buildViews()
	local views = {}

	self._gameView = V3a9BirdGameView.New()
	self._pipeView = V3a9BirdPipeMgr.New()

	table.insert(views, self._gameView)
	table.insert(views, self._pipeView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function V3a9BirdGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideClose, self)

		return {
			self.navigateView
		}
	end
end

function V3a9BirdGameViewContainer:onContainerInit()
	V3a9BirdGameViewContainer.super.onContainerInit(self)
	V3a9BirdController.instance:onStartGame()
end

function V3a9BirdGameViewContainer:_overrideClose()
	self._isPause = true

	V3a9BirdController.instance:openPauseView(self._exitGame, self, self._cancelPause, self)
end

function V3a9BirdGameViewContainer:_exitGame()
	local episodeId = V3a9BirdModel.instance:getEnterGameEpisodeId()
	local gameType = V3a9BirdModel.instance:getGameType(episodeId)

	if gameType == V3a9BirdEnum.BirdGameType.Infinite then
		if self.viewParam then
			if not self.viewParam.actId then
				local actId = V3a9BirdModel.instance:getActId()

				V3a9BirdController.instance:openBirdMainView(actId, episodeId, true)
			end
		end
	else
		self:closeThis()
	end

	V3a9BirdController.instance:sendGameSuccessStat(false)
end

function V3a9BirdGameViewContainer:_cancelPause()
	self._isPause = false
end

function V3a9BirdGameViewContainer:UpdateFrame(dt)
	if self._isPause then
		return
	end

	if self._birdEntity then
		self._birdEntity:updateFrame(dt)
	end

	self._pipeView:UpdateFrame(dt)
end

function V3a9BirdGameViewContainer:flapBird()
	if self._birdEntity then
		self._birdEntity:flap()
	end
end

function V3a9BirdGameViewContainer:getBirdEntity()
	return self._birdEntity
end

function V3a9BirdGameViewContainer:setBirdEntity(entity)
	self._birdEntity = entity
end

function V3a9BirdGameViewContainer:resetPipes()
	self._pipeView:resetPipes()
end

function V3a9BirdGameViewContainer:refreshScore()
	if self._gameView then
		self._gameView:refreshScore()
	end
end

return V3a9BirdGameViewContainer
