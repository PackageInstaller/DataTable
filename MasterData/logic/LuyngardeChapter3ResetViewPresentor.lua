-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeChapter3ResetViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeChapter3ResetViewPresentor", package.seeall)

local LuyngardeChapter3ResetViewPresentor = class("LuyngardeChapter3ResetViewPresentor", ViewPresentor)

function LuyngardeChapter3ResetViewPresentor:ctor()
	LuyngardeChapter3ResetViewPresentor.super.ctor(self)
end

function LuyngardeChapter3ResetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeChapter3ResetViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardechapter3resetview.prefab"
	}
end

function LuyngardeChapter3ResetViewPresentor:buildViews()
	return {
		LuyngardeChapter3ResetView.New()
	}
end

return LuyngardeChapter3ResetViewPresentor
