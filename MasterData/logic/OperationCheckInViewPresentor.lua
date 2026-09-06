-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/OperationCheckInViewPresentor.lua

module("logic.extensions.operationsignin.view.OperationCheckInViewPresentor", package.seeall)

local OperationCheckInViewPresentor = class("OperationCheckInViewPresentor", ViewPresentor)

function OperationCheckInViewPresentor:ctor()
	OperationCheckInViewPresentor.super.ctor(self)
end

function OperationCheckInViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OperationCheckInViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsignin/operationcheckinview.prefab"
	}
end

function OperationCheckInViewPresentor:buildViews()
	return {
		OperationCheckInView.New()
	}
end

return OperationCheckInViewPresentor
