-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/view/ShareImageViewPresentor.lua

module("logic.extensions.share.view.ShareImageViewPresentor", package.seeall)

local ShareImageViewPresentor = class("ShareImageViewPresentor", ViewPresentor)

function ShareImageViewPresentor:ctor()
	ShareImageViewPresentor.super.ctor(self)
end

function ShareImageViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function ShareImageViewPresentor:dependWhatResources()
	return {
		"ui/views/share/shareimageview.prefab"
	}
end

function ShareImageViewPresentor:setGrayMaskGO(grayMaskGO)
	ShareImageViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

function ShareImageViewPresentor:buildViews()
	return {
		ShareImageView.New()
	}
end

function ShareImageViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShareImageViewPresentor
