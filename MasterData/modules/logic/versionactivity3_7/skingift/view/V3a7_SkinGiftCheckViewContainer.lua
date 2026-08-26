-- chunkname: @modules/logic/versionactivity3_7/skingift/view/V3a7_SkinGiftCheckViewContainer.lua

module("modules.logic.versionactivity3_7.skingift.view.V3a7_SkinGiftCheckViewContainer", package.seeall)

local V3a7_SkinGiftCheckViewContainer = class("V3a7_SkinGiftCheckViewContainer", BaseViewContainer)

function V3a7_SkinGiftCheckViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a7_SkinGiftCheckView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function V3a7_SkinGiftCheckViewContainer:buildTabViews(tabContainerId)
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

return V3a7_SkinGiftCheckViewContainer
