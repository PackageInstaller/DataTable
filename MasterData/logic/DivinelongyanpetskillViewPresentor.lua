-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/view/DivinelongyanpetskillViewPresentor.lua

module("logic.extensions.divinelongyan.view.DivinelongyanpetskillViewPresentor", package.seeall)

local DivinelongyanpetskillViewPresentor = class("DivinelongyanpetskillViewPresentor", ViewPresentor)

function DivinelongyanpetskillViewPresentor:ctor()
	DivinelongyanpetskillViewPresentor.super.ctor(self)
end

function DivinelongyanpetskillViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinelongyanpetskillViewPresentor:dependWhatResources()
	return {
		"ui/views/divinelongyan/divinelongyanpetskillview.prefab"
	}
end

function DivinelongyanpetskillViewPresentor:buildViews()
	return {
		DivinelongyanpetskillView.New()
	}
end

function DivinelongyanpetskillViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DivinelongyanpetskillViewPresentor
