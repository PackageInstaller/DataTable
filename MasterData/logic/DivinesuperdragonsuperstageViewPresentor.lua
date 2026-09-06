-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/view/DivinesuperdragonsuperstageViewPresentor.lua

module("logic.extensions.divinesuperdragon.view.DivinesuperdragonsuperstageViewPresentor", package.seeall)

local DivinesuperdragonsuperstageViewPresentor = class("DivinesuperdragonsuperstageViewPresentor", ViewPresentor)

function DivinesuperdragonsuperstageViewPresentor:ctor()
	DivinesuperdragonsuperstageViewPresentor.super.ctor(self)
end

function DivinesuperdragonsuperstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinesuperdragonsuperstageViewPresentor:dependWhatResources()
	return {
		"ui/views/divinesuperdragon/divinesuperdragonsuperstageview.prefab"
	}
end

function DivinesuperdragonsuperstageViewPresentor:buildViews()
	return {
		DivinesuperdragonsuperstageView.New()
	}
end

return DivinesuperdragonsuperstageViewPresentor
