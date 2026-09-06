-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/NewHandTargetViewPresentor.lua

module("logic.extensions.sevendays.view.NewHandTargetViewPresentor", package.seeall)

local NewHandTargetViewPresentor = class("NewHandTargetViewPresentor", ViewPresentor)

function NewHandTargetViewPresentor:ctor()
	NewHandTargetViewPresentor.super.ctor(self)
end

function NewHandTargetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewHandTargetViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandtargetview.prefab"
	}
end

function NewHandTargetViewPresentor:buildViews()
	return {
		NewHandTargetView.New()
	}
end

return NewHandTargetViewPresentor
