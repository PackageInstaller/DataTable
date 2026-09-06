-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/remembertheater/view/RememberTheaterViewPresentor.lua

module("logic.extensions.remembertheater.view.RememberTheaterViewPresentor", package.seeall)

local RememberTheaterViewPresentor = class("RememberTheaterViewPresentor", ViewPresentor)

function RememberTheaterViewPresentor:ctor()
	RememberTheaterViewPresentor.super.ctor(self)
end

function RememberTheaterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RememberTheaterViewPresentor:dependWhatResources()
	return {
		"ui/views/theater/remembertheaterview.prefab"
	}
end

function RememberTheaterViewPresentor:buildViews()
	return {
		RememberTheaterView.New(),
		RememberTheaterRightView.New(),
		RememberTheaterLeftView.New()
	}
end

return RememberTheaterViewPresentor
