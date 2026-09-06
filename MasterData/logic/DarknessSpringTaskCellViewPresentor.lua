-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darknessspring/view/DarknessSpringTaskCellViewPresentor.lua

module("logic.extensions.darknessspring.view.DarknessSpringTaskCellViewPresentor", package.seeall)

local DarknessSpringTaskCellViewPresentor = class("DarknessSpringTaskCellViewPresentor", ViewPresentor)

function DarknessSpringTaskCellViewPresentor:ctor()
	DarknessSpringTaskCellViewPresentor.super.ctor(self)
end

function DarknessSpringTaskCellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarknessSpringTaskCellViewPresentor:dependWhatResources()
	return {
		"ui/views/darknessspring/darknessspringtaskcellview.prefab"
	}
end

function DarknessSpringTaskCellViewPresentor:buildViews()
	return {
		DarknessSpringTaskCellView.New()
	}
end

function DarknessSpringTaskCellViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DarknessSpringTaskCellViewPresentor
