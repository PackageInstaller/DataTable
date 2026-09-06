-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgLevelViewPresentor.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgLevelViewPresentor", package.seeall)

local DivinexjClgLevelViewPresentor = class("DivinexjClgLevelViewPresentor", ViewPresentor)

function DivinexjClgLevelViewPresentor:ctor()
	DivinexjClgLevelViewPresentor.super.ctor(self)
end

function DivinexjClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexjClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexingjiangclg/divinexjclglevelview.prefab"
	}
end

function DivinexjClgLevelViewPresentor:buildViews()
	return {
		DivinexjClgLevelView.New()
	}
end

return DivinexjClgLevelViewPresentor
