-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeRankViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeRankViewPresentor", package.seeall)

local LuyngardeRankViewPresentor = class("LuyngardeRankViewPresentor", ViewPresentor)

function LuyngardeRankViewPresentor:ctor()
	LuyngardeRankViewPresentor.super.ctor(self)
end

function LuyngardeRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeRankViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngarderankview.prefab"
	}
end

function LuyngardeRankViewPresentor:buildViews()
	return {
		LuyngardeRankView.New()
	}
end

return LuyngardeRankViewPresentor
