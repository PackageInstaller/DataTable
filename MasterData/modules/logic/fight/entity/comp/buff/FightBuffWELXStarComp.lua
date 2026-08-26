-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffWELXStarComp.lua

module("modules.logic.fight.entity.comp.buff.FightBuffWELXStarComp", package.seeall)

local FightBuffWELXStarComp = class("FightBuffWELXStarComp", FightBuffHandleClsBase)

FightBuffWELXStarComp.MoveTweenTime = 0.5

function FightBuffWELXStarComp:onBuffStart(entity, buffMo)
	self.entityId = entity.id
	self.entity = entity
	self.entityMo = entity:getMO()

	self:initValidBuffDict()
	self:initOffsetXY()

	self.movingTweenId = nil
	self.effectPool = {}
	self.effectItemPool = {}
	self.effectItemList = {}
	self.bornningBuffUidDict = {}
	self.removingBuffUidDict = {}
	self.updateHandle = UpdateBeat:CreateListener(self.onFrameUpdate, self)

	UpdateBeat:AddListener(self.updateHandle)
	self:initStar()
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, self.onUpdateBuff, self)
end

function FightBuffWELXStarComp:getEffectItem(effectWrap, buffUid, buffId)
	local effectItem = table.remove(self.effectItemPool)

	effectItem = effectItem or {}
	effectItem.effectWrap = effectWrap
	effectItem.buffUid = buffUid
	effectItem.buffId = buffId

	local _, y, _ = self:getEffectWrapLocalPos(effectWrap)

	effectItem.startY = y
	effectItem.targetY = y

	return effectItem
end

function FightBuffWELXStarComp:recycleEffectItem(effectItem)
	effectItem.effectWrap = nil
	effectItem.buffUid = nil
	effectItem.buffId = nil
	effectItem.startY = nil
	effectItem.targetY = nil

	table.insert(self.effectItemPool, effectItem)
end

function FightBuffWELXStarComp:initValidBuffDict()
	self.validBuffDict = {}

	for buffId, _ in pairs(lua_fight_sp_wuerlixi_monster_star_effect.configDict) do
		self.validBuffDict[buffId] = true
	end
end

function FightBuffWELXStarComp:initOffsetXY()
	local modelId = self.entityMo.modelId
	local offsetCo = lua_fight_sp_wuerlixi_monster_star_position_offset.configDict[modelId]

	offsetCo = offsetCo or lua_fight_sp_wuerlixi_monster_star_position_offset.configDict[0]
	self.offsetX = offsetCo.offsetX
	self.offsetY = offsetCo.offsetY
end

function FightBuffWELXStarComp:initStar()
	local buffList = self.entityMo:getOrderedBuffList_ByTime()

	for _, buffMo in ipairs(buffList) do
		local buffId = buffMo.buffId

		if self.validBuffDict[buffId] then
			local co = lua_fight_sp_wuerlixi_monster_star_effect.configDict[buffId]

			if co then
				local effectWrap = self:getEffectWrap(co.effect)
				local effectItem = self:getEffectItem(effectWrap, buffMo.uid, buffId)

				effectWrap:setActive(true, FightBuffWELXStarComp.EffectRecycleKey)
				table.insert(self.effectItemList, effectItem)
			end
		end
	end

	self:refreshEffectPos()
end

function FightBuffWELXStarComp:refreshEffectPos()
	if self.movingTweenId then
		return
	end

	local usedHeight = 0

	for _, effectItem in ipairs(self.effectItemList) do
		local buffId = effectItem.buffId
		local co = lua_fight_sp_wuerlixi_monster_star_effect.configDict[buffId]

		if co then
			local effectWrap = effectItem.effectWrap

			effectWrap:setLocalPos(self.offsetX, self.offsetY + usedHeight, 0)

			usedHeight = usedHeight + co.height
		end
	end
end

function FightBuffWELXStarComp:onUpdateBuff(entityId, effectType, buffId, buffUid)
	if entityId ~= self.entityId then
		return
	end

	if not self.validBuffDict[buffId] then
		return
	end

	if effectType == FightEnum.EffectType.BUFFADD then
		self:onAddBuff(buffId, buffUid)
	elseif effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
		self:onRemoveBuff(buffId, buffUid)
	end
end

function FightBuffWELXStarComp:onAddBuff(buffId, buffUid)
	local co = lua_fight_sp_wuerlixi_monster_star_effect.configDict[buffId]

	if not co then
		return
	end

	if self.movingTweenId then
		ZProj.TweenHelper.KillById(self.movingTweenId)
	end

	local bornEffect = co.bornEffect
	local effectWrap

	if not string.nilorempty(bornEffect) then
		local duration = co.bornEffectDuration

		self.bornningBuffUidDict[buffUid] = Time.realtimeSinceStartup + duration
		effectWrap = self.entity.effect:addHangEffect(bornEffect, ModuleEnum.SpineHangPointRoot, nil, duration + 0.1)
	else
		effectWrap = self:getEffectWrap(co.effect)
	end

	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, effectWrap)
	effectWrap:setLocalPos(self.offsetX, self.offsetY, 0)

	local height = co.height

	for _, effectItem in ipairs(self.effectItemList) do
		local _, y, _ = self:getEffectWrapLocalPos(effectItem.effectWrap)

		effectItem.startY = y
		effectItem.targetY = self.movingTweenId and effectItem.targetY + height or y + height
	end

	local effectItem = self:getEffectItem(effectWrap, buffUid, buffId)

	table.insert(self.effectItemList, 1, effectItem)

	self.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, FightBuffWELXStarComp.MoveTweenTime, self.onMovingTweenFrameCallback, self.onMovingTweenDone, self)
end

function FightBuffWELXStarComp:onMovingTweenFrameCallback(value)
	for _, effectItem in ipairs(self.effectItemList) do
		local x, _, z = self:getEffectWrapLocalPos(effectItem.effectWrap)
		local startY, targetY = effectItem.startY, effectItem.targetY
		local y = startY + (targetY - startY) * value

		effectItem.effectWrap:setLocalPos(x, y, z)
	end
end

function FightBuffWELXStarComp:onMovingTweenDone()
	self.movingTweenId = nil

	for _, effectItem in ipairs(self.effectItemList) do
		local _, y, _ = self:getEffectWrapLocalPos(effectItem.effectWrap)

		effectItem.startY = y
		effectItem.targetY = y
	end

	self:refreshEffectPos()
end

function FightBuffWELXStarComp:onRemoveBuff(buffId, buffUid)
	for index, effectItem in ipairs(self.effectItemList) do
		if effectItem.buffUid == buffUid then
			local srcEffectWrap = effectItem.effectWrap
			local co = lua_fight_sp_wuerlixi_monster_star_effect.configDict[buffId]
			local disappearEffectDuration = 0

			if co then
				local disappearEffect = co.disAppearEffect

				if not string.nilorempty(disappearEffect) then
					disappearEffectDuration = co.disAppearEffectDuration

					local effectWrap = self.entity.effect:addHangEffect(disappearEffect, ModuleEnum.SpineHangPointRoot, nil, co.disAppearEffectDuration)

					FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, effectWrap)
					effectWrap:setLocalPos(self:getEffectWrapLocalPos(srcEffectWrap))

					effectItem.effectWrap = effectWrap
				end
			end

			self:recycleEffect(srcEffectWrap)

			if disappearEffectDuration > 0 then
				self.removingBuffUidDict[buffUid] = Time.realtimeSinceStartup + disappearEffectDuration

				break
			end

			self:_frameRemoveEffectItem(buffUid)

			break
		end
	end
end

function FightBuffWELXStarComp:getEffectWrap(effectRes)
	local pool = self.effectPool[effectRes]

	if pool and #pool > 0 then
		return table.remove(pool)
	end

	local effectWrap = self.entity.effect:addHangEffect(effectRes, ModuleEnum.SpineHangPointRoot)

	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, effectWrap)
	self.entity.buff:addLoopBuff(effectWrap)

	return effectWrap
end

FightBuffWELXStarComp.EffectRecycleKey = "FightBuffWELXStarComp_EffectRecycleKey"

function FightBuffWELXStarComp:recycleEffect(effectWrap)
	local resPath = effectWrap.path
	local pool = self.effectPool[resPath]

	if not pool then
		pool = {}
		self.effectPool[resPath] = pool
	end

	effectWrap:setActive(false, FightBuffWELXStarComp.EffectRecycleKey)
	table.insert(pool, effectWrap)
end

function FightBuffWELXStarComp:clear()
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, self.onUpdateBuff, self)

	local effectComp = self.entity.effect

	if self.effectItemList then
		for _, effectItem in ipairs(self.effectItemList) do
			local effectWrap = effectItem.effectWrap

			effectComp:removeEffect(effectWrap)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, effectWrap)
			self.entity.buff:removeLoopBuff(effectWrap)
		end

		self.effectItemList = nil
	end

	if self.effectPool then
		for _, effectList in pairs(self.effectPool) do
			for _, effectWrap in ipairs(effectList) do
				effectComp:removeEffect(effectWrap)
				FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, effectWrap)
				self.entity.buff:removeLoopBuff(effectWrap)
			end
		end

		self.effectPool = nil
	end

	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)

		self.updateHandle = nil
	end

	if self.movingTweenId then
		ZProj.TweenHelper.KillById(self.movingTweenId)

		self.movingTweenId = nil
	end
end

function FightBuffWELXStarComp:onFrameUpdate()
	local curTime = Time.realtimeSinceStartup

	for buffUid, endTime in pairs(self.bornningBuffUidDict) do
		if endTime <= curTime then
			self.bornningBuffUidDict[buffUid] = nil

			self:_frameAddBuffEffect(buffUid)
		end
	end

	for buffUid, endTime in pairs(self.removingBuffUidDict) do
		if endTime <= curTime then
			self.removingBuffUidDict[buffUid] = nil

			self:_frameRemoveEffectItem(buffUid)
		end
	end
end

function FightBuffWELXStarComp:_frameAddBuffEffect(buffUid)
	local buffMo = self.entityMo:getBuffMO(buffUid)

	if buffMo then
		local buffId = buffMo.buffId
		local co = lua_fight_sp_wuerlixi_monster_star_effect.configDict[buffId]

		if co then
			local effectWrap = self:getEffectWrap(co.effect)

			effectWrap:setActive(true, FightBuffWELXStarComp.EffectRecycleKey)

			for _, effectItem in ipairs(self.effectItemList) do
				if effectItem.buffUid == buffUid then
					local x, y, z = self:getEffectWrapLocalPos(effectItem.effectWrap)

					effectWrap:setLocalPos(x, y, z)

					effectItem.effectWrap = effectWrap

					break
				end
			end
		end
	end
end

function FightBuffWELXStarComp:_frameRemoveEffectItem(buffUid)
	for index, effectItem in ipairs(self.effectItemList) do
		if effectItem.buffUid == buffUid then
			self:recycleEffectItem(effectItem)
			table.remove(self.effectItemList, index)

			break
		end
	end

	self:refreshEffectPos()
end

function FightBuffWELXStarComp:getEffectWrapLocalPos(effectWrap)
	if not effectWrap then
		return 0, 0, 0
	end

	local tr = effectWrap.containerTr

	if not tr then
		return 0, 0, 0
	end

	return transformhelper.getLocalPos(tr)
end

return FightBuffWELXStarComp
