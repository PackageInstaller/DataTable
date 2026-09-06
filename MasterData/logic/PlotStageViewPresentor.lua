-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/PlotStageViewPresentor.lua

module("logic.extensions.plotcopy.view.PlotStageViewPresentor", package.seeall)

local PlotStageViewPresentor = class("PlotStageViewPresentor", ViewWithGuidePresentor)

function PlotStageViewPresentor:ctor()
	PlotStageViewPresentor.super.ctor(self)
end

function PlotStageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PlotStageViewPresentor:dependWhatResources()
	return {
		"ui/views/plotcopy/stageview.prefab"
	}
end

function PlotStageViewPresentor:buildViews()
	return {
		PlotStageView.New()
	}
end

function PlotStageViewPresentor:setGrayMaskGO(grayMaskGO)
	PlotStageViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return PlotStageViewPresentor
