-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineshikonglongzunmainview/view/DivineShiKongLongZunFightEndShowViewPresentor.lua

module("logic.extensions.divineshikonglongzunmainview.view.DivineShiKongLongZunFightEndShowViewPresentor", package.seeall)

local DivineShiKongLongZunFightEndShowViewPresentor = class("DivineShiKongLongZunFightEndShowViewPresentor", ViewPresentor)

function DivineShiKongLongZunFightEndShowViewPresentor:ctor()
	DivineShiKongLongZunFightEndShowViewPresentor.super.ctor(self)
end

function DivineShiKongLongZunFightEndShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineShiKongLongZunFightEndShowViewPresentor:dependWhatResources()
	return {
		"ui/views/divineshikonglongzun/divineshikonglongzunfightendshowview.prefab"
	}
end

function DivineShiKongLongZunFightEndShowViewPresentor:buildViews()
	return {
		DivineShiKongLongZunFightEndShowView.New()
	}
end

return DivineShiKongLongZunFightEndShowViewPresentor
