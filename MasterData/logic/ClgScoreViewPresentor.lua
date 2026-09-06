-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/challengescoreview/ClgScoreViewPresentor.lua

module("logic.extensions.challenge.view.challengescoreview.ClgScoreViewPresentor", package.seeall)

local ClgScoreViewPresentor = class("ClgScoreViewPresentor", ViewPresentor)

function ClgScoreViewPresentor:ctor()
	ClgScoreViewPresentor.super.ctor(self)
end

function ClgScoreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ClgScoreViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/score/clgscoreview.prefab"
	}
end

function ClgScoreViewPresentor:buildViews()
	local views = {}
	local view = ClgScoreView.New()

	table.insert(views, view)

	return views
end

return ClgScoreViewPresentor
