-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/view/DivineDiShiTianExtremeFmtOneViewPresentor.lua

module("logic.extensions.divinedishitianclg.view.DivineDiShiTianExtremeFmtOneViewPresentor", package.seeall)

local DivineDiShiTianExtremeFmtOneViewPresentor = class("DivineDiShiTianExtremeFmtOneViewPresentor", ViewPresentor)

function DivineDiShiTianExtremeFmtOneViewPresentor:ctor()
	DivineDiShiTianExtremeFmtOneViewPresentor.super.ctor(self)
end

function DivineDiShiTianExtremeFmtOneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineDiShiTianExtremeFmtOneViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedishitianclg/divinedishitianextremefmtoneview.prefab"
	}
end

function DivineDiShiTianExtremeFmtOneViewPresentor:buildViews()
	return {
		DivineDiShiTianExtremeFmtOneView.New()
	}
end

return DivineDiShiTianExtremeFmtOneViewPresentor
