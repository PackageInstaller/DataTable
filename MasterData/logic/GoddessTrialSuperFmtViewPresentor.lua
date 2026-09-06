-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialSuperFmtViewPresentor.lua

module("logic.extensions.goddesstrial.view.GoddessTrialSuperFmtViewPresentor", package.seeall)

local GoddessTrialSuperFmtViewPresentor = class("GoddessTrialSuperFmtViewPresentor", ViewPresentor)

function GoddessTrialSuperFmtViewPresentor:ctor()
	GoddessTrialSuperFmtViewPresentor.super.ctor(self)
end

function GoddessTrialSuperFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessTrialSuperFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesstrial/goddesstrialsuperfmtview.prefab"
	}
end

function GoddessTrialSuperFmtViewPresentor:buildViews()
	return {
		GoddessTrialSuperFmtView.New()
	}
end

function GoddessTrialSuperFmtViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessTrialSuperFmtViewPresentor
