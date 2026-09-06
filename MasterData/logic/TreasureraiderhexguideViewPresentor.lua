-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraiderhexguideViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraiderhexguideViewPresentor", package.seeall)

local TreasureraiderhexguideViewPresentor = class("TreasureraiderhexguideViewPresentor", ViewPresentor)

function TreasureraiderhexguideViewPresentor:ctor()
	TreasureraiderhexguideViewPresentor.super.ctor(self)
end

function TreasureraiderhexguideViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraiderhexguideViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraiderhexguideview.prefab"
	}
end

function TreasureraiderhexguideViewPresentor:buildViews()
	return {
		TreasureraiderhexguideView.New()
	}
end

function TreasureraiderhexguideViewPresentor:setGrayMaskGO(grayMaskGO)
	TreasureraiderhexguideViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return TreasureraiderhexguideViewPresentor
