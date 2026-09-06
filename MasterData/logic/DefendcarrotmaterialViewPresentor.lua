-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendcarrotmaterialViewPresentor.lua

module("logic.extensions.defendcarrot.view.DefendcarrotmaterialViewPresentor", package.seeall)

local DefendcarrotmaterialViewPresentor = class("DefendcarrotmaterialViewPresentor", ViewPresentor)

function DefendcarrotmaterialViewPresentor:ctor()
	DefendcarrotmaterialViewPresentor.super.ctor(self)
end

function DefendcarrotmaterialViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DefendcarrotmaterialViewPresentor:dependWhatResources()
	return {
		"ui/views/defendcarrot/defendcarrotmaterialview.prefab"
	}
end

function DefendcarrotmaterialViewPresentor:buildViews()
	return {
		DefendcarrotmaterialView.New()
	}
end

return DefendcarrotmaterialViewPresentor
