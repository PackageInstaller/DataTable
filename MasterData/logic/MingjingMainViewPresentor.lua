-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mingjing/MingjingMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.amier.MingjingMainViewPresentor", package.seeall)

local MingjingMainViewPresentor = class("MingjingMainViewPresentor", ViewPresentor)

function MingjingMainViewPresentor:ctor()
	MingjingMainViewPresentor.super.ctor(self)
end

function MingjingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MingjingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mingjing/mingjingmainview.prefab"
	}
end

function MingjingMainViewPresentor:buildViews()
	return {
		MingjingMainView.New()
	}
end

return MingjingMainViewPresentor
