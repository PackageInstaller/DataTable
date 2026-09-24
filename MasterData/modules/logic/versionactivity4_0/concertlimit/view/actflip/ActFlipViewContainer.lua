-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/actflip/ActFlipViewContainer.lua

module("modules.logic.versionactivity4_0.concertlimit.view.actflip.ActFlipViewContainer", package.seeall)

local ActFlipViewContainer = class("ActFlipViewContainer", BaseViewContainer)

function ActFlipViewContainer:buildViews()
	local views = {}

	table.insert(views, ActFlipView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function ActFlipViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return ActFlipViewContainer
