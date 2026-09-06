-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuorewardViewPresentor.lua

module("logic.extensions.flyingnuo.view.FlynuorewardViewPresentor", package.seeall)

local FlynuorewardViewPresentor = class("FlynuorewardViewPresentor", ViewPresentor)

function FlynuorewardViewPresentor:ctor()
	FlynuorewardViewPresentor.super.ctor(self)
end

function FlynuorewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FlynuorewardViewPresentor:dependWhatResources()
	return {
		"ui/views/flyingnuo/flynuorewardview.prefab"
	}
end

function FlynuorewardViewPresentor:buildViews()
	return {
		FlynuorewardView.New()
	}
end

return FlynuorewardViewPresentor
