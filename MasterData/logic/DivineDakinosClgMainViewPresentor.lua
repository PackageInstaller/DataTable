-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedakinosclg/view/DivineDakinosClgMainViewPresentor.lua

module("logic.extensions.divinedakinosclg.view.DivineDakinosClgMainViewPresentor", package.seeall)

local DivineDakinosClgMainViewPresentor = class("DivineDakinosClgMainViewPresentor", ViewPresentor)

function DivineDakinosClgMainViewPresentor:ctor()
	DivineDakinosClgMainViewPresentor.super.ctor(self)
end

function DivineDakinosClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineDakinosClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedakinosclg/divinedakinosclgmainview.prefab"
	}
end

function DivineDakinosClgMainViewPresentor:buildViews()
	return {
		DivineDakinosClgMainView.New()
	}
end

return DivineDakinosClgMainViewPresentor
