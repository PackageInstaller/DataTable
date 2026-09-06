-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/ZxldaywishViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.ZxldaywishViewPresentor", package.seeall)

local ZxldaywishViewPresentor = class("ZxldaywishViewPresentor", ViewPresentor)

function ZxldaywishViewPresentor:ctor()
	ZxldaywishViewPresentor.super.ctor(self)
end

function ZxldaywishViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZxldaywishViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shikongshenglong/zxldaywishview.prefab"
	}
end

function ZxldaywishViewPresentor:buildViews()
	return {
		ZxldaywishView.New()
	}
end

return ZxldaywishViewPresentor
