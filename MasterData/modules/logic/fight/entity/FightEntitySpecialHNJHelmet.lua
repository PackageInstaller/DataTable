-- chunkname: @modules/logic/fight/entity/FightEntitySpecialHNJHelmet.lua

module("modules.logic.fight.entity.FightEntitySpecialHNJHelmet", package.seeall)

local FightEntitySpecialHNJHelmet = class("FightEntitySpecialHNJHelmet", FightEntityObject)

function FightEntitySpecialHNJHelmet:getTag()
	return SceneTag.UnitNpc
end

function FightEntitySpecialHNJHelmet:onConstructor()
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntitySpecialHNJHelmet:initComponents()
	self.spine = self:addEntityComponent(self:getSpineClass())
	self.effect = self:addEntityComponent(FightEffectComp)
	self.spineRenderer = self:addEntityComponent(self:getSpineRendererClass())
end

function FightEntitySpecialHNJHelmet:resetStandPos()
	if not self.secEntityMo then
		return
	end

	if not self.helmetCo then
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

function FightEntitySpecialHNJHelmet:setSrcEntityPos(posX, posY, posZ)
	if not self.helmetCo then
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

function FightEntitySpecialHNJHelmet:setSrcEntityMo(entityMo)
	self.secEntityMo = entityMo
end

function FightEntitySpecialHNJHelmet:setHNJHelmetCo(co)
	self.helmetCo = co

	local offsetPos = self.helmetCo.pos

	self.offsetX = offsetPos[1] or 0
	self.offsetY = offsetPos[2] or 0
	self.offsetZ = offsetPos[3] or 0
end

function FightEntitySpecialHNJHelmet:setAlpha(alpha, duration)
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

function FightEntitySpecialHNJHelmet:setRenderOrder(order)
	if self.spine then
		self.spine:setRenderOrder(order)
	end
end

function FightEntitySpecialHNJHelmet:resetAnimState()
	return
end

return FightEntitySpecialHNJHelmet
