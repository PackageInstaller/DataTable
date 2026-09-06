-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessinvitetypeViewPresentor.lua

module("logic.extensions.drawandguess.view.DrawandguessinvitetypeViewPresentor", package.seeall)

local DrawandguessinvitetypeViewPresentor = class("DrawandguessinvitetypeViewPresentor", ViewPresentor)

function DrawandguessinvitetypeViewPresentor:ctor()
	DrawandguessinvitetypeViewPresentor.super.ctor(self)
end

function DrawandguessinvitetypeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DrawandguessinvitetypeViewPresentor:dependWhatResources()
	return {
		"ui/views/drawandguess/drawandguessinvitetypeview.prefab"
	}
end

function DrawandguessinvitetypeViewPresentor:buildViews()
	return {
		DrawandguessinvitetypeView.New()
	}
end

return DrawandguessinvitetypeViewPresentor
