-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/KingArenaMainViewPresentor.lua

module("logic.extensions.kingarena.view.KingArenaMainViewPresentor", package.seeall)

local KingArenaMainViewPresentor = class("KingArenaMainViewPresentor", ViewPresentor)

function KingArenaMainViewPresentor:ctor()
	KingArenaMainViewPresentor.super.ctor(self)
end

function KingArenaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingArenaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/kingarena/kingarenamainview.prefab"
	}
end

function KingArenaMainViewPresentor:buildViews()
	return {
		KingArenaMainView.New()
	}
end

return KingArenaMainViewPresentor
