-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinfinitefutureclg/view/DivineinfinitefutureclgmainViewPresentor.lua

module("logic.extensions.divineinfinitefutureclg.view.DivineinfinitefutureclgmainViewPresentor", package.seeall)

local DivineinfinitefutureclgmainViewPresentor = class("DivineinfinitefutureclgmainViewPresentor", ViewPresentor)

function DivineinfinitefutureclgmainViewPresentor:ctor()
	DivineinfinitefutureclgmainViewPresentor.super.ctor(self)
end

function DivineinfinitefutureclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineinfinitefutureclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineinfinitefutureclg/divineinfinitefutureclgmainview.prefab"
	}
end

function DivineinfinitefutureclgmainViewPresentor:buildViews()
	return {
		DivineinfinitefutureclgmainView.New()
	}
end

return DivineinfinitefutureclgmainViewPresentor
