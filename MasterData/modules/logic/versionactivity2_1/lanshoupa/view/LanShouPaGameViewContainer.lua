-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaGameViewContainer.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameViewContainer", package.seeall)

local LanShouPaGameViewContainer = class("LanShouPaGameViewContainer", BaseViewContainer)

function LanShouPaGameViewContainer:buildViews()
	local views = {}

	table.insert(views, LanShouPaGameView.New())
	table.insert(views, LanShouPaGameScene.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function LanShouPaGameViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function LanShouPaGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		navigateView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			navigateView
		}
	end
end

function LanShouPaGameViewContainer:_overrideCloseFunc()
	ChessGameController.instance:release()
	self:closeThis()
end

function LanShouPaGameViewContainer:_onEscape()
	self:_overrideCloseFunc()
end

function LanShouPaGameViewContainer:setRootSceneGo(sceneGo)
	self.sceneGo = sceneGo
end

function LanShouPaGameViewContainer:getRootSceneGo()
	return self.sceneGo
end

return LanShouPaGameViewContainer
