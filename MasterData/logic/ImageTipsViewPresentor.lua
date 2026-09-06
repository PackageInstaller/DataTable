-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/ImageTipsViewPresentor.lua

module("logic.extensions.tips.view.ImageTipsViewPresentor", package.seeall)

local ImageTipsViewPresentor = class("ImageTipsViewPresentor", ViewPresentor)

function ImageTipsViewPresentor:ctor()
	ImageTipsViewPresentor.super.ctor(self)
end

function ImageTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ImageTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/imagetipsview.prefab"
	}
end

function ImageTipsViewPresentor:buildViews()
	return {
		ImageTipsView.New()
	}
end

return ImageTipsViewPresentor
