-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcopen/view/FuncOpenViewPresentor.lua

module("logic.extensions.funcopen.view.FuncOpenViewPresentor", package.seeall)

local FuncOpenViewPresentor = class("FuncOpenViewPresentor", ViewWithGuidePresentor)

function FuncOpenViewPresentor:ctor()
	FuncOpenViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.FuncOpenViewPriority
end

function FuncOpenViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function FuncOpenViewPresentor:dependWhatResources()
	return {
		"ui/views/funcopen/funcopenview.prefab"
	}
end

function FuncOpenViewPresentor:buildViews()
	return {
		FuncOpenView.New()
	}
end

function FuncOpenViewPresentor:_onViewShowByHigherPriority()
	FuncOpenController.instance:localNotify("FuncOpenShowByHigherPriority")
end

function FuncOpenViewPresentor:_onViewHideByLowerPriority()
	FuncOpenController.instance:localNotify("FuncOpenHideByLowerPriority")
end

function FuncOpenViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FuncOpenViewPresentor
