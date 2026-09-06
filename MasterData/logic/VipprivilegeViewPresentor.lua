-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/view/VipprivilegeViewPresentor.lua

module("logic.extensions.vip.view.VipprivilegeViewPresentor", package.seeall)

local VipprivilegeViewPresentor = class("VipprivilegeViewPresentor", ViewPresentor)

function VipprivilegeViewPresentor:ctor()
	VipprivilegeViewPresentor.super.ctor(self)
end

function VipprivilegeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VipprivilegeViewPresentor:dependWhatResources()
	return {
		"ui/views/vip/vipprivilegeview.prefab"
	}
end

function VipprivilegeViewPresentor:buildViews()
	return {
		VipprivilegeView.New()
	}
end

return VipprivilegeViewPresentor
