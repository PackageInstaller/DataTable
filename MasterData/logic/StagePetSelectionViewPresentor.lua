-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/stage/StagePetSelectionViewPresentor.lua

module("logic.extensions.powerland.view.stage.StagePetSelectionViewPresentor", package.seeall)

local StagePetSelectionViewPresentor = class("StagePetSelectionViewPresentor", ViewPresentor)

function StagePetSelectionViewPresentor:ctor()
	StagePetSelectionViewPresentor.super.ctor(self)
end

function StagePetSelectionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StagePetSelectionViewPresentor:dependWhatResources()
	return {
		"ui/views/powerland/stagepetselectionview.prefab"
	}
end

function StagePetSelectionViewPresentor:buildViews()
	return {
		StagePetSelectionView.New()
	}
end

return StagePetSelectionViewPresentor
