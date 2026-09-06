-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/CommonGroupTaskCellViewPresentor.lua

module("logic.extensions.caiqingdraw.view.CommonGroupTaskCellViewPresentor", package.seeall)

local CommonGroupTaskCellViewPresentor = class("CommonGroupTaskCellViewPresentor", ViewPresentor)

function CommonGroupTaskCellViewPresentor:ctor()
	CommonGroupTaskCellViewPresentor.super.ctor(self)
end

function CommonGroupTaskCellViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CommonGroupTaskCellViewPresentor:dependWhatResources()
	return {
		"ui/views/common/task/commontaskcellview.prefab"
	}
end

function CommonGroupTaskCellViewPresentor:buildViews()
	return {
		CommonGroupTaskCellView.New()
	}
end

function CommonGroupTaskCellViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CommonGroupTaskCellViewPresentor
