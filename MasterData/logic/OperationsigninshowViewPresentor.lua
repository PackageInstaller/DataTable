-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/OperationsigninshowViewPresentor.lua

module("logic.extensions.operationsignin.view.OperationsigninshowViewPresentor", package.seeall)

local OperationsigninshowViewPresentor = class("OperationsigninshowViewPresentor", ViewPresentor)

function OperationsigninshowViewPresentor:ctor()
	OperationsigninshowViewPresentor.super.ctor(self)
end

function OperationsigninshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OperationsigninshowViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsignin/operationsigninshowview.prefab"
	}
end

function OperationsigninshowViewPresentor:buildViews()
	return {
		OperationSignInShowView.New()
	}
end

return OperationsigninshowViewPresentor
