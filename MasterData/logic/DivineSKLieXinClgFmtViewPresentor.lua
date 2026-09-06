-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/view/DivineSKLieXinClgFmtViewPresentor.lua

module("logic.extensions.divineskliexinclg.view.DivineSKLieXinClgFmtViewPresentor", package.seeall)

local DivineSKLieXinClgFmtViewPresentor = class("DivineSKLieXinClgFmtViewPresentor", ViewPresentor)

function DivineSKLieXinClgFmtViewPresentor:ctor()
	DivineSKLieXinClgFmtViewPresentor.super.ctor(self)
end

function DivineSKLieXinClgFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineSKLieXinClgFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/divineskliexinclg/divineskliexinclgfmtview.prefab"
	}
end

function DivineSKLieXinClgFmtViewPresentor:buildViews()
	return {
		DivineSKLieXinClgFmtView.New()
	}
end

return DivineSKLieXinClgFmtViewPresentor
