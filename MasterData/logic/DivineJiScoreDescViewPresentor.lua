-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiScoreDescViewPresentor.lua

module("logic.extensions.divinejiclg.view.DivineJiScoreDescViewPresentor", package.seeall)

local DivineJiScoreDescViewPresentor = class("DivineJiScoreDescViewPresentor", ViewPresentor)

function DivineJiScoreDescViewPresentor:ctor()
	DivineJiScoreDescViewPresentor.super.ctor(self)
end

function DivineJiScoreDescViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineJiScoreDescViewPresentor:dependWhatResources()
	return {
		"ui/views/divinejiclg/divinejiscoredescview.prefab"
	}
end

function DivineJiScoreDescViewPresentor:buildViews()
	return {
		DivineJiScoreDescView.New()
	}
end

return DivineJiScoreDescViewPresentor
