-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonPolygonSelectViewContainer.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonPolygonSelectViewContainer", package.seeall)

local AtomicDungeonPolygonSelectViewContainer = class("AtomicDungeonPolygonSelectViewContainer", BaseViewContainer)

function AtomicDungeonPolygonSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicDungeonPolygonSelectView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function AtomicDungeonPolygonSelectViewContainer:buildTabViews(tabContainerId)
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

return AtomicDungeonPolygonSelectViewContainer
