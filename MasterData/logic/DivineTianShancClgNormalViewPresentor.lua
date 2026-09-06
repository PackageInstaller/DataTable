-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShancClgNormalViewPresentor.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShancClgNormalViewPresentor", package.seeall)

local DivineTianShancClgNormalViewPresentor = class("DivineTianShancClgNormalViewPresentor", ViewPresentor)

function DivineTianShancClgNormalViewPresentor:ctor()
	DivineTianShancClgNormalViewPresentor.super.ctor(self)
end

function DivineTianShancClgNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTianShancClgNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetianshanclg/divinetianshanclgnormalview.prefab"
	}
end

function DivineTianShancClgNormalViewPresentor:buildViews()
	return {
		DivineTianShancClgNormalView.New()
	}
end

return DivineTianShancClgNormalViewPresentor
