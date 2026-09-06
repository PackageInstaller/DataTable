-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonsoulvote/view/DragonsoulvotemainViewPresentor.lua

module("logic.extensions.dragonsoulvote.view.DragonsoulvotemainViewPresentor", package.seeall)

local DragonsoulvotemainViewPresentor = class("DragonsoulvotemainViewPresentor", ViewPresentor)

function DragonsoulvotemainViewPresentor:ctor()
	DragonsoulvotemainViewPresentor.super.ctor(self)
end

function DragonsoulvotemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonsoulvotemainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonsoulvote/dragonsoulvotemainview.prefab"
	}
end

function DragonsoulvotemainViewPresentor:buildViews()
	return {
		DragonsoulvotemainView.New()
	}
end

return DragonsoulvotemainViewPresentor
