-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/view/RecallInviteViewPresentor.lua

module("logic.extensions.recalltask.view.RecallInviteViewPresentor", package.seeall)

local RecallInviteViewPresentor = class("RecallInviteViewPresentor", ViewPresentor)

function RecallInviteViewPresentor:ctor()
	RecallInviteViewPresentor.super.ctor(self)
end

function RecallInviteViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RecallInviteViewPresentor:dependWhatResources()
	return {
		"ui/views/recalltask/recallinviteview.prefab"
	}
end

function RecallInviteViewPresentor:buildViews()
	return {
		RecallInviteView.New()
	}
end

return RecallInviteViewPresentor
