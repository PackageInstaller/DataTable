-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summer/view/SummerViewPresentor.lua

module("logic.extensions.summer.view.SummerViewPresentor", package.seeall)

local SummerViewPresentor = class("SummerViewPresentor", ViewPresentor)

function SummerViewPresentor:ctor()
	SummerViewPresentor.super.ctor(self)
end

function SummerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerViewPresentor:dependWhatResources()
	return {
		"ui/views/summer/summerview.prefab"
	}
end

function SummerViewPresentor:buildViews()
	return {
		SummerView.New()
	}
end

return SummerViewPresentor
