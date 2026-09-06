-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazypartnersqViewPresentor.lua

module("logic.extensions.crazypartner.view.CrazypartnersqViewPresentor", package.seeall)

local CrazypartnersqViewPresentor = class("CrazypartnersqViewPresentor", ViewPresentor)

function CrazypartnersqViewPresentor:ctor()
	CrazypartnersqViewPresentor.super.ctor(self)
end

function CrazypartnersqViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CrazypartnersqViewPresentor:dependWhatResources()
	return {
		"ui/views/crazypartner/crazypartnersqview.prefab"
	}
end

function CrazypartnersqViewPresentor:buildViews()
	return {
		CrazyPartnerExtensionView.New()
	}
end

return CrazypartnersqViewPresentor
