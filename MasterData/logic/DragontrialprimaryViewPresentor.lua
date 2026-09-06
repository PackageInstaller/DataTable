-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrialprimaryViewPresentor.lua

module("logic.extensions.dragontrial.view.DragontrialprimaryViewPresentor", package.seeall)

local DragontrialprimaryViewPresentor = class("DragontrialprimaryViewPresentor", ViewPresentor)

function DragontrialprimaryViewPresentor:ctor()
	DragontrialprimaryViewPresentor.super.ctor(self)
end

function DragontrialprimaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragontrialprimaryViewPresentor:dependWhatResources()
	return {
		"ui/views/dragontrial/dragontrialprimaryview.prefab"
	}
end

function DragontrialprimaryViewPresentor:buildViews()
	return {
		DragontrialprimaryView.New()
	}
end

return DragontrialprimaryViewPresentor
