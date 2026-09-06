-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/view/FemaleGodUseTipViewPresentor.lua

module("logic.extensions.femalegod.view.FemaleGodUseTipViewPresentor", package.seeall)

local FemaleGodUseTipViewPresentor = class("FemaleGodUseTipViewPresentor", ViewPresentor)

function FemaleGodUseTipViewPresentor:ctor()
	FemaleGodUseTipViewPresentor.super.ctor(self)
end

function FemaleGodUseTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FemaleGodUseTipViewPresentor:dependWhatResources()
	return {
		"ui/views/femalegod/femalegodusetipview.prefab"
	}
end

function FemaleGodUseTipViewPresentor:buildViews()
	return {
		FemaleGodUseTipView.New()
	}
end

return FemaleGodUseTipViewPresentor
