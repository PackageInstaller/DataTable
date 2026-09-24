-- chunkname: @modules/logic/college/view/other/CollegeStatusViewContainer.lua

module("modules.logic.college.view.other.CollegeStatusViewContainer", package.seeall)

local CollegeStatusViewContainer = class("CollegeStatusViewContainer", BaseViewContainer)

function CollegeStatusViewContainer:buildViews()
	return {
		CollegeStatusView.New(),
		CollegeVisibleBaseView.New()
	}
end

return CollegeStatusViewContainer
