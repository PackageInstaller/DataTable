-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/theater/view/DreamTheaterViewPresentor.lua

module("logic.extensions.theater.view.DreamTheaterViewPresentor", package.seeall)

local DreamTheaterViewPresentor = class("DreamTheaterViewPresentor", ViewPresentor)

function DreamTheaterViewPresentor:ctor()
	DreamTheaterViewPresentor.super.ctor(self)
end

function DreamTheaterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DreamTheaterViewPresentor:dependWhatResources()
	return {
		"ui/views/theater/dreamtheaterview.prefab"
	}
end

function DreamTheaterViewPresentor:buildViews()
	return {
		DreamTheaterView.New()
	}
end

return DreamTheaterViewPresentor
