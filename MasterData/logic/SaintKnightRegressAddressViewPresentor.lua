-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/view/SaintKnightRegressAddressViewPresentor.lua

module("logic.extensions.saintknightregress.view.SaintKnightRegressAddressViewPresentor", package.seeall)

local SaintKnightRegressAddressViewPresentor = class("SaintKnightRegressAddressViewPresentor", ViewPresentor)

function SaintKnightRegressAddressViewPresentor:ctor()
	SaintKnightRegressAddressViewPresentor.super.ctor(self)
end

function SaintKnightRegressAddressViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SaintKnightRegressAddressViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightregress/saintknightregressaddressview.prefab"
	}
end

function SaintKnightRegressAddressViewPresentor:buildViews()
	return {
		SaintKnightRegressAddressView.New()
	}
end

return SaintKnightRegressAddressViewPresentor
