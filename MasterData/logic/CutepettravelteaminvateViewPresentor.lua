-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutepettravelteaminvateViewPresentor.lua

module("logic.extensions.cutepet.view.CutepettravelteaminvateViewPresentor", package.seeall)

local CutepettravelteaminvateViewPresentor = class("CutepettravelteaminvateViewPresentor", ViewPresentor)

function CutepettravelteaminvateViewPresentor:ctor()
	CutepettravelteaminvateViewPresentor.super.ctor(self)
end

function CutepettravelteaminvateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutepettravelteaminvateViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepettravelteaminvateview.prefab"
	}
end

function CutepettravelteaminvateViewPresentor:buildViews()
	return {
		CutepettravelteaminvateView.New()
	}
end

return CutepettravelteaminvateViewPresentor
