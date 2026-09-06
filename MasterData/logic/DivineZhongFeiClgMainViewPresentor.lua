-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgMainViewPresentor.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgMainViewPresentor", package.seeall)

local DivineZhongFeiClgMainViewPresentor = class("DivineZhongFeiClgMainViewPresentor", ViewPresentor)

function DivineZhongFeiClgMainViewPresentor:ctor()
	DivineZhongFeiClgMainViewPresentor.super.ctor(self)
end

function DivineZhongFeiClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineZhongFeiClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinezhongfeiclg/divinezhongfeiclgmainview.prefab"
	}
end

function DivineZhongFeiClgMainViewPresentor:buildViews()
	return {
		DivineZhongFeiClgMainView.New()
	}
end

return DivineZhongFeiClgMainViewPresentor
