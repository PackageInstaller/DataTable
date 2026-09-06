-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eleme/view/ElemeprizeViewPresentor.lua

module("logic.extensions.eleme.view.ElemeprizeViewPresentor", package.seeall)

local ElemeprizeViewPresentor = class("ElemeprizeViewPresentor", ViewPresentor)

function ElemeprizeViewPresentor:ctor()
	ElemeprizeViewPresentor.super.ctor(self)
end

function ElemeprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElemeprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/eleme/elemeprizeview.prefab"
	}
end

function ElemeprizeViewPresentor:buildViews()
	return {
		ElemeprizeView.New()
	}
end

return ElemeprizeViewPresentor
