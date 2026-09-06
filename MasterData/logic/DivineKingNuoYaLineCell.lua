-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/view/DivineKingNuoYaLineCell.lua

module("logic.extensions.divinekingnuoya.view.DivineKingNuoYaLineCell", package.seeall)

local DivineKingNuoYaLineCell = class("DivineKingNuoYaLineCell", ViewComponent)

function DivineKingNuoYaLineCell:ctor(luaComponentContainer)
	DivineKingNuoYaLineCell.super.ctor(self)

	self._mainGo = luaComponentContainer.gameObject
	self._spriteChange = self._mainGo:GetComponent(ComponentType.UIImageSpriteChange)
end

function DivineKingNuoYaLineCell:bindEvents()
	DivineKingNuoYaLineCell.super.bindEvents(self)
end

function DivineKingNuoYaLineCell:unbindEvents()
	DivineKingNuoYaLineCell.super.unbindEvents(self)
end

function DivineKingNuoYaLineCell:onExit()
	DivineKingNuoYaLineCell.super.onExit(self)
	self:setRotation(0, 0, 0)
	self:setPos(0, 0, 0)
end

function DivineKingNuoYaLineCell:onEnter()
	DivineKingNuoYaLineCell.super.onEnter(self)
end

function DivineKingNuoYaLineCell:setRotation(x, y, z)
	GameUtil.setLocalRotation(self._mainGo, x, y, z)
end

function DivineKingNuoYaLineCell:setPos(x, y, z)
	GameUtil.setLocalPos(self._mainGo, x, y, z)
end

function DivineKingNuoYaLineCell:setShowMode(showMode)
	self._spriteChange:SetState(showMode - 1)
end

return DivineKingNuoYaLineCell
