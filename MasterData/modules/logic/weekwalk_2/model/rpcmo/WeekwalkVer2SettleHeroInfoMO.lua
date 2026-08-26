-- chunkname: @modules/logic/weekwalk_2/model/rpcmo/WeekwalkVer2SettleHeroInfoMO.lua

module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SettleHeroInfoMO", package.seeall)

local WeekwalkVer2SettleHeroInfoMO = pureTable("WeekwalkVer2SettleHeroInfoMO")

function WeekwalkVer2SettleHeroInfoMO:init(info)
	self.heroId = info.heroId
	self.allHarm = info.allHarm
	self.singleHighHarm = info.singleHighHarm
	self.allHurt = info.allHurt
	self.allHeal = info.allHeal
	self.allHealed = info.allHealed
	self.battleNum = info.battleNum
end

return WeekwalkVer2SettleHeroInfoMO
