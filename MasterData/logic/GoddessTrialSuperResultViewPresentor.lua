-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialSuperResultViewPresentor.lua

module("logic.extensions.goddesstrial.view.GoddessTrialSuperResultViewPresentor", package.seeall)

local GoddessTrialSuperResultViewPresentor = class("GoddessTrialSuperResultViewPresentor", ViewPresentor)

function GoddessTrialSuperResultViewPresentor:ctor()
	GoddessTrialSuperResultViewPresentor.super.ctor(self)
end

function GoddessTrialSuperResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessTrialSuperResultViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesstrial/goddesstrialsuperresultview.prefab"
	}
end

function GoddessTrialSuperResultViewPresentor:buildViews()
	return {
		GoddessTrialSuperResultView.New()
	}
end

return GoddessTrialSuperResultViewPresentor
