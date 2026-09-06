-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineqingguclg/view/DivineQingGuClgLevelViewPresentor.lua

module("logic.extensions.divineqingguclg.view.DivineQingGuClgLevelViewPresentor", package.seeall)

local DivineQingGuClgLevelViewPresentor = class("DivineQingGuClgLevelViewPresentor", ViewPresentor)

function DivineQingGuClgLevelViewPresentor:ctor()
	DivineQingGuClgLevelViewPresentor.super.ctor(self)
end

function DivineQingGuClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineQingGuClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/divineqingguclg/divineqingguclglevelview.prefab"
	}
end

function DivineQingGuClgLevelViewPresentor:buildViews()
	return {
		DivineQingGuClgLevelView.New()
	}
end

return DivineQingGuClgLevelViewPresentor
