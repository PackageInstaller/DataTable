-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazypartnerrankViewPresentor.lua

module("logic.extensions.crazypartner.view.CrazypartnerrankViewPresentor", package.seeall)

local CrazypartnerrankViewPresentor = class("CrazypartnerrankViewPresentor", ViewPresentor)

function CrazypartnerrankViewPresentor:ctor()
	CrazypartnerrankViewPresentor.super.ctor(self)
end

function CrazypartnerrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CrazypartnerrankViewPresentor:dependWhatResources()
	return {
		"ui/views/crazypartner/crazypartnerrankview.prefab"
	}
end

function CrazypartnerrankViewPresentor:buildViews()
	return {
		CrazyPartnerRankView.New()
	}
end

return CrazypartnerrankViewPresentor
