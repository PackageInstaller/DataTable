-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/manjianshangcheng/ManjianshangchengjumpViewPresentor.lua

module("logic.extensions.bonus.view.manjianshangcheng.ManjianshangchengjumpViewPresentor", package.seeall)

local ManjianshangchengjumpViewPresentor = class("ManjianshangchengjumpViewPresentor", ViewPresentor)

function ManjianshangchengjumpViewPresentor:ctor()
	ManjianshangchengjumpViewPresentor.super.ctor(self)
end

function ManjianshangchengjumpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ManjianshangchengjumpViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/manjianshangcheng/manjianshangchengjumpview.prefab"
	}
end

function ManjianshangchengjumpViewPresentor:buildViews()
	return {
		ManjianshangchengjumpView.New()
	}
end

return ManjianshangchengjumpViewPresentor
