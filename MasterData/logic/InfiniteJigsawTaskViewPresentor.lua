-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitejigsaw/view/InfiniteJigsawTaskViewPresentor.lua

module("logic.extensions.infinitejigsaw.view.InfiniteJigsawTaskViewPresentor", package.seeall)

local InfiniteJigsawTaskViewPresentor = class("InfiniteJigsawTaskViewPresentor", ViewPresentor)

function InfiniteJigsawTaskViewPresentor:ctor()
	InfiniteJigsawTaskViewPresentor.super.ctor(self)
end

function InfiniteJigsawTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function InfiniteJigsawTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/infinitejigsaw/infinitejigsawtaskview.prefab"
	}
end

function InfiniteJigsawTaskViewPresentor:buildViews()
	return {
		InfiniteJigsawTaskView.New()
	}
end

return InfiniteJigsawTaskViewPresentor
