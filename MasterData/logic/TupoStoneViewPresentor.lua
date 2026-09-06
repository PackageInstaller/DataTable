-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/TupoStoneViewPresentor.lua

module("logic.extensions.equipment.view.TupoStoneViewPresentor", package.seeall)

local TupoStoneViewPresentor = class("TupoStoneViewPresentor", ViewWithGuidePresentor)

function TupoStoneViewPresentor:ctor()
	TupoStoneViewPresentor.super.ctor(self)
end

function TupoStoneViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TupoStoneViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/tupostoneview.prefab"
	}
end

function TupoStoneViewPresentor:buildViews()
	return {
		TupoStoneView.New()
	}
end

return TupoStoneViewPresentor
