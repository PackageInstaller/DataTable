-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeHelpCfgResultViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeHelpCfgResultViewPresentor", package.seeall)

local LuyngardeHelpCfgResultViewPresentor = class("LuyngardeHelpCfgResultViewPresentor", ViewPresentor)

function LuyngardeHelpCfgResultViewPresentor:ctor()
	LuyngardeHelpCfgResultViewPresentor.super.ctor(self)
end

function LuyngardeHelpCfgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeHelpCfgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardehelpcfgresultview.prefab"
	}
end

function LuyngardeHelpCfgResultViewPresentor:buildViews()
	return {
		LuyngardeHelpCfgResultView.New()
	}
end

return LuyngardeHelpCfgResultViewPresentor
