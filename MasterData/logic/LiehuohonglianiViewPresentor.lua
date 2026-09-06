-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/LiehuohonglianiViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.moyan.LiehuohonglianiViewPresentor", package.seeall)

local LiehuohonglianiViewPresentor = class("LiehuohonglianiViewPresentor", ViewPresentor)

function LiehuohonglianiViewPresentor:ctor()
	LiehuohonglianiViewPresentor.super.ctor(self)
end

function LiehuohonglianiViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiehuohonglianiViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/moyan/liehuohonglianiview.prefab"
	}
end

function LiehuohonglianiViewPresentor:buildViews()
	return {
		LiehuohonglianiView.New()
	}
end

return LiehuohonglianiViewPresentor
