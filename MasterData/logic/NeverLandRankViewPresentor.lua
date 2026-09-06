-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/view/NeverLandRankViewPresentor.lua

module("logic.extensions.neverland.view.NeverLandRankViewPresentor", package.seeall)

local NeverLandRankViewPresentor = class("NeverLandRankViewPresentor", ViewPresentor)

function NeverLandRankViewPresentor:ctor()
	NeverLandRankViewPresentor.super.ctor(self)
end

function NeverLandRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NeverLandRankViewPresentor:dependWhatResources()
	return {
		"ui/views/neverland/neverlandrankview.prefab"
	}
end

function NeverLandRankViewPresentor:buildViews()
	return {
		NeverLandRankView.New()
	}
end

return NeverLandRankViewPresentor
