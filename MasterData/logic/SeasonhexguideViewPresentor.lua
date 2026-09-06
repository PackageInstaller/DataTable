-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonhexguideViewPresentor.lua

module("logic.extensions.season.view.SeasonhexguideViewPresentor", package.seeall)

local SeasonhexguideViewPresentor = class("SeasonhexguideViewPresentor", ViewPresentor)

function SeasonhexguideViewPresentor:ctor()
	SeasonhexguideViewPresentor.super.ctor(self)
end

function SeasonhexguideViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonhexguideViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonhexguideview.prefab"
	}
end

function SeasonhexguideViewPresentor:buildViews()
	return {
		SeasonhexguideView.New()
	}
end

function SeasonhexguideViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function SeasonhexguideViewPresentor:setGrayMaskGO(grayMaskGO)
	SeasonhexguideViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return SeasonhexguideViewPresentor
