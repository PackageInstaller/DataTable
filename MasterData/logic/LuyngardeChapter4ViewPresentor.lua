-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeChapter4ViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeChapter4ViewPresentor", package.seeall)

local LuyngardeChapter4ViewPresentor = class("LuyngardeChapter4ViewPresentor", ViewPresentor)

function LuyngardeChapter4ViewPresentor:ctor()
	LuyngardeChapter4ViewPresentor.super.ctor(self)
end

function LuyngardeChapter4ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeChapter4ViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardechapter4view.prefab"
	}
end

function LuyngardeChapter4ViewPresentor:buildViews()
	return {
		LuyngardeChapter4View.New()
	}
end

return LuyngardeChapter4ViewPresentor
