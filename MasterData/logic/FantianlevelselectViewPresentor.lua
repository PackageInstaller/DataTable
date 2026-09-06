-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/FantianlevelselectViewPresentor.lua

module("logic.extensions.fantian.view.FantianlevelselectViewPresentor", package.seeall)

local FantianlevelselectViewPresentor = class("FantianlevelselectViewPresentor", ViewPresentor)

function FantianlevelselectViewPresentor:ctor()
	FantianlevelselectViewPresentor.super.ctor(self)
end

function FantianlevelselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FantianlevelselectViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fantian/fantianlevelselectview.prefab"
	}
end

function FantianlevelselectViewPresentor:buildViews()
	return {
		FantianlevelselectView.New()
	}
end

return FantianlevelselectViewPresentor
