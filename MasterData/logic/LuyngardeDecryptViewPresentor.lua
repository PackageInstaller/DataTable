-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeDecryptViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeDecryptViewPresentor", package.seeall)

local LuyngardeDecryptViewPresentor = class("LuyngardeDecryptViewPresentor", ViewPresentor)

function LuyngardeDecryptViewPresentor:ctor()
	LuyngardeDecryptViewPresentor.super.ctor(self)
end

function LuyngardeDecryptViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeDecryptViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardedecryptview.prefab"
	}
end

function LuyngardeDecryptViewPresentor:buildViews()
	return {
		LuyngardeDecryptView.New()
	}
end

return LuyngardeDecryptViewPresentor
