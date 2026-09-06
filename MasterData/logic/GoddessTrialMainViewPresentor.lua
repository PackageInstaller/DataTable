-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialMainViewPresentor.lua

module("logic.extensions.goddesstrial.view.GoddessTrialMainViewPresentor", package.seeall)

local GoddessTrialMainViewPresentor = class("GoddessTrialMainViewPresentor", ViewPresentor)

function GoddessTrialMainViewPresentor:ctor()
	GoddessTrialMainViewPresentor.super.ctor(self)
end

function GoddessTrialMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessTrialMainViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesstrial/goddesstrialmainview.prefab"
	}
end

function GoddessTrialMainViewPresentor:buildViews()
	return {
		GoddessTrialMainView.New()
	}
end

return GoddessTrialMainViewPresentor
