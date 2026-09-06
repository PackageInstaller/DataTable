-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/view/VipgiftViewPresentor.lua

module("logic.extensions.vip.view.VipgiftViewPresentor", package.seeall)

local VipgiftViewPresentor = class("VipgiftViewPresentor", ViewPresentor)

function VipgiftViewPresentor:ctor()
	VipgiftViewPresentor.super.ctor(self)
end

function VipgiftViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VipgiftViewPresentor:dependWhatResources()
	return {
		"ui/views/vip/vipgiftview.prefab"
	}
end

function VipgiftViewPresentor:buildViews()
	return {
		VipgiftView.New()
	}
end

return VipgiftViewPresentor
