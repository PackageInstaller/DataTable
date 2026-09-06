-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collection/view/CollectionViewPresentor.lua

module("logic.extensions.collection.view.CollectionViewPresentor", package.seeall)

local CollectionViewPresentor = class("CollectionViewPresentor", ViewWithGuidePresentor)

function CollectionViewPresentor:ctor()
	CollectionViewPresentor.super.ctor(self)
end

function CollectionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectionViewPresentor:dependWhatResources()
	return {
		"ui/views/collection/collectionview_new.prefab"
	}
end

function CollectionViewPresentor:buildViews()
	return {
		CollectionViewNew.New()
	}
end

return CollectionViewPresentor
