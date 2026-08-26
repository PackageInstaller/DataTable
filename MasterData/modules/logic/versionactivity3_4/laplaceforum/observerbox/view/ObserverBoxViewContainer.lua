-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/observerbox/view/ObserverBoxViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.observerbox.view.ObserverBoxViewContainer", package.seeall)

local ObserverBoxViewContainer = class("ObserverBoxViewContainer", BaseViewContainer)

function ObserverBoxViewContainer:buildViews()
	local views = {}

	table.insert(views, ObserverBoxView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function ObserverBoxViewContainer:buildTabViews(tabContainerId)
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

return ObserverBoxViewContainer
