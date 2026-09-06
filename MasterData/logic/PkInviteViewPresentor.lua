-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkInviteViewPresentor.lua

module("logic.extensions.pk.view.PkInviteViewPresentor", package.seeall)

local PkInviteViewPresentor = class("PkInviteViewPresentor", ViewPresentor)

function PkInviteViewPresentor:ctor()
	PkInviteViewPresentor.super.ctor(self)
end

function PkInviteViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PkInviteViewPresentor:dependWhatResources()
	return {
		"ui/views/pk/pkinviteview.prefab"
	}
end

function PkInviteViewPresentor:buildViews()
	return {
		PkInviteView.New()
	}
end

return PkInviteViewPresentor
