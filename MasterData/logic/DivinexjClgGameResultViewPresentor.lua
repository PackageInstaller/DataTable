-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgGameResultViewPresentor.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgGameResultViewPresentor", package.seeall)

local DivinexjClgGameResultViewPresentor = class("DivinexjClgGameResultViewPresentor", ViewPresentor)

function DivinexjClgGameResultViewPresentor:ctor()
	DivinexjClgGameResultViewPresentor.super.ctor(self)
end

function DivinexjClgGameResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexjClgGameResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexingjiangclg/divinexjclggameresultview.prefab"
	}
end

function DivinexjClgGameResultViewPresentor:buildViews()
	return {
		DivinexjClgGameResultView.New()
	}
end

return DivinexjClgGameResultViewPresentor
