-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraidecontructViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraidecontructViewPresentor", package.seeall)

local TreasureraidecontructViewPresentor = class("TreasureraidecontructViewPresentor", ViewWithGuidePresentor)

function TreasureraidecontructViewPresentor:ctor()
	TreasureraidecontructViewPresentor.super.ctor(self)
end

function TreasureraidecontructViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraidecontructViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraidecontructview.prefab"
	}
end

function TreasureraidecontructViewPresentor:buildViews()
	return {
		TreasureraidecontructView.New()
	}
end

return TreasureraidecontructViewPresentor
