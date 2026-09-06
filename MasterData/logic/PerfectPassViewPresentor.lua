-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/PerfectPassViewPresentor.lua

module("logic.extensions.plotcopy.view.PerfectPassViewPresentor", package.seeall)

local PerfectPassViewPresentor = class("PerfectPassViewPresentor", ViewPresentor)

function PerfectPassViewPresentor:ctor()
	PerfectPassViewPresentor.super.ctor(self)
end

function PerfectPassViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PerfectPassViewPresentor:dependWhatResources()
	return {
		"ui/views/plotcopy/perfectpassview.prefab"
	}
end

function PerfectPassViewPresentor:buildViews()
	return {
		PerfectPassView.New()
	}
end

return PerfectPassViewPresentor
