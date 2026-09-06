-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/view/DivineDualDragonClgMainViewPresentor.lua

module("logic.extensions.divinedualdragonclg.view.DivineDualDragonClgMainViewPresentor", package.seeall)

local DivineDualDragonClgMainViewPresentor = class("DivineDualDragonClgMainViewPresentor", ViewPresentor)

function DivineDualDragonClgMainViewPresentor:ctor()
	DivineDualDragonClgMainViewPresentor.super.ctor(self)
end

function DivineDualDragonClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineDualDragonClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedualdragonclg/divinedualdragonclgmainview.prefab"
	}
end

function DivineDualDragonClgMainViewPresentor:buildViews()
	return {
		DivineDualDragonClgMainView.New()
	}
end

return DivineDualDragonClgMainViewPresentor
