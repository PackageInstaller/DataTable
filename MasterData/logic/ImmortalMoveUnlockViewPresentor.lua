-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/view/ImmortalMoveUnlockViewPresentor.lua

module("logic.extensions.immortalmovement.view.ImmortalMoveUnlockViewPresentor", package.seeall)

local ImmortalMoveUnlockViewPresentor = class("ImmortalMoveUnlockViewPresentor", ViewPresentor)

function ImmortalMoveUnlockViewPresentor:ctor()
	ImmortalMoveUnlockViewPresentor.super.ctor(self)
end

function ImmortalMoveUnlockViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ImmortalMoveUnlockViewPresentor:dependWhatResources()
	return {
		"ui/views/immortalmovement/immortalmoveunlockview.prefab"
	}
end

function ImmortalMoveUnlockViewPresentor:buildViews()
	return {
		ImmortalMoveUnlockView.New()
	}
end

return ImmortalMoveUnlockViewPresentor
