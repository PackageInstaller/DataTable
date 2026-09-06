-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/TLChallengerankViewPresentor.lua

module("logic.extensions.rank.view.TLChallengerankViewPresentor", package.seeall)

local TLChallengerankViewPresentor = class("TLChallengerankViewPresentor", ViewPresentor)

function TLChallengerankViewPresentor:ctor()
	TLChallengerankViewPresentor.super.ctor(self)
end

function TLChallengerankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TLChallengerankViewPresentor:dependWhatResources()
	return {
		"ui/views/rank/challengerankview.prefab"
	}
end

function TLChallengerankViewPresentor:buildViews()
	return {
		TLChallengerankView.New()
	}
end

return TLChallengerankViewPresentor
