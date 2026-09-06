-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShanClgResultViewPresentor.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShanClgResultViewPresentor", package.seeall)

local DivineTianShanClgResultViewPresentor = class("DivineTianShanClgResultViewPresentor", ViewPresentor)

function DivineTianShanClgResultViewPresentor:ctor()
	DivineTianShanClgResultViewPresentor.super.ctor(self)
end

function DivineTianShanClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTianShanClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetianshanclg/divinetianshanclgresultview.prefab"
	}
end

function DivineTianShanClgResultViewPresentor:buildViews()
	return {
		DivineTianShanClgResultView.New()
	}
end

return DivineTianShanClgResultViewPresentor
