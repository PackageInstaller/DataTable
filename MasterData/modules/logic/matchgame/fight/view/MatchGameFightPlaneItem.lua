-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightPlaneItem.lua

module("modules.logic.matchgame.fight.view.MatchGameFightPlaneItem", package.seeall)

local MatchGameFightPlaneItem = class("MatchGameFightPlaneItem", LuaCompBase)

function MatchGameFightPlaneItem:ctor(param)
	self.param = param
	self.posXIndex = param.posXIndex
	self.posYIndex = param.posYIndex
	self.planeSizeWidth = param.planeSizeWidth
	self.sceneView = self.param.scenevView
end

function MatchGameFightPlaneItem:init(go)
	self:__onInit()

	self.go = go
end

function MatchGameFightPlaneItem:addEventListeners()
	return
end

function MatchGameFightPlaneItem:removeEventListeners()
	return
end

function MatchGameFightPlaneItem:refreshUI()
	return
end

function MatchGameFightPlaneItem:setPlaneItemPos()
	local posX, posY = MatchGameFightModel.instance:getPlaneItemAnchorPos(self.posXIndex, self.posYIndex)

	recthelper.setAnchor(self.go.transform, posX, posY)
end

function MatchGameFightPlaneItem:onDestroy()
	return
end

return MatchGameFightPlaneItem
