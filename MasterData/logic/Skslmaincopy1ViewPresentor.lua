-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/copy/view/Skslmaincopy1ViewPresentor.lua

module("logic.extensions.copy.view.Skslmaincopy1ViewPresentor", package.seeall)

local Skslmaincopy1ViewPresentor = class("Skslmaincopy1ViewPresentor", ViewPresentor)

function Skslmaincopy1ViewPresentor:ctor()
	Skslmaincopy1ViewPresentor.super.ctor(self)
end

function Skslmaincopy1ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Skslmaincopy1ViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shikongshenglong/copy/skslmaincopy1view.prefab"
	}
end

function Skslmaincopy1ViewPresentor:buildViews()
	return {
		Skslmaincopy1View.New()
	}
end

return Skslmaincopy1ViewPresentor
