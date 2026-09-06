-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeChapter4ResultViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeChapter4ResultViewPresentor", package.seeall)

local LuyngardeChapter4ResultViewPresentor = class("LuyngardeChapter4ResultViewPresentor", ViewPresentor)

function LuyngardeChapter4ResultViewPresentor:ctor()
	LuyngardeChapter4ResultViewPresentor.super.ctor(self)
end

function LuyngardeChapter4ResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeChapter4ResultViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardechapter4resultview.prefab"
	}
end

function LuyngardeChapter4ResultViewPresentor:buildViews()
	return {
		LuyngardeChapter4ResultView.New()
	}
end

return LuyngardeChapter4ResultViewPresentor
