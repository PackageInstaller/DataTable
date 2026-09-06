-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/louna/LounalevelsViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.louna.LounalevelsViewPresentor", package.seeall)

local LounalevelsViewPresentor = class("LounalevelsViewPresentor", ViewPresentor)

function LounalevelsViewPresentor:ctor()
	LounalevelsViewPresentor.super.ctor(self)
end

function LounalevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LounalevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/louna/lounalevelsview.prefab"
	}
end

function LounalevelsViewPresentor:buildViews()
	return {
		LounalevelsView.New()
	}
end

return LounalevelsViewPresentor
