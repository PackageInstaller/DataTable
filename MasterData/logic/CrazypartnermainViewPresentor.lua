-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazypartnermainViewPresentor.lua

module("logic.extensions.crazypartner.view.CrazypartnermainViewPresentor", package.seeall)

local CrazypartnermainViewPresentor = class("CrazypartnermainViewPresentor", ViewPresentor)

function CrazypartnermainViewPresentor:ctor()
	CrazypartnermainViewPresentor.super.ctor(self)
end

function CrazypartnermainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CrazypartnermainViewPresentor:dependWhatResources()
	return {
		"ui/views/crazypartner/crazypartnermainview.prefab"
	}
end

function CrazypartnermainViewPresentor:buildViews()
	return {
		CrazyPartnerMainView.New()
	}
end

return CrazypartnermainViewPresentor
