-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineqingguclg/view/DivineQingGuClgMainViewPresentor.lua

module("logic.extensions.divineqingguclg.view.DivineQingGuClgMainViewPresentor", package.seeall)

local DivineQingGuClgMainViewPresentor = class("DivineQingGuClgMainViewPresentor", ViewPresentor)

function DivineQingGuClgMainViewPresentor:ctor()
	DivineQingGuClgMainViewPresentor.super.ctor(self)
end

function DivineQingGuClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineQingGuClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineqingguclg/divineqingguclgmainview.prefab"
	}
end

function DivineQingGuClgMainViewPresentor:buildViews()
	return {
		DivineQingGuClgMainView.New()
	}
end

return DivineQingGuClgMainViewPresentor
