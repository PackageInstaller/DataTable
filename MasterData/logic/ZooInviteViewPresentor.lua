-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooInviteViewPresentor.lua

module("logic.extensions.pk.view.ZooInviteViewPresentor", package.seeall)

local ZooInviteViewPresentor = class("ZooInviteViewPresentor", ViewPresentor)

function ZooInviteViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooInviteViewPresentor:dependWhatResources()
	return {
		"ui/views/pk/pkinviteview.prefab"
	}
end

function ZooInviteViewPresentor:buildViews()
	return {
		ZooInviteView.New()
	}
end

return ZooInviteViewPresentor
