-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutepettravelmainViewPresentor.lua

module("logic.extensions.cutepet.view.CutepettravelmainViewPresentor", package.seeall)

local CutepettravelmainViewPresentor = class("CutepettravelmainViewPresentor", ViewPresentor)

function CutepettravelmainViewPresentor:ctor()
	CutepettravelmainViewPresentor.super.ctor(self)
end

function CutepettravelmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutepettravelmainViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepettravelmainview.prefab"
	}
end

function CutepettravelmainViewPresentor:buildViews()
	return {
		CutepettravelmainView.New()
	}
end

return CutepettravelmainViewPresentor
