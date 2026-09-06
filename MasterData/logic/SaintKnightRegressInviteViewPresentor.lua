-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/view/SaintKnightRegressInviteViewPresentor.lua

module("logic.extensions.saintknightregress.view.SaintKnightRegressInviteViewPresentor", package.seeall)

local SaintKnightRegressInviteViewPresentor = class("SaintKnightRegressInviteViewPresentor", ViewPresentor)

function SaintKnightRegressInviteViewPresentor:ctor()
	SaintKnightRegressInviteViewPresentor.super.ctor(self)
end

function SaintKnightRegressInviteViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SaintKnightRegressInviteViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightregress/saintknightregressinviteview.prefab"
	}
end

function SaintKnightRegressInviteViewPresentor:buildViews()
	return {
		SaintKnightRegressInviteView.New()
	}
end

return SaintKnightRegressInviteViewPresentor
