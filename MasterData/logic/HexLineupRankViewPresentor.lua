-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hexlineup/view/HexLineupRankViewPresentor.lua

module("logic.extensions.hexlineup.view.HexLineupRankViewPresentor", package.seeall)

local HexLineupRankViewPresentor = class("HexLineupRankViewPresentor", ViewPresentor)

function HexLineupRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HexLineupRankViewPresentor:dependWhatResources()
	return {
		"ui/views/hexlineup/hexlineuprankview.prefab"
	}
end

function HexLineupRankViewPresentor:buildViews()
	return {
		HexLineupRankView.New()
	}
end

return HexLineupRankViewPresentor
