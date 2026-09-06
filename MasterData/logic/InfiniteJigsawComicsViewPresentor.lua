-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitejigsaw/view/InfiniteJigsawComicsViewPresentor.lua

module("logic.extensions.infinitejigsaw.view.InfiniteJigsawComicsViewPresentor", package.seeall)

local InfiniteJigsawComicsViewPresentor = class("InfiniteJigsawComicsViewPresentor", ViewPresentor)

function InfiniteJigsawComicsViewPresentor:ctor()
	InfiniteJigsawComicsViewPresentor.super.ctor(self)
end

function InfiniteJigsawComicsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function InfiniteJigsawComicsViewPresentor:dependWhatResources()
	return {
		"ui/views/infinitejigsaw/infinitejigsawcomicsview.prefab"
	}
end

function InfiniteJigsawComicsViewPresentor:buildViews()
	return {
		InfiniteJigsawComicsView.New()
	}
end

return InfiniteJigsawComicsViewPresentor
