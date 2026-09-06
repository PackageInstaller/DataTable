-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FmtUnlockViewPresentor.lua

module("logic.extensions.formation.view.FmtUnlockViewPresentor", package.seeall)

local FmtUnlockViewPresentor = class("FmtUnlockViewPresentor", ViewPresentor)

function FmtUnlockViewPresentor:ctor()
	FmtUnlockViewPresentor.super.ctor(self)
end

function FmtUnlockViewPresentor:attachToWhichRoot()
	return ViewRootType.NotifyTop
end

function FmtUnlockViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/fmtunlockview.prefab"
	}
end

function FmtUnlockViewPresentor:buildViews()
	return {
		FmtUnlockView.New()
	}
end

return FmtUnlockViewPresentor
