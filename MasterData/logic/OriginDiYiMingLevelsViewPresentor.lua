-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindiyiming/view/OriginDiYiMingLevelsViewPresentor.lua

module("logic.extensions.origindiyiming.view.OriginDiYiMingLevelsViewPresentor", package.seeall)

local OriginDiYiMingLevelsViewPresentor = class("OriginDiYiMingLevelsViewPresentor", ViewPresentor)

function OriginDiYiMingLevelsViewPresentor:ctor()
	OriginDiYiMingLevelsViewPresentor.super.ctor(self)
end

function OriginDiYiMingLevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDiYiMingLevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/origindiyiming/origindiyiminglevelsview.prefab"
	}
end

function OriginDiYiMingLevelsViewPresentor:buildViews()
	return {
		OriginDiYiMingLevelsView.New()
	}
end

return OriginDiYiMingLevelsViewPresentor
