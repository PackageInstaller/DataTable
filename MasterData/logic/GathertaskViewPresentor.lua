-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gathertask/view/GathertaskViewPresentor.lua

module("logic.extensions.gathertask.view.GathertaskViewPresentor", package.seeall)

local GathertaskViewPresentor = class("GathertaskViewPresentor", ViewPresentor)

function GathertaskViewPresentor:ctor()
	GathertaskViewPresentor.super.ctor(self)
end

function GathertaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GathertaskViewPresentor:dependWhatResources()
	return {
		"ui/views/gathertask/gathertaskview.prefab"
	}
end

function GathertaskViewPresentor:buildViews()
	return {
		GathertaskView.New()
	}
end

return GathertaskViewPresentor
