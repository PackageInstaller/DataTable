-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineeternaldragonclg/view/DivineEternalDragonClgStageViewPresentor.lua

module("logic.extensions.divineeternaldragonclg.view.DivineEternalDragonClgStageViewPresentor", package.seeall)

local DivineEternalDragonClgStageViewPresentor = class("DivineEternalDragonClgStageViewPresentor", ViewPresentor)

function DivineEternalDragonClgStageViewPresentor:ctor()
	DivineEternalDragonClgStageViewPresentor.super.ctor(self)
end

function DivineEternalDragonClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEternalDragonClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/divineeternaldragonclg/divineeternaldragonclgstageview.prefab"
	}
end

function DivineEternalDragonClgStageViewPresentor:buildViews()
	return {
		DivineEternalDragonClgStageView.New()
	}
end

return DivineEternalDragonClgStageViewPresentor
