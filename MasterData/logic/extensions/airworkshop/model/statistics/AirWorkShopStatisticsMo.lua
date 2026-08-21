-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/statistics/AirWorkShopStatisticsMo.lua

module("logic.extensions.airworkshop.model.statistics.AirWorkShopStatisticsMo", package.seeall)

local M = class("AirWorkShopStatisticsMo")

function M:ctor()
	return
end

function M:updateFromServer(id, msg)
	self._id = id

	self:_buildDataLstAtk(msg.attackData)
	self:_buildDataLstDef(msg.defenceData)
	self:setUpdateTimeStamp(ServerTime.now())
	self:setDataDirty(false)
end

function M:getId()
	return self._id
end

function M:getAttackDataLst()
	return self._dataLstAtk
end

function M:getDefDataLst()
	return self._dataLstDef
end

function M:setDataDirty(dirty)
	self._dataDirty = dirty
end

function M:getDataDirty()
	return self._dataDirty
end

function M:getUpdateTimeStamp()
	return self._updateTimeStamp
end

function M:setUpdateTimeStamp(ts)
	self._updateTimeStamp = ts
end

function M:_buildDataLstAtk(lstAttackDataNO)
	self._dataLstAtk = {}

	if lstAttackDataNO and #lstAttackDataNO > 0 then
		for _, AttackDataNO in ipairs(lstAttackDataNO) do
			local data = {}

			data.heroId = AttackDataNO.heroId
			data.count = AttackDataNO.count
			data.thinkingId = AttackDataNO.thinkingId
			data.echoItemId = AttackDataNO.echoItemId

			table.insert(self._dataLstAtk, data)
		end
	end
end

function M:_buildDataLstDef(lstDefenceDataNO)
	self._dataLstDef = {}

	if lstDefenceDataNO and #lstDefenceDataNO > 0 then
		for _, DefenceDataNO in ipairs(lstDefenceDataNO) do
			local data = {}

			data.heroId = DefenceDataNO.heroId
			data.kill = {}

			for _, targetHeroNO in ipairs(DefenceDataNO.kill or {}) do
				table.insert(data.kill, self:_buildDataTargetHeroNO(targetHeroNO))
			end

			data.beKill = {}

			for _, targetHeroNO in ipairs(DefenceDataNO.beKill or {}) do
				table.insert(data.beKill, self:_buildDataTargetHeroNO(targetHeroNO))
			end

			table.insert(self._dataLstDef, data)
		end
	end
end

function M:_buildDataTargetHeroNO(targetHeroNO)
	local data = {}

	data.heroId = targetHeroNO.heroId
	data.count = targetHeroNO.count

	return data
end

return M
