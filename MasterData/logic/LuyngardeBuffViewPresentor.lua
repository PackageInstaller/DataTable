-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeBuffViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeBuffViewPresentor", package.seeall)

local LuyngardeBuffViewPresentor = class("LuyngardeBuffViewPresentor", ViewPresentor)

function LuyngardeBuffViewPresentor:ctor()
	LuyngardeBuffViewPresentor.super.ctor(self)
end

function LuyngardeBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardebuffview.prefab"
	}
end

function LuyngardeBuffViewPresentor:buildViews()
	return {
		LuyngardeBuffView.New()
	}
end

return LuyngardeBuffViewPresentor
