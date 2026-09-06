-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/summerdouble/SummerTaskViewPresentor.lua

module("logic.extensions.bonus.view.summerdouble.SummerTaskViewPresentor", package.seeall)

local SummerTaskViewPresentor = class("SummerTaskViewPresentor", ViewPresentor)

function SummerTaskViewPresentor:ctor()
	SummerTaskViewPresentor.super.ctor(self)
end

function SummerTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummerTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/summerdouble/summertaskview.prefab"
	}
end

function SummerTaskViewPresentor:buildViews()
	return {
		SummerTaskView.New()
	}
end

return SummerTaskViewPresentor
