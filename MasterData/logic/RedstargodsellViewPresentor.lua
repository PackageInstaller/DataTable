-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redstargodsell/view/RedstargodsellViewPresentor.lua

module("logic.extensions.redstargodsell.view.RedstargodsellViewPresentor", package.seeall)

local RedstargodsellViewPresentor = class("RedstargodsellViewPresentor", ViewPresentor)

function RedstargodsellViewPresentor:ctor()
	RedstargodsellViewPresentor.super.ctor(self)
end

function RedstargodsellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RedstargodsellViewPresentor:dependWhatResources()
	return {
		"ui/views/redstargodsell/redstargodsellview.prefab"
	}
end

function RedstargodsellViewPresentor:buildViews()
	return {
		RedstargodsellView.New()
	}
end

return RedstargodsellViewPresentor
