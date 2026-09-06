-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuorankViewPresentor.lua

module("logic.extensions.flyingnuo.view.FlynuorankViewPresentor", package.seeall)

local FlynuorankViewPresentor = class("FlynuorankViewPresentor", ViewPresentor)

function FlynuorankViewPresentor:ctor()
	FlynuorankViewPresentor.super.ctor(self)
end

function FlynuorankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FlynuorankViewPresentor:dependWhatResources()
	return {
		"ui/views/rank/rankview.prefab"
	}
end

function FlynuorankViewPresentor:buildViews()
	return {
		FlynuorankView.New()
	}
end

return FlynuorankViewPresentor
