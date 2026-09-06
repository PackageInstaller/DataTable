-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddailyrank/view/GoddailytabZhouNianViewPresentor.lua

module("logic.extensions.goddailyrank.view.GoddailytabZhouNianViewPresentor", package.seeall)

local GoddailytabZhouNianViewPresentor = class("GoddailytabZhouNianViewPresentor", ViewPresentor)

function GoddailytabZhouNianViewPresentor:ctor()
	GoddailytabZhouNianViewPresentor.super.ctor(self)
end

function GoddailytabZhouNianViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddailytabZhouNianViewPresentor:dependWhatResources()
	return {
		"ui/views/goddailyrank/goddailytabview.prefab"
	}
end

function GoddailytabZhouNianViewPresentor:buildViews()
	return {
		GoddailytabZhouNianView.New()
	}
end

function GoddailytabZhouNianViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddailytabZhouNianViewPresentor
