-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/view/DarkKingDragonResultViewPresentor.lua

module("logic.extensions.divinedarkkingdragonclg.view.DarkKingDragonResultViewPresentor", package.seeall)

local DarkKingDragonResultViewPresentor = class("DarkKingDragonResultViewPresentor", ViewPresentor)

function DarkKingDragonResultViewPresentor:ctor()
	DarkKingDragonResultViewPresentor.super.ctor(self)
end

function DarkKingDragonResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarkKingDragonResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedarkkingdragonclg/darkkingdragonresultview.prefab"
	}
end

function DarkKingDragonResultViewPresentor:buildViews()
	return {
		DarkKingDragonResultView.New()
	}
end

return DarkKingDragonResultViewPresentor
