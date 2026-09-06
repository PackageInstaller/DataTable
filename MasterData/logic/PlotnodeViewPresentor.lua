-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotmemories/view/PlotnodeViewPresentor.lua

module("logic.extensions.plotmemories.view.PlotnodeViewPresentor", package.seeall)

local PlotnodeViewPresentor = class("PlotnodeViewPresentor", ViewPresentor)

function PlotnodeViewPresentor:ctor()
	PlotnodeViewPresentor.super.ctor(self)
end

function PlotnodeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlotnodeViewPresentor:dependWhatResources()
	return {
		"ui/views/plotmemories/plotnodeview.prefab"
	}
end

function PlotnodeViewPresentor:buildViews()
	return {
		PlotnodeView.New()
	}
end

return PlotnodeViewPresentor
