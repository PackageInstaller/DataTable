-- chunkname: @modules/logic/weekwalk_2/model/rpcmo/WeekwalkVer2BattleInfoMO.lua

module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2BattleInfoMO", package.seeall)

local WeekwalkVer2BattleInfoMO = pureTable("WeekwalkVer2BattleInfoMO")

function WeekwalkVer2BattleInfoMO:init(info)
	self.battleId = info.battleId
	self.status = info.status
	self.heroGroupSelect = info.heroGroupSelect
	self.elementId = info.elementId
	self.cupInfos = GameUtil.rpcInfosToMap(info.cupInfos or {}, WeekwalkVer2CupInfoMO, "index")
	self.chooseSkillIds = {}

	for i, v in ipairs(info.chooseSkillIds) do
		table.insert(self.chooseSkillIds, v)
	end

	self.heroIds = {}
	self.heroInCDMap = {}

	for i, v in ipairs(info.heroIds) do
		self.heroInCDMap[v] = true

		table.insert(self.heroIds, v)
	end

	if self.status == WeekWalk_2Enum.BattleStatus.Finished then
		self.star = WeekWalk_2Enum.MaxStar or 0
	end
end

function WeekwalkVer2BattleInfoMO:getCupMaxResult()
	local result = 0

	for k, v in pairs(self.cupInfos) do
		if result < v.result then
			result = v.result
		end
	end

	return result
end

function WeekwalkVer2BattleInfoMO:heroInCD(heroId)
	return self.heroInCDMap[heroId]
end

function WeekwalkVer2BattleInfoMO:getChooseSkillId()
	return self.chooseSkillIds[1]
end

function WeekwalkVer2BattleInfoMO:setIndex(index)
	self.index = index
end

function WeekwalkVer2BattleInfoMO:getCupInfo(index)
	return self.cupInfos[index]
end

return WeekwalkVer2BattleInfoMO
