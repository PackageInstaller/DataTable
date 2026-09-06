-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FbbrankViewPresentor.lua

module("logic.extensions.fbbchallenge.view.FbbrankViewPresentor", package.seeall)

local FbbrankViewPresentor = class("FbbrankViewPresentor", ViewPresentor)

function FbbrankViewPresentor:ctor()
	FbbrankViewPresentor.super.ctor(self)
end

function FbbrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FbbrankViewPresentor:dependWhatResources()
	return {
		"ui/views/fbbchallenge/fbbrankview.prefab"
	}
end

function FbbrankViewPresentor:buildViews()
	return {
		FbbrankView.New()
	}
end

return FbbrankViewPresentor
