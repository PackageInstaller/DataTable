-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/TeamChessUnitEntityMgr.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.TeamChessUnitEntityMgr", package.seeall)

local TeamChessUnitEntityMgr = class("TeamChessUnitEntityMgr")

function TeamChessUnitEntityMgr:ctor()
	self._entitys = {}
	self.emptyEntity = {}
end

function TeamChessUnitEntityMgr:addEntity(unitMo, parent)
	local id = unitMo:getUid()

	if self._entitys[id] then
		return self._entitys[id]
	end

	local go = gohelper.create3d(parent, id)
	local entity

	if unitMo.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		entity = MonoHelper.addNoUpdateLuaComOnceToGo(go, TeamChessPlayerSoldierUnit)
	end

	if unitMo.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		entity = MonoHelper.addNoUpdateLuaComOnceToGo(go, TeamChessEnemySoldierUnit)
	end

	if entity == nil then
		logError("TeamChessUnitEntityMgr:addEntity entity is nil.. type: " .. unitMo.teamType)

		entity = MonoHelper.addNoUpdateLuaComOnceToGo(go, TeamChessSoldierUnit)
	end

	entity:updateMo(unitMo)

	self._entitys[id] = entity

	return entity
end

function TeamChessUnitEntityMgr:getEmptyEntity(parent, soliderId)
	local path = EliminateConfig.instance:getSoldierChessModelPath(soliderId)

	if self.emptyEntity[path] then
		return self.emptyEntity[path]
	end

	if gohelper.isNil(parent) then
		return nil
	end

	local go = gohelper.create3d(parent, "tempEmpty")
	local config = EliminateConfig.instance:getSoldierChessConfig(soliderId)
	local entity = MonoHelper.addNoUpdateLuaComOnceToGo(go, TeamChessEmptyUnit)

	entity:init(go)
	entity:setScale(config.resZoom)
	entity:setPath(path)

	self.emptyEntity[path] = entity

	return entity
end

function TeamChessUnitEntityMgr:setAllEmptyEntityActive(active)
	for _, entity in pairs(self.emptyEntity) do
		if entity then
			entity:setActive(active)
		end
	end
end

function TeamChessUnitEntityMgr:getEntity(id)
	return self._entitys[id]
end

function TeamChessUnitEntityMgr:getAllEntity()
	return self._entitys
end

function TeamChessUnitEntityMgr:removeEntity(id)
	if self._entitys[id] then
		self._entitys[id]:dispose()

		self._entitys[id] = nil
	end
end

function TeamChessUnitEntityMgr:setAllEntityActive(active)
	for _, entity in pairs(self._entitys) do
		if entity then
			if active then
				entity:updatePosByTr()
			end

			entity:setActive(active)
		end
	end
end

function TeamChessUnitEntityMgr:setAllEntityActiveAndPlayAni(active)
	for _, entity in pairs(self._entitys) do
		if entity then
			if active then
				entity:updatePosByTr()
			end

			entity:setActiveAndPlayAni(active)
		end
	end
end

function TeamChessUnitEntityMgr:setAllEntityCanClick(active)
	for _, entity in pairs(self._entitys) do
		if entity then
			entity:setCanClick(active)
		end
	end
end

function TeamChessUnitEntityMgr:setAllEntityCanDrag(active)
	for _, entity in pairs(self._entitys) do
		if entity then
			entity:setCanDrag(active)
		end
	end
end

function TeamChessUnitEntityMgr:setOutlineActive(uid, active)
	if active then
		if not EliminateTeamChessEnum.ModeType.outline then
			local showMode = EliminateTeamChessEnum.ModeType.Normal

			if self._entitys and self._entitys[uid] then
				self._entitys[uid]:setShowModeType(showMode)
			end
		end
	end
end

function TeamChessUnitEntityMgr:setGrayActive(uid, active)
	if active then
		if not EliminateTeamChessEnum.ModeType.Gray then
			local showMode = EliminateTeamChessEnum.ModeType.Normal

			if self._entitys and self._entitys[uid] then
				self._entitys[uid]:setShowModeType(showMode)
			end
		end
	end
end

function TeamChessUnitEntityMgr:moveEntityByTeamTypeAndStrongHold(teamType, strongholdId, targetTr, rectWidth, rectHeight)
	for _, entity in pairs(self._entitys) do
		if entity and entity._unitMo.teamType == teamType and entity._unitMo.stronghold == strongholdId then
			entity:moveToPosByTargetTr(targetTr, rectWidth, rectHeight)
		end
	end
end

function TeamChessUnitEntityMgr:resetEntityPosByTeamTypeAndStrongHold(teamType, strongholdId)
	for _, entity in pairs(self._entitys) do
		if entity and entity._unitMo.teamType == teamType and entity._unitMo.stronghold == strongholdId then
			entity:movePosByTr()
		end
	end
end

function TeamChessUnitEntityMgr:cacheAllEntityShowMode()
	if self.entityCacheMode == nil then
		self.entityCacheMode = {}
	end

	for key, entity in pairs(self._entitys) do
		if entity then
			self.entityCacheMode[key] = entity:getShowModeType()
		end
	end
end

function TeamChessUnitEntityMgr:setAllEntityNormal()
	for _, entity in pairs(self._entitys) do
		if entity then
			entity:setShowModeType(EliminateTeamChessEnum.ModeType.Normal)
		end
	end
end

function TeamChessUnitEntityMgr:cacheEntityShowMode(strongHoldId)
	if self.entityCacheMode == nil then
		self.entityCacheMode = {}
	end

	for key, entity in pairs(self._entitys) do
		if entity and entity._unitMo.stronghold == strongHoldId then
			self.entityCacheMode[key] = entity:getShowModeType()
		end
	end
end

function TeamChessUnitEntityMgr:restoreEntityShowMode()
	if self.entityCacheMode == nil then
		return
	end

	for uid, mode in pairs(self.entityCacheMode) do
		local entity = self._entitys[uid]

		if entity then
			entity:setShowModeType(mode)
		end
	end

	tabletool.clear(self.entityCacheMode)
end

function TeamChessUnitEntityMgr:setTempShowModeAndCacheByTeamType(teamType, showMode)
	for uid, entity in pairs(self._entitys) do
		if entity and entity._unitMo.teamType == teamType and uid ~= EliminateTeamChessEnum.tempPieceUid then
			entity:cacheModel()
			entity:setShowModeType(showMode)
		end
	end
end

function TeamChessUnitEntityMgr:restoreTempShowModeAndCacheByTeamType(teamType)
	for _, entity in pairs(self._entitys) do
		if entity and entity._unitMo.teamType == teamType then
			entity:restoreModel()
		end
	end
end

function TeamChessUnitEntityMgr:refreshShowModeStateByTeamType(teamType)
	for _, entity in pairs(self._entitys) do
		if entity and entity._unitMo.teamType == teamType then
			entity:refreshShowModeState()
		end
	end
end

function TeamChessUnitEntityMgr:clear()
	for _, entity in pairs(self._entitys) do
		entity:dispose()
	end

	for _, entity in pairs(self.emptyEntity) do
		entity:dispose()
	end

	self._entitys = {}
	self.emptyEntity = {}
end

TeamChessUnitEntityMgr.instance = TeamChessUnitEntityMgr.New()

return TeamChessUnitEntityMgr
