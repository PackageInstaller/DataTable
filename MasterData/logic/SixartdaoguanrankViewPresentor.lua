-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanrankViewPresentor.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanrankViewPresentor", package.seeall)

local SixartdaoguanrankViewPresentor = class("SixartdaoguanrankViewPresentor", ViewPresentor)

function SixartdaoguanrankViewPresentor:ctor()
	SixartdaoguanrankViewPresentor.super.ctor(self)
end

function SixartdaoguanrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SixartdaoguanrankViewPresentor:dependWhatResources()
	return {
		"ui/views/sixartdaoguan/sixartdaoguanrankview.prefab"
	}
end

function SixartdaoguanrankViewPresentor:buildViews()
	return {
		SixartdaoguanrankView.New()
	}
end

return SixartdaoguanrankViewPresentor
