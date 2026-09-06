-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/view/FemaleGodTipViewPresentor.lua

module("logic.extensions.femalegod.view.FemaleGodTipViewPresentor", package.seeall)

local FemaleGodTipViewPresentor = class("FemaleGodTipViewPresentor", ViewPresentor)

function FemaleGodTipViewPresentor:ctor()
	FemaleGodTipViewPresentor.super.ctor(self)
end

function FemaleGodTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FemaleGodTipViewPresentor:dependWhatResources()
	return {
		"ui/views/femalegod/femalegodtipview.prefab"
	}
end

function FemaleGodTipViewPresentor:buildViews()
	return {
		FemaleGodTipView.New()
	}
end

return FemaleGodTipViewPresentor
