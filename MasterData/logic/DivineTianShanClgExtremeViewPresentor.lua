-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShanClgExtremeViewPresentor.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShanClgExtremeViewPresentor", package.seeall)

local DivineTianShanClgExtremeViewPresentor = class("DivineTianShanClgExtremeViewPresentor", ViewPresentor)

function DivineTianShanClgExtremeViewPresentor:ctor()
	DivineTianShanClgExtremeViewPresentor.super.ctor(self)
end

function DivineTianShanClgExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTianShanClgExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetianshanclg/divinetianshanclgextremeview.prefab"
	}
end

function DivineTianShanClgExtremeViewPresentor:buildViews()
	return {
		DivineTianShanClgExtremeView.New()
	}
end

return DivineTianShanClgExtremeViewPresentor
