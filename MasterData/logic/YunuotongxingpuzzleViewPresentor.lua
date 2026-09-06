-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunuotongxing/view/YunuotongxingpuzzleViewPresentor.lua

module("logic.extensions.yunuotongxing.view.YunuotongxingpuzzleViewPresentor", package.seeall)

local YunuotongxingpuzzleViewPresentor = class("YunuotongxingpuzzleViewPresentor", ViewPresentor)

function YunuotongxingpuzzleViewPresentor:ctor()
	YunuotongxingpuzzleViewPresentor.super.ctor(self)
end

function YunuotongxingpuzzleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YunuotongxingpuzzleViewPresentor:dependWhatResources()
	return {
		"ui/views/yunuotongxing/yunuotongxingpuzzleview.prefab"
	}
end

function YunuotongxingpuzzleViewPresentor:buildViews()
	return {
		YunuotongxingpuzzleView.New()
	}
end

return YunuotongxingpuzzleViewPresentor
