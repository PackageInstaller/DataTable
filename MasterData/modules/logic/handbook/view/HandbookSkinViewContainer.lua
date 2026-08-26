-- chunkname: @modules/logic/handbook/view/HandbookSkinViewContainer.lua

module("modules.logic.handbook.view.HandbookSkinViewContainer", package.seeall)

local HandbookSkinViewContainer = class("HandbookSkinViewContainer", BaseViewContainer)
local closeAniDuration = 0.01

function HandbookSkinViewContainer:buildViews()
	local views = {}

	self._scene = HandbookSkinScene.New()

	table.insert(views, HandbookSkinView.New())
	table.insert(views, self._scene)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function HandbookSkinViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigateView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function HandbookSkinViewContainer:_overrideCloseFunc()
	if self._scene:isInTarotMode() then
		self._scene:exitTarotScene()

		return
	end

	TaskDispatcher.runDelay(self.closeThis, self, closeAniDuration)
end

function HandbookSkinViewContainer:onClickHome()
	if self._scene then
		self._scene:playCloseAni()
	end

	TaskDispatcher.runDelay(self._doHomeAction, self, closeAniDuration)
end

function HandbookSkinViewContainer:_doHomeAction()
	NavigateButtonsView.homeClick()
end

function HandbookSkinViewContainer:onContainerClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function HandbookSkinViewContainer:onContainerInit()
	return
end

function HandbookSkinViewContainer:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

function HandbookSkinViewContainer:_setVisible(isVisible)
	BaseViewContainer._setVisible(self, isVisible)

	if self._scene then
		self._scene.sceneVisible = isVisible
	end
end

return HandbookSkinViewContainer
