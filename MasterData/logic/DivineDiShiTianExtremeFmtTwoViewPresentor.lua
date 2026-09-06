-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/view/DivineDiShiTianExtremeFmtTwoViewPresentor.lua

module("logic.extensions.divinedishitianclg.view.DivineDiShiTianExtremeFmtTwoViewPresentor", package.seeall)

local DivineDiShiTianExtremeFmtTwoViewPresentor = class("DivineDiShiTianExtremeFmtTwoViewPresentor", ViewPresentor)

function DivineDiShiTianExtremeFmtTwoViewPresentor:ctor()
	DivineDiShiTianExtremeFmtTwoViewPresentor.super.ctor(self)
end

function DivineDiShiTianExtremeFmtTwoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineDiShiTianExtremeFmtTwoViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedishitianclg/divinedishitianextremefmttwoview.prefab"
	}
end

function DivineDiShiTianExtremeFmtTwoViewPresentor:buildViews()
	return {
		DivineDiShiTianExtremeFmtTwoView.New()
	}
end

function DivineDiShiTianExtremeFmtTwoViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DivineDiShiTianExtremeFmtTwoViewPresentor
