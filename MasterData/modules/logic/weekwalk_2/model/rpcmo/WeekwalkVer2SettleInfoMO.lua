-- chunkname: @modules/logic/weekwalk_2/model/rpcmo/WeekwalkVer2SettleInfoMO.lua

module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SettleInfoMO", package.seeall)

local WeekwalkVer2SettleInfoMO = pureTable("WeekwalkVer2SettleInfoMO")

function WeekwalkVer2SettleInfoMO:init(info)
	self.harmHero = WeekwalkVer2SettleHeroInfoMO.New()

	self.harmHero:init(info.harmHero)

	self.healHero = WeekwalkVer2SettleHeroInfoMO.New()

	self.healHero:init(info.healHero)

	self.hurtHero = WeekwalkVer2SettleHeroInfoMO.New()

	self.hurtHero:init(info.hurtHero)

	self.layerInfos = GameUtil.rpcInfosToMap(info.layerInfos, WeekwalkVer2SettleLayerInfoMO, "layerId")
end

return WeekwalkVer2SettleInfoMO
