-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanselectpetViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanselectpetViewPresentor", package.seeall)

local RmxplanselectpetViewPresentor = class("RmxplanselectpetViewPresentor", ViewPresentor)

function RmxplanselectpetViewPresentor:ctor()
	RmxplanselectpetViewPresentor.super.ctor(self)
end

function RmxplanselectpetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplanselectpetViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanselectpetview.prefab"
	}
end

function RmxplanselectpetViewPresentor:buildViews()
	return {
		RmxplanselectpetView.New()
	}
end

return RmxplanselectpetViewPresentor
