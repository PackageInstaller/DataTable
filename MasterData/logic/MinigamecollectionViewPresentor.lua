-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/minigamecollection/view/MinigamecollectionViewPresentor.lua

module("logic.extensions.minigamecollection.view.MinigamecollectionViewPresentor", package.seeall)

local MinigamecollectionViewPresentor = class("MinigamecollectionViewPresentor", ViewPresentor)

function MinigamecollectionViewPresentor:ctor()
	MinigamecollectionViewPresentor.super.ctor(self)
end

function MinigamecollectionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MinigamecollectionViewPresentor:dependWhatResources()
	return {
		"ui/views/minigamecollection/minigamecollectionview.prefab"
	}
end

function MinigamecollectionViewPresentor:buildViews()
	return {
		MinigamecollectionView.New()
	}
end

return MinigamecollectionViewPresentor
