-- chunkname: @modules/logic/fight/entity/mgr/FightRenderOrderMgr.lua

module("modules.logic.fight.entity.mgr.FightRenderOrderMgr", package.seeall)

local FightRenderOrderMgr = class("FightRenderOrderMgr")
local sortIndex = -1

local function getIndex()
	sortIndex = sortIndex + 1

	return sortIndex
end

FightRenderOrderMgr.MaxOrder = 20 * FightEnum.OrderRegion
FightRenderOrderMgr.MinOrder = getIndex()
FightRenderOrderMgr.LYEffect = getIndex()
FightRenderOrderMgr.AssistBossOrder = getIndex()
FightRenderOrderMgr.Act191Boss = getIndex()
FightRenderOrderMgr.Boss3_9 = getIndex()
FightRenderOrderMgr.NuoDiKa = getIndex()
FightRenderOrderMgr.MinSpecialOrder = sortIndex

function FightRenderOrderMgr:init()
	self._registIdList = {}
	self._entityId2OrderSort = {}
	self._entityId2OrderFixed = {}
	self._entityId2WrapList = {}
	self._renderOrderType = FightEnum.RenderOrderType.StandPos
end

function FightRenderOrderMgr:setSortType(renderOrderType)
	self._renderOrderType = renderOrderType

	self:refreshRenderOrder()
end

function FightRenderOrderMgr:refreshRenderOrder(keepOrderPriorityDict)
	self._entityId2OrderSort = FightRenderOrderMgr.sortOrder(self._renderOrderType, self._registIdList, keepOrderPriorityDict)

	for _, entityId in ipairs(self._registIdList) do
		self:_resetRenderOrder(entityId)
	end
end

function FightRenderOrderMgr:dispose()
	self._registIdList = nil
	self._entityId2OrderSort = nil
	self._entityId2OrderFixed = nil
	self._entityId2WrapList = nil

	TaskDispatcher.cancelTask(self.refreshRenderOrder, self)
end

function FightRenderOrderMgr:register(entityId)
	TaskDispatcher.cancelTask(self.refreshRenderOrder, self)
	TaskDispatcher.runDelay(self.refreshRenderOrder, self, 0.1)
	table.insert(self._registIdList, entityId)
end

function FightRenderOrderMgr:unregister(entityId)
	if self._registIdList then
		tabletool.removeValue(self._registIdList, entityId)
	end

	if self._entityId2OrderFixed then
		self._entityId2OrderFixed[entityId] = nil
	end
end

function FightRenderOrderMgr:onAddEffectWrap(entityId, effectWrap)
	if not self._entityId2WrapList then
		return
	end

	self._entityId2WrapList[entityId] = self._entityId2WrapList[entityId] or {}

	table.insert(self._entityId2WrapList[entityId], effectWrap)

	local order = self:getOrder(entityId)

	effectWrap:setRenderOrder(order)
end

function FightRenderOrderMgr:addEffectWrapByOrder(entityId, effectWrap, order)
	if not self._entityId2WrapList then
		return
	end

	self._entityId2WrapList[entityId] = self._entityId2WrapList[entityId] or {}

	table.insert(self._entityId2WrapList[entityId], effectWrap)

	order = order or FightEnum.OrderRegion

	effectWrap:setRenderOrder(order)
end

function FightRenderOrderMgr:onRemoveEffectWrap(entityId, effectWrap)
	if self._entityId2WrapList and self._entityId2WrapList[entityId] then
		tabletool.removeValue(self._entityId2WrapList[entityId], effectWrap)
	end

	effectWrap:setRenderOrder(0)
end

function FightRenderOrderMgr:setEffectOrder(effectWrap, order)
	effectWrap:setRenderOrder(order * FightEnum.OrderRegion)
end

function FightRenderOrderMgr:setOrder(entityId, order)
	self._entityId2OrderFixed[entityId] = order

	self:_resetRenderOrder(entityId)
end

function FightRenderOrderMgr:cancelOrder(entityId)
	if self._entityId2OrderFixed and self._entityId2OrderFixed[entityId] then
		self._entityId2OrderFixed[entityId] = nil

		self:_resetRenderOrder(entityId)
	end
end

function FightRenderOrderMgr:_resetRenderOrder(entityId)
	local order = self:getOrder(entityId)
	local entity = FightGameMgr.entityMgr:getEntity(entityId)

	if entity then
		entity:setRenderOrder(order)
	end

	local effectWrapList = self._entityId2WrapList[entityId]

	if effectWrapList then
		for _, effectWrap in ipairs(effectWrapList) do
			effectWrap:setRenderOrder(order)
		end
	end
end

function FightRenderOrderMgr:getOrder(entityId)
	local order = 1

	if self._entityId2OrderFixed[entityId] then
		order = self._entityId2OrderFixed[entityId]
	elseif self._entityId2OrderSort[entityId] then
		order = self._entityId2OrderSort[entityId]
	end

	return order * FightEnum.OrderRegion
end

function FightRenderOrderMgr.sortOrder(renderOrderType, entityIdList, keepOrderPriorityDict)
	local result = {}

	if renderOrderType == FightEnum.RenderOrderType.SameOrder then
		return result
	end

	local list = {}

	for _, entityId in ipairs(entityIdList) do
		local entity = FightHelper.getEntity(entityId)
		local keepOrder

		if keepOrderPriorityDict and keepOrderPriorityDict[entityId] then
			keepOrder = keepOrderPriorityDict[entityId]
		end

		if entity then
			if renderOrderType == FightEnum.RenderOrderType.StandPos then
				local _, _, z = FightHelper.getEntityStandPos(entity:getMO())

				table.insert(list, {
					entityId,
					z,
					keepOrder
				})
			elseif renderOrderType == FightEnum.RenderOrderType.ZPos then
				local _, _, z = transformhelper.getPos(entity.go.transform)

				table.insert(list, {
					entityId,
					z,
					keepOrder
				})
			end
		end
	end

	table.sort(list, function(m1, m2)
		if m1[2] ~= m2[2] then
			return m1[2] > m2[2]
		elseif m1[3] and m2[3] and m1[3] ~= m2[3] then
			return m1[3] > m2[3]
		else
			return tonumber(m1[1]) < tonumber(m2[1])
		end
	end)

	local counter = 1

	for _, item in ipairs(list) do
		local entityId = item[1]

		result[entityId] = counter
		counter = counter + 1
	end

	local assembledMonsterIndex

	for k, v in pairs(result) do
		local tarEntity = FightHelper.getEntity(k)

		if FightHelper.isAssembledMonster(tarEntity) then
			assembledMonsterIndex = assembledMonsterIndex or v
			result[k] = assembledMonsterIndex
		end
	end

	local minSpecialOrder = FightRenderOrderMgr.MinSpecialOrder

	for k, order in pairs(result) do
		result[k] = order + minSpecialOrder
	end

	for k, _ in pairs(result) do
		local entityData = FightDataHelper.entityMgr:getById(k)

		if FightDataHelper.entityMgr:isAssistBoss(k) then
			result[k] = FightRenderOrderMgr.AssistBossOrder
		end

		if entityData.entityType == FightEnum.EntityType.Act191Boss then
			result[k] = FightRenderOrderMgr.Act191Boss
		end

		if entityData.skin == 670415 then
			result[k] = FightRenderOrderMgr.Boss3_9
		end
	end

	return result
end

FightRenderOrderMgr.instance = FightRenderOrderMgr.New()

return FightRenderOrderMgr
