-- chunkname: @modules/logic/college/model/rpcmo/CollegeCharacterMo.lua

module("modules.logic.college.model.rpcmo.CollegeCharacterMo", package.seeall)

local CollegeCharacterMo = pureTable("CollegeCharacterMo")

function CollegeCharacterMo:init(data)
	self.uid = data.uid
	self.id = data.id
	self.level = data.level
	self.entries = GameUtil.rpcInfosToList(data.entries, CollegeEntryMo)
	self.attributeContainer = GameUtil.rpcInfoToMo(data.attributeContainer, CollegeAttributeContainerMo, self.attributeContainer)
	self.co = lua_college_actor.configDict[self.id]
	self.cost = CollegeConfig.instance:getActorGrowthCost(self.id, self.level + 1)
	self.isMaxLv = self.cost == nil

	self:buildAllEntries()
end

function CollegeCharacterMo:buildAllEntries()
	self.allEntries = tabletool.copy(self.entries)

	for i = self.level + 1, #lua_college_actor_growth.configDict[self.id] do
		local lvCo = lua_college_actor_growth.configDict[self.id][i]

		if lvCo.entryPool ~= 0 then
			table.insert(self.allEntries, CollegeEntryMo.CreateLock(lvCo))
		end
	end
end

function CollegeCharacterMo:setInLocationStatus(status)
	self.inLocationStatus = status
end

function CollegeCharacterMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeCharacterMo" then
		return false
	end

	local isSame = true

	if self.uid ~= otherMo.uid then
		isSame = false

		logError(string.format("CollegeCharacterMo compareWith uid not same: %s >> %s", self.uid, otherMo.uid))
	end

	if self.id ~= otherMo.id then
		isSame = false

		logError(string.format("CollegeCharacterMo compareWith id not same: %s >> %s", self.id, otherMo.id))
	end

	if self.level ~= otherMo.level then
		isSame = false

		logError(string.format("CollegeCharacterMo compareWith level not same: %s >> %s", self.level, otherMo.level))
	end

	if #self.entries ~= #otherMo.entries then
		isSame = false

		logError(string.format("CollegeCharacterMo compareWith entries count not same: %s >> %s", #self.entries, #otherMo.entries))
	else
		for i = 1, #self.entries do
			if not self.entries[i]:compareWith(otherMo.entries[i]) then
				isSame = false

				logError(string.format("CollegeCharacterMo compareWith entries not same: id=%s", self.entries[i].id))

				break
			end
		end
	end

	if not self.attributeContainer:compareWith(otherMo.attributeContainer) then
		isSame = false

		logError("CollegeCharacterMo compareWith attributeContainer not same")
	end

	return isSame
end

function CollegeCharacterMo:getLockEntriesNum()
	local lockNum = 0

	for _, entryMo in ipairs(self.entries) do
		if entryMo.locked then
			lockNum = lockNum + 1
		end
	end

	return lockNum
end

return CollegeCharacterMo
