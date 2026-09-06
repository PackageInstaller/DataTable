-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardePrizeViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardePrizeViewPresentor", package.seeall)

local LuyngardePrizeViewPresentor = class("LuyngardePrizeViewPresentor", ViewPresentor)

function LuyngardePrizeViewPresentor:ctor()
	LuyngardePrizeViewPresentor.super.ctor(self)
end

function LuyngardePrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardePrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardeprizeview.prefab"
	}
end

function LuyngardePrizeViewPresentor:buildViews()
	return {
		LuyngardePrizeView.New()
	}
end

function LuyngardePrizeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return LuyngardePrizeViewPresentor
