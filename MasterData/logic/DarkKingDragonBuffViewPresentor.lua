-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/view/DarkKingDragonBuffViewPresentor.lua

module("logic.extensions.divinedarkkingdragonclg.view.DarkKingDragonBuffViewPresentor", package.seeall)

local DarkKingDragonBuffViewPresentor = class("DarkKingDragonBuffViewPresentor", ViewPresentor)

function DarkKingDragonBuffViewPresentor:ctor()
	DarkKingDragonBuffViewPresentor.super.ctor(self)
end

function DarkKingDragonBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarkKingDragonBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedarkkingdragonclg/darkkingdragonbuffview.prefab"
	}
end

function DarkKingDragonBuffViewPresentor:buildViews()
	return {
		DarkKingDragonBuffView.New()
	}
end

return DarkKingDragonBuffViewPresentor
