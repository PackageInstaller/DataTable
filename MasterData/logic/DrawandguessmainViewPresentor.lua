-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessmainViewPresentor.lua

module("logic.extensions.drawandguess.view.DrawandguessmainViewPresentor", package.seeall)

local DrawandguessmainViewPresentor = class("DrawandguessmainViewPresentor", ViewPresentor)

function DrawandguessmainViewPresentor:ctor()
	DrawandguessmainViewPresentor.super.ctor(self)
end

function DrawandguessmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DrawandguessmainViewPresentor:dependWhatResources()
	return {
		"ui/views/drawandguess/drawandguessmainview.prefab"
	}
end

function DrawandguessmainViewPresentor:buildViews()
	return {
		DrawandguessmainView.New()
	}
end

return DrawandguessmainViewPresentor
