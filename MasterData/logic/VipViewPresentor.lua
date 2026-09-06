-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/view/VipViewPresentor.lua

module("logic.extensions.vip.view.VipViewPresentor", package.seeall)

local VipViewPresentor = class("VipViewPresentor", ViewPresentor)

function VipViewPresentor:ctor()
	VipViewPresentor.super.ctor(self)
end

function VipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VipViewPresentor:dependWhatResources()
	return {
		"ui/views/vip/vipview.prefab"
	}
end

function VipViewPresentor:buildViews()
	return {
		VipView.New()
	}
end

return VipViewPresentor
