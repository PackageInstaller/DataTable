-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineeternaldragonclg/view/DivineEternalDragonClgResultViewPresentor.lua

module("logic.extensions.divineeternaldragonclg.view.DivineEternalDragonClgResultViewPresentor", package.seeall)

local DivineEternalDragonClgResultViewPresentor = class("DivineEternalDragonClgResultViewPresentor", ViewPresentor)

function DivineEternalDragonClgResultViewPresentor:ctor()
	DivineEternalDragonClgResultViewPresentor.super.ctor(self)
end

function DivineEternalDragonClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEternalDragonClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divineeternaldragonclg/divineeternaldragonclgresultview.prefab"
	}
end

function DivineEternalDragonClgResultViewPresentor:buildViews()
	return {
		DivineEternalDragonClgResultView.New()
	}
end

return DivineEternalDragonClgResultViewPresentor
