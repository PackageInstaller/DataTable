-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FbbgametipViewPresentor.lua

module("logic.extensions.fbbchallenge.view.FbbgametipViewPresentor", package.seeall)

local FbbgametipViewPresentor = class("FbbgametipViewPresentor", ViewPresentor)

function FbbgametipViewPresentor:ctor()
	FbbgametipViewPresentor.super.ctor(self)
end

function FbbgametipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FbbgametipViewPresentor:dependWhatResources()
	return {
		"ui/views/fbbchallenge/fbbgametipview.prefab"
	}
end

function FbbgametipViewPresentor:buildViews()
	return {
		FbbgametipView.New()
	}
end

return FbbgametipViewPresentor
