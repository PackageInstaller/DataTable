-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventRefreshRenderOrder.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventRefreshRenderOrder", package.seeall)

local FightTLEventRefreshRenderOrder = class("FightTLEventRefreshRenderOrder", FightTimelineTrackItem)

function FightTLEventRefreshRenderOrder:onTrackStart(fightStepData, duration, paramsArr)
	local attacker = FightHelper.getEntity(fightStepData.fromId)
	local sideEntitys = FightHelper.getSideEntitys(attacker:getSide(), true)
	local defenders = FightHelper.getDefenders(fightStepData, true)

	for _, entity in ipairs(sideEntitys) do
		FightRenderOrderMgr.instance:cancelOrder(entity.id)
	end

	local renderType = tonumber(paramsArr[1])

	FightRenderOrderMgr.instance:setSortType(renderType)

	if renderType == FightEnum.RenderOrderType.ZPos then
		self._keepOrderPriorityDict = {}
		self._keepOrderPriorityDict[attacker.id] = 0

		for i, defender in ipairs(defenders) do
			self._keepOrderPriorityDict[defender.id] = 1
		end

		local refreshInterval = tonumber(paramsArr[2]) or 0.33

		TaskDispatcher.runRepeat(self._refreshOrder, self, refreshInterval)
	end
end

function FightTLEventRefreshRenderOrder:_refreshOrder()
	FightRenderOrderMgr.instance:refreshRenderOrder(self._keepOrderPriorityDict)
end

function FightTLEventRefreshRenderOrder:onDestructor()
	self._keepOrderPriorityDict = nil

	TaskDispatcher.cancelTask(self._refreshOrder, self)
end

return FightTLEventRefreshRenderOrder
