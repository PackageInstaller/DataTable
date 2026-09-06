-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessrankViewPresentor.lua

module("logic.extensions.drawandguess.view.DrawandguessrankViewPresentor", package.seeall)

local DrawandguessrankViewPresentor = class("DrawandguessrankViewPresentor", ViewPresentor)

function DrawandguessrankViewPresentor:ctor()
	DrawandguessrankViewPresentor.super.ctor(self)
end

function DrawandguessrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DrawandguessrankViewPresentor:dependWhatResources()
	return {
		"ui/views/drawandguess/drawandguessrankview.prefab"
	}
end

function DrawandguessrankViewPresentor:buildViews()
	return {
		DrawandguessrankView.New()
	}
end

return DrawandguessrankViewPresentor
