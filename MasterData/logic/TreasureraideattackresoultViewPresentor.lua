-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraideattackresoultViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraideattackresoultViewPresentor", package.seeall)

local TreasureraideattackresoultViewPresentor = class("TreasureraideattackresoultViewPresentor", ViewPresentor)

function TreasureraideattackresoultViewPresentor:ctor()
	TreasureraideattackresoultViewPresentor.super.ctor(self)
end

function TreasureraideattackresoultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraideattackresoultViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraideattackresoultview.prefab"
	}
end

function TreasureraideattackresoultViewPresentor:buildViews()
	return {
		TreasureraideattackresoultView.New()
	}
end

return TreasureraideattackresoultViewPresentor
