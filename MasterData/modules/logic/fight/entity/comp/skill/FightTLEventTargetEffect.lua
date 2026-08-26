-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventTargetEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventTargetEffect", package.seeall)

local FightTLEventTargetEffect = class("FightTLEventTargetEffect", FightTimelineTrackItem)
local IgnoreEffectMap = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.FIGHTSTEP] = true
}

function FightTLEventTargetEffect:onTrackStart(fightStepData, duration, paramsArr)
	self.paramsArr = paramsArr
	self.fightStepData = fightStepData
	self._delayReleaseEffect = not string.nilorempty(paramsArr[8]) and tonumber(paramsArr[8])

	if self._delayReleaseEffect then
		self._delayReleaseEffect = self._delayReleaseEffect / FightModel.instance:getSpeed()
	end

	local effectName = paramsArr[1]

	if string.nilorempty(effectName) then
		logError("目标特效名称不能为空")

		return
	end

	self._tokenRelease = not string.nilorempty(self.paramsArr[12])

	local hangPoint = paramsArr[2]
	local notHangCenter = paramsArr[3]
	local offsetX, offsetY, offsetZ = 0, 0, 0

	if paramsArr[4] then
		local arr = string.split(paramsArr[4], ",")

		offsetX = arr[1] and tonumber(arr[1]) or offsetX
		offsetY = arr[2] and tonumber(arr[2]) or offsetY
		offsetZ = arr[3] and tonumber(arr[3]) or offsetZ
	end

	local renderOrder = tonumber(paramsArr[5]) or -1
	local entitys = {}

	if string.nilorempty(paramsArr[6]) or paramsArr[6] == "1" then
		local entity = FightHelper.getEntity(fightStepData.toId)

		if entity then
			table.insert(entitys, entity)
		end
	elseif not string.nilorempty(paramsArr[9]) then
		local arr = string.splitToNumber(paramsArr[9], "#")
		local dic = {}

		for i, v in ipairs(arr) do
			dic[v] = v
		end

		for _, effect in ipairs(fightStepData.actEffect) do
			if dic[effect.effectType] then
				local entity = FightHelper.getEntity(effect.targetId)

				if entity then
					local attacker = FightHelper.getEntity(self.fightStepData.fromId)
					local needAdd = false

					if paramsArr[6] == "2" then
						needAdd = true
					elseif paramsArr[6] == "3" then
						needAdd = entity:getSide() == attacker:getSide()
					elseif paramsArr[6] == "4" then
						needAdd = entity:getSide() ~= attacker:getSide()
					end

					if needAdd and not tabletool.indexOf(entitys, entity) then
						table.insert(entitys, entity)
					end
				end
			end
		end
	else
		for _, effect in ipairs(fightStepData.actEffect) do
			local actEffectData = effect

			if not ((actEffectData.effectType == FightEnum.EffectType.SHIELD and not FightHelper.checkShieldHit(actEffectData) or nil) and true) and not IgnoreEffectMap[effect.effectType] then
				local entity = FightHelper.getEntity(effect.targetId)

				if entity then
					local attacker = FightHelper.getEntity(self.fightStepData.fromId)
					local needAdd = false

					if paramsArr[6] == "2" then
						needAdd = true
					elseif paramsArr[6] == "3" then
						needAdd = entity:getSide() == attacker:getSide()
					elseif paramsArr[6] == "4" then
						needAdd = entity:getSide() ~= attacker:getSide()
					end

					if needAdd and not tabletool.indexOf(entitys, entity) then
						table.insert(entitys, entity)
					end
				end
			end
		end
	end

	if not string.nilorempty(paramsArr[7]) then
		entitys = {}

		local deadEntityMgr = self:com_sendMsg(FightMsgId.GetDeadEntityMgr)
		local arr = string.splitToNumber(paramsArr[7], "#")

		for k, v in pairs(deadEntityMgr.entityDic) do
			local entityMO = v:getMO()

			if entityMO and tabletool.indexOf(arr, entityMO.skin) then
				table.insert(entitys, v)
			end
		end
	end

	local releaseToken = paramsArr[13]

	releaseToken = not string.nilorempty(releaseToken) and releaseToken

	if releaseToken then
		for _, entity in ipairs(entitys) do
			entity.effect:_onInvokeTokenRelease(releaseToken)
		end

		return
	end

	if #entitys > 0 then
		self._effectWrapDict = {}

		local audioId = tonumber(paramsArr[10])

		for _, entity in ipairs(entitys) do
			local effectWrap = self:_createEffect(entity, effectName, hangPoint, notHangCenter, offsetX, offsetY, offsetZ)

			self:_setRenderOrder(entity.id, effectWrap, renderOrder)

			self._effectWrapDict[entity] = effectWrap

			if audioId then
				AudioMgr.instance:trigger(audioId)
			end
		end
	end
end

function FightTLEventTargetEffect:onTrackEnd()
	self:_removeEffect()
end

function FightTLEventTargetEffect:_createEffect(entity, effectName, hangPoint, notHangCenter, offsetX, offsetY, offsetZ)
	local attacker = FightHelper.getEntity(self.fightStepData.fromId)
	local effectWrap

	if not string.nilorempty(hangPoint) then
		effectWrap = entity.effect:addHangEffect(effectName, hangPoint, attacker:getSide(), self._delayReleaseEffect)

		effectWrap:setLocalPos(offsetX, offsetY, offsetZ)

		local workY = tonumber(self.paramsArr[11])

		if workY then
			local containerTr = effectWrap.containerTr

			if containerTr then
				local x, y, z = transformhelper.getPos(containerTr)

				effectWrap:setWorldPos(x, workY, z)
			end
		end
	else
		effectWrap = entity.effect:addGlobalEffect(effectName, attacker:getSide(), self._delayReleaseEffect)

		local posX, posY, posZ

		if notHangCenter == "0" then
			posX, posY, posZ = FightHelper.getEntityWorldBottomPos(entity)
		elseif notHangCenter == "1" then
			posX, posY, posZ = FightHelper.getEntityWorldCenterPos(entity)
		elseif notHangCenter == "2" then
			posX, posY, posZ = FightHelper.getEntityWorldTopPos(entity)
		elseif notHangCenter == "3" then
			posX, posY, posZ = FightHelper.getProcessEntitySpinePos(entity)
		else
			local hangPointGO = not string.nilorempty(notHangCenter) and entity:getHangPoint(notHangCenter)

			if hangPointGO then
				local hangPointPosition = hangPointGO.transform.position

				posZ = hangPointPosition.z
				posY = hangPointPosition.y
				posX = hangPointPosition.x
			else
				posX, posY, posZ = FightHelper.getEntityWorldCenterPos(entity)
			end
		end

		if entity:isMySide() then
			if not -offsetX then
				local offsetX2 = offsetX

				effectWrap:setWorldPos(posX + offsetX2, posY + offsetY, posZ + offsetZ)

				local workY = tonumber(self.paramsArr[11])

				if workY then
					local containerTr = effectWrap.containerTr

					if containerTr then
						local x, y, z = transformhelper.getPos(containerTr)

						effectWrap:setWorldPos(x, workY, z)
					end
				end
			end
		end
	end

	if self._tokenRelease then
		entity.effect:addTokenRelease(self.paramsArr[12], effectWrap)
	end

	return effectWrap
end

function FightTLEventTargetEffect:_setRenderOrder(entityId, effectWrap, renderOrder)
	if renderOrder == -1 then
		FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)
	else
		FightRenderOrderMgr.instance:setEffectOrder(effectWrap, renderOrder)
	end
end

function FightTLEventTargetEffect:onDestructor()
	self:_removeEffect()
end

function FightTLEventTargetEffect:_removeEffect()
	if self._effectWrapDict and not self._delayReleaseEffect and not self._tokenRelease then
		for entity, effectWrap in pairs(self._effectWrapDict) do
			FightRenderOrderMgr.instance:onRemoveEffectWrap(entity.id, effectWrap)
			entity.effect:removeEffect(effectWrap)
		end
	end

	self._effectWrapDict = nil
end

return FightTLEventTargetEffect
