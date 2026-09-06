-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeHudViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeHudViewPresentor", package.seeall)

local LuyngardeHudViewPresentor = class("LuyngardeHudViewPresentor", ViewPresentor)

function LuyngardeHudViewPresentor:ctor()
	LuyngardeHudViewPresentor.super.ctor(self)
end

function LuyngardeHudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeHudViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/luyngardehudview.prefab"
	}
end

function LuyngardeHudViewPresentor:buildViews()
	return {
		LuyngardeHudView.New()
	}
end

return LuyngardeHudViewPresentor
