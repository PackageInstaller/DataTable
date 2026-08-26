-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaMapViewContainer.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapViewContainer", package.seeall)

local JiaLaBoNaMapViewContainer = class("JiaLaBoNaMapViewContainer", BaseViewContainer)

function JiaLaBoNaMapViewContainer:buildViews()
	local views = {}

	self._mapViewScene = JiaLaBoNaMapScene.New()
	self._viewAnim = JiaLaBoNaMapViewAnim.New()

	table.insert(views, self._mapViewScene)
	table.insert(views, JiaLaBoNaMapView.New())
	table.insert(views, self._viewAnim)
	table.insert(views, JiaLaBoNaMapViewAudio.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function JiaLaBoNaMapViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function JiaLaBoNaMapViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonsView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self._navigateButtonsView
		}
	end
end

JiaLaBoNaMapViewContainer.UI_COLSE_BLOCK_KEY = "JiaLaBoNaMapViewContainer_COLSE_BLOCK_KEY"

function JiaLaBoNaMapViewContainer:_overrideCloseFunc()
	UIBlockMgr.instance:startBlock(JiaLaBoNaMapViewContainer.UI_COLSE_BLOCK_KEY)
	self._viewAnim:playViewAnimator(UIAnimationName.Close)
	TaskDispatcher.runDelay(self._onDelayCloseView, self, JiaLaBoNaEnum.AnimatorTime.MapViewClose)
end

function JiaLaBoNaMapViewContainer:_onDelayCloseView()
	UIBlockMgr.instance:endBlock(JiaLaBoNaMapViewContainer.UI_COLSE_BLOCK_KEY)
	self._viewAnim:closeThis()
end

function JiaLaBoNaMapViewContainer:switchPage(page, playAnim)
	if self._mapViewScene then
		self._mapViewScene:switchPage(page)

		if not string.nilorempty(playAnim) then
			self._mapViewScene:playSceneAnim(playAnim)
		end
	end
end

function JiaLaBoNaMapViewContainer:refreshInteract(animEpisodeId)
	if self._mapViewScene then
		self._mapViewScene:refreshInteract(animEpisodeId)
	end
end

function JiaLaBoNaMapViewContainer:_setVisible(isVisible)
	JiaLaBoNaMapViewContainer.super._setVisible(self, isVisible)

	if self._mapViewScene then
		local isHasStoryOpen = ViewMgr.instance:isOpen(ViewName.JiaLaBoNaStoryView)

		if not isHasStoryOpen or isVisible then
			self._mapViewScene:setSceneActive(isVisible)
		end

		if self._lastMapViewSceneVisible ~= isVisible then
			self._lastMapViewSceneVisible = isVisible

			if isVisible and not isHasStoryOpen then
				self._mapViewScene:playSceneAnim(UIAnimationName.Open)
				self._viewAnim:playViewAnimator(UIAnimationName.Open)
			end
		end
	end
end

function JiaLaBoNaMapViewContainer:switchScene(isNext)
	if self._viewAnim then
		self._viewAnim:switchScene(isNext)
	end
end

function JiaLaBoNaMapViewContainer:playPathAnim()
	if self._viewAnim then
		self._viewAnim:playPathAnim()
	end
end

function JiaLaBoNaMapViewContainer:refreshPathPoin()
	if self._viewAnim then
		self._viewAnim:refreshPathPoin()
	end
end

function JiaLaBoNaMapViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Act306)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Act306
	})
end

return JiaLaBoNaMapViewContainer
