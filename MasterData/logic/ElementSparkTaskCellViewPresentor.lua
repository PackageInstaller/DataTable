-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkTaskCellViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkTaskCellViewPresentor", package.seeall)

local ElementSparkTaskCellViewPresentor = class("ElementSparkTaskCellViewPresentor", ViewPresentor)

function ElementSparkTaskCellViewPresentor:ctor()
	ElementSparkTaskCellViewPresentor.super.ctor(self)
end

function ElementSparkTaskCellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkTaskCellViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparktaskcellview.prefab"
	}
end

function ElementSparkTaskCellViewPresentor:buildViews()
	return {
		ElementSparkTaskCellView.New()
	}
end

function ElementSparkTaskCellViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ElementSparkTaskCellViewPresentor
