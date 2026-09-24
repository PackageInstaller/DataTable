-- chunkname: @modules/logic/college/view/relation/CollegeRelationShipBoardContainer.lua

module("modules.logic.college.view.relation.CollegeRelationShipBoardContainer", package.seeall)

local CollegeRelationShipBoardContainer = class("CollegeRelationShipBoardContainer", BaseViewContainer)

function CollegeRelationShipBoardContainer:buildViews()
	local views = {}

	table.insert(views, CollegeRelationShipBoard.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	local fit = TabViewGroupFit.New(2, "#go_page")

	fit:keepCloseVisible(true)
	table.insert(views, fit)

	return views
end

function CollegeRelationShipBoardContainer:buildTabViews(tabContainerId)
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

	if tabContainerId == 2 then
		return {
			CollegeRelationShipBoardPage.New(CollegeEnum.RelationShipBoardPage.Default),
			CollegeRelationShipBoardPage.New(CollegeEnum.RelationShipBoardPage.Chapter13)
		}
	end
end

function CollegeRelationShipBoardContainer:changePage(index)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, index)
end

return CollegeRelationShipBoardContainer
