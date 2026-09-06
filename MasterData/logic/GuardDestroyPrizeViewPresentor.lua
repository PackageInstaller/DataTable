-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/view/GuardDestroyPrizeViewPresentor.lua

module("logic.extensions.guarddestroy.view.GuardDestroyPrizeViewPresentor", package.seeall)

local GuardDestroyPrizeViewPresentor = class("GuardDestroyPrizeViewPresentor", ViewPresentor)

function GuardDestroyPrizeViewPresentor:ctor()
	GuardDestroyPrizeViewPresentor.super.ctor(self)
end

function GuardDestroyPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GuardDestroyPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/guarddestroy/guarddestroyprizeview.prefab"
	}
end

function GuardDestroyPrizeViewPresentor:buildViews()
	return {
		GuardDestroyPrizeView.New()
	}
end

return GuardDestroyPrizeViewPresentor
