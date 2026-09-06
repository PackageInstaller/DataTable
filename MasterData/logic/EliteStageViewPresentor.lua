-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/EliteStageViewPresentor.lua

module("logic.extensions.plotcopy.view.EliteStageViewPresentor", package.seeall)

local EliteStageViewPresentor = class("EliteStageViewPresentor", ViewWithGuidePresentor)

function EliteStageViewPresentor:ctor()
	EliteStageViewPresentor.super.ctor(self)
end

function EliteStageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EliteStageViewPresentor:dependWhatResources()
	return {
		"ui/views/plotcopy/stageview.prefab"
	}
end

function EliteStageViewPresentor:buildViews()
	return {
		EliteStageView.New()
	}
end

return EliteStageViewPresentor
