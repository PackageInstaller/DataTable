-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/view/DivinesuperdragonmainViewPresentor.lua

module("logic.extensions.divinesuperdragon.view.DivinesuperdragonmainViewPresentor", package.seeall)

local DivinesuperdragonmainViewPresentor = class("DivinesuperdragonmainViewPresentor", ViewPresentor)

function DivinesuperdragonmainViewPresentor:ctor()
	DivinesuperdragonmainViewPresentor.super.ctor(self)
end

function DivinesuperdragonmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinesuperdragonmainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinesuperdragon/divinesuperdragonmainview.prefab"
	}
end

function DivinesuperdragonmainViewPresentor:buildViews()
	return {
		DivinesuperdragonmainView.New()
	}
end

return DivinesuperdragonmainViewPresentor
