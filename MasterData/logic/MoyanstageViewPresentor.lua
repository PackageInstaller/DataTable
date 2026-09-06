-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/moyan/MoyanstageViewPresentor.lua

module("logic.extensions.scenariocopy.view.moyan.MoyanstageViewPresentor", package.seeall)

local MoyanstageViewPresentor = class("MoyanstageViewPresentor", ViewPresentor)

function MoyanstageViewPresentor:ctor()
	MoyanstageViewPresentor.super.ctor(self)
end

function MoyanstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MoyanstageViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/moyan/moyanstageview.prefab"
	}
end

function MoyanstageViewPresentor:buildViews()
	return {
		MoYanStageView.New()
	}
end

return MoyanstageViewPresentor
