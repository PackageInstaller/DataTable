-- chunkname: @modules/logic/gm/view/yeshumei/GMYeShuMeiViewContainer.lua

module("modules.logic.gm.view.yeshumei.GMYeShuMeiViewContainer", package.seeall)

local GMYeShuMeiViewContainer = class("GMYeShuMeiViewContainer", BaseViewContainer)

function GMYeShuMeiViewContainer:buildViews()
	local views = {}

	table.insert(views, GMYeShuMeiView.New())

	return views
end

function GMYeShuMeiViewContainer:buildTabViews(tabContainerId)
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

return GMYeShuMeiViewContainer
