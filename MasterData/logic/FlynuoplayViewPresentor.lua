-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuoplayViewPresentor.lua

module("logic.extensions.flyingnuo.view.FlynuoplayViewPresentor", package.seeall)

local FlynuoplayViewPresentor = class("FlynuoplayViewPresentor", ViewPresentor)

function FlynuoplayViewPresentor:ctor()
	FlynuoplayViewPresentor.super.ctor(self)
end

function FlynuoplayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FlynuoplayViewPresentor:dependWhatResources()
	return {
		"ui/views/flyingnuo/flynuoplayview.prefab"
	}
end

function FlynuoplayViewPresentor:buildViews()
	return {
		FlynuoplayView.New()
	}
end

return FlynuoplayViewPresentor
