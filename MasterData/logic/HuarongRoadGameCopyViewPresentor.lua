-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/copygame/HuarongRoadGameCopyViewPresentor.lua

module("logic.extensions.huarongroad.view.copygame.HuarongRoadGameCopyViewPresentor", package.seeall)

local HuarongRoadGameCopyViewPresentor = class("HuarongRoadGameCopyViewPresentor", ViewPresentor)

function HuarongRoadGameCopyViewPresentor:ctor()
	HuarongRoadGameCopyViewPresentor.super.ctor(self)
end

function HuarongRoadGameCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuarongRoadGameCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightnuo/copy/ppcopysaintknightnuogameview.prefab"
	}
end

function HuarongRoadGameCopyViewPresentor:buildViews()
	return {
		HuarongRoadGameCopyView.New()
	}
end

return HuarongRoadGameCopyViewPresentor
