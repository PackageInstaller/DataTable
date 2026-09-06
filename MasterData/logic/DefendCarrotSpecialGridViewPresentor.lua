-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotSpecialGridViewPresentor.lua

module("logic.extensions.defendcarrot.view.DefendCarrotSpecialGridViewPresentor", package.seeall)

local DefendCarrotSpecialGridViewPresentor = class("DefendCarrotSpecialGridViewPresentor", ViewPresentor)

function DefendCarrotSpecialGridViewPresentor:ctor()
	DefendCarrotSpecialGridViewPresentor.super.ctor(self)
end

function DefendCarrotSpecialGridViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DefendCarrotSpecialGridViewPresentor:dependWhatResources()
	return {
		"ui/views/defendcarrot/defendcarrotspecialgridview.prefab"
	}
end

function DefendCarrotSpecialGridViewPresentor:buildViews()
	return {
		DefendCarrotSpecialGridView.New()
	}
end

return DefendCarrotSpecialGridViewPresentor
