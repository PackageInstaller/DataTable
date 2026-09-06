-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monopoly/view/MonopolyprizePresentor.lua

module("logic.extensions.monopoly.view.MonopolyprizePresentor", package.seeall)

local MonopolyprizePresentor = class("MonopolyprizePresentor", ViewPresentor)

function MonopolyprizePresentor:ctor()
	MonopolyprizePresentor.super.ctor(self)
end

function MonopolyprizePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MonopolyprizePresentor:dependWhatResources()
	return {
		"ui/views/monopoly/monopolyprizeview.prefab"
	}
end

function MonopolyprizePresentor:buildViews()
	return {
		MonopolyprizeView.New()
	}
end

return MonopolyprizePresentor
