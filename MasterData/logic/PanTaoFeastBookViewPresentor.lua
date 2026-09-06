-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastBookViewPresentor.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastBookViewPresentor", package.seeall)

local PanTaoFeastBookViewPresentor = class("PanTaoFeastBookViewPresentor", ViewPresentor)

function PanTaoFeastBookViewPresentor:ctor()
	PanTaoFeastBookViewPresentor.super.ctor(self)
end

function PanTaoFeastBookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PanTaoFeastBookViewPresentor:dependWhatResources()
	return {
		"ui/views/pantaofeast/pantaofeastbookview.prefab"
	}
end

function PanTaoFeastBookViewPresentor:buildViews()
	return {
		PanTaoFeastBookView.New()
	}
end

return PanTaoFeastBookViewPresentor
