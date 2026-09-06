-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/view/DarkKingDragonMainViewPresentor.lua

module("logic.extensions.divinedarkkingdragonclg.view.DarkKingDragonMainViewPresentor", package.seeall)

local DarkKingDragonMainViewPresentor = class("DarkKingDragonMainViewPresentor", ViewPresentor)

function DarkKingDragonMainViewPresentor:ctor()
	DarkKingDragonMainViewPresentor.super.ctor(self)
end

function DarkKingDragonMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarkKingDragonMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedarkkingdragonclg/darkkingdragonmainview.prefab"
	}
end

function DarkKingDragonMainViewPresentor:buildViews()
	return {
		DarkKingDragonMainView.New()
	}
end

return DarkKingDragonMainViewPresentor
