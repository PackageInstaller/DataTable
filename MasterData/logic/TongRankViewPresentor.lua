-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/TongRankViewPresentor.lua

module("logic.extensions.tongbattle.view.TongRankViewPresentor", package.seeall)

local TongRankViewPresentor = class("TongRankViewPresentor", ViewWithGuidePresentor)

function TongRankViewPresentor:ctor()
	TongRankViewPresentor.super.ctor(self)
end

function TongRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongRankViewPresentor:dependWhatResources()
	return {
		"ui/views/tongbattle/tongrankview.prefab"
	}
end

function TongRankViewPresentor:buildViews()
	return {
		TongRankView.New()
	}
end

return TongRankViewPresentor
