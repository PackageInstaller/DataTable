-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mofang/view/MofangLockTipViewPresentor.lua

module("logic.extensions.mofang.view.MofangLockTipViewPresentor", package.seeall)

local MofangLockTipViewPresentor = class("MofangLockTipViewPresentor", ViewPresentor)

function MofangLockTipViewPresentor:ctor()
	MofangLockTipViewPresentor.super.ctor(self)
end

function MofangLockTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MofangLockTipViewPresentor:dependWhatResources()
	return {
		"ui/views/mofang/mofanglocktipview.prefab"
	}
end

function MofangLockTipViewPresentor:buildViews()
	return {
		MofangLockTipView.New()
	}
end

return MofangLockTipViewPresentor
