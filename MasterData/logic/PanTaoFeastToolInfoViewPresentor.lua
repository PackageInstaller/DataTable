-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastToolInfoViewPresentor.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastToolInfoViewPresentor", package.seeall)

local PanTaoFeastToolInfoViewPresentor = class("PanTaoFeastToolInfoViewPresentor", ViewPresentor)

function PanTaoFeastToolInfoViewPresentor:ctor()
	PanTaoFeastToolInfoViewPresentor.super.ctor(self)
end

function PanTaoFeastToolInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PanTaoFeastToolInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/pantaofeast/pantaofeasttoolinfoview.prefab"
	}
end

function PanTaoFeastToolInfoViewPresentor:buildViews()
	return {
		PanTaoFeastToolInfoView.New()
	}
end

return PanTaoFeastToolInfoViewPresentor
