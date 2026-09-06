-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightcard/view/SaintKnightCardDrawViewPresentor.lua

module("logic.extensions.saintknightcard.view.SaintKnightCardDrawViewPresentor", package.seeall)

local SaintKnightCardDrawViewPresentor = class("SaintKnightCardDrawViewPresentor", ViewPresentor)

function SaintKnightCardDrawViewPresentor:ctor()
	SaintKnightCardDrawViewPresentor.super.ctor(self)
end

function SaintKnightCardDrawViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintKnightCardDrawViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightcard/saintknightcarddrawview.prefab"
	}
end

function SaintKnightCardDrawViewPresentor:buildViews()
	return {
		SaintKnightCardDrawView.New()
	}
end

return SaintKnightCardDrawViewPresentor
