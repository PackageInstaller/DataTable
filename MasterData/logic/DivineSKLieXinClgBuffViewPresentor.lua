-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/view/DivineSKLieXinClgBuffViewPresentor.lua

module("logic.extensions.divineskliexinclg.view.DivineSKLieXinClgBuffViewPresentor", package.seeall)

local DivineSKLieXinClgBuffViewPresentor = class("DivineSKLieXinClgBuffViewPresentor", ViewPresentor)

function DivineSKLieXinClgBuffViewPresentor:ctor()
	DivineSKLieXinClgBuffViewPresentor.super.ctor(self)
end

function DivineSKLieXinClgBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineSKLieXinClgBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divineskliexinclg/divineskliexinclgbuffview.prefab"
	}
end

function DivineSKLieXinClgBuffViewPresentor:buildViews()
	return {
		DivineSKLieXinClgBuffView.New()
	}
end

return DivineSKLieXinClgBuffViewPresentor
