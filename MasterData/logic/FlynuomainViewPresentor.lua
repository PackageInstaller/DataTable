-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuomainViewPresentor.lua

module("logic.extensions.flyingnuo.view.FlynuomainViewPresentor", package.seeall)

local FlynuomainViewPresentor = class("FlynuomainViewPresentor", ViewPresentor)

function FlynuomainViewPresentor:ctor()
	FlynuomainViewPresentor.super.ctor(self)
end

function FlynuomainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FlynuomainViewPresentor:dependWhatResources()
	return {
		"ui/views/flyingnuo/flynuomainview.prefab"
	}
end

function FlynuomainViewPresentor:buildViews()
	return {
		FlynuomainView.New()
	}
end

return FlynuomainViewPresentor
