-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/PreferentialViewPresentor.lua

module("logic.extensions.bonus.view.PreferentialViewPresentor", package.seeall)

local PreferentialViewPresentor = class("PreferentialViewPresentor", ViewPresentor)

function PreferentialViewPresentor:ctor()
	PreferentialViewPresentor.super.ctor(self)
end

function PreferentialViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PreferentialViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/preferentialview.prefab"
	}
end

function PreferentialViewPresentor:buildViews()
	return {
		PreferentialView.New()
	}
end

function PreferentialViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PreferentialViewPresentor
