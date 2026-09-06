-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonsoulvote/view/DragonsoulvoteprizeViewPresentor.lua

module("logic.extensions.dragonsoulvote.view.DragonsoulvoteprizeViewPresentor", package.seeall)

local DragonsoulvoteprizeViewPresentor = class("DragonsoulvoteprizeViewPresentor", ViewPresentor)

function DragonsoulvoteprizeViewPresentor:ctor()
	DragonsoulvoteprizeViewPresentor.super.ctor(self)
end

function DragonsoulvoteprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonsoulvoteprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonsoulvote/dragonsoulvoteprizeview.prefab"
	}
end

function DragonsoulvoteprizeViewPresentor:buildViews()
	return {
		DragonsoulvoteprizeView.New()
	}
end

return DragonsoulvoteprizeViewPresentor
