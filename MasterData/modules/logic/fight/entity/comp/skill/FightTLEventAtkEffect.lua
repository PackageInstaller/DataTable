-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventAtkEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventAtkEffect", package.seeall)

local FightTLEventAtkEffect = class("FightTLEventAtkEffect", FightTimelineTrackItem)

function FightTLEventAtkEffect:onTrackStart(fightStepData, duration, paramsArr)
	if not FightHelper.detectTimelinePlayEffectCondition(fightStepData, paramsArr[10]) then
		return
	end

	self._attacker = FightHelper.getEntity(fightStepData.fromId)

	if not self._attacker then
		return
	end

	if self._attacker.skill and self._attacker.skill:atkEffectNeedFilter(paramsArr[1], fightStepData) then
		return
	end

	self.fightStepData = fightStepData
	self.duration = duration
	self.paramsArr = paramsArr
	self.release_time = not string.nilorempty(paramsArr[9]) and paramsArr[9] ~= "0" and tonumber(paramsArr[9])
	self._tokenRelease = not string.nilorempty(paramsArr[14])

	local entityParam = paramsArr[6]

	if entityParam == "1" then
		self._targetEntity = self._attacker
	elseif not string.nilorempty(entityParam) then
		local entityMgr = FightGameMgr.entityMgr
		local entityId = fightStepData.stepUid .. "_" .. entityParam
		local tempEntity = entityMgr:getEntity(entityId)

		if tempEntity then
			self._targetEntity = tempEntity
		else
			self.load_entity_id = entityId

			FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)

			return
		end
	else
		self._targetEntity = self._attacker
	end

	self:_bootLogic(fightStepData, duration, paramsArr)

	if not string.nilorempty(paramsArr[11]) then
		AudioMgr.instance:trigger(tonumber(paramsArr[11]))
	end
end

function FightTLEventAtkEffect:_bootLogic(fightStepData, duration, paramsArr)
	self._effectName = paramsArr[1]

	if not string.nilorempty(paramsArr[12]) then
		local entityMO = self._attacker:getMO()
		local skinId = entityMO and entityMO.skin

		if skinId then
			local skinArr = string.split(paramsArr[12], "|")

			for i, v in ipairs(skinArr) do
				local arr = string.split(v, "#")

				if tonumber(arr[1]) == skinId then
					self._effectName = arr[2]

					break
				end
			end
		end
	end

	self._hangPoint = paramsArr[2]
	self._offsetX, self._offsetY, self._offsetZ = 0, 0, 0

	if paramsArr[3] then
		local arr = string.split(paramsArr[3], ",")

		self._offsetX = arr[1] and tonumber(arr[1]) or self._offsetX
		self._offsetY = arr[2] and tonumber(arr[2]) or self._offsetY
		self._offsetZ = arr[3] and tonumber(arr[3]) or self._offsetZ
	end

	local renderOrder = tonumber(paramsArr[4]) or -1

	self._notHangCenter = paramsArr[5]

	local followEntityMove = paramsArr[7] == "1"
	local lockRotationZero = paramsArr[8] == "1"

	if self._targetEntity and not self._targetEntity:isMySide() then
		self._offsetX = -self._offsetX
	end

	if string.nilorempty(self._effectName) then
		logError("atk effect name is nil,攻击特效配了空，")
	else
		self._effectWrap = self:_createEffect(self._effectName, self._hangPoint)

		if self._effectWrap then
			if self._tokenRelease then
				self._attacker.effect:addTokenRelease(self.paramsArr[14], self._effectWrap)
			end

			self._roundRelease = not string.nilorempty(paramsArr[15])

			if self._roundRelease then
				self._attacker.effect:addRoundRelease(tonumber(paramsArr[15]), self._effectWrap)
			end

			self:_setRenderOrder(self._effectWrap, renderOrder)

			if string.nilorempty(self._hangPoint) and followEntityMove then
				TaskDispatcher.runRepeat(self._onFrameUpdateEffectPos, self, 0.01)
			end

			if lockRotationZero then
				TaskDispatcher.runRepeat(self._onFrameUpdateEffectRotation, self, 0.01)
			end

			if not string.nilorempty(paramsArr[13]) then
				local arr = string.split(paramsArr[13], "#")
				local effectDistance = arr[1]
				local standardDistanceOffset = arr[2]

				effectDistance = effectDistance + standardDistanceOffset

				local fromEntity = FightHelper.getEntity(fightStepData.fromId)
				local toEntity = FightHelper.getEntity(fightStepData.toId)

				if fromEntity and toEntity then
					local fromPosX, fromPosY, fromPosZ = transformhelper.getLocalPos(fromEntity.go.transform)
					local toPosX, toPosY, toPosZ = transformhelper.getLocalPos(toEntity.go.transform)
					local distance = math.abs(fromPosX - toPosX) + standardDistanceOffset
					local scale = distance / effectDistance

					if self._effectWrap.containerTr then
						local curPosX, curPosY, curPosZ = transformhelper.getLocalPos(self._effectWrap.containerTr)
						local curScaleX, curScaleY, curScaleZ = transformhelper.getLocalScale(self._effectWrap.containerTr)

						transformhelper.setLocalScale(self._effectWrap.containerTr, scale, curScaleY, curScaleZ)
						transformhelper.setLocalPos(self._effectWrap.containerTr, curPosX, curPosY, curPosZ)
					end
				end
			end
		end
	end
end

function FightTLEventAtkEffect:onTrackEnd()
	self:_removeEffect()
end

function FightTLEventAtkEffect:_createEffect()
	local effectWrap

	if not string.nilorempty(self._hangPoint) then
		local pos = {
			x = self._offsetX,
			y = self._offsetY,
			z = self._offsetZ
		}

		effectWrap = self._targetEntity.effect:addHangEffect(self._effectName, self._hangPoint, nil, self.release_time, pos)

		effectWrap:setLocalPos(self._offsetX, self._offsetY, self._offsetZ)
	else
		effectWrap = self._targetEntity.effect:addGlobalEffect(self._effectName, nil, self.release_time)

		local posX, posY, posZ = self:_getTargetPosXYZ()

		effectWrap:setWorldPos(posX + self._offsetX, posY + self._offsetY, posZ + self._offsetZ)
	end

	if self.paramsArr[1] == "v2a2_tsnn/tsnn_unique_08_s5" or self.paramsArr[1] == "v2a2_tsnn/tsnn_unique_09_s6" then
		TaskDispatcher.runRepeat(function()
			effectWrap:setLocalPos(0, 0, 0)
		end, self, 0.01, 5)
	end

	return effectWrap
end

function FightTLEventAtkEffect:_getTargetPosXYZ()
	local posX, posY, posZ

	if self._notHangCenter == "0" then
		posX, posY, posZ = FightHelper.getEntityWorldBottomPos(self._targetEntity)
	elseif self._notHangCenter == "1" then
		posX, posY, posZ = FightHelper.getEntityWorldCenterPos(self._targetEntity)
	elseif self._notHangCenter == "2" then
		posX, posY, posZ = FightHelper.getEntityWorldTopPos(self._targetEntity)
	elseif self._notHangCenter == "3" then
		posX, posY, posZ = transformhelper.getPos(self._targetEntity.go.transform)
	elseif self._notHangCenter == "4" then
		local entityMO = FightDataHelper.entityMgr:getById(self._targetEntity.id)

		posX, posY, posZ = FightHelper.getEntityStandPos(entityMO)
	else
		local hangPointGO = not string.nilorempty(self._notHangCenter) and self._targetEntity:getHangPoint(self._notHangCenter)

		if hangPointGO then
			local hangPointPosition = hangPointGO.transform.position

			posZ = hangPointPosition.z
			posY = hangPointPosition.y
			posX = hangPointPosition.x
		else
			posX, posY, posZ = transformhelper.getPos(self._targetEntity.go.transform)
		end
	end

	return posX, posY, posZ
end

function FightTLEventAtkEffect:_setRenderOrder(effectWrap, renderOrder)
	if renderOrder == -1 then
		FightRenderOrderMgr.instance:onAddEffectWrap(self._attacker.id, effectWrap)
	else
		FightRenderOrderMgr.instance:setEffectOrder(effectWrap, renderOrder)
	end
end

function FightTLEventAtkEffect:_onFrameUpdateEffectPos()
	if not self._targetEntity then
		return
	end

	if gohelper.isNil(self._targetEntity.go) then
		return
	end

	if self._effectWrap then
		local posX, posY, posZ = self:_getTargetPosXYZ()

		self._effectWrap:setWorldPos(posX + self._offsetX, posY + self._offsetY, posZ + self._offsetZ)
	end
end

function FightTLEventAtkEffect:_onFrameUpdateEffectRotation()
	if not self._targetEntity then
		return
	end

	if gohelper.isNil(self._targetEntity.go) then
		return
	end

	if self._effectWrap and not gohelper.isNil(self._effectWrap.containerTr) then
		transformhelper.setRotation(self._effectWrap.containerTr, 0, 0, 0, 1)
	end
end

function FightTLEventAtkEffect:_onSpineLoaded(tar_spine)
	if tar_spine and tar_spine.unitSpawn and tar_spine.unitSpawn.id == self.load_entity_id then
		self._targetEntity = tar_spine.unitSpawn

		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
		self:_bootLogic(self.fightStepData, self.duration, self.paramsArr)
	end
end

function FightTLEventAtkEffect:onDestructor()
	self:_removeEffect()
	TaskDispatcher.cancelTask(self._onFrameUpdateEffectPos, self)
	TaskDispatcher.cancelTask(self._onFrameUpdateEffectRotation, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
end

function FightTLEventAtkEffect:_removeEffect()
	if self._effectWrap then
		local canRelease = not self.release_time

		if self._tokenRelease then
			canRelease = false
		end

		if (self._roundRelease or nil) and false then
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self._targetEntity.id, self._effectWrap)
			self._targetEntity.effect:removeEffect(self._effectWrap)

			self._effectWrap = nil
		end
	end

	self._targetEntity = nil
end

return FightTLEventAtkEffect
