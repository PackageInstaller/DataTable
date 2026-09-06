-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emperorsubdue/view/EmperorSubdueRankViewPresentor.lua

module("logic.extensions.emperorsubdue.view.EmperorSubdueRankViewPresentor", package.seeall)

local EmperorSubdueRankViewPresentor = class("EmperorSubdueRankViewPresentor", ViewPresentor)

function EmperorSubdueRankViewPresentor:ctor()
	EmperorSubdueRankViewPresentor.super.ctor(self)
end

function EmperorSubdueRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EmperorSubdueRankViewPresentor:dependWhatResources()
	return {
		"ui/views/emperorsubdue/emperorsubduerankview.prefab"
	}
end

function EmperorSubdueRankViewPresentor:buildViews()
	return {
		EmperorSubdueRankView.New()
	}
end

return EmperorSubdueRankViewPresentor
