-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/view/DivineDiShiTianExtremeViewPresentor.lua

module("logic.extensions.divinedishitianclg.view.DivineDiShiTianExtremeViewPresentor", package.seeall)

local DivineDiShiTianExtremeViewPresentor = class("DivineDiShiTianExtremeViewPresentor", ViewPresentor)

function DivineDiShiTianExtremeViewPresentor:ctor()
	DivineDiShiTianExtremeViewPresentor.super.ctor(self)
end

function DivineDiShiTianExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineDiShiTianExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedishitianclg/divinedishitianextremeview.prefab"
	}
end

function DivineDiShiTianExtremeViewPresentor:buildViews()
	return {
		DivineDiShiTianExtremeView.New()
	}
end

return DivineDiShiTianExtremeViewPresentor
