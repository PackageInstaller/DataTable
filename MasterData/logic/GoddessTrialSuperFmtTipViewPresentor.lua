-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialSuperFmtTipViewPresentor.lua

module("logic.extensions.goddesstrial.view.GoddessTrialSuperFmtTipViewPresentor", package.seeall)

local GoddessTrialSuperFmtTipViewPresentor = class("GoddessTrialSuperFmtTipViewPresentor", ViewPresentor)

function GoddessTrialSuperFmtTipViewPresentor:ctor()
	GoddessTrialSuperFmtTipViewPresentor.super.ctor(self)
end

function GoddessTrialSuperFmtTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessTrialSuperFmtTipViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesstrial/goddesstrialsuperfmttipview.prefab"
	}
end

function GoddessTrialSuperFmtTipViewPresentor:buildViews()
	return {
		GoddessTrialSuperFmtTipView.New()
	}
end

return GoddessTrialSuperFmtTipViewPresentor
