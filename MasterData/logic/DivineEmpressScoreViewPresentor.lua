-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressScoreViewPresentor.lua

module("logic.extensions.divineempress.view.DivineEmpressScoreViewPresentor", package.seeall)

local DivineEmpressScoreViewPresentor = class("DivineEmpressScoreViewPresentor", ViewPresentor)

function DivineEmpressScoreViewPresentor:ctor()
	DivineEmpressScoreViewPresentor.super.ctor(self)
end

function DivineEmpressScoreViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineEmpressScoreViewPresentor:dependWhatResources()
	return {
		"ui/views/divineempress/divineempressscoreview.prefab"
	}
end

function DivineEmpressScoreViewPresentor:buildViews()
	return {
		DivineEmpressScoreView.New()
	}
end

return DivineEmpressScoreViewPresentor
