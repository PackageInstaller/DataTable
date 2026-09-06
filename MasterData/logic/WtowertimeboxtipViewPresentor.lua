-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WtowertimeboxtipViewPresentor.lua

module("logic.extensions.warriortower.view.WtowertimeboxtipViewPresentor", package.seeall)

local WtowertimeboxtipViewPresentor = class("WtowertimeboxtipViewPresentor", ViewPresentor)

function WtowertimeboxtipViewPresentor:ctor()
	WtowertimeboxtipViewPresentor.super.ctor(self)
end

function WtowertimeboxtipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WtowertimeboxtipViewPresentor:dependWhatResources()
	return {
		"ui/views/warriortower/wtowertimeboxtipview.prefab"
	}
end

function WtowertimeboxtipViewPresentor:buildViews()
	return {
		WtowerTimeboxTipView.New()
	}
end

return WtowertimeboxtipViewPresentor
