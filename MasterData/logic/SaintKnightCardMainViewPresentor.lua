-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightcard/view/SaintKnightCardMainViewPresentor.lua

module("logic.extensions.saintknightcard.view.SaintKnightCardMainViewPresentor", package.seeall)

local SaintKnightCardMainViewPresentor = class("SaintKnightCardMainViewPresentor", ViewPresentor)

function SaintKnightCardMainViewPresentor:ctor()
	SaintKnightCardMainViewPresentor.super.ctor(self)
end

function SaintKnightCardMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintKnightCardMainViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightcard/saintknightcardmainview.prefab"
	}
end

function SaintKnightCardMainViewPresentor:buildViews()
	return {
		SaintKnightCardMainView.New()
	}
end

function SaintKnightCardMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SaintKnightCardMainViewPresentor
