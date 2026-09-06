-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/view/DivineDiShiTianNormalViewPresentor.lua

module("logic.extensions.divinedishitianclg.view.DivineDiShiTianNormalViewPresentor", package.seeall)

local DivineDiShiTianNormalViewPresentor = class("DivineDiShiTianNormalViewPresentor", ViewPresentor)

function DivineDiShiTianNormalViewPresentor:ctor()
	DivineDiShiTianNormalViewPresentor.super.ctor(self)
end

function DivineDiShiTianNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineDiShiTianNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedishitianclg/divinedishitiannormalview.prefab"
	}
end

function DivineDiShiTianNormalViewPresentor:buildViews()
	return {
		DivineDiShiTianNormalView.New()
	}
end

return DivineDiShiTianNormalViewPresentor
