-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/view/ViprecordViewPresentor.lua

module("logic.extensions.vip.view.ViprecordViewPresentor", package.seeall)

local ViprecordViewPresentor = class("ViprecordViewPresentor", ViewPresentor)

function ViprecordViewPresentor:ctor()
	ViprecordViewPresentor.super.ctor(self)
end

function ViprecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ViprecordViewPresentor:dependWhatResources()
	return {
		"ui/views/vip/viprecordview.prefab"
	}
end

function ViprecordViewPresentor:buildViews()
	return {
		ViprecordView.New()
	}
end

return ViprecordViewPresentor
