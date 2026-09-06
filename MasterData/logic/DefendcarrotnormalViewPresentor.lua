-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendcarrotnormalViewPresentor.lua

module("logic.extensions.defendcarrot.view.DefendcarrotnormalViewPresentor", package.seeall)

local DefendcarrotnormalViewPresentor = class("DefendcarrotnormalViewPresentor", ViewPresentor)

function DefendcarrotnormalViewPresentor:ctor()
	DefendcarrotnormalViewPresentor.super.ctor(self)
end

function DefendcarrotnormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DefendcarrotnormalViewPresentor:dependWhatResources()
	return {
		"ui/views/defendcarrot/defendcarrotnormalview.prefab"
	}
end

function DefendcarrotnormalViewPresentor:buildViews()
	return {
		DefendcarrotnormalView.New()
	}
end

return DefendcarrotnormalViewPresentor
