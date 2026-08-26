-- chunkname: @modules/logic/fight/entity/FightTemp3DEntityObject.lua

module("modules.logic.fight.entity.FightTemp3DEntityObject", package.seeall)

local FightTemp3DEntityObject = class("FightTemp3DEntityObject", FightEntityObject)

function FightTemp3DEntityObject:getTag()
	return SceneTag.UnitNpc
end

function FightTemp3DEntityObject:onConstructor()
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightTemp3DEntityObject:initComponents()
	self.effect = self:addEntityComponent(FightEffectComp)
	self.spine = self:addEntityComponent(Fight3DSpineComp)
	self.spineRenderer = self:addEntityComponent(Fight3DSpineRendererComp)
	self.moveComp = self:addEntityComponent(FightEntityMoveComp)
	self.variantHeart = self:addEntityComponent(FightVariantHeartComp)
	self.entityVisible = self:addEntityComponent(FightEntityVisibleComp)
end

function FightTemp3DEntityObject:getHangPoint(hangPointName, noProcess)
	if not hangPointName then
		return self.go
	end

	local existHangPoint = self._hangPointDict[hangPointName]

	if existHangPoint then
		return existHangPoint
	elseif self.spine then
		local spineGO = self.spine:getSpineGO()

		if not spineGO then
			return self.go
		end

		if not self.hangMap then
			self.hangMap = {}

			local config3D = lua_fight_monster_3d.configDict[self.entityData.skin]

			if config3D then
				local arr = string.split(config3D.hangMap, "|")

				for i, v in ipairs(arr) do
					local hangPoint = string.split(v, "#")

					self.hangMap[hangPoint[1]] = hangPoint[2]
				end
			end
		end

		if not self.hangMap[hangPointName] then
			logError("没有配置3D模型挂点, " .. hangPointName)

			self._hangPointDict[hangPointName] = spineGO

			return spineGO
		end

		local obj = gohelper.findChild(spineGO, self.hangMap[hangPointName] or "")

		return obj or spineGO
	end
end

function FightTemp3DEntityObject:onDestructor()
	return
end

return FightTemp3DEntityObject
