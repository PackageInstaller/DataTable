-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/paladinlottery/YanLuoViewPresentor.lua

module("logic.extensions.lottery.view.paladin.YanLuoViewPresentor", package.seeall)

local YanLuoViewPresentor = class("YanLuoViewPresentor", ViewPresentor)

function YanLuoViewPresentor:ctor()
	YanLuoViewPresentor.super.ctor(self)
end

function YanLuoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YanLuoViewPresentor:dependWhatResources()
	return {
		"ui/views/paladinlottery/yanluoview.prefab"
	}
end

function YanLuoViewPresentor:buildViews()
	return {
		YanLuoView.New()
	}
end

return YanLuoViewPresentor
