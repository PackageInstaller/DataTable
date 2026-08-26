-- chunkname: @modules/logic/toughbattle/view/ToughBattleMapViewContainer.lua

module("modules.logic.toughbattle.view.ToughBattleMapViewContainer", package.seeall)

local ToughBattleMapViewContainer = class("ToughBattleMapViewContainer", BaseViewContainer)

function ToughBattleMapViewContainer:buildViews()
	self._mapScene = ToughBattleMapScene.New()

	return {
		self._mapScene,
		ToughBattleMapView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function ToughBattleMapViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self.navigateView
	}
end

function ToughBattleMapViewContainer:setVisibleInternal(isVisible)
	ToughBattleMapViewContainer.super.setVisibleInternal(self, isVisible)

	if self._mapScene then
		self._mapScene:setSceneVisible(isVisible)
	end
end

function ToughBattleMapViewContainer:playCloseTransition()
	self:_cancelBlock()
	self:_stopOpenCloseAnim()
	self:startViewCloseBlock()

	local animatorPlayer = self:__getAnimatorPlayer()

	if not gohelper.isNil(animatorPlayer) then
		local animName = "close"

		animatorPlayer:Play(animName, self.onPlayCloseTransitionFinish, self)
	end

	local duration = 2

	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, duration)
end

return ToughBattleMapViewContainer
