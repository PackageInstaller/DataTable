-- chunkname: @modules/logic/college/view/other/CollegeStoryView2Container.lua

module("modules.logic.college.view.other.CollegeStoryView2Container", package.seeall)

local CollegeStoryView2Container = class("CollegeStoryView2Container", BaseViewContainer)

function CollegeStoryView2Container:buildViews()
	return {
		CollegeStoryView2.New()
	}
end

return CollegeStoryView2Container
