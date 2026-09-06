-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeRankMainViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeRankMainViewPresentor", package.seeall)

local LuyngardeRankMainViewPresentor = class("LuyngardeRankMainViewPresentor", ViewPresentor)

function LuyngardeRankMainViewPresentor:ctor()
	LuyngardeRankMainViewPresentor.super.ctor(self)
end

function LuyngardeRankMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeRankMainViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngarderankmainview.prefab"
	}
end

function LuyngardeRankMainViewPresentor:buildViews()
	return {
		LuyngardeRankMainView.New()
	}
end

return LuyngardeRankMainViewPresentor
