-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/view/DivineDiShiTianMainViewPresentor.lua

module("logic.extensions.divinedishitianclg.view.DivineDiShiTianMainViewPresentor", package.seeall)

local DivineDiShiTianMainViewPresentor = class("DivineDiShiTianMainViewPresentor", ViewPresentor)

function DivineDiShiTianMainViewPresentor:ctor()
	DivineDiShiTianMainViewPresentor.super.ctor(self)
end

function DivineDiShiTianMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineDiShiTianMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedishitianclg/divinedishitianmainview.prefab"
	}
end

function DivineDiShiTianMainViewPresentor:buildViews()
	return {
		DivineDiShiTianMainView.New()
	}
end

return DivineDiShiTianMainViewPresentor
