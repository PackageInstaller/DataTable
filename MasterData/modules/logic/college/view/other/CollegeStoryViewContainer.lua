-- chunkname: @modules/logic/college/view/other/CollegeStoryViewContainer.lua

module("modules.logic.college.view.other.CollegeStoryViewContainer", package.seeall)

local CollegeStoryViewContainer = class("CollegeStoryViewContainer", BaseViewContainer)

function CollegeStoryViewContainer:buildViews()
	return {
		CollegeStoryView.New()
	}
end

return CollegeStoryViewContainer
