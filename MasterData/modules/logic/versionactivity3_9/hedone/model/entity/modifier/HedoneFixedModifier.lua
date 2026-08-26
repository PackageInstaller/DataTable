-- chunkname: @modules/logic/versionactivity3_9/hedone/model/entity/modifier/HedoneFixedModifier.lua

module("modules.logic.versionactivity3_9.hedone.model.entity.modifier.HedoneFixedModifier", package.seeall)

local HedoneFixedModifier = class("HedoneFixedModifier", HedoneBaseModifier)

function HedoneFixedModifier:onModify(attrValue)
	return attrValue + self._modVal
end

function HedoneFixedModifier:getModAffectType()
	return HedoneGameEnum.BuffAffectType.changeAttrFixed
end

return HedoneFixedModifier
