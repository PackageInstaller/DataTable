-- chunkname: @modules/logic/sodache/view/outside/SodacheMainViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheMainViewContainer", package.seeall)

local SodacheMainViewContainer = class("SodacheMainViewContainer", BaseViewContainer)

function SodacheMainViewContainer:buildViews()
	return {
		SodacheMainView.New(),
		SodacheMainScene.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function SodacheMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigationView:setOverrideClose(self._overrideClose, self)

		return {
			self.navigationView
		}
	end
end

function SodacheMainViewContainer:_overrideClose()
	SodacheController.instance:exitScene()
end

return SodacheMainViewContainer
