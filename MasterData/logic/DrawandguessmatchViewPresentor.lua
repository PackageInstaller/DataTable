-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessmatchViewPresentor.lua

module("logic.extensions.drawandguess.view.DrawandguessmatchViewPresentor", package.seeall)

local DrawandguessmatchViewPresentor = class("DrawandguessmatchViewPresentor", ViewPresentor)

function DrawandguessmatchViewPresentor:ctor()
	DrawandguessmatchViewPresentor.super.ctor(self)
end

function DrawandguessmatchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DrawandguessmatchViewPresentor:dependWhatResources()
	return {
		"ui/views/drawandguess/drawandguessmatchview.prefab"
	}
end

function DrawandguessmatchViewPresentor:buildViews()
	return {
		DrawandguessmatchView.New()
	}
end

return DrawandguessmatchViewPresentor
