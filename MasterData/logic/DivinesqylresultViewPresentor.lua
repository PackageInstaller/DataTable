-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/view/copy/DivinesqylresultViewPresentor.lua

module("logic.extensions.xiayin.view.copy.DivinesqylresultViewPresentor", package.seeall)

local DivinesqylresultViewPresentor = class("DivinesqylresultViewPresentor", ViewPresentor)

function DivinesqylresultViewPresentor:ctor()
	DivinesqylresultViewPresentor.super.ctor(self)
end

function DivinesqylresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinesqylresultViewPresentor:dependWhatResources()
	return {
		"ui/views/xiayin/copy/divinesqylresultview.prefab"
	}
end

function DivinesqylresultViewPresentor:buildViews()
	return {
		DivinesqylresultView.New()
	}
end

return DivinesqylresultViewPresentor
