-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastRewardShowViewPresentor.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastRewardShowViewPresentor", package.seeall)

local PanTaoFeastRewardShowViewPresentor = class("PanTaoFeastRewardShowViewPresentor", ViewPresentor)

function PanTaoFeastRewardShowViewPresentor:ctor()
	PanTaoFeastRewardShowViewPresentor.super.ctor(self)
end

function PanTaoFeastRewardShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PanTaoFeastRewardShowViewPresentor:dependWhatResources()
	return {
		"ui/views/pantaofeast/pantaofeastrewardshowview.prefab"
	}
end

function PanTaoFeastRewardShowViewPresentor:buildViews()
	return {
		PanTaoFeastRewardShowView.New()
	}
end

return PanTaoFeastRewardShowViewPresentor
