-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/view/FemaleGodFirstPopViewPresentor.lua

module("logic.extensions.femalegod.view.FemaleGodFirstPopViewPresentor", package.seeall)

local FemaleGodFirstPopViewPresentor = class("FemaleGodFirstPopViewPresentor", ViewPresentor)

function FemaleGodFirstPopViewPresentor:ctor()
	FemaleGodFirstPopViewPresentor.super.ctor(self)
end

function FemaleGodFirstPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FemaleGodFirstPopViewPresentor:dependWhatResources()
	return {
		"ui/views/femalegod/femalegodfirstpopview.prefab"
	}
end

function FemaleGodFirstPopViewPresentor:buildViews()
	return {
		FemaleGodFirstPopView.New()
	}
end

return FemaleGodFirstPopViewPresentor
