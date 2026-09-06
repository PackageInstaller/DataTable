-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgNormalViewPresentor.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgNormalViewPresentor", package.seeall)

local DivineZhongFeiClgNormalViewPresentor = class("DivineZhongFeiClgNormalViewPresentor", ViewPresentor)

function DivineZhongFeiClgNormalViewPresentor:ctor()
	DivineZhongFeiClgNormalViewPresentor.super.ctor(self)
end

function DivineZhongFeiClgNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineZhongFeiClgNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/divinezhongfeiclg/divinezhongfeiclgnormalview.prefab"
	}
end

function DivineZhongFeiClgNormalViewPresentor:buildViews()
	return {
		DivineZhongFeiClgNormalView.New()
	}
end

return DivineZhongFeiClgNormalViewPresentor
