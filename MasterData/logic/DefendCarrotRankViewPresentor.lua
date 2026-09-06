-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotRankViewPresentor.lua

module("logic.extensions.defendcarrot.view.DefendCarrotRankViewPresentor", package.seeall)

local DefendCarrotRankViewPresentor = class("DefendCarrotRankViewPresentor", ViewPresentor)

function DefendCarrotRankViewPresentor:ctor()
	DefendCarrotRankViewPresentor.super.ctor(self)
end

function DefendCarrotRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DefendCarrotRankViewPresentor:dependWhatResources()
	return {
		"ui/views/defendcarrot/defendcarrotrankview.prefab"
	}
end

function DefendCarrotRankViewPresentor:buildViews()
	return {
		DefendCarrotRankView.New()
	}
end

return DefendCarrotRankViewPresentor
