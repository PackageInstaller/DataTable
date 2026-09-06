-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuoitemgetViewPresentor.lua

module("logic.extensions.flyingnuo.view.FlynuoitemgetViewPresentor", package.seeall)

local FlynuoitemgetViewPresentor = class("FlynuoitemgetViewPresentor", ViewPresentor)

function FlynuoitemgetViewPresentor:ctor()
	FlynuoitemgetViewPresentor.super.ctor(self)
end

function FlynuoitemgetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FlynuoitemgetViewPresentor:dependWhatResources()
	return {
		"ui/views/flyingnuo/flynuoitemgetview.prefab"
	}
end

function FlynuoitemgetViewPresentor:buildViews()
	return {
		FlynuoitemgetView.New()
	}
end

return FlynuoitemgetViewPresentor
