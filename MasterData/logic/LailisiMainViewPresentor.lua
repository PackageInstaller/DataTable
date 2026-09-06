-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/LailisiMainViewPresentor.lua

module("logic.extensions.lailisi.view.LailisiMainViewPresentor", package.seeall)

local LailisiMainViewPresentor = class("LailisiMainViewPresentor", ViewPresentor)

function LailisiMainViewPresentor:ctor()
	LailisiMainViewPresentor.super.ctor(self)
end

function LailisiMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LailisiMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lailisi/lailisimainview.prefab"
	}
end

function LailisiMainViewPresentor:buildViews()
	return {
		LailisiMainView.New()
	}
end

return LailisiMainViewPresentor
