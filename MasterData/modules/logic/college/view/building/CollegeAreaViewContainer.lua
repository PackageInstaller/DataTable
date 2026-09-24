-- chunkname: @modules/logic/college/view/building/CollegeAreaViewContainer.lua

module("modules.logic.college.view.building.CollegeAreaViewContainer", package.seeall)

local CollegeAreaViewContainer = class("CollegeAreaViewContainer", BaseViewContainer)

function CollegeAreaViewContainer:buildViews()
	return {
		CollegeAreaView.New(),
		CollegeVisibleBaseView.New()
	}
end

return CollegeAreaViewContainer
