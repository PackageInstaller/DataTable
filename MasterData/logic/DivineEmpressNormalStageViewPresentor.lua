-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressNormalStageViewPresentor.lua

module("logic.extensions.divineempress.view.DivineEmpressNormalStageViewPresentor", package.seeall)

local DivineEmpressNormalStageViewPresentor = class("DivineEmpressNormalStageViewPresentor", ViewPresentor)

function DivineEmpressNormalStageViewPresentor:ctor()
	DivineEmpressNormalStageViewPresentor.super.ctor(self)
end

function DivineEmpressNormalStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEmpressNormalStageViewPresentor:dependWhatResources()
	return {
		"ui/views/divineempress/divineempressnormalstageview.prefab"
	}
end

function DivineEmpressNormalStageViewPresentor:buildViews()
	return {
		DivineEmpressNormalStageView.New()
	}
end

return DivineEmpressNormalStageViewPresentor
