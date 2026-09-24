-- chunkname: @modules/logic/fight/entity/FightEntitySpecialHNJ.lua

module("modules.logic.fight.entity.FightEntitySpecialHNJ", package.seeall)

local FightEntitySpecialHNJ = class("FightEntitySpecialHNJ", FightEntityObject)

function FightEntitySpecialHNJ:getTag()
	return SceneTag.UnitNpc
end

function FightEntitySpecialHNJ:onConstructor()
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntitySpecialHNJ:initComponents()
	self.spine = self:addEntityComponent(self:getSpineClass())
	self.effect = self:addEntityComponent(FightEffectComp)
	self.spineRenderer = self:addEntityComponent(self:getSpineRendererClass())
end

function FightEntitySpecialHNJ:resetStandPos()
	if not self.secEntityMo then
		return
	end

	if not self.specialCo then
		return
	end

	if not gohelper.isNil(self.go) then
		local posX, posY, posZ = FightHelper.getEntityStandPos(self.secEntityMo)

		posX = posX + self.offsetX
		posY = posY + self.offsetY
		posZ = posZ + self.offsetZ

		transformhelper.setLocalPos(self.goTransform, posX, posY, posZ)
	end
end

function FightEntitySpecialHNJ:setSrcEntityPos(posX, posY, posZ)
	if not self.specialCo then
		return
	end

	if gohelper.isNil(self.go) then
		return
	end

	posX = posX + self.offsetX
	posY = posY + self.offsetY
	posZ = posZ + self.offsetZ

	transformhelper.setPos(self.goTransform, posX, posY, posZ)
end

function FightEntitySpecialHNJ:setSrcEntityMo(entityMo)
	self.secEntityMo = entityMo
end

function FightEntitySpecialHNJ:setHNJSpecialCo(co)
	self.specialCo = co

	local offsetPos = self.specialCo.pos

	self.offsetX = offsetPos[1] or 0
	self.offsetY = offsetPos[2] or 0
	self.offsetZ = offsetPos[3] or 0
end

function FightEntitySpecialHNJ:setAlpha(alpha, duration)
	self.marked_alpha = alpha

	if self.spineRenderer then
		self.spineRenderer:setAlpha(alpha, duration)
	end

	if self.buff then
		if alpha == 0 then
			self.buff:hideBuffEffects()
		elseif alpha == 1 then
			self.buff:showBuffEffects()
		end
	end

	if self.skinSpineEffect then
		if alpha == 0 then
			self.skinSpineEffect:hideEffects()
		else
			self.skinSpineEffect:showEffects()
		end
	end
end

function FightEntitySpecialHNJ:setRenderOrder(order)
	if self.spine then
		self.spine:setRenderOrder(order)
	end
end

return FightEntitySpecialHNJ
