-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenconvene/view/LingShenConveneRevealViewPresentor.lua

module("logic.extensions.lingshenconvene.view.LingShenConveneRevealViewPresentor", package.seeall)

local LingShenConveneRevealViewPresentor = class("LingShenConveneRevealViewPresentor", ViewPresentor)

function LingShenConveneRevealViewPresentor:ctor()
	LingShenConveneRevealViewPresentor.super.ctor(self)
end

function LingShenConveneRevealViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LingShenConveneRevealViewPresentor:dependWhatResources()
	return {
		"ui/views/lingshenconvene/lingshenconvenerevealview.prefab"
	}
end

function LingShenConveneRevealViewPresentor:buildViews()
	return {
		LingShenConveneRevealView.New()
	}
end

return LingShenConveneRevealViewPresentor
