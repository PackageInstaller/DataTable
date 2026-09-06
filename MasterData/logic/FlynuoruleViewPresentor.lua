-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuoruleViewPresentor.lua

module("logic.extensions.flyingnuo.view.FlynuoruleViewPresentor", package.seeall)

local FlynuoruleViewPresentor = class("FlynuoruleViewPresentor", ViewPresentor)

function FlynuoruleViewPresentor:ctor()
	FlynuoruleViewPresentor.super.ctor(self)
end

function FlynuoruleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FlynuoruleViewPresentor:dependWhatResources()
	return {
		"ui/views/flyingnuo/flynuoruleview.prefab"
	}
end

function FlynuoruleViewPresentor:buildViews()
	return {
		FlynuoruleView.New()
	}
end

return FlynuoruleViewPresentor
