-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/ResStageViewPresentor.lua

module("logic.extensions.materialchallenge.view.ResStageViewPresentor", package.seeall)

local ResStageViewPresentor = class("ResStageViewPresentor", ViewWithGuidePresentor)

function ResStageViewPresentor:ctor()
	ResStageViewPresentor.super.ctor(self)
end

function ResStageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ResStageViewPresentor:dependWhatResources()
	return {
		"ui/views/materialchallenge/resstageview.prefab"
	}
end

function ResStageViewPresentor:buildViews()
	return {
		ResStageView.New()
	}
end

function ResStageViewPresentor:setGrayMaskGO(grayMaskGO)
	ResStageViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return ResStageViewPresentor
