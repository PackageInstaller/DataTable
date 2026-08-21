-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/forecast/model/BattleForecastHaloMO.lua

module("logic.battle.battleflow.component.forecast.model.BattleForecastHaloMO", package.seeall)

local BattleForecastHaloMO = class("BattleForecastHaloMO", AbstractGlobalReusable)

function BattleForecastHaloMO:parseFromHaloLinkedNO(haloLinkedNO)
	local haloLinkedMO = BattleForecastHaloMO:createInstance()

	haloLinkedMO:initFromHaloLinkedNO(haloLinkedNO)

	return haloLinkedMO
end

function BattleForecastHaloMO:initFromHaloLinkedNO(haloLinkedNO)
	self.fromEntityId = haloLinkedNO.fromEntity
	self.toEntityId = haloLinkedNO.toEntity
	self.fromSkill = haloLinkedNO.fromSkill
end

function BattleForecastHaloMO:ctor()
	self.fromEntityId = false
	self.toEntityId = false
	self.fromSkill = false
end

function BattleForecastHaloMO:reset()
	self.fromEntityId = false
	self.toEntityId = false
	self.fromSkill = false
end

function BattleForecastHaloMO:destroy()
	self.fromEntityId = nil
	self.toEntityId = nil
	self.fromSkill = false
end

function BattleForecastHaloMO:toString()
	return string.format("halo from [%s] to [%s]", self.fromEntityId, self.toEntityId)
end

return BattleForecastHaloMO
