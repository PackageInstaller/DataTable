-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattlemainViewPresentor.lua

module("logic.extensions.glorybattle.view.GlorybattlemainViewPresentor", package.seeall)

local GlorybattlemainViewPresentor = class("GlorybattlemainViewPresentor", ViewPresentor)

function GlorybattlemainViewPresentor:ctor()
	GlorybattlemainViewPresentor.super.ctor(self)
end

function GlorybattlemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GlorybattlemainViewPresentor:dependWhatResources()
	return {
		"ui/views/glorybattle/glorybattlemainview.prefab"
	}
end

function GlorybattlemainViewPresentor:buildViews()
	return {
		GlorybattlemainView.New()
	}
end

return GlorybattlemainViewPresentor
