-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/PozhenRewardViewPresentor.lua

module("logic.extensions.breakformation.view.PozhenRewardViewPresentor", package.seeall)

local PozhenRewardViewPresentor = class("PozhenRewardViewPresentor", ViewPresentor)

function PozhenRewardViewPresentor:ctor()
	PozhenRewardViewPresentor.super.ctor(self)
end

function PozhenRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PozhenRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/breakformation/pozhenrewardview.prefab"
	}
end

function PozhenRewardViewPresentor:buildViews()
	return {
		PozhenRewardView.New()
	}
end

return PozhenRewardViewPresentor
