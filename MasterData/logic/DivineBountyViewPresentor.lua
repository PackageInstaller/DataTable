-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinebounty/view/DivineBountyViewPresentor.lua

module("logic.extensions.divinebounty.view.DivineBountyViewPresentor", package.seeall)

local DivineBountyViewPresentor = class("DivineBountyViewPresentor", ViewPresentor)

DivineBountyViewPresentor.MainViewBgSpinePath = GameUrl.getViewSpineUIUrl("1000_divinebounty")

function DivineBountyViewPresentor:ctor()
	DivineBountyViewPresentor.super.ctor(self)
end

function DivineBountyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineBountyViewPresentor:dependWhatResources()
	return {
		"ui/views/divinebounty/divinebountyview.prefab",
		DivineBountyViewPresentor.MainViewBgSpinePath
	}
end

function DivineBountyViewPresentor:buildViews()
	return {
		DivineBountyView.New()
	}
end

function DivineBountyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DivineBountyViewPresentor
