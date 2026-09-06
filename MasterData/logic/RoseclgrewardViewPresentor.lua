-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roseclg/view/RoseclgrewardViewPresentor.lua

module("logic.extensions.roseclg.view.RoseclgrewardViewPresentor", package.seeall)

local RoseclgrewardViewPresentor = class("RoseclgrewardViewPresentor", ViewPresentor)

function RoseclgrewardViewPresentor:ctor()
	RoseclgrewardViewPresentor.super.ctor(self)
end

function RoseclgrewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RoseclgrewardViewPresentor:dependWhatResources()
	return {
		"ui/views/roseclg/roseclgrewardview.prefab"
	}
end

function RoseclgrewardViewPresentor:buildViews()
	return {
		RoseclgrewardView.New()
	}
end

return RoseclgrewardViewPresentor
