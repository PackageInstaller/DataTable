-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddailyrank/view/GoddailyrankmainViewPresentor.lua

module("logic.extensions.goddailyrank.view.GoddailyrankmainViewPresentor", package.seeall)

local GoddailyrankmainViewPresentor = class("GoddailyrankmainViewPresentor", ViewPresentor)

function GoddailyrankmainViewPresentor:ctor()
	GoddailyrankmainViewPresentor.super.ctor(self)
end

function GoddailyrankmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddailyrankmainViewPresentor:dependWhatResources()
	return {
		"ui/views/goddailyrank/goddailyrankmainview.prefab"
	}
end

function GoddailyrankmainViewPresentor:buildViews()
	return {
		GoddailyrankmainView.New()
	}
end

return GoddailyrankmainViewPresentor
