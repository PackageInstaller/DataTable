-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgExtremeViewPresentor.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgExtremeViewPresentor", package.seeall)

local DivineZhongFeiClgExtremeViewPresentor = class("DivineZhongFeiClgExtremeViewPresentor", ViewPresentor)

function DivineZhongFeiClgExtremeViewPresentor:ctor()
	DivineZhongFeiClgExtremeViewPresentor.super.ctor(self)
end

function DivineZhongFeiClgExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineZhongFeiClgExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/divinezhongfeiclg/divinezhongfeiclgextremeview.prefab"
	}
end

function DivineZhongFeiClgExtremeViewPresentor:buildViews()
	return {
		DivineZhongFeiClgExtremeView.New()
	}
end

return DivineZhongFeiClgExtremeViewPresentor
