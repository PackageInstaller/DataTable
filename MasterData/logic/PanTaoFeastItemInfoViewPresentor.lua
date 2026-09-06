-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastItemInfoViewPresentor.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastItemInfoViewPresentor", package.seeall)

local PanTaoFeastItemInfoViewPresentor = class("PanTaoFeastItemInfoViewPresentor", ViewPresentor)

function PanTaoFeastItemInfoViewPresentor:ctor()
	PanTaoFeastItemInfoViewPresentor.super.ctor(self)
end

function PanTaoFeastItemInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PanTaoFeastItemInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/pantaofeast/pantaofeastiteminfoview.prefab"
	}
end

function PanTaoFeastItemInfoViewPresentor:buildViews()
	return {
		PanTaoFeastItemInfoView.New()
	}
end

return PanTaoFeastItemInfoViewPresentor
