-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressExtreCardViewPresentor.lua

module("logic.extensions.divineempress.view.DivineEmpressExtreCardViewPresentor", package.seeall)

local DivineEmpressExtreCardViewPresentor = class("DivineEmpressExtreCardViewPresentor", ViewPresentor)

function DivineEmpressExtreCardViewPresentor:ctor()
	DivineEmpressExtreCardViewPresentor.super.ctor(self)
end

function DivineEmpressExtreCardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEmpressExtreCardViewPresentor:dependWhatResources()
	return {
		"ui/views/divineempress/divineempressextrecardview.prefab"
	}
end

function DivineEmpressExtreCardViewPresentor:buildViews()
	return {
		DivineEmpressExtreCardView.New()
	}
end

return DivineEmpressExtreCardViewPresentor
