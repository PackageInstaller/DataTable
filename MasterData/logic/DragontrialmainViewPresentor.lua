-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrialmainViewPresentor.lua

module("logic.extensions.dragontrial.view.DragontrialmainViewPresentor", package.seeall)

local DragontrialmainViewPresentor = class("DragontrialmainViewPresentor", ViewPresentor)

function DragontrialmainViewPresentor:ctor()
	DragontrialmainViewPresentor.super.ctor(self)
end

function DragontrialmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragontrialmainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragontrial/dragontrialmainview.prefab"
	}
end

function DragontrialmainViewPresentor:buildViews()
	return {
		DragontrialmainView.New()
	}
end

return DragontrialmainViewPresentor
