-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pindaodao/view/PinDaoDaoInviteViewPresentor.lua

module("logic.extensions.pindaodao.view.PinDaoDaoInviteViewPresentor", package.seeall)

local PinDaoDaoInviteViewPresentor = class("PinDaoDaoInviteViewPresentor", ViewPresentor)

function PinDaoDaoInviteViewPresentor:ctor()
	PinDaoDaoInviteViewPresentor.super.ctor(self)
end

function PinDaoDaoInviteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinDaoDaoInviteViewPresentor:dependWhatResources()
	return {
		"ui/views/pindaodao/pindaodaoinviteview.prefab"
	}
end

function PinDaoDaoInviteViewPresentor:buildViews()
	return {
		PinDaoDaoInviteView.New()
	}
end

return PinDaoDaoInviteViewPresentor
