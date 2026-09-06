-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/view/DragonKingGameView.lua

module("logic.extensions.dragonking.view.DragonKingGameView", package.seeall)

local DragonKingGameView = class("DragonKingGameView", HuarongRoadGameView)

function DragonKingGameView:ctor()
	DragonKingGameView.super.ctor(self)
end

function DragonKingGameView:unbindEvents()
	DragonKingGameView.super.unbindEvents(self)
end

function DragonKingGameView:bindEvents()
	DragonKingGameView.super.bindEvents(self)
end

function DragonKingGameView:buildUI()
	DragonKingGameView.super.buildUI(self)
end

function DragonKingGameView:onExit()
	DragonKingGameView.super.onExit(self)
end

function DragonKingGameView:onEnter()
	DragonKingGameView.super.onEnter(self)
end

return DragonKingGameView
