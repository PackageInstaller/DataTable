-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinfinitefutureclg/view/DivineinfinitefutureclgstageViewPresentor.lua

module("logic.extensions.divineinfinitefutureclg.view.DivineinfinitefutureclgstageViewPresentor", package.seeall)

local DivineinfinitefutureclgstageViewPresentor = class("DivineinfinitefutureclgstageViewPresentor", ViewPresentor)

function DivineinfinitefutureclgstageViewPresentor:ctor()
	DivineinfinitefutureclgstageViewPresentor.super.ctor(self)
end

function DivineinfinitefutureclgstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineinfinitefutureclgstageViewPresentor:dependWhatResources()
	return {
		"ui/views/divineinfinitefutureclg/divineinfinitefutureclgstageview.prefab"
	}
end

function DivineinfinitefutureclgstageViewPresentor:buildViews()
	return {
		DivineinfinitefutureclgstageView.New()
	}
end

return DivineinfinitefutureclgstageViewPresentor
