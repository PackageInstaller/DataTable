-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/view/ViplvViewPresentor.lua

module("logic.extensions.vip.view.ViplvViewPresentor", package.seeall)

local ViplvViewPresentor = class("ViplvViewPresentor", ViewPresentor)

function ViplvViewPresentor:ctor()
	ViplvViewPresentor.super.ctor(self)
end

function ViplvViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ViplvViewPresentor:dependWhatResources()
	return {
		"ui/views/vip/viplvview.prefab"
	}
end

function ViplvViewPresentor:buildViews()
	return {
		ViplvView.New()
	}
end

function ViplvViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ViplvViewPresentor
