-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/FavorChangeViewPresentor.lua

module("logic.extensions.pigraise.view.FavorChangeViewPresentor", package.seeall)

local FavorChangeViewPresentor = class("FavorChangeViewPresentor", ViewPresentor)

function FavorChangeViewPresentor:ctor()
	FavorChangeViewPresentor.super.ctor(self)
end

function FavorChangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FavorChangeViewPresentor:dependWhatResources()
	return {
		"ui/views/pigraise/favorchangeview.prefab"
	}
end

function FavorChangeViewPresentor:buildViews()
	return {
		FavorChangeView.New()
	}
end

return FavorChangeViewPresentor
