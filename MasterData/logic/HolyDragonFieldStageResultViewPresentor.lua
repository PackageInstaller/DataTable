-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldStageResultViewPresentor.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldStageResultViewPresentor", package.seeall)

local HolyDragonFieldStageResultViewPresentor = class("HolyDragonFieldStageResultViewPresentor", ViewPresentor)

function HolyDragonFieldStageResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyDragonFieldStageResultViewPresentor:dependWhatResources()
	return {
		"ui/views/holydragonfield/holydragonfieldstageresultview.prefab"
	}
end

function HolyDragonFieldStageResultViewPresentor:buildViews()
	return {
		HolyDragonFieldStageResultView.New()
	}
end

return HolyDragonFieldStageResultViewPresentor
