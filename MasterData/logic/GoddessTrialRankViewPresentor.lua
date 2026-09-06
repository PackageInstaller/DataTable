-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialRankViewPresentor.lua

module("logic.extensions.goddesstrial.view.GoddessTrialRankViewPresentor", package.seeall)

local GoddessTrialRankViewPresentor = class("GoddessTrialRankViewPresentor", ViewPresentor)

function GoddessTrialRankViewPresentor:ctor()
	GoddessTrialRankViewPresentor.super.ctor(self)
end

function GoddessTrialRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessTrialRankViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesstrial/goddesstrialrankview.prefab"
	}
end

function GoddessTrialRankViewPresentor:buildViews()
	return {
		GoddessTrialRankView.New()
	}
end

return GoddessTrialRankViewPresentor
