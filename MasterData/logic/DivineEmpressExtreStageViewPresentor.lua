-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressExtreStageViewPresentor.lua

module("logic.extensions.divineempress.view.DivineEmpressExtreStageViewPresentor", package.seeall)

local DivineEmpressExtreStageViewPresentor = class("DivineEmpressExtreStageViewPresentor", ViewPresentor)

function DivineEmpressExtreStageViewPresentor:ctor()
	DivineEmpressExtreStageViewPresentor.super.ctor(self)
end

function DivineEmpressExtreStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEmpressExtreStageViewPresentor:dependWhatResources()
	return {
		"ui/views/divineempress/divineempressextrestageview.prefab"
	}
end

function DivineEmpressExtreStageViewPresentor:buildViews()
	return {
		DivineEmpressExtreStageView.New()
	}
end

return DivineEmpressExtreStageViewPresentor
