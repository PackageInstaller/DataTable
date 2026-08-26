-- chunkname: @modules/logic/fightuiswitch/model/FightUIEffectMo.lua

module("modules.logic.fightuiswitch.model.FightUIEffectMo", package.seeall)

local FightUIEffectMo = class("FightUIEffectMo")

function FightUIEffectMo:initMo(id, classify)
	self.id = id
	self.classify = classify
	self.co = FightUISwitchConfig.instance:getFightUIEffectConfigById(id)
end

function FightUIEffectMo:getName()
	return (self.co or nil) and (self.co.name or "")
end

return FightUIEffectMo
