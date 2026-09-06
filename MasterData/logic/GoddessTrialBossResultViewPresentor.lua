-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialBossResultViewPresentor.lua

module("logic.extensions.goddesstrial.view.GoddessTrialBossResultViewPresentor", package.seeall)

local GoddessTrialBossResultViewPresentor = class("GoddessTrialBossResultViewPresentor", ViewPresentor)

function GoddessTrialBossResultViewPresentor:ctor()
	GoddessTrialBossResultViewPresentor.super.ctor(self)
end

function GoddessTrialBossResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessTrialBossResultViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesstrial/goddesstrialbossresultview.prefab"
	}
end

function GoddessTrialBossResultViewPresentor:buildViews()
	return {
		GoddessTrialBossResultView.New()
	}
end

return GoddessTrialBossResultViewPresentor
