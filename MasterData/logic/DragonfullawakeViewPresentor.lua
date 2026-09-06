-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/DragonfullawakeViewPresentor.lua

module("logic.extensions.sevendays.view.DragonfullawakeViewPresentor", package.seeall)

local DragonfullawakeViewPresentor = class("DragonfullawakeViewPresentor", ViewWithGuidePresentor)

function DragonfullawakeViewPresentor:ctor()
	DragonfullawakeViewPresentor.super.ctor(self)
end

function DragonfullawakeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonfullawakeViewPresentor:dependWhatResources()
	return {
		"ui/views/sevendays/helpdragonfullawakeview.prefab"
	}
end

function DragonfullawakeViewPresentor:buildViews()
	return {
		DragonfullawakeView.New()
	}
end

return DragonfullawakeViewPresentor
