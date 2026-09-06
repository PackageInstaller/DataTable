-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialBossViewPresentor.lua

module("logic.extensions.goddesstrial.view.GoddessTrialBossViewPresentor", package.seeall)

local GoddessTrialBossViewPresentor = class("GoddessTrialBossViewPresentor", ViewPresentor)

function GoddessTrialBossViewPresentor:ctor()
	GoddessTrialBossViewPresentor.super.ctor(self)
end

function GoddessTrialBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessTrialBossViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesstrial/goddesstrialbossview.prefab"
	}
end

function GoddessTrialBossViewPresentor:buildViews()
	return {
		GoddessTrialBossView.New()
	}
end

return GoddessTrialBossViewPresentor
