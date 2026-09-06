-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/DragonPreviewViewPresentor.lua

module("logic.extensions.lottery.view.DragonPreviewViewPresentor", package.seeall)

local DragonPreviewViewPresentor = class("DragonPreviewViewPresentor", ViewPresentor)

function DragonPreviewViewPresentor:ctor()
	DragonPreviewViewPresentor.super.ctor(self)
end

function DragonPreviewViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DragonPreviewViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/dragonpreviewview.prefab"
	}
end

function DragonPreviewViewPresentor:buildViews()
	return {
		DragonPreviewView.New()
	}
end

return DragonPreviewViewPresentor
