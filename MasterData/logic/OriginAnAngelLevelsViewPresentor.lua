-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originanangel/view/OriginAnAngelLevelsViewPresentor.lua

module("logic.extensions.originanangel.view.OriginAnAngelLevelsViewPresentor", package.seeall)

local OriginAnAngelLevelsViewPresentor = class("OriginAnAngelLevelsViewPresentor", ViewPresentor)

function OriginAnAngelLevelsViewPresentor:ctor()
	OriginAnAngelLevelsViewPresentor.super.ctor(self)
end

function OriginAnAngelLevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAnAngelLevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/originanangel/originanangellevelsview.prefab"
	}
end

function OriginAnAngelLevelsViewPresentor:buildViews()
	return {
		OriginAnAngelLevelsView.New()
	}
end

return OriginAnAngelLevelsViewPresentor
