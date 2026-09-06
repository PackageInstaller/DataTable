-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerholidayscheckin/view/SummerholidayscheckinmainViewPresentor.lua

module("logic.extensions.summerholidayscheckin.view.SummerholidayscheckinmainViewPresentor", package.seeall)

local SummerholidayscheckinmainViewPresentor = class("SummerholidayscheckinmainViewPresentor", ViewPresentor)

function SummerholidayscheckinmainViewPresentor:ctor()
	SummerholidayscheckinmainViewPresentor.super.ctor(self)
end

function SummerholidayscheckinmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerholidayscheckinmainViewPresentor:dependWhatResources()
	return {
		"ui/views/summerholidayscheckin/summerholidayscheckinmainview.prefab"
	}
end

function SummerholidayscheckinmainViewPresentor:buildViews()
	return {
		SummerholidayscheckinmainView.New()
	}
end

return SummerholidayscheckinmainViewPresentor
