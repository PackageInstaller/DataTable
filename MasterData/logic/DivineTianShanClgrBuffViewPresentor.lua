-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShanClgrBuffViewPresentor.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShanClgrBuffViewPresentor", package.seeall)

local DivineTianShanClgrBuffViewPresentor = class("DivineTianShanClgrBuffViewPresentor", ViewPresentor)

function DivineTianShanClgrBuffViewPresentor:ctor()
	DivineTianShanClgrBuffViewPresentor.super.ctor(self)
end

function DivineTianShanClgrBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTianShanClgrBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetianshanclg/divinetianshanclgrbuffview.prefab"
	}
end

function DivineTianShanClgrBuffViewPresentor:buildViews()
	return {
		DivineTianShanClgrBuffView.New()
	}
end

return DivineTianShanClgrBuffViewPresentor
