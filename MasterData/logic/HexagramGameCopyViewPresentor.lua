-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/HexagramGameCopyViewPresentor.lua

module("logic.extensions.yirenpozhen.view.HexagramGameCopyViewPresentor", package.seeall)

local HexagramGameCopyViewPresentor = class("HexagramGameCopyViewPresentor", ViewPresentor)

function HexagramGameCopyViewPresentor:ctor()
	HexagramGameCopyViewPresentor.super.ctor(self)
end

function HexagramGameCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HexagramGameCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/yirenpozhen/hexagramgamecopyview.prefab",
		"ui/views/yirenpozhen/hexagramcell.prefab"
	}
end

function HexagramGameCopyViewPresentor:buildViews()
	return {
		HexagramGameCopyView.New()
	}
end

return HexagramGameCopyViewPresentor
