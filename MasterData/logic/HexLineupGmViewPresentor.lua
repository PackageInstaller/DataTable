-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hexlineup/view/HexLineupGmViewPresentor.lua

module("logic.extensions.hexlineup.view.HexLineupGmViewPresentor", package.seeall)

local HexLineupGmViewPresentor = class("HexLineupGmViewPresentor", ViewPresentor)

function HexLineupGmViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HexLineupGmViewPresentor:dependWhatResources()
	return {
		"ui/views/hexlineup/hexlineupgmview.prefab"
	}
end

function HexLineupGmViewPresentor:buildViews()
	return {
		HexLineupGmView.New()
	}
end

return HexLineupGmViewPresentor
