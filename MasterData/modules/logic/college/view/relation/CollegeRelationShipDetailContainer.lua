-- chunkname: @modules/logic/college/view/relation/CollegeRelationShipDetailContainer.lua

module("modules.logic.college.view.relation.CollegeRelationShipDetailContainer", package.seeall)

local CollegeRelationShipDetailContainer = class("CollegeRelationShipDetailContainer", BaseViewContainer)

function CollegeRelationShipDetailContainer:buildViews()
	local views = {}

	table.insert(views, CollegeRelationShipDetail.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CollegeRelationShipDetailContainer:buildTabViews(tabContainerId)
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

return CollegeRelationShipDetailContainer
