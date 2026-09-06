-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hexlineup/view/HexLineupMainViewPresentor.lua

module("logic.extensions.hexlineup.view.HexLineupMainViewPresentor", package.seeall)

local HexLineupMainViewPresentor = class("HexLineupMainViewPresentor", ViewPresentor)

function HexLineupMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HexLineupMainViewPresentor:dependWhatResources()
	return {
		"ui/views/hexlineup/hexlineupmainview.prefab"
	}
end

function HexLineupMainViewPresentor:buildViews()
	return {
		HexLineupMainView.New()
	}
end

return HexLineupMainViewPresentor
