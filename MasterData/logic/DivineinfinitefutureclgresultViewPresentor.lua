-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinfinitefutureclg/view/DivineinfinitefutureclgresultViewPresentor.lua

module("logic.extensions.divineinfinitefutureclg.view.DivineinfinitefutureclgresultViewPresentor", package.seeall)

local DivineinfinitefutureclgresultViewPresentor = class("DivineinfinitefutureclgresultViewPresentor", ViewPresentor)

function DivineinfinitefutureclgresultViewPresentor:ctor()
	DivineinfinitefutureclgresultViewPresentor.super.ctor(self)
end

function DivineinfinitefutureclgresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineinfinitefutureclgresultViewPresentor:dependWhatResources()
	return {
		"ui/views/divineinfinitefutureclg/divineinfinitefutureclgresultview.prefab"
	}
end

function DivineinfinitefutureclgresultViewPresentor:buildViews()
	return {
		DivineinfinitefutureclgresultView.New()
	}
end

return DivineinfinitefutureclgresultViewPresentor
