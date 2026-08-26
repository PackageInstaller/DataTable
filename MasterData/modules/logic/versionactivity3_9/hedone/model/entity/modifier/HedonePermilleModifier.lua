-- chunkname: @modules/logic/versionactivity3_9/hedone/model/entity/modifier/HedonePermilleModifier.lua

module("modules.logic.versionactivity3_9.hedone.model.entity.modifier.HedonePermilleModifier", package.seeall)

local HedonePermilleModifier = class("HedonePermilleModifier", HedoneBaseModifier)

function HedonePermilleModifier:onModify(attrValue)
	return attrValue * self._modVal / HedoneGameEnum.Const.PermillageBase
end

function HedonePermilleModifier:getModAffectType()
	return HedoneGameEnum.BuffAffectType.changeAttrPermille
end

return HedonePermilleModifier
