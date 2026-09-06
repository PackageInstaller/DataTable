-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShanClgViewPresentor.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShanClgViewPresentor", package.seeall)

local DivineTianShanClgViewPresentor = class("DivineTianShanClgViewPresentor", ViewPresentor)

function DivineTianShanClgViewPresentor:ctor()
	DivineTianShanClgViewPresentor.super.ctor(self)
end

function DivineTianShanClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTianShanClgViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetianshanclg/divinetianshanclgview.prefab"
	}
end

function DivineTianShanClgViewPresentor:buildViews()
	return {
		DivineTianShanClgView.New()
	}
end

return DivineTianShanClgViewPresentor
