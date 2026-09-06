-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/imagefragmentcollection/view/ImagefragmentcollectiongetViewPresentor.lua

module("logic.extensions.imagefragmentcollection.view.ImagefragmentcollectiongetViewPresentor", package.seeall)

local ImagefragmentcollectiongetViewPresentor = class("ImagefragmentcollectiongetViewPresentor", ViewPresentor)

function ImagefragmentcollectiongetViewPresentor:ctor()
	ImagefragmentcollectiongetViewPresentor.super.ctor(self)
end

function ImagefragmentcollectiongetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ImagefragmentcollectiongetViewPresentor:dependWhatResources()
	return {
		"ui/views/imagefragmentcollection/imagefragmentcollectiongetview.prefab"
	}
end

function ImagefragmentcollectiongetViewPresentor:buildViews()
	return {
		ImagefragmentcollectiongetView.New()
	}
end

return ImagefragmentcollectiongetViewPresentor
