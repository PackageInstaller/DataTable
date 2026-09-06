-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastMatInfoViewPresentor.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastMatInfoViewPresentor", package.seeall)

local PanTaoFeastMatInfoViewPresentor = class("PanTaoFeastMatInfoViewPresentor", ViewPresentor)

function PanTaoFeastMatInfoViewPresentor:ctor()
	PanTaoFeastMatInfoViewPresentor.super.ctor(self)
end

function PanTaoFeastMatInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PanTaoFeastMatInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/pantaofeast/pantaofeastmatinfoview.prefab"
	}
end

function PanTaoFeastMatInfoViewPresentor:buildViews()
	return {
		PanTaoFeastMatInfoView.New()
	}
end

return PanTaoFeastMatInfoViewPresentor
