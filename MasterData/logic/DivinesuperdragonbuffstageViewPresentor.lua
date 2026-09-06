-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/view/DivinesuperdragonbuffstageViewPresentor.lua

module("logic.extensions.divinesuperdragon.view.DivinesuperdragonbuffstageViewPresentor", package.seeall)

local DivinesuperdragonbuffstageViewPresentor = class("DivinesuperdragonbuffstageViewPresentor", ViewPresentor)

function DivinesuperdragonbuffstageViewPresentor:ctor()
	DivinesuperdragonbuffstageViewPresentor.super.ctor(self)
end

function DivinesuperdragonbuffstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinesuperdragonbuffstageViewPresentor:dependWhatResources()
	return {
		"ui/views/divinesuperdragon/divinesuperdragonbuffstageview.prefab"
	}
end

function DivinesuperdragonbuffstageViewPresentor:buildViews()
	return {
		DivinesuperdragonbuffstageView.New()
	}
end

return DivinesuperdragonbuffstageViewPresentor
