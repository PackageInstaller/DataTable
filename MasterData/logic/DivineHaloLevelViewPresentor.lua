-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/view/DivineHaloLevelViewPresentor.lua

module("logic.extensions.divinehalogame.view.DivineHaloLevelViewPresentor", package.seeall)

local DivineHaloLevelViewPresentor = class("DivineHaloLevelViewPresentor", ViewPresentor)

function DivineHaloLevelViewPresentor:ctor()
	DivineHaloLevelViewPresentor.super.ctor(self)
end

function DivineHaloLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineHaloLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/divinehalogame/divinehalolevelview.prefab"
	}
end

function DivineHaloLevelViewPresentor:buildViews()
	return {
		DivineHaloLevelView.New()
	}
end

return DivineHaloLevelViewPresentor
