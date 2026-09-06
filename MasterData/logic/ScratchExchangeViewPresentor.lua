-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/view/ScratchExchangeViewPresentor.lua

module("logic.extensions.scratch.view.ScratchExchangeViewPresentor", package.seeall)

local ScratchExchangeViewPresentor = class("ScratchExchangeViewPresentor", ViewPresentor)

function ScratchExchangeViewPresentor:ctor()
	ScratchExchangeViewPresentor.super.ctor(self)
end

function ScratchExchangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScratchExchangeViewPresentor:dependWhatResources()
	return {
		"ui/views/scratch/scratchexchangeview.prefab"
	}
end

function ScratchExchangeViewPresentor:buildViews()
	return {
		ScratchExchangeView.New()
	}
end

return ScratchExchangeViewPresentor
