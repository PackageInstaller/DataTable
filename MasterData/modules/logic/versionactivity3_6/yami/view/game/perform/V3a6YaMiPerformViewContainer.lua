-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/perform/V3a6YaMiPerformViewContainer.lua

module("modules.logic.versionactivity3_6.yami.view.game.perform.V3a6YaMiPerformViewContainer", package.seeall)

local V3a6YaMiPerformViewContainer = class("V3a6YaMiPerformViewContainer", BaseViewContainer)

function V3a6YaMiPerformViewContainer:buildViews()
	local views = {}

	self._preformView = V3a6YaMiPerformView.New()
	self._resultView = V3a6YaMiPerformResultView.New()
	self._eventView = V3a6YaMiPerformEventView.New()
	self._entityMgr = V3a6YaMiPerformEntityMgr.New()

	table.insert(views, self._preformView)
	table.insert(views, self._resultView)
	table.insert(views, self._eventView)
	table.insert(views, self._entityMgr)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function V3a6YaMiPerformViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function V3a6YaMiPerformViewContainer:getEntityMgr()
	return self._entityMgr
end

return V3a6YaMiPerformViewContainer
