-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattlematchViewPresentor.lua

module("logic.extensions.glorybattle.view.GlorybattlematchViewPresentor", package.seeall)

local GlorybattlematchViewPresentor = class("GlorybattlematchViewPresentor", ViewPresentor)

function GlorybattlematchViewPresentor:ctor()
	GlorybattlematchViewPresentor.super.ctor(self)
end

function GlorybattlematchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GlorybattlematchViewPresentor:dependWhatResources()
	return {
		"ui/views/glorybattle/glorybattlematchview.prefab"
	}
end

function GlorybattlematchViewPresentor:buildViews()
	return {
		GlorybattlematchView.New()
	}
end

return GlorybattlematchViewPresentor
