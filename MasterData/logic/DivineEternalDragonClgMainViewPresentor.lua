-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineeternaldragonclg/view/DivineEternalDragonClgMainViewPresentor.lua

module("logic.extensions.divineeternaldragonclg.view.DivineEternalDragonClgMainViewPresentor", package.seeall)

local DivineEternalDragonClgMainViewPresentor = class("DivineEternalDragonClgMainViewPresentor", ViewPresentor)

function DivineEternalDragonClgMainViewPresentor:ctor()
	DivineEternalDragonClgMainViewPresentor.super.ctor(self)
end

function DivineEternalDragonClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEternalDragonClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineeternaldragonclg/divineeternaldragonclgmainview.prefab"
	}
end

function DivineEternalDragonClgMainViewPresentor:buildViews()
	return {
		DivineEternalDragonClgMainView.New()
	}
end

return DivineEternalDragonClgMainViewPresentor
