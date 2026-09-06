-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeChapter2ViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeChapter2ViewPresentor", package.seeall)

local LuyngardeChapter2ViewPresentor = class("LuyngardeChapter2ViewPresentor", ViewPresentor)

function LuyngardeChapter2ViewPresentor:ctor()
	LuyngardeChapter2ViewPresentor.super.ctor(self)
end

function LuyngardeChapter2ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeChapter2ViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardechapter2view.prefab"
	}
end

function LuyngardeChapter2ViewPresentor:buildViews()
	return {
		LuyngardeChapter2View.New()
	}
end

return LuyngardeChapter2ViewPresentor
