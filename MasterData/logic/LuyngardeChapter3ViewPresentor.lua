-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeChapter3ViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeChapter3ViewPresentor", package.seeall)

local LuyngardeChapter3ViewPresentor = class("LuyngardeChapter3ViewPresentor", ViewPresentor)

function LuyngardeChapter3ViewPresentor:ctor()
	LuyngardeChapter3ViewPresentor.super.ctor(self)
end

function LuyngardeChapter3ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeChapter3ViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardechapter3view.prefab"
	}
end

function LuyngardeChapter3ViewPresentor:buildViews()
	return {
		LuyngardeChapter3View.New()
	}
end

return LuyngardeChapter3ViewPresentor
