-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectorRankViewPresentor.lua

module("logic.extensions.goddesscollector.view.GoddesscollectorRankViewPresentor", package.seeall)

local GoddesscollectorRankViewPresentor = class("GoddesscollectorRankViewPresentor", ViewPresentor)

function GoddesscollectorRankViewPresentor:ctor()
	GoddesscollectorRankViewPresentor.super.ctor(self)
end

function GoddesscollectorRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddesscollectorRankViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscollector/goddesscollectorrankview.prefab"
	}
end

function GoddesscollectorRankViewPresentor:buildViews()
	return {
		GoddesscollectorRankView.New()
	}
end

return GoddesscollectorRankViewPresentor
