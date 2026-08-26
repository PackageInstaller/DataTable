-- chunkname: @modules/logic/fight/entity/Fight3DEntityObject.lua

module("modules.logic.fight.entity.Fight3DEntityObject", package.seeall)

local Fight3DEntityObject = class("Fight3DEntityObject", FightEntityObject)

function Fight3DEntityObject:getTag()
	return SceneTag.UnitMonster
end

function Fight3DEntityObject:initComponents()
	Fight3DEntityObject.super.initComponents(self)

	self.nameUIVisible = self:addEntityComponent(FightNameUIVisibleComp)
	self.entityVisible = self:addEntityComponent(FightEntityVisibleComp)
end

function Fight3DEntityObject:getHangPoint(hangPointName, noProcess)
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

		if string.find(hangPointName, ModuleEnum.SpineHangPoint.BodyStatic) then
			if self.bodyStaticRoot then
				return self.bodyStaticRoot
			end

			local findHangPointGO = gohelper.create3d(spineGO, hangPointName)

			self.bodyStaticRoot = findHangPointGO

			transformhelper.setLocalPos(findHangPointGO.transform, FightHelper.getEntityLocalCenterPos(self))

			return findHangPointGO
		end

		if not self.hangMap then
			self.hangMap = {}
			self.buffHangMap = {}

			local config3D = lua_fight_monster_3d.configDict[self.entityData.skin]
			local arr = string.split(config3D.hangMap, "|")

			for i, v in ipairs(arr) do
				local hangPoint = string.split(v, "#")

				self.hangMap[hangPoint[1]] = hangPoint[2]
			end

			local buffId2Hang = string.split(config3D.buffId2hang, "|")

			for i, v in ipairs(buffId2Hang) do
				if not string.nilorempty(v) then
					local hangPoint = string.split(v, "#")

					if not hangPoint[2] then
						local buffId = tonumber(hangPoint[1])

						self.buffHangMap[hangPoint[2]] = self.buffHangMap[hangPoint[2]] or {}
						self.buffHangMap[hangPoint[2]][buffId] = hangPoint[3]
					end
				end
			end
		end

		if not self.hangMap[hangPointName] then
			self._hangPointDict[hangPointName] = spineGO

			return spineGO
		end

		local hangName = self.hangMap[hangPointName]

		if self.buffHangMap[hangName] then
			for buffId, v in pairs(self.buffHangMap[hangName]) do
				if self.buff:haveBuffId(buffId) then
					hangName = v

					break
				end
			end
		end

		local obj = gohelper.findChild(spineGO, hangName or "")

		return obj or spineGO
	end
end

function Fight3DEntityObject:onDestructor()
	return
end

return Fight3DEntityObject
