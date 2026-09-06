-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/heavenswakensummon/HeavenAwakenSummonPopViewPresentor.lua

module("logic.extensions.formation.view.heavenswakensummon.HeavenAwakenSummonPopViewPresentor", package.seeall)

local HeavenAwakenSummonPopViewPresentor = class("HeavenAwakenSummonPopViewPresentor", ViewWithGuidePresentor)

function HeavenAwakenSummonPopViewPresentor:ctor()
	HeavenAwakenSummonPopViewPresentor.super.ctor(self)
end

function HeavenAwakenSummonPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HeavenAwakenSummonPopViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/heavenawakensummonpopview.prefab"
	}
end

function HeavenAwakenSummonPopViewPresentor:buildViews()
	return {
		HeavenAwakenSummonPopView.New()
	}
end

return HeavenAwakenSummonPopViewPresentor
