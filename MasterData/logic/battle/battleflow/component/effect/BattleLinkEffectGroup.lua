-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/effect/BattleLinkEffectGroup.lua

module("logic.battle.battleflow.component.effect.BattleLinkEffectGroup", package.seeall)

local M = class("BattleLinkEffectGroup")

function M:ctor()
	self._linkLines = {}
	self._resLoader = SingleResLoader.New()

	self:_setEvent(true)
end

function M:setUrl(url)
	self._resLoader:load(url, self._onResLoaded, self)
end

function M:destroy()
	BattleTableUtil.clearReusableTable(self._linkLines)
	self:_setEvent(false)
	self._resLoader:clear()

	self._resLoader = false
	self._linkLines = false
end

function M:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnEntityMove, self._onUnitMove, self)
		BattleDispatcher:addEventListener(BattleEventType.OnEntityDead, self._onUnitDead, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnEntityMove, self._onUnitMove, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnEntityDead, self._onUnitDead, self)
	end
end

function M:_onResLoaded()
	local resLoader = self._resLoader

	for _, line in ipairs(self._linkLines) do
		line:setGameObject(resLoader:getResInstance())
	end
end

function M:addLinkeLine(fromEntityId, toEntityId)
	fromEntityId, toEntityId = self:_judgeFromAndToEntityId(fromEntityId, toEntityId)

	if self:_indexOfLine(fromEntityId, toEntityId) then
		return false
	end

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local fromUnit = unitMgr:getUnit(fromEntityId)
	local toUnit = unitMgr:getUnit(toEntityId)
	local goInst = self._resLoader:getResInstance()
	local line = BattleLinkEffect:createInstance()

	table.insert(self._linkLines, line)
	line:setLinkEntitys(fromEntityId, toEntityId)
	line:setFromPositionXYZ(BattleUnitUtil.getUnitCenterPos(fromUnit))
	line:setToPositionXYZ(BattleUnitUtil.getUnitCenterPos(toUnit))
	line:setGameObject(goInst)
	line:showLink()

	return true
end

function M:removeLinkLine(fromEntityId, toEntityId)
	fromEntityId, toEntityId = self:_judgeFromAndToEntityId(fromEntityId, toEntityId)

	local index = self:_indexOfLine(fromEntityId, toEntityId)

	if not index then
		return false
	end

	local line = self._linkLines[index]

	self:_removeLine(line)

	return true
end

function M:removeLinkLineContainsEntityId(entityId)
	for index = #self._linkLines, 1, -1 do
		local line = self._linkLines[index]

		if line:constainsEntityId(entityId) then
			self:_removeLine(line)
		end
	end
end

function M:hasLine(fromEntityId, toEntityId)
	fromEntityId, toEntityId = self:_judgeFromAndToEntityId(fromEntityId, toEntityId)

	return self:_indexOfLine(fromEntityId, toEntityId)
end

function M:_onUnitMove(evt, entityId)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)

	if not unit then
		return
	end

	local x, y, z = BattleUnitUtil.getUnitCenterPos(unit)

	for index, line in ipairs(self._linkLines) do
		if line:isFromEntityId(entityId) then
			line:setFromPositionXYZ(x, y, z)
		elseif line:isToEntityId(entityId) then
			line:setToPositionXYZ(x, y, z)
		end
	end
end

function M:_onUnitDead(evt, entityId)
	self:removeLinkLineContainsEntityId(entityId)
end

function M:_removeLine(line)
	line:hideLink(self._onLineHideFinish, self)
end

function M:_onLineHideFinish(line)
	line:returnSelf()
	table.removebyvalue(self._linkLines, line)
end

function M:_indexOfLine(fromEntityId, toEntityId)
	for index, line in ipairs(self._linkLines) do
		if line:isTargetLink(fromEntityId, toEntityId) then
			return index
		end
	end

	return false
end

function M:_judgeFromAndToEntityId(fromEntityId, toEntityId)
	if toEntityId < fromEntityId then
		return fromEntityId, toEntityId
	end

	return toEntityId, fromEntityId
end

return M
