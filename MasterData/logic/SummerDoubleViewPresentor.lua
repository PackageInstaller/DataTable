-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/summerdouble/SummerDoubleViewPresentor.lua

module("logic.extensions.bonus.view.summerdouble.SummerDoubleViewPresentor", package.seeall)

local SummerDoubleViewPresentor = class("SummerDoubleViewPresentor", ViewPresentor)

function SummerDoubleViewPresentor:ctor()
	SummerDoubleViewPresentor.super.ctor(self)
end

function SummerDoubleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerDoubleViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/summerdouble/summerdoubleview.prefab"
	}
end

function SummerDoubleViewPresentor:buildViews()
	return {
		SummerDoubleView.New()
	}
end

return SummerDoubleViewPresentor
