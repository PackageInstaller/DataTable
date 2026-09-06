-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenconvene/view/LingShenConveneDetailViewPresentor.lua

module("logic.extensions.lingshenconvene.view.LingShenConveneDetailViewPresentor", package.seeall)

local LingShenConveneDetailViewPresentor = class("LingShenConveneDetailViewPresentor", ViewPresentor)

function LingShenConveneDetailViewPresentor:ctor()
	LingShenConveneDetailViewPresentor.super.ctor(self)
end

function LingShenConveneDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LingShenConveneDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/lingshenconvene/lingshenconvenedetailview.prefab"
	}
end

function LingShenConveneDetailViewPresentor:buildViews()
	return {
		LingShenConveneDetailView.New()
	}
end

return LingShenConveneDetailViewPresentor
