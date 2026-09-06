-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/ZxlpresentwishViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.ZxlpresentwishViewPresentor", package.seeall)

local ZxlpresentwishViewPresentor = class("ZxlpresentwishViewPresentor", ViewPresentor)

function ZxlpresentwishViewPresentor:ctor()
	ZxlpresentwishViewPresentor.super.ctor(self)
end

function ZxlpresentwishViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZxlpresentwishViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shikongshenglong/zxlpresentwishview.prefab"
	}
end

function ZxlpresentwishViewPresentor:buildViews()
	return {
		ZxlpresentwishView.New()
	}
end

return ZxlpresentwishViewPresentor
