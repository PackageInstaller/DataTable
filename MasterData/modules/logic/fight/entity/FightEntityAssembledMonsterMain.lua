-- chunkname: @modules/logic/fight/entity/FightEntityAssembledMonsterMain.lua

module("modules.logic.fight.entity.FightEntityAssembledMonsterMain", package.seeall)

local FightEntityAssembledMonsterMain = class("FightEntityAssembledMonsterMain", FightEntityMonster)

function FightEntityAssembledMonsterMain:getHangPoint(hangPointName, noProcess)
	if not noProcess and not string.nilorempty(hangPointName) and ModuleEnum.SpineHangPointRoot ~= hangPointName then
		hangPointName = string.format("%s_part_%d", hangPointName, self:getPartIndex())
	end

	return FightEntityAssembledMonsterMain.super.getHangPoint(self, hangPointName)
end

function FightEntityAssembledMonsterMain:getBuffAnim()
	local buffList = {}
	local AniDic = {}
	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)

	for i, v in ipairs(entityList) do
		if (isTypeOf(v, FightEntityAssembledMonsterMain) or isTypeOf(v, FightEntityAssembledMonsterSub)) and v.buff then
			local buffAnim, buffMO = v.buff:getBuffAnim()

			if buffAnim then
				table.insert(buffList, buffMO)

				AniDic[buffMO.uid] = buffAnim
			end
		end
	end

	if #buffList > 0 then
		table.sort(buffList, FightBuffComp.buffCompareFuncAni)

		return AniDic[buffList[1].uid]
	end
end

function FightEntityAssembledMonsterMain:getDefaultMatName()
	local buffList = {}
	local matDic = {}
	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)

	for i, v in ipairs(entityList) do
		if (isTypeOf(v, FightEntityAssembledMonsterMain) or isTypeOf(v, FightEntityAssembledMonsterSub)) and v.buff then
			local buffMat, buffMO = v.buff:getBuffMatName()

			if buffMat then
				table.insert(buffList, buffMO)

				matDic[buffMO.uid] = buffMat
			end
		end
	end

	if #buffList > 0 then
		table.sort(buffList, FightBuffComp.buffCompareFuncMat)

		return matDic[buffList[1].uid]
	end
end

function FightEntityAssembledMonsterMain:setAlpha(alpha, duration)
	self:setAlphaData(self.id, alpha, duration)
end

function FightEntityAssembledMonsterMain:setAlphaData(entityId, alpha, duration)
	self._alphaDic = self._alphaDic or {}
	self._alphaDic[entityId] = alpha

	for k, v in pairs(self._alphaDic) do
		if v ~= alpha then
			FightEntityAssembledMonsterMain.super.setAlpha(self, 1, 0)

			local tarEntity = FightHelper.getEntity(k)

			if tarEntity ~= self then
				tarEntity.super.setAlpha(tarEntity, 1, 0)
			end

			return
		end
	end

	FightEntityAssembledMonsterMain.super.setAlpha(self, alpha, duration)

	for k, v in pairs(self._alphaDic) do
		local tarEntity = FightHelper.getEntity(k)

		if tarEntity ~= self then
			tarEntity.super.setAlpha(tarEntity, alpha, duration)
		end
	end
end

function FightEntityAssembledMonsterMain:initComponents()
	FightEntityAssembledMonsterMain.super.initComponents(self)
end

function FightEntityAssembledMonsterMain:getSpineClass()
	return FightAssembledMonsterSpine
end

function FightEntityAssembledMonsterMain:getPartIndex()
	local entityMO = self:getMO()

	if entityMO then
		return lua_fight_assembled_monster.configDict[entityMO.skin].part
	end
end

function FightEntityAssembledMonsterMain:killAllSubMonster()
	local entityMgr = FightGameMgr.entityMgr
	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)

	for i, v in ipairs(entityList) do
		if FightHelper.isAssembledMonster(v) and v ~= self then
			entityMgr:delEntity(v.id)

			local entityMO = FightDataHelper.entityMgr:getById(v.id)

			entityMO:setDead()
			FightDataHelper.entityMgr:addDeadUid(entityMO.id)

			if self._alphaDic then
				self._alphaDic[v.id] = nil
			end
		end
	end
end

return FightEntityAssembledMonsterMain
