-- chunkname: @modules/common/global/screen/GameLoadingState.lua

module("modules.common.global.screen.GameLoadingState", package.seeall)

local GameLoadingState = class("GameLoadingState")

GameLoadingState.LoadingView = 1
GameLoadingState.LoadingBlackView = 2
GameLoadingState.LoadingBlackView2 = 3
GameLoadingState.LoadingHeadsetView = 4
GameLoadingState.LoadingRoomView = 5
GameLoadingState.LoadingDownloadView = 6
GameLoadingState.LoadingCachotView = 7
GameLoadingState.LoadingCachotChangeView = 8
GameLoadingState.SurvivalLoadingView = 9
GameLoadingState.VersionActivity2_8BossStoryLoadingView = 10
GameLoadingState.Rouge2_MapLoadingView = 11
GameLoadingState.PartyGameLobbyLoadingView = 12
GameLoadingState.PartyGameCardDropLoadingView = 13
GameLoadingState.V3a9RacingCarLoadingView = 14

local ViewNames = {
	[GameLoadingState.LoadingView] = ViewName.LoadingView,
	[GameLoadingState.LoadingBlackView] = ViewName.LoadingBlackView,
	[GameLoadingState.LoadingBlackView2] = ViewName.LoadingBlackView2,
	[GameLoadingState.LoadingHeadsetView] = ViewName.LoadingHeadsetView,
	[GameLoadingState.LoadingRoomView] = ViewName.LoadingRoomView,
	[GameLoadingState.LoadingDownloadView] = ViewName.LoadingDownloadView,
	[GameLoadingState.LoadingCachotView] = ViewName.V1a6_CachotLoadingView,
	[GameLoadingState.LoadingCachotChangeView] = ViewName.V1a6_CachotLayerChangeView,
	[GameLoadingState.SurvivalLoadingView] = ViewName.SurvivalLoadingView,
	[GameLoadingState.VersionActivity2_8BossStoryLoadingView] = ViewName.VersionActivity2_8BossStoryLoadingView,
	[GameLoadingState.Rouge2_MapLoadingView] = ViewName.Rouge2_MapLoadingView,
	[GameLoadingState.PartyGameLobbyLoadingView] = ViewName.PartyGameLobbyLoadingView,
	[GameLoadingState.PartyGameCardDropLoadingView] = ViewName.CardDropLoadingView,
	[GameLoadingState.V3a9RacingCarLoadingView] = ViewName.V3a9RacingCarLoadingView
}
local ViewNameDict = {
	[ViewName.LoadingView] = GameLoadingState.LoadingView,
	[ViewName.LoadingBlackView] = GameLoadingState.LoadingBlackView,
	[ViewName.LoadingBlackView2] = GameLoadingState.LoadingBlackView2,
	[ViewName.LoadingHeadsetView] = GameLoadingState.LoadingHeadsetView,
	[ViewName.LoadingRoomView] = GameLoadingState.LoadingRoomView,
	[ViewName.LoadingDownloadView] = GameLoadingState.LoadingDownloadView,
	[ViewName.V1a6_CachotLoadingView] = GameLoadingState.LoadingCachotView,
	[ViewName.V1a6_CachotLayerChangeView] = GameLoadingState.LoadingCachotChangeView,
	[ViewName.SurvivalLoadingView] = GameLoadingState.SurvivalLoadingView,
	[ViewName.VersionActivity2_8BossStoryLoadingView] = GameLoadingState.VersionActivity2_8BossStoryLoadingView,
	[ViewName.Rouge2_MapLoadingView] = GameLoadingState.Rouge2_MapLoadingView,
	[ViewName.PartyGameLobbyLoadingView] = GameLoadingState.PartyGameLobbyLoadingView,
	[ViewName.CardDropLoadingView] = GameLoadingState.PartyGameCardDropLoadingView,
	[ViewName.V3a9RacingCarLoadingView] = GameLoadingState.V3a9RacingCarLoadingView
}

function GameLoadingState:ctor()
	self:addConstEvents()

	self._loadingType = nil
	self._showLoadingView = nil
end

function GameLoadingState:addConstEvents()
	GameSceneMgr.instance:registerCallback(SceneEventName.OpenLoading, self._openLoading, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.CloseLoading, self._closeLoading, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.SetLoadingTypeOnce, self._setLoadingTypeOnce, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.WaitViewOpenCloseLoading, self._waitViewOpenCloseLoading, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function GameLoadingState:getLoadingType()
	return self._loadingType
end

function GameLoadingState:_onCloseView(viewName)
	if ViewNameDict[viewName] then
		self._showLoadingView = nil
	end
end

function GameLoadingState:_setLoadingTypeOnce(loadingType)
	self._loadingType = tonumber(loadingType)
end

function GameLoadingState:_checkOpenView(viewName, viewParam)
	if self._viewName and self._viewName == viewName then
		self:clearWaitView()
	end
end

function GameLoadingState:clearWaitView()
	self._viewName = nil

	self:_closeLoading()
end

function GameLoadingState:_waitViewOpenCloseLoading(viewName)
	logNormal("GameLoadingState waitViewName:" .. viewName)

	self._viewName = viewName
end

function GameLoadingState:getLoadingViewName()
	return self._showLoadingView
end

function GameLoadingState:_openLoading(sceneType, isEnterGame)
	if self._showLoadingView then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.AgainOpenLoading)
	else
		local loadingType = self._loadingType

		self._loadingType = nil

		if loadingType then
			if not ViewNames[loadingType] then
				local viewName = ViewNames[1]

				self._showLoadingView = viewName

				ViewMgr.instance:openView(viewName, sceneType)
			end
		end
	end
end

function GameLoadingState:_closeLoading()
	if self._viewName then
		return
	end

	if self._showLoadingView == ViewName.LoadingView then
		if ViewMgr.instance:isOpen(ViewName.LoadingView) then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.DelayCloseLoading)
		elseif ViewMgr.instance:isOpening(self._showLoadingView) then
			ViewMgr.instance:closeView(self._showLoadingView)
		else
			self._showLoadingView = nil
		end
	elseif self._showLoadingView == ViewName.LoadingHeadsetView then
		-- block empty
	elseif self._showLoadingView == ViewName.V1a6_CachotLoadingView then
		-- block empty
	elseif self._showLoadingView == ViewName.V1a6_CachotLayerChangeView then
		-- block empty
	elseif self._showLoadingView == ViewName.SurvivalLoadingView then
		-- block empty
	elseif self._showLoadingView == ViewName.V3a9RacingCarLoadingView then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.CanCloseLoading)
	elseif self._showLoadingView == ViewName.VersionActivity2_8BossStoryLoadingView then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.CanCloseLoading)
	elseif self._showLoadingView == ViewName.PartyGameLobbyLoadingView then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.CanCloseLoading)
	else
		ViewMgr.instance:closeView(self._showLoadingView)

		self._showLoadingView = nil
	end
end

return GameLoadingState
