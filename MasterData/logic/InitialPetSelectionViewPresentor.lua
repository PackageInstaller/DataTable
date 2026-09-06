-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/InitialPetSelectionViewPresentor.lua

module("logic.extensions.powerland.view.InitialPetSelectionViewPresentor", package.seeall)

local InitialPetSelectionViewPresentor = class("InitialPetSelectionViewPresentor", ViewPresentor)

function InitialPetSelectionViewPresentor:ctor()
	InitialPetSelectionViewPresentor.super.ctor(self)
end

function InitialPetSelectionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InitialPetSelectionViewPresentor:dependWhatResources()
	return {
		"ui/views/powerland/initialpetselectionview.prefab"
	}
end

function InitialPetSelectionViewPresentor:buildViews()
	return {
		InitialPetSelectionView.New()
	}
end

return InitialPetSelectionViewPresentor
