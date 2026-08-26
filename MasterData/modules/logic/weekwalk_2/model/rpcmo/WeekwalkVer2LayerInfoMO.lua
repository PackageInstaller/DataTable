-- chunkname: @modules/logic/weekwalk_2/model/rpcmo/WeekwalkVer2LayerInfoMO.lua

module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2LayerInfoMO", package.seeall)

local WeekwalkVer2LayerInfoMO = pureTable("WeekwalkVer2LayerInfoMO")

function WeekwalkVer2LayerInfoMO:init(info)
	self.id = info.id
	self.sceneId = info.sceneId
	self.allPass = info.allPass
	self.finished = info.finished
	self.unlock = info.unlock
	self.showFinished = info.showFinished
	self.battleInfos, self.battleInfoElementMap = GameUtil.rpcInfosToListAndMap(info.battleInfos, WeekwalkVer2BattleInfoMO, "elementId")
	self.elementInfos = GameUtil.rpcInfosToMap(info.elementInfos, WeekwalkVer2ElementInfoMO, "index")
	self.battleIds = {}
	self.battleIndex = {}

	for k, v in pairs(self.elementInfos) do
		local battleInfo = self:getBattleInfoByIndex(v.index)

		battleInfo:setIndex(v.index)

		self.battleIds[v.index] = battleInfo.battleId
		self.battleIndex[battleInfo.battleId] = v.index
	end

	table.sort(self.battleInfos, function(a, b)
		if not self.battleIndex[a.battleId] then
			local aIndex = 0

			if not self.battleIndex[b.battleId] then
				local bIndex = 0

				return aIndex < bIndex
			end
		end
	end)

	self.config = lua_weekwalk_ver2.configDict[self.id]
	self.sceneConfig = lua_weekwalk_ver2_scene.configDict[self.config.sceneId]
end

function WeekwalkVer2LayerInfoMO:getBattleInfo(index)
	return self:getBattleInfoByIndex(index)
end

function WeekwalkVer2LayerInfoMO:getBattleInfoByIndex(index)
	local elementInfo = self.elementInfos[index]
	local elementId = elementInfo and elementInfo.elementId

	return elementId and self.battleInfoElementMap[elementId]
end

function WeekwalkVer2LayerInfoMO:getBattleInfoByBattleId(id)
	for k, v in pairs(self.battleInfos) do
		if v.battleId == id then
			return v
		end
	end
end

function WeekwalkVer2LayerInfoMO:getLayer()
	return self.config.layer
end

function WeekwalkVer2LayerInfoMO:getChooseSkillNum()
	return self.config.chooseSkillNum
end

function WeekwalkVer2LayerInfoMO:getHasStarIndex()
	for i = #self.battleInfos, 1, -1 do
		if self.battleInfos[i].star > 0 then
			return i
		end
	end

	return 0
end

function WeekwalkVer2LayerInfoMO:heroInCD(heroId)
	for k, v in pairs(self.battleInfos) do
		if v:heroInCD(heroId) then
			return true
		end
	end
end

return WeekwalkVer2LayerInfoMO
