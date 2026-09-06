-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/imagefragmentcollection/view/ImagefragmentcollectionhotViewPresentor.lua

module("logic.extensions.imagefragmentcollection.view.ImagefragmentcollectionhotViewPresentor", package.seeall)

local ImagefragmentcollectionhotViewPresentor = class("ImagefragmentcollectionhotViewPresentor", ViewPresentor)

function ImagefragmentcollectionhotViewPresentor:ctor()
	ImagefragmentcollectionhotViewPresentor.super.ctor(self)
end

function ImagefragmentcollectionhotViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ImagefragmentcollectionhotViewPresentor:dependWhatResources()
	return {
		"ui/views/imagefragmentcollection/imagefragmentcollectionhotview.prefab"
	}
end

function ImagefragmentcollectionhotViewPresentor:buildViews()
	return {
		ImagefragmentcollectionhotView.New()
	}
end

function ImagefragmentcollectionhotViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function ImagefragmentcollectionhotViewPresentor:setGrayMaskGO(grayMaskGO)
	ImagefragmentcollectionhotViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	goutil.setActive(grayMaskGO, false)
end

return ImagefragmentcollectionhotViewPresentor
