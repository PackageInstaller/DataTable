-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetHexGuideViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetHexGuideViewPresentor", package.seeall)

local CutePetHexGuideViewPresentor = class("CutePetHexGuideViewPresentor", ViewWithGuidePresentor)

function CutePetHexGuideViewPresentor:ctor()
	CutePetHexGuideViewPresentor.super.ctor(self)
end

function CutePetHexGuideViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetHexGuideViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepethexguideview.prefab"
	}
end

function CutePetHexGuideViewPresentor:buildViews()
	return {
		CutePetHexGuideView.New()
	}
end

function CutePetHexGuideViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function CutePetHexGuideViewPresentor:setGrayMaskGO(grayMaskGO)
	CutePetHexGuideViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return CutePetHexGuideViewPresentor
