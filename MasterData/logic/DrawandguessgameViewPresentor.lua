-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessgameViewPresentor.lua

module("logic.extensions.drawandguess.view.DrawandguessgameViewPresentor", package.seeall)

local DrawandguessgameViewPresentor = class("DrawandguessgameViewPresentor", ViewPresentor)

function DrawandguessgameViewPresentor:ctor()
	DrawandguessgameViewPresentor.super.ctor(self)
end

function DrawandguessgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DrawandguessgameViewPresentor:dependWhatResources()
	return {
		"ui/views/drawandguess/drawandguessgameview.prefab"
	}
end

function DrawandguessgameViewPresentor:buildViews()
	return {
		DrawandguessgameView.New()
	}
end

return DrawandguessgameViewPresentor
