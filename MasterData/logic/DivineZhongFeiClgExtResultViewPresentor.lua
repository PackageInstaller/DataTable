-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgExtResultViewPresentor.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgExtResultViewPresentor", package.seeall)

local DivineZhongFeiClgExtResultViewPresentor = class("DivineZhongFeiClgExtResultViewPresentor", ViewPresentor)

function DivineZhongFeiClgExtResultViewPresentor:ctor()
	DivineZhongFeiClgExtResultViewPresentor.super.ctor(self)
end

function DivineZhongFeiClgExtResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineZhongFeiClgExtResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divinezhongfeiclg/divinezhongfeiclgextresultview.prefab"
	}
end

function DivineZhongFeiClgExtResultViewPresentor:buildViews()
	return {
		DivineZhongFeiClgExtResultView.New()
	}
end

return DivineZhongFeiClgExtResultViewPresentor
