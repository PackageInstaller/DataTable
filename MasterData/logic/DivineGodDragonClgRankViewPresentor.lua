-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegoddragonclg/view/DivineGodDragonClgRankViewPresentor.lua

module("logic.extensions.divinegoddragonclg.view.DivineGodDragonClgRankViewPresentor", package.seeall)

local DivineGodDragonClgRankViewPresentor = class("DivineGodDragonClgRankViewPresentor", ViewPresentor)

function DivineGodDragonClgRankViewPresentor:ctor()
	DivineGodDragonClgRankViewPresentor.super.ctor(self)
end

function DivineGodDragonClgRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineGodDragonClgRankViewPresentor:dependWhatResources()
	return {
		"ui/views/divinegoddragonclg/divinegoddragonclgrankview.prefab"
	}
end

function DivineGodDragonClgRankViewPresentor:buildViews()
	return {
		DivineGodDragonClgRankView.New()
	}
end

return DivineGodDragonClgRankViewPresentor
