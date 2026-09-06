-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/view/DarkKingDragonSpaceViewPresentor.lua

module("logic.extensions.divinedarkkingdragonclg.view.DarkKingDragonSpaceViewPresentor", package.seeall)

local DarkKingDragonSpaceViewPresentor = class("DarkKingDragonSpaceViewPresentor", ViewPresentor)

function DarkKingDragonSpaceViewPresentor:ctor()
	DarkKingDragonSpaceViewPresentor.super.ctor(self)
end

function DarkKingDragonSpaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarkKingDragonSpaceViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedarkkingdragonclg/darkkingdragonspaceview.prefab"
	}
end

function DarkKingDragonSpaceViewPresentor:buildViews()
	return {
		DarkKingDragonSpaceView.New()
	}
end

return DarkKingDragonSpaceViewPresentor
