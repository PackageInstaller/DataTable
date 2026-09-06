-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeResultViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeResultViewPresentor", package.seeall)

local LuyngardeResultViewPresentor = class("LuyngardeResultViewPresentor", ViewPresentor)

function LuyngardeResultViewPresentor:ctor()
	LuyngardeResultViewPresentor.super.ctor(self)
end

function LuyngardeResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeResultViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngarderesultview.prefab"
	}
end

function LuyngardeResultViewPresentor:buildViews()
	return {
		LuyngardeResultView.New()
	}
end

return LuyngardeResultViewPresentor
