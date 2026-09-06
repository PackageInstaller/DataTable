-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/PopupItemViewPresentor.lua

module("logic.extensions.seniorarena.view.PopupItemViewPresentor", package.seeall)

local PopupItemViewPresentor = class("PopupItemViewPresentor", ViewPresentor)

function PopupItemViewPresentor:ctor()
	PopupItemViewPresentor.super.ctor(self)
end

function PopupItemViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PopupItemViewPresentor:dependWhatResources()
	return {
		"ui/views/seniorarena/popupitemview.prefab"
	}
end

function PopupItemViewPresentor:buildViews()
	return {
		PopupItemView.New()
	}
end

return PopupItemViewPresentor
