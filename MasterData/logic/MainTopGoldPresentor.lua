-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainTopGoldPresentor.lua

module("logic.extensions.mainui.view.MainTopGoldPresentor", package.seeall)

local MainTopGoldPresentor = class("MainTopGoldPresentor", ViewPresentor)

function MainTopGoldPresentor:ctor()
	MainTopGoldPresentor.super.ctor(self)
end

function MainTopGoldPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MainTopGoldPresentor:dependWhatResources()
	return {
		"ui/views/mainui/maintopgoldview.prefab"
	}
end

function MainTopGoldPresentor:buildViews()
	return {
		MainTopGoldView.New()
	}
end

function MainTopGoldPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MainTopGoldPresentor
