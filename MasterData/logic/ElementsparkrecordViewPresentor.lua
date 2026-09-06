-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementsparkrecordViewPresentor.lua

module("logic.extensions.elementspark.view.ElementsparkrecordViewPresentor", package.seeall)

local ElementsparkrecordViewPresentor = class("ElementsparkrecordViewPresentor", ViewPresentor)

function ElementsparkrecordViewPresentor:ctor()
	ElementsparkrecordViewPresentor.super.ctor(self)
end

function ElementsparkrecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ElementsparkrecordViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkrecordview.prefab"
	}
end

function ElementsparkrecordViewPresentor:buildViews()
	return {
		ElementsparkrecordView.New()
	}
end

function ElementsparkrecordViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(ViewName.ElementsparkrecordView)
end

return ElementsparkrecordViewPresentor
