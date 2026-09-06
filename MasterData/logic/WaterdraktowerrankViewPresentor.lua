-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WaterdraktowerrankViewPresentor.lua

module("logic.extensions.waterdraktower.view.WaterdraktowerrankViewPresentor", package.seeall)

local WaterdraktowerrankViewPresentor = class("WaterdraktowerrankViewPresentor", ViewPresentor)

function WaterdraktowerrankViewPresentor:ctor()
	WaterdraktowerrankViewPresentor.super.ctor(self)
end

function WaterdraktowerrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WaterdraktowerrankViewPresentor:dependWhatResources()
	return {
		"ui/views/waterdraktower/waterdraktowerrankview.prefab"
	}
end

function WaterdraktowerrankViewPresentor:buildViews()
	return {
		WaterdraktowerrankView.New()
	}
end

return WaterdraktowerrankViewPresentor
