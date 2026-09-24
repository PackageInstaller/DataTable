-- chunkname: @modules/logic/college/view/other/CollegeOptionViewContainer.lua

module("modules.logic.college.view.other.CollegeOptionViewContainer", package.seeall)

local CollegeOptionViewContainer = class("CollegeOptionViewContainer", BaseViewContainer)

function CollegeOptionViewContainer:buildViews()
	return {
		CollegeOptionView.New()
	}
end

return CollegeOptionViewContainer
