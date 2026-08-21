-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/forecast/model/BattleAiForecastResult.lua

module("logic.battle.battleflow.component.forecast.model.BattleAiForecastResult", package.seeall)

local BattleAiForecastResult = class("BattleAiForecastResult", AbstractGlobalReusable)

function BattleAiForecastResult:initFromAiForecastNOList(aiForecastNOList)
	self.isValid = true

	for _, aiForecastNO in ipairs(aiForecastNOList) do
		local aiForecastMO = BattleAiForecastResult.AiForecastMO:createInstance()

		aiForecastMO:initFromAiForecastNO(aiForecastNO)
		table.insert(self.aiForecastMOList, aiForecastMO)
	end

	if BattleLog.enableLog then
		BattleLog.log(self:toString())
	end
end

function BattleAiForecastResult:ctor()
	self.isValid = false
	self.aiForecastMOList = {}

	self:reuse()
end

function BattleAiForecastResult:reset()
	self.isValid = false

	BattleTableUtil.clearReusableTable(self.aiForecastMOList)
end

function BattleAiForecastResult:destroy()
	self:reset()
end

function BattleAiForecastResult:toString()
	local sb = StringBuffer.New()

	sb:append("ai forecast results:"):appendLine()

	for _, aiForecastMO in pairs(self.aiForecastMOList) do
		sb:append(aiForecastMO:toString()):appendLine()
	end

	return sb:toString()
end

BattleAiForecastResult.AiForecastMO = class("BattleAiForecastResult.AiForecastMO", AbstractGlobalReusable)

function BattleAiForecastResult.AiForecastMO:initFromAiForecastNO(aiForecastNO)
	self.fromEntityId = aiForecastNO.entity
	self.toEntityId = aiForecastNO.target
end

function BattleAiForecastResult.AiForecastMO:ctor()
	self.fromEntityId = false
	self.toEntityId = false
end

function BattleAiForecastResult.AiForecastMO:reset()
	self.fromEntityId = false
	self.toEntityId = false
end

function BattleAiForecastResult.AiForecastMO:destroy()
	self:reset()
end

function BattleAiForecastResult.AiForecastMO:isAttacker(entityId)
	return self.fromEntityId == entityId
end

function BattleAiForecastResult.AiForecastMO:isVictim(entityId)
	return self.toEntityId == entityId
end

function BattleAiForecastResult.AiForecastMO:toString()
	return string.format("AIForecast:%s->%s", self.fromEntityId, self.toEntityId)
end

return BattleAiForecastResult
