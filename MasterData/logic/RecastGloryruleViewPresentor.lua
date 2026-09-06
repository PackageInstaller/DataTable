-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGloryruleViewPresentor.lua

module("logic.extensions.recastglory.view.RecastGloryruleViewPresentor", package.seeall)

local RecastGloryruleViewPresentor = class("RecastGloryruleViewPresentor", ViewPresentor)

function RecastGloryruleViewPresentor:ctor()
	RecastGloryruleViewPresentor.super.ctor(self)
end

function RecastGloryruleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RecastGloryruleViewPresentor:dependWhatResources()
	return {
		"ui/views/recastglory/recastgloryruleview.prefab"
	}
end

function RecastGloryruleViewPresentor:buildViews()
	return {
		RecastGloryruleView.New()
	}
end

return RecastGloryruleViewPresentor
