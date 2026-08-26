-- chunkname: @modules/logic/versionactivity3_6/yami/view/main/V3a6YaMiMainViewContainer.lua

module("modules.logic.versionactivity3_6.yami.view.main.V3a6YaMiMainViewContainer", package.seeall)

local V3a6YaMiMainViewContainer = class("V3a6YaMiMainViewContainer", BaseViewContainer)

function V3a6YaMiMainViewContainer:buildViews()
	local views = {}

	self._entityMgr = V3a6YaMiHeroEntityMgr.New()

	table.insert(views, V3a6YaMiMainView.New())
	table.insert(views, self._entityMgr)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "root/right/#go_fundingitem"))

	return views
end

function V3a6YaMiMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		self.currencyView = V3a6YaMiCurrencyView.New()

		return {
			self.currencyView
		}
	end
end

function V3a6YaMiMainViewContainer:overrideCloseFunc()
	V3a6YaMiController.instance:onExit()
	self:closeThis()
end

function V3a6YaMiMainViewContainer:checkCurrencyViewPlayAddAnim()
	self.currencyView:checkPlayAddAnim()
end

function V3a6YaMiMainViewContainer:getEntityMgr()
	return self._entityMgr
end

return V3a6YaMiMainViewContainer
