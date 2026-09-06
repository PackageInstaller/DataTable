-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialPrizeViewPresentor.lua

module("logic.extensions.goddesstrial.view.GoddessTrialPrizeViewPresentor", package.seeall)

local GoddessTrialPrizeViewPresentor = class("GoddessTrialPrizeViewPresentor", ViewPresentor)

function GoddessTrialPrizeViewPresentor:ctor()
	GoddessTrialPrizeViewPresentor.super.ctor(self)
end

function GoddessTrialPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessTrialPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesstrial/goddesstrialprizeview.prefab"
	}
end

function GoddessTrialPrizeViewPresentor:buildViews()
	return {
		GoddessTrialPrizeView.New()
	}
end

return GoddessTrialPrizeViewPresentor
