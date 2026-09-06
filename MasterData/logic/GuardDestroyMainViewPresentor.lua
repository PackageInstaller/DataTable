-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/view/GuardDestroyMainViewPresentor.lua

module("logic.extensions.guarddestroy.view.GuardDestroyMainViewPresentor", package.seeall)

local GuardDestroyMainViewPresentor = class("GuardDestroyMainViewPresentor", ViewPresentor)

function GuardDestroyMainViewPresentor:ctor()
	GuardDestroyMainViewPresentor.super.ctor(self)
end

function GuardDestroyMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardDestroyMainViewPresentor:dependWhatResources()
	return {
		"ui/views/guarddestroy/guarddestroymainview.prefab"
	}
end

function GuardDestroyMainViewPresentor:buildViews()
	return {
		GuardDestroyMainView.New()
	}
end

return GuardDestroyMainViewPresentor
