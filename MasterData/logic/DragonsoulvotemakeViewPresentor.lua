-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonsoulvote/view/DragonsoulvotemakeViewPresentor.lua

module("logic.extensions.dragonsoulvote.view.DragonsoulvotemakeViewPresentor", package.seeall)

local DragonsoulvotemakeViewPresentor = class("DragonsoulvotemakeViewPresentor", ViewPresentor)

function DragonsoulvotemakeViewPresentor:ctor()
	DragonsoulvotemakeViewPresentor.super.ctor(self)
end

function DragonsoulvotemakeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonsoulvotemakeViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonsoulvote/dragonsoulvotemakeview.prefab"
	}
end

function DragonsoulvotemakeViewPresentor:buildViews()
	return {
		DragonsoulvotemakeView.New()
	}
end

return DragonsoulvotemakeViewPresentor
