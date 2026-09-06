-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddailyrank/view/GoddailytabViewPresentor.lua

module("logic.extensions.goddailyrank.view.GoddailytabViewPresentor", package.seeall)

local GoddailytabViewPresentor = class("GoddailytabViewPresentor", ViewPresentor)

function GoddailytabViewPresentor:ctor()
	GoddailytabViewPresentor.super.ctor(self)
end

function GoddailytabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddailytabViewPresentor:dependWhatResources()
	return {
		"ui/views/goddailyrank/goddailytabview.prefab"
	}
end

function GoddailytabViewPresentor:buildViews()
	return {
		GoddailytabView.New()
	}
end

function GoddailytabViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddailytabViewPresentor
