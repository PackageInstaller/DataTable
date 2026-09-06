-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/SuppressGameStartMaskPresentor.lua

module("logic.extensions.suppressgame.view.SuppressGameStartMaskPresentor", package.seeall)

local SuppressGameStartMaskPresentor = class("SuppressGameStartMaskPresentor", ViewPresentor)

function SuppressGameStartMaskPresentor:ctor()
	SuppressGameStartMaskPresentor.super.ctor(self)
end

function SuppressGameStartMaskPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SuppressGameStartMaskPresentor:dependWhatResources()
	return {
		"ui/views/suppressgame/suppressgamestartmask.prefab"
	}
end

function SuppressGameStartMaskPresentor:buildViews()
	return {
		SuppressGameStartMask.New()
	}
end

return SuppressGameStartMaskPresentor
