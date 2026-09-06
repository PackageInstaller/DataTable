-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/raiders/RaidersBigViewPresentor.lua

module("logic.extensions.legend.view.raiders.RaidersBigViewPresentor", package.seeall)

local RaidersBigViewPresentor = class("RaidersBigViewPresentor", ViewPresentor)

function RaidersBigViewPresentor:ctor()
	RaidersBigViewPresentor.super.ctor(self)
end

function RaidersBigViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RaidersBigViewPresentor:dependWhatResources()
	return {
		"ui/views/legend/raidersbigview.prefab"
	}
end

function RaidersBigViewPresentor:buildViews()
	return {
		RaidersBigView.New(),
		RaidersCommonView.New()
	}
end

return RaidersBigViewPresentor
