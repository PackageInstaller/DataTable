-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/imagefragmentcollection/view/ImagefragmentcollectionmainViewPresentor.lua

module("logic.extensions.imagefragmentcollection.view.ImagefragmentcollectionmainViewPresentor", package.seeall)

local ImagefragmentcollectionmainViewPresentor = class("ImagefragmentcollectionmainViewPresentor", ViewPresentor)

function ImagefragmentcollectionmainViewPresentor:ctor()
	ImagefragmentcollectionmainViewPresentor.super.ctor(self)
end

function ImagefragmentcollectionmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ImagefragmentcollectionmainViewPresentor:dependWhatResources()
	return {
		"ui/views/imagefragmentcollection/imagefragmentcollectionmainview.prefab"
	}
end

function ImagefragmentcollectionmainViewPresentor:buildViews()
	return {
		ImagefragmentcollectionmainView.New()
	}
end

return ImagefragmentcollectionmainViewPresentor
