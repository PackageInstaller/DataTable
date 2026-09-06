-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/OperationsigninViewPresentor.lua

module("logic.extensions.operationsignin.view.OperationsigninViewPresentor", package.seeall)

local OperationsigninViewPresentor = class("OperationsigninViewPresentor", ViewPresentor)

function OperationsigninViewPresentor:ctor()
	OperationsigninViewPresentor.super.ctor(self)
end

function OperationsigninViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OperationsigninViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsignin/operationsigninview.prefab"
	}
end

function OperationsigninViewPresentor:buildViews()
	return {
		OperationSignInView.New()
	}
end

return OperationsigninViewPresentor
