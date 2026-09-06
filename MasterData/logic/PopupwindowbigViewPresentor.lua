-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupwindowbigViewPresentor.lua

module("logic.extensions.tips.view.PopupwindowbigViewPresentor", package.seeall)

local PopupwindowbigViewPresentor = class("PopupwindowbigViewPresentor", PopupWindowViewPresentor)

function PopupwindowbigViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/popupwindow_big.prefab"
	}
end

function PopupwindowbigViewPresentor:buildViews()
	return {
		PopupwindowbigView.New()
	}
end

return PopupwindowbigViewPresentor
