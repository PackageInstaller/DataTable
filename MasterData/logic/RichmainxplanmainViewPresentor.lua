-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RichmainxplanmainViewPresentor.lua

module("logic.extensions.richmanxplan.view.RichmainxplanmainViewPresentor", package.seeall)

local RichmainxplanmainViewPresentor = class("RichmainxplanmainViewPresentor", ViewPresentor)

function RichmainxplanmainViewPresentor:ctor()
	RichmainxplanmainViewPresentor.super.ctor(self)
end

function RichmainxplanmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RichmainxplanmainViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/richmainxplanmainview.prefab"
	}
end

function RichmainxplanmainViewPresentor:buildViews()
	return {
		RichmainxplanmainView.New()
	}
end

return RichmainxplanmainViewPresentor
