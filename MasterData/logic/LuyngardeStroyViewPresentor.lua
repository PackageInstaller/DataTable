-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeStroyViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeStroyViewPresentor", package.seeall)

local LuyngardeStroyViewPresentor = class("LuyngardeStroyViewPresentor", ViewPresentor)

function LuyngardeStroyViewPresentor:ctor()
	LuyngardeStroyViewPresentor.super.ctor(self)
end

function LuyngardeStroyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeStroyViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardestroyview.prefab"
	}
end

function LuyngardeStroyViewPresentor:buildViews()
	return {
		LuyngardeStroyView.New()
	}
end

return LuyngardeStroyViewPresentor
