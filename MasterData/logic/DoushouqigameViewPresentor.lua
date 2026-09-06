-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqigameViewPresentor.lua

module("logic.extensions.doushouqi.view.DoushouqigameViewPresentor", package.seeall)

local DoushouqigameViewPresentor = class("DoushouqigameViewPresentor", ViewWithGuidePresentor)

function DoushouqigameViewPresentor:ctor()
	DoushouqigameViewPresentor.super.ctor(self)
end

function DoushouqigameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoushouqigameViewPresentor:dependWhatResources()
	return {
		"ui/views/doushouqi/doushouqigameview.prefab"
	}
end

function DoushouqigameViewPresentor:buildViews()
	return {
		DoushouqigameView.New()
	}
end

return DoushouqigameViewPresentor
