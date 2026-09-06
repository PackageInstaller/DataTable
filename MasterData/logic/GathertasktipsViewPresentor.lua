-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gathertask/view/GathertasktipsViewPresentor.lua

module("logic.extensions.gathertask.view.GathertasktipsViewPresentor", package.seeall)

local GathertasktipsViewPresentor = class("GathertasktipsViewPresentor", ViewPresentor)

function GathertasktipsViewPresentor:ctor()
	GathertasktipsViewPresentor.super.ctor(self)
end

function GathertasktipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GathertasktipsViewPresentor:dependWhatResources()
	return {
		"ui/views/gathertask/gathertasktipsview.prefab"
	}
end

function GathertasktipsViewPresentor:buildViews()
	return {
		GathertasktipsView.New()
	}
end

return GathertasktipsViewPresentor
