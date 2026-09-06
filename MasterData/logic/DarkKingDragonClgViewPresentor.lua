-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/view/DarkKingDragonClgViewPresentor.lua

module("logic.extensions.divinedarkkingdragonclg.view.DarkKingDragonClgViewPresentor", package.seeall)

local DarkKingDragonClgViewPresentor = class("DarkKingDragonClgViewPresentor", ViewPresentor)

function DarkKingDragonClgViewPresentor:ctor()
	DarkKingDragonClgViewPresentor.super.ctor(self)
end

function DarkKingDragonClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarkKingDragonClgViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedarkkingdragonclg/darkkingdragonclgview.prefab"
	}
end

function DarkKingDragonClgViewPresentor:buildViews()
	return {
		DarkKingDragonClgView.New()
	}
end

return DarkKingDragonClgViewPresentor
