-- chunkname: @modules/logic/sp02/paomian/enter/view/Sp02_PaoMian_MainViewContainer.lua

module("modules.logic.sp02.paomian.enter.view.Sp02_PaoMian_MainViewContainer", package.seeall)

local Sp02_PaoMian_MainViewContainer = class("Sp02_PaoMian_MainViewContainer", BaseViewContainer)

function Sp02_PaoMian_MainViewContainer:buildViews()
	local views = {}

	table.insert(views, Sp02_PaoMian_MainView.New())
	table.insert(views, Sp02_PaoMian_WebView.New())
	table.insert(views, Sp02_PaoMian_LiveView.New({
		[ActivityEnum.Activity.SP02_PaoMianActivityMarcus] = {
			ViewName.Sp02_MarcusView
		},
		[ActivityEnum.Activity.SP02_PaoMianActivityGuessMe] = {
			ViewName.Sp02_GuessMeView
		},
		[ActivityEnum.Activity.SP02_PaoMianActivityMain] = {
			ViewName.Sp02_PaoMian_MainView
		},
		[ActivityEnum.Activity.SP02_PaoMianActivityShop] = {
			ViewName.Sp02_PaoMian_ShopPanelView
		},
		[ActivityEnum.Activity.SP02_PaoMianActivityWeb] = {
			ViewName.WebView
		}
	}))
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Sp02_PaoMian_MainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

function Sp02_PaoMian_MainViewContainer:onContainerClose()
	Sp02_PaoMianController.instance:setWebWeekFirstLoginRed()
end

return Sp02_PaoMian_MainViewContainer
