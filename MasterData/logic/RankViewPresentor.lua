-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/RankViewPresentor.lua

module("logic.extensions.rank.view.RankViewPresentor", package.seeall)

local RankViewPresentor = class("RankViewPresentor", ViewPresentor)

function RankViewPresentor:ctor()
	RankViewPresentor.super.ctor(self)
end

function RankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankViewPresentor:dependWhatResources()
	return {
		"ui/views/rank/rankview.prefab"
	}
end

function RankViewPresentor:buildViews()
	return {
		RankView.New()
	}
end

return RankViewPresentor
