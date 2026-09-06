-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/view/copy/DivinesqyltagViewPresentor.lua

module("logic.extensions.xiayin.view.copy.DivinesqyltagViewPresentor", package.seeall)

local DivinesqyltagViewPresentor = class("DivinesqyltagViewPresentor", ViewPresentor)

function DivinesqyltagViewPresentor:ctor()
	DivinesqyltagViewPresentor.super.ctor(self)
end

function DivinesqyltagViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinesqyltagViewPresentor:dependWhatResources()
	return {
		"ui/views/xiayin/copy/divinesqyltagview.prefab"
	}
end

function DivinesqyltagViewPresentor:buildViews()
	return {
		DivinesqyltagView.New()
	}
end

return DivinesqyltagViewPresentor
