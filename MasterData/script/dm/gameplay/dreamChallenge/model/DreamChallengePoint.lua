-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamChallenge/model/DreamChallengePoint.lua

DreamChallengePoint = class("DreamChallengePoint", objectlua.Object)

DreamChallengePoint:has("_pointId", {
	is = "rw"
})
DreamChallengePoint:has("_pointConfig", {
	is = "rw"
})
DreamChallengePoint:has("_battleIds", {
	is = "rw"
})
DreamChallengePoint:has("_dreamBattles", {
	is = "rw"
})
DreamChallengePoint:has("_fatigue", {
	is = "rw"
})
DreamChallengePoint:has("_buffs", {
	is = "rw"
})
DreamChallengePoint:has("_points", {
	is = "rw"
})

function DreamChallengePoint:initialize(pointId)
	super.initialize(self)

	self._pointId = pointId
	self._pointConfig = ConfigReader:requireRecordById("DreamChallengePoint", self._pointId)
	self._battleIds = self._pointConfig.BlockPoint
	self._dreamBattles = {}
	self._fatigue = {}
	self._points = {}
	self._buffs = {}

	for i = 1, #self._battleIds do
		self._dreamBattles[self._battleIds[i]] = ConfigReader:requireRecordById("DreamChallengeBattle", self._battleIds[i])
	end
end

function DreamChallengePoint:synchronize(data)
	if data.fatigue then
		for k, v in pairs(data.fatigue) do
			self._fatigue[k] = v
		end
	end

	if data.buffs then
		for k, v in pairs(data.buffs) do
			local skillId = k

			if self._buffs[skillId] then
				if v.duration then
					self._buffs[skillId].duration = v.duration
				end

				if v.targetType then
					self._buffs[skillId].targetType = v.targetType
				end

				if v.target then
					self._buffs[skillId].target = v.target
				end

				if v.time then
					self._buffs[skillId].time = v.time
				end

				if v.buffType then
					self._buffs[skillId].buffType = v.buffType
				end

				if v.pointId then
					self._buffs[skillId].pointId = v.pointId
				end

				if v.skillId then
					self._buffs[skillId].skillId = v.skillId
				end
			else
				self._buffs[skillId] = {}
				self._buffs[skillId] = v
			end
		end
	end

	if data.points then
		local i = 1

		for _, v in pairs(data.points) do
			self._points[i] = v
			i = i + 1
		end
	end
end

function DreamChallengePoint:delete(data)
	if data and data.points then
		self._points = {}
	end

	if data and data.buffs then
		self._buffs = {}
	end

	if data and data.fatigue then
		self._fatigue = {}
	end
end

function DreamChallengePoint:getPointShowCond()
	return self._pointConfig.ShowCondition
end

function DreamChallengePoint:getPointLockCond()
	return self._pointConfig.UnlockCondition
end

function DreamChallengePoint:isPass()
	if #self._points == #self._battleIds then
		return true
	end

	return false
end

function DreamChallengePoint:isBattlePass(battleId)
	for i = 1, #self._points do
		if battleId == self._points[i] then
			return true
		end
	end

	return false
end

function DreamChallengePoint:checkHeroTired(heroId)
	if self._fatigue[heroId] and self._fatigue[heroId] <= 0 then
		return true
	end

	return false
end

function DreamChallengePoint:checkHeroLocked(heroInfo)
	local condition = self._pointConfig.screen

	if condition.Down and #condition.Down > 0 then
		for i = 1, #condition.Down do
			if condition.Down[i].type == "job" and condition.Down[i].value == heroInfo.type then
				return true
			end

			if condition.Down[i].type == "Party" and condition.Down[i].value == heroInfo.party then
				return true
			end

			if condition.Down[i].type == "Tag" and heroInfo.flags and #heroInfo.flags > 0 then
				for j = 1, #heroInfo.flags do
					if heroInfo.flags[j] == condition.Down[i].value then
						return true
					end
				end
			end
		end
	end

	if condition.Up and #condition.Up > 0 then
		for i = 1, #condition.Up do
			if condition.Up[i].type == "job" and condition.Up[i].value == heroInfo.type then
				return false
			end

			if condition.Up[i].type == "Party" and condition.Up[i].value == heroInfo.party then
				return false
			end

			if condition.Up[i].type == "Tag" and heroInfo.flags and #heroInfo.flags > 0 then
				for j = 1, #heroInfo.flags do
					if heroInfo.flags[j] == condition.Up[i].value then
						return false
					end
				end
			end
		end

		return true
	end

	return false
end

function DreamChallengePoint:checkHeroRecomand(heroInfo)
	local recomandData = self._pointConfig.Excellent

	for i = 1, #recomandData do
		local data = recomandData[i]

		if data.Hero and #data.Hero > 0 then
			for j = 1, #data.Hero do
				if data.Hero[j] == heroInfo.id then
					return true
				end
			end
		end

		if data.Party and #data.Party > 0 then
			for j = 1, #data.Party do
				if data.Party[j] == heroInfo.party then
					return true
				end
			end
		end

		if data.job and #data.job > 0 then
			for j = 1, #data.job do
				if data.job[j] == heroInfo.type then
					return true
				end
			end
		end

		if data.Tag and #data.Tag > 0 then
			for j = 1, #data.Tag do
				if data.Tag[j] == heroInfo.flags then
					return true
				end
			end
		end
	end

	return false
end

function DreamChallengePoint:getMasterList()
	return self._pointConfig.Master
end

function DreamChallengePoint:getPointFatigue()
	return self._pointConfig.fatigue
end

function DreamChallengePoint:getPointFatigueByHeroId(heroId)
	if self._fatigue[heroId] then
		return self._fatigue[heroId]
	end

	return self._pointConfig.fatigue
end

function DreamChallengePoint:getRecomandMaster()
	local recomandData = self._pointConfig.Excellent

	for i = 1, #recomandData do
		local data = recomandData[i]

		if data.Master then
			return data.Master, data.Skill
		end
	end

	return {}, {}
end

function DreamChallengePoint:getRecomandHero()
	local recomandData = self._pointConfig.Excellent

	for i = 1, #recomandData do
		local data = recomandData[i]

		if data.Hero then
			return data.Hero, data.Skill
		end
	end

	return {}, {}
end

function DreamChallengePoint:getRecomandParty()
	local recomandData = self._pointConfig.Excellent

	for i = 1, #recomandData do
		local data = recomandData[i]

		if data.Party then
			return data.Party, data.Skill
		end
	end

	return {}, {}
end

function DreamChallengePoint:getRecomandJob()
	local recomandData = self._pointConfig.Excellent

	for i = 1, #recomandData do
		local data = recomandData[i]

		if data.job then
			return data.job, data.Skill
		end
	end

	return {}, {}
end

function DreamChallengePoint:getRecomandTag()
	local recomandData = self._pointConfig.Excellent

	for i = 1, #recomandData do
		local data = recomandData[i]

		if data.Tag then
			return data.Tag, data.Skill
		end
	end

	return {}, {}
end

function DreamChallengePoint:getPointName()
	return self._pointConfig.Name
end

function DreamChallengePoint:getNpc(battleId)
	local npc = {}

	if self._dreamBattles[battleId].NPC and #self._dreamBattles[battleId].NPC > 0 then
		for i = 1, #self._dreamBattles[battleId].NPC do
			npc[#npc + 1] = self._dreamBattles[battleId].NPC[i].id
		end
	end

	return npc
end

function DreamChallengePoint:getNpcForbidId(battleId)
	local npc = {}

	if self._dreamBattles[battleId].NPC and #self._dreamBattles[battleId].NPC > 0 then
		for i = 1, #self._dreamBattles[battleId].NPC do
			npc[#npc + 1] = self._dreamBattles[battleId].NPC[i].forbidid
		end
	end

	return npc
end

function DreamChallengePoint:getFullStarSkill()
	return self._pointConfig.StarsAttrEffect
end

function DreamChallengePoint:getAwakenSkill()
	return self._pointConfig.AwakenAttrEffect
end

function DreamChallengePoint:getBattleLockCond(battleId)
	return self._dreamBattles[battleId].UnlockCondition
end

function DreamChallengePoint:getBattleBackground(battleId)
	return self._dreamBattles[battleId].Pic .. ".png"
end

function DreamChallengePoint:getBattleReward(battleId)
	return self._dreamBattles[battleId].Showreward
end

function DreamChallengePoint:getPointShowImg()
	return self._pointConfig.Pic .. ".jpg"
end

function DreamChallengePoint:getPointMapShowImg()
	return self._pointConfig.PointBackground .. ".jpg"
end

function DreamChallengePoint:getPointLongDesc()
	return Strings:get(self._pointConfig.Desc)
end

function DreamChallengePoint:getPointTabImage()
	return self._pointConfig.TabPic .. ".png"
end

function DreamChallengePoint:getPointShowReward()
	return self._pointConfig.Show
end

function DreamChallengePoint:getShortDesc()
	return self._pointConfig.ShortDesc
end

function DreamChallengePoint:getPointScreen()
	return self._pointConfig.screen
end
