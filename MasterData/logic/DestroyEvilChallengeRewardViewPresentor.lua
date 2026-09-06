-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilChallengeRewardViewPresentor.lua

module("logic.extensions.destroyevil.view.DestroyEvilChallengeRewardViewPresentor", package.seeall)

local DestroyEvilChallengeRewardViewPresentor = class("DestroyEvilChallengeRewardViewPresentor", ViewPresentor)

function DestroyEvilChallengeRewardViewPresentor:ctor()
	DestroyEvilChallengeRewardViewPresentor.super.ctor(self)
end

function DestroyEvilChallengeRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DestroyEvilChallengeRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/destroyevil/destroyevilchallengerewardview.prefab"
	}
end

function DestroyEvilChallengeRewardViewPresentor:buildViews()
	return {
		DestroyEvilChallengeRewardView.New()
	}
end

return DestroyEvilChallengeRewardViewPresentor
