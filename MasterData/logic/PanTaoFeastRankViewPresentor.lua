-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastRankViewPresentor.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastRankViewPresentor", package.seeall)

local PanTaoFeastRankViewPresentor = class("PanTaoFeastRankViewPresentor", ViewPresentor)

function PanTaoFeastRankViewPresentor:ctor()
	PanTaoFeastRankViewPresentor.super.ctor(self)
end

function PanTaoFeastRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PanTaoFeastRankViewPresentor:dependWhatResources()
	return {
		"ui/views/pantaofeast/pantaofeastrankview.prefab"
	}
end

function PanTaoFeastRankViewPresentor:buildViews()
	return {
		PanTaoFeastRankView.New()
	}
end

return PanTaoFeastRankViewPresentor
