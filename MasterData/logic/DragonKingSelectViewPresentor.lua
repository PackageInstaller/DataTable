-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/view/DragonKingSelectViewPresentor.lua

module("logic.extensions.dragonking.view.DragonKingSelectViewPresentor", package.seeall)

local DragonKingSelectViewPresentor = class("DragonKingSelectViewPresentor", ViewPresentor)

function DragonKingSelectViewPresentor:ctor()
	DragonKingSelectViewPresentor.super.ctor(self)
end

function DragonKingSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonKingSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonking/dragonkingselectview.prefab"
	}
end

function DragonKingSelectViewPresentor:buildViews()
	return {
		DragonKingSelectView.New()
	}
end

return DragonKingSelectViewPresentor
