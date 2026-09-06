-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/newyear/HuangjinshenglongbonusViewPresentor.lua

module("logic.extensions.bonus.view.newyear.HuangjinshenglongbonusViewPresentor", package.seeall)

local HuangjinshenglongbonusViewPresentor = class("HuangjinshenglongbonusViewPresentor", ViewPresentor)

function HuangjinshenglongbonusViewPresentor:ctor()
	HuangjinshenglongbonusViewPresentor.super.ctor(self)
end

function HuangjinshenglongbonusViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuangjinshenglongbonusViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/newyear/huangjinshenglongbonusview.prefab"
	}
end

function HuangjinshenglongbonusViewPresentor:buildViews()
	return {
		HuangjinshenglongbonusView.New()
	}
end

return HuangjinshenglongbonusViewPresentor
