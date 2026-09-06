-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/HexagramgameViewPresentor.lua

module("logic.extensions.yirenpozhen.view.HexagramgameViewPresentor", package.seeall)

local HexagramgameViewPresentor = class("HexagramgameViewPresentor", ViewPresentor)

function HexagramgameViewPresentor:ctor()
	HexagramgameViewPresentor.super.ctor(self)
end

function HexagramgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HexagramgameViewPresentor:dependWhatResources()
	return {
		"ui/views/yirenpozhen/hexagramgameview.prefab",
		"ui/views/yirenpozhen/hexagramcell.prefab"
	}
end

function HexagramgameViewPresentor:buildViews()
	return {
		HexagramGameView.New()
	}
end

return HexagramgameViewPresentor
