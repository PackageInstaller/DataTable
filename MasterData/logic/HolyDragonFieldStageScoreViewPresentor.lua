-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldStageScoreViewPresentor.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldStageScoreViewPresentor", package.seeall)

local HolyDragonFieldStageScoreViewPresentor = class("HolyDragonFieldStageScoreViewPresentor", ViewPresentor)

function HolyDragonFieldStageScoreViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyDragonFieldStageScoreViewPresentor:dependWhatResources()
	return {
		"ui/views/holydragonfield/holydragonfieldstagescoreview.prefab"
	}
end

function HolyDragonFieldStageScoreViewPresentor:buildViews()
	return {
		HolyDragonFieldStageScoreView.New()
	}
end

return HolyDragonFieldStageScoreViewPresentor
