-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/view/TwinDragonChallengeEnterViewPresentor.lua

module("logic.extensions.twindragonchallenge.view.TwinDragonChallengeEnterViewPresentor", package.seeall)

local TwinDragonChallengeEnterViewPresentor = class("TwinDragonChallengeEnterViewPresentor", ViewPresentor)

function TwinDragonChallengeEnterViewPresentor:ctor()
	TwinDragonChallengeEnterViewPresentor.super.ctor(self)
end

function TwinDragonChallengeEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TwinDragonChallengeEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/tongbattle/tongruleview.prefab"
	}
end

function TwinDragonChallengeEnterViewPresentor:buildViews()
	return {
		TwinDragonChallengeEnterView.New()
	}
end

return TwinDragonChallengeEnterViewPresentor
