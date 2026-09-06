-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindiyiming/view/OriginDiYiMingMainViewPresentor.lua

module("logic.extensions.origindiyiming.view.OriginDiYiMingMainViewPresentor", package.seeall)

local OriginDiYiMingMainViewPresentor = class("OriginDiYiMingMainViewPresentor", ViewPresentor)

function OriginDiYiMingMainViewPresentor:ctor()
	OriginDiYiMingMainViewPresentor.super.ctor(self)
end

function OriginDiYiMingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDiYiMingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/origindiyiming/origindiyimingmainview.prefab"
	}
end

function OriginDiYiMingMainViewPresentor:buildViews()
	return {
		OriginDiYiMingMainView.New()
	}
end

return OriginDiYiMingMainViewPresentor
