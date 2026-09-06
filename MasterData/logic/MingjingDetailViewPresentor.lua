-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mingjing/MingjingDetailViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.amier.MingjingDetailViewPresentor", package.seeall)

local MingjingDetailViewPresentor = class("MingjingDetailViewPresentor", ViewPresentor)

function MingjingDetailViewPresentor:ctor()
	MingjingDetailViewPresentor.super.ctor(self)
end

function MingjingDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MingjingDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mingjing/mingjingdetailview.prefab"
	}
end

function MingjingDetailViewPresentor:buildViews()
	return {
		MingjingDetailView.New()
	}
end

return MingjingDetailViewPresentor
