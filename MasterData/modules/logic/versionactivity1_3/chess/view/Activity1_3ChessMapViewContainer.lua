-- chunkname: @modules/logic/versionactivity1_3/chess/view/Activity1_3ChessMapViewContainer.lua

module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapViewContainer", package.seeall)

local Activity1_3ChessMapViewContainer = class("Activity1_3ChessMapViewContainer", BaseViewContainer)
local COLSE_BLOCK_KEY = "ChessMapViewColseBlockKey"
local CloseMapViewTime = 0.3

function Activity1_3ChessMapViewContainer:buildViews()
	local views = {}

	self._mapViewScene = Activity1_3ChessMapScene.New()
	self._mapView = Activity1_3ChessMapView.New()
	self._viewAnim = Activity1_3ChessMapViewAnim.New()
	self._viewAudio = Activity1_3ChessMapViewAudio.New()
	views[#views + 1] = self._mapViewScene
	views[#views + 1] = self._mapView
	views[#views + 1] = self._viewAnim
	views[#views + 1] = self._viewAudio
	views[#views + 1] = TabViewGroup.New(1, "#go_BackBtns")

	return views
end

function Activity1_3ChessMapViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		navigateButtonsView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			navigateButtonsView
		}
	end
end

function Activity1_3ChessMapViewContainer:_overrideCloseFunc()
	UIBlockMgr.instance:startBlock(COLSE_BLOCK_KEY)
	self._mapView:playViewAnimation(UIAnimationName.Close)
	TaskDispatcher.runDelay(self._onDelayCloseView, self, CloseMapViewTime)
end

function Activity1_3ChessMapViewContainer:_onDelayCloseView()
	UIBlockMgr.instance:endBlock(COLSE_BLOCK_KEY)
	self._viewAnim:closeThis()
end

function Activity1_3ChessMapViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Act304)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Act304
	})
end

function Activity1_3ChessMapViewContainer:switchStage(stage)
	if self._mapViewScene then
		self._mapViewScene:switchStage(stage)
	end
end

function Activity1_3ChessMapViewContainer:playPathAnim()
	if self._viewAnim then
		self._viewAnim:playPathAnim()
	end
end

function Activity1_3ChessMapViewContainer:showEnterSceneView(stage)
	if self._mapViewScene then
		self._mapViewScene:playSceneEnterAni(stage)
	end
end

function Activity1_3ChessMapViewContainer:_setVisible(isVisible)
	BaseViewContainer._setVisible(self, isVisible)

	local isReviewingStory = Activity1_3ChessController.instance:isReviewStory()

	if self._mapViewScene then
		self._mapViewScene:onSetVisible(isVisible)

		if not isReviewingStory then
			self._mapViewScene:setSceneActive(isVisible)
		end
	end

	if self._mapView then
		self._mapView:onSetVisible(isVisible)

		if not isReviewingStory and isVisible then
			self._mapView:playViewAnimation(UIAnimationName.Open)
		end
	end
end

return Activity1_3ChessMapViewContainer
