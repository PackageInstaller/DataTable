-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/DivineelizabethenterViewPresentor.lua

module("logic.extensions.ashechallenge.view.DivineelizabethenterViewPresentor", package.seeall)

local DivineelizabethenterViewPresentor = class("DivineelizabethenterViewPresentor", ViewPresentor)

function DivineelizabethenterViewPresentor:ctor()
	DivineelizabethenterViewPresentor.super.ctor(self)
end

function DivineelizabethenterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineelizabethenterViewPresentor:dependWhatResources()
	return {
		"ui/views/ashechallenge/divineelizabethenterview.prefab"
	}
end

function DivineelizabethenterViewPresentor:buildViews()
	return {
		DivineelizabethenterView.New()
	}
end

return DivineelizabethenterViewPresentor
