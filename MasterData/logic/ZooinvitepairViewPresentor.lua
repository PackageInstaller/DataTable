-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooinvitepairViewPresentor.lua

module("logic.extensions.zoo.view.ZooinvitepairViewPresentor", package.seeall)

local ZooinvitepairViewPresentor = class("ZooinvitepairViewPresentor", ViewPresentor)

function ZooinvitepairViewPresentor:ctor()
	ZooinvitepairViewPresentor.super.ctor(self)
end

function ZooinvitepairViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooinvitepairViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zooinvitepairview.prefab"
	}
end

function ZooinvitepairViewPresentor:buildViews()
	return {
		ZooinvitepairView.New()
	}
end

return ZooinvitepairViewPresentor
