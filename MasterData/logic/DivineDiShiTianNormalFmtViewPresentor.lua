-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/view/DivineDiShiTianNormalFmtViewPresentor.lua

module("logic.extensions.divinedishitianclg.view.DivineDiShiTianNormalFmtViewPresentor", package.seeall)

local DivineDiShiTianNormalFmtViewPresentor = class("DivineDiShiTianNormalFmtViewPresentor", ViewPresentor)

function DivineDiShiTianNormalFmtViewPresentor:ctor()
	DivineDiShiTianNormalFmtViewPresentor.super.ctor(self)
end

function DivineDiShiTianNormalFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineDiShiTianNormalFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedishitianclg/divinedishitiannormalfmtview.prefab"
	}
end

function DivineDiShiTianNormalFmtViewPresentor:buildViews()
	return {
		DivineDiShiTianNormalFmtView.New()
	}
end

return DivineDiShiTianNormalFmtViewPresentor
