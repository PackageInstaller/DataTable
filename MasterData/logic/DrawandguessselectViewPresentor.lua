-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessselectViewPresentor.lua

module("logic.extensions.drawandguess.view.DrawandguessselectViewPresentor", package.seeall)

local DrawandguessselectViewPresentor = class("DrawandguessselectViewPresentor", ViewPresentor)

function DrawandguessselectViewPresentor:ctor()
	DrawandguessselectViewPresentor.super.ctor(self)
end

function DrawandguessselectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DrawandguessselectViewPresentor:dependWhatResources()
	return {
		"ui/views/drawandguess/drawandguessselectview.prefab"
	}
end

function DrawandguessselectViewPresentor:buildViews()
	return {
		DrawandguessselectView.New()
	}
end

return DrawandguessselectViewPresentor
