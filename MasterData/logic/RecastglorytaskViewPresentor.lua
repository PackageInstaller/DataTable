-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastglorytaskViewPresentor.lua

module("logic.extensions.recastglory.view.RecastglorytaskViewPresentor", package.seeall)

local RecastglorytaskViewPresentor = class("RecastglorytaskViewPresentor", ViewPresentor)

function RecastglorytaskViewPresentor:ctor()
	RecastglorytaskViewPresentor.super.ctor(self)
end

function RecastglorytaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RecastglorytaskViewPresentor:dependWhatResources()
	return {
		"ui/views/recastglory/recastglorytaskview.prefab"
	}
end

function RecastglorytaskViewPresentor:buildViews()
	return {
		RecastGlorytaskView.New()
	}
end

return RecastglorytaskViewPresentor
