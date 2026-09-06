-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/view/SwordStormFmtViewPresentor.lua

module("logic.extensions.swordstorm.view.SwordStormFmtViewPresentor", package.seeall)

local SwordStormFmtViewPresentor = class("SwordStormFmtViewPresentor", ViewPresentor)

function SwordStormFmtViewPresentor:ctor()
	SwordStormFmtViewPresentor.super.ctor(self)
end

function SwordStormFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SwordStormFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/swordstorm/swordstormfmtview.prefab"
	}
end

function SwordStormFmtViewPresentor:buildViews()
	return {
		SwordStormFmtView.New()
	}
end

function SwordStormFmtViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SwordStormFmtViewPresentor
