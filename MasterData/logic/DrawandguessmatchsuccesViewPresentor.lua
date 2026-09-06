-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessmatchsuccesViewPresentor.lua

module("logic.extensions.drawandguess.view.DrawandguessmatchsuccesViewPresentor", package.seeall)

local DrawandguessmatchsuccesViewPresentor = class("DrawandguessmatchsuccesViewPresentor", ViewPresentor)

function DrawandguessmatchsuccesViewPresentor:ctor()
	DrawandguessmatchsuccesViewPresentor.super.ctor(self)
end

function DrawandguessmatchsuccesViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DrawandguessmatchsuccesViewPresentor:dependWhatResources()
	return {
		"ui/views/drawandguess/drawandguessmatchsuccesview.prefab"
	}
end

function DrawandguessmatchsuccesViewPresentor:buildViews()
	return {
		DrawandguessmatchsuccesView.New()
	}
end

return DrawandguessmatchsuccesViewPresentor
