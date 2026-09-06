-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialSuperViewPresentor.lua

module("logic.extensions.goddesstrial.view.GoddessTrialSuperViewPresentor", package.seeall)

local GoddessTrialSuperViewPresentor = class("GoddessTrialSuperViewPresentor", ViewPresentor)

function GoddessTrialSuperViewPresentor:ctor()
	GoddessTrialSuperViewPresentor.super.ctor(self)
end

function GoddessTrialSuperViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessTrialSuperViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesstrial/goddesstrialsuperview.prefab"
	}
end

function GoddessTrialSuperViewPresentor:buildViews()
	return {
		GoddessTrialSuperView.New()
	}
end

return GoddessTrialSuperViewPresentor
