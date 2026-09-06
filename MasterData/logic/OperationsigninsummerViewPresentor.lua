-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/OperationsigninsummerViewPresentor.lua

module("logic.extensions.operationsignin.view.OperationsigninsummerViewPresentor", package.seeall)

local OperationsigninsummerViewPresentor = class("OperationsigninsummerViewPresentor", ViewPresentor)

function OperationsigninsummerViewPresentor:ctor()
	OperationsigninsummerViewPresentor.super.ctor(self)
end

function OperationsigninsummerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OperationsigninsummerViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsignin/operationsigninsummerview.prefab"
	}
end

function OperationsigninsummerViewPresentor:buildViews()
	return {
		OperationsigninsummerView.New()
	}
end

return OperationsigninsummerViewPresentor
