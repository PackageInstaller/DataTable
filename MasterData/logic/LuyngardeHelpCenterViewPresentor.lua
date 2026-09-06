-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeHelpCenterViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeHelpCenterViewPresentor", package.seeall)

local LuyngardeHelpCenterViewPresentor = class("LuyngardeHelpCenterViewPresentor", ViewPresentor)

function LuyngardeHelpCenterViewPresentor:ctor()
	LuyngardeHelpCenterViewPresentor.super.ctor(self)
end

function LuyngardeHelpCenterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeHelpCenterViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardehelpcenterview.prefab"
	}
end

function LuyngardeHelpCenterViewPresentor:buildViews()
	return {
		LuyngardeHelpCenterView.New()
	}
end

return LuyngardeHelpCenterViewPresentor
