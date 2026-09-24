-- chunkname: @modules/logic/college/view/common/CollegeToastViewContainer.lua

module("modules.logic.college.view.common.CollegeToastViewContainer", package.seeall)

local CollegeToastViewContainer = class("CollegeToastViewContainer", BaseViewContainer)

function CollegeToastViewContainer:buildViews()
	return {
		CollegeToastView.New()
	}
end

return CollegeToastViewContainer
