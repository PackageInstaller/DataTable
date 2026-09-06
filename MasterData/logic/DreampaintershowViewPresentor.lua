-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampaintershowViewPresentor.lua

module("logic.extensions.dreampainter.view.DreampaintershowViewPresentor", package.seeall)

local DreampaintershowViewPresentor = class("DreampaintershowViewPresentor", ViewPresentor)

function DreampaintershowViewPresentor:ctor()
	DreampaintershowViewPresentor.super.ctor(self)
end

function DreampaintershowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreampaintershowViewPresentor:dependWhatResources()
	return {
		"ui/views/dreampainter/dreampaintershowview.prefab"
	}
end

function DreampaintershowViewPresentor:buildViews()
	return {
		DreampaintershowView.New()
	}
end

return DreampaintershowViewPresentor
