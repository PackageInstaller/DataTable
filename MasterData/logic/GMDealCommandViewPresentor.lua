-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/GMDealCommandViewPresentor.lua

module("logic.extensions.gm.view.GMDealCommandViewPresentor", package.seeall)

local GMDealCommandViewPresentor = class("GMDealCommandViewPresentor", ViewPresentor)

function GMDealCommandViewPresentor:ctor()
	GMDealCommandViewPresentor.super.ctor(self)
end

function GMDealCommandViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GMDealCommandViewPresentor:dependWhatResources()
	return {
		"ui/views/gm/gmdealcommandview.prefab"
	}
end

function GMDealCommandViewPresentor:buildViews()
	return {
		GMDealCommandView.New()
	}
end

return GMDealCommandViewPresentor
