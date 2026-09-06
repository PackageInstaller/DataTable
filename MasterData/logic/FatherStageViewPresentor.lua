-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/father/FatherStageViewPresentor.lua

module("logic.extensions.scenariocopy.view.father.FatherStageViewPresentor", package.seeall)

local FatherStageViewPresentor = class("FatherStageViewPresentor", ViewPresentor)

function FatherStageViewPresentor:ctor()
	FatherStageViewPresentor.super.ctor(self)
end

function FatherStageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FatherStageViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/brithday/brithdaystageview.prefab"
	}
end

function FatherStageViewPresentor:buildViews()
	return {
		FatherStageView.New()
	}
end

return FatherStageViewPresentor
