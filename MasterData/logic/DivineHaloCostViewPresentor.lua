-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/view/DivineHaloCostViewPresentor.lua

module("logic.extensions.divinehalogame.view.DivineHaloCostViewPresentor", package.seeall)

local DivineHaloCostViewPresentor = class("DivineHaloCostViewPresentor", ViewPresentor)

function DivineHaloCostViewPresentor:ctor()
	DivineHaloCostViewPresentor.super.ctor(self)
end

function DivineHaloCostViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineHaloCostViewPresentor:dependWhatResources()
	return {
		"ui/views/divinehalogame/divinehalocostview.prefab"
	}
end

function DivineHaloCostViewPresentor:buildViews()
	return {
		DivineHaloCostView.New()
	}
end

return DivineHaloCostViewPresentor
