-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShanNormalResultViewPresentor.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShanNormalResultViewPresentor", package.seeall)

local DivineTianShanNormalResultViewPresentor = class("DivineTianShanNormalResultViewPresentor", ViewPresentor)

function DivineTianShanNormalResultViewPresentor:ctor()
	DivineTianShanNormalResultViewPresentor.super.ctor(self)
end

function DivineTianShanNormalResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTianShanNormalResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetianshanclg/divinetianshannormalresultview.prefab"
	}
end

function DivineTianShanNormalResultViewPresentor:buildViews()
	return {
		DivineTianShanNormalResultView.New()
	}
end

return DivineTianShanNormalResultViewPresentor
