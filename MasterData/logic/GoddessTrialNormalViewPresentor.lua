-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialNormalViewPresentor.lua

module("logic.extensions.goddesstrial.view.GoddessTrialNormalViewPresentor", package.seeall)

local GoddessTrialNormalViewPresentor = class("GoddessTrialNormalViewPresentor", ViewPresentor)

function GoddessTrialNormalViewPresentor:ctor()
	GoddessTrialNormalViewPresentor.super.ctor(self)
end

function GoddessTrialNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessTrialNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesstrial/goddesstrialnormalview.prefab"
	}
end

function GoddessTrialNormalViewPresentor:buildViews()
	return {
		GoddessTrialNormalView.New()
	}
end

return GoddessTrialNormalViewPresentor
