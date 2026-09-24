-- chunkname: @modules/logic/college/view/building/CollegeBuildingViewContainer.lua

module("modules.logic.college.view.building.CollegeBuildingViewContainer", package.seeall)

local CollegeBuildingViewContainer = class("CollegeBuildingViewContainer", BaseViewContainer)

function CollegeBuildingViewContainer:buildViews()
	return {
		CollegeBuildingView.New(),
		CollegeVisibleBaseView.New(),
		CollegeCurrencyView.New("#go_righttop")
	}
end

return CollegeBuildingViewContainer
