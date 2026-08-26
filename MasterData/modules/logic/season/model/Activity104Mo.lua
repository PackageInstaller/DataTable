-- chunkname: @modules/logic/season/model/Activity104Mo.lua

module("modules.logic.season.model.Activity104Mo", package.seeall)

local Activity104Mo = pureTable("Activity104Mo")

function Activity104Mo:ctor()
	self.activityId = 0
	self.activity104Items = {}
	self.episodes = {}
	self.retails = {}
	self.specials = {}
	self.unlockEquipIndexs = {}
	self.optionalEquipCount = 0
	self.heroGroupSnapshot = {}
	self.tempHeroGroupSnapshot = {}
	self.heroGroupSnapshotSubId = 1
	self.retailStage = 1
	self.unlockActivity104EquipIds = {}
	self.activity104ItemCountDict = {}
	self.trialId = 0
	self.isPopSummary = true
	self.lastMaxLayer = 0
end

function Activity104Mo:init(info)
	self.activityId = info.activityId
	self.activity104Items = self:_buildItems(info.activity104Items)
	self.episodes = self:_buildEpisodes(info.episodes)
	self.retails = self:_buildRetails(info.retails)
	self.specials = self:_buildSpecials(info.specials)
	self.unlockEquipIndexs = self:_buildList(info.unlockEquipIndexs)
	self.optionalEquipCount = info.optionalEquipCount
	self.heroGroupSnapshot = self:_buildSnapshot(info.heroGroupSnapshot)
	self.heroGroupSnapshotSubId = info.heroGroupSnapshotSubId
	self.retailStage = info.retailStage

	self:setUnlockActivity104EquipIds(info.unlockActivity104EquipIds)

	self.readActivity104Story = info.readActivity104Story
	self.trialId = info.trial.id
	self.isPopSummary = info.preSummary.isPopSummary
	self.lastMaxLayer = info.preSummary.maxLayer

	self:refreshItemCount()
end

function Activity104Mo:reset(info)
	self.activityId = info.activityId
	self.trialId = info.trial.id

	self:_addUnlockEquipIndexs(info.unlockEquipIndexs)

	self.optionalEquipCount = info.optionalEquipCount

	for _, v in ipairs(info.updateEpisodes) do
		if not self.episodes[v.layer] then
			self.episodes[v.layer] = Activity104EpisodeMo.New()

			self.episodes[v.layer]:init(v)
		else
			self.episodes[v.layer]:reset(v)
		end
	end

	self.retails = self:_buildRetails(info.retails)

	for _, v in ipairs(info.updateSpecials) do
		if not self.specials[v.layer] then
			self.specials[v.layer] = Activity104SpecialMo.New()

			self.specials[v.layer]:init(v)
		else
			self.specials[v.layer]:reset(v)
		end
	end
end

function Activity104Mo:_addUnlockEquipIndexs(indexs)
	for _, index in ipairs(indexs) do
		table.insert(self.unlockEquipIndexs, index)
	end
end

function Activity104Mo:updateItems(info)
	for _, v in ipairs(info.activity104Items) do
		if self.activity104Items[v.uid] then
			self.activity104Items[v.uid]:reset(v)
		else
			local itemMo = Activity104ItemMo.New()

			itemMo:init(v)

			self.activity104Items[v.uid] = itemMo
		end
	end

	for _, v in ipairs(info.deleteItems) do
		if self.activity104Items[v.uid] then
			self.activity104Items[v.uid] = nil
		end
	end

	self:refreshItemCount()
end

function Activity104Mo:_buildEpisodes(episodes)
	local dict = {}

	for _, v in ipairs(episodes) do
		local episodeMo = Activity104EpisodeMo.New()

		episodeMo:init(v)

		dict[episodeMo.layer] = episodeMo
	end

	return dict
end

function Activity104Mo:_buildRetails(retails)
	self.lastRetails = self.retails

	local list = {}

	for _, v in ipairs(retails) do
		local retailMo = Activity104RetailMo.New()

		retailMo:init(v)
		table.insert(list, retailMo)
	end

	table.sort(list, function(a, b)
		return a.id < b.id
	end)

	return list
end

function Activity104Mo:_buildSpecials(specials)
	local list = {}

	for _, v in ipairs(specials) do
		local specialMo = Activity104SpecialMo.New()

		specialMo:init(v)
		table.insert(list, specialMo)
	end

	table.sort(list, function(a, b)
		return a.layer < b.layer
	end)

	return list
end

function Activity104Mo:_buildItems(items)
	local list = {}

	for _, v in ipairs(items) do
		local itemMo = Activity104ItemMo.New()

		itemMo:init(v)

		list[v.uid] = itemMo
	end

	table.sort(list, function(a, b)
		return a.itemId < b.itemId
	end)

	return list
end

function Activity104Mo:_buildList(listInfo)
	local list = {}

	for _, v in ipairs(listInfo) do
		table.insert(list, v)
	end

	return list
end

function Activity104Mo:_buildSnapshot(snapshots)
	local list = {}

	for _, v in ipairs(snapshots) do
		local snapMo = HeroGroupMO.New()
		local fit = true

		for _, hero in ipairs(v.heroList) do
			if tonumber(hero) ~= 0 then
				fit = false
			end

			break
		end

		if fit then
			local mainHeroGroupMo = HeroGroupModel.instance:getById(1)

			if v.groupId == 1 and mainHeroGroupMo then
				snapMo.id = v.groupId
				snapMo.groupId = v.groupId
				snapMo.name = mainHeroGroupMo.name
				snapMo.heroList = LuaUtil.deepCopy(mainHeroGroupMo.heroList)
				snapMo.aidDict = LuaUtil.deepCopy(mainHeroGroupMo.aidDict)
				snapMo.clothId = mainHeroGroupMo.clothId
				snapMo.equips = LuaUtil.deepCopy(mainHeroGroupMo.equips)
				snapMo.activity104Equips = LuaUtil.deepCopy(mainHeroGroupMo.activity104Equips)
			else
				snapMo.id = v.groupId
				snapMo.groupId = v.groupId
				snapMo.name = ""
				snapMo.heroList = {
					"0",
					"0",
					"0",
					"0"
				}
				snapMo.clothId = mainHeroGroupMo.clothId
				snapMo.equips = {}

				for i = 0, 3 do
					snapMo:updatePosEquips({
						index = i,
						equipUid = {
							"0"
						}
					})
				end

				snapMo.activity104Equips = {}

				for i = 0, 3 do
					snapMo:updatePosEquips({
						index = i,
						equipUid = {
							"0"
						}
					})
				end

				local mainEquipMo = HeroGroupActivity104EquipMo.New()

				mainEquipMo:init({
					index = 4,
					equipUid = {
						"0"
					}
				})

				snapMo.activity104Equips[4] = mainEquipMo
			end
		else
			snapMo:init(v)
		end

		snapMo:clearAidHero()

		list[v.groupId] = snapMo
	end

	table.sort(list, function(a, b)
		return a.groupId < b.groupId
	end)

	return list
end

function Activity104Mo:replaceRetails(info)
	self.retails = self:_buildRetails(info)
end

function Activity104Mo:getLastRetails()
	self.lastRetails = nil

	return self.lastRetails
end

function Activity104Mo:setUnlockActivity104EquipIds(proto)
	self.unlockActivity104EquipIds = {}

	for i, v in ipairs(proto) do
		self.unlockActivity104EquipIds[v] = v
	end
end

function Activity104Mo:markStory(mark)
	self.readActivity104Story = mark
end

function Activity104Mo:markEpisodeAfterStory(layer)
	local mo = self.episodes[layer]

	if mo then
		mo:markStory(true)
	end
end

function Activity104Mo:setBattleFinishLayer(layer)
	if layer > 0 then
		self.battleFinishLayer = layer
	end
end

function Activity104Mo:getBattleFinishLayer()
	return self.battleFinishLayer
end

function Activity104Mo:refreshItemCount()
	self.activity104ItemCountDict = {}

	if self.activity104Items then
		for k, v in pairs(self.activity104Items) do
			self.activity104ItemCountDict[v.itemId] = self.activity104ItemCountDict[v.itemId] and self.activity104ItemCountDict[v.itemId] + 1 or 1
		end
	end
end

function Activity104Mo:getItemCount(itemId)
	return self.activity104ItemCountDict[itemId] or 0
end

function Activity104Mo:getSnapshotHeroGroupBySubId(subId)
	subId = subId or self.heroGroupSnapshotSubId

	local groupMo = self.heroGroupSnapshot[subId]
	local battleCO = HeroGroupModel.instance.battleConfig

	if battleCO then
		local configAids = string.splitToNumber(battleCO.aid, "#")

		if #configAids > 0 or battleCO.trialLimit > 0 then
			return self.tempHeroGroupSnapshot[subId]
		end
	end

	return groupMo
end

function Activity104Mo:getRealHeroGroupBySubId(subId)
	subId = subId or self.heroGroupSnapshotSubId

	return self.heroGroupSnapshot[subId]
end

function Activity104Mo:getIsPopSummary()
	return self.isPopSummary
end

function Activity104Mo:setIsPopSummary(isPopSummary)
	self.isPopSummary = isPopSummary
end

function Activity104Mo:getLastMaxLayer()
	return self.lastMaxLayer
end

function Activity104Mo:getTrialId()
	return self.trialId
end

function Activity104Mo:buildHeroGroup()
	local battleCO = HeroGroupModel.instance.battleConfig

	if battleCO then
		local configAids = string.splitToNumber(battleCO.aid, "#")

		if #configAids > 0 or battleCO.trialLimit > 0 then
			self.tempHeroGroupSnapshot = {}

			for i, v in ipairs(self.heroGroupSnapshot) do
				self.tempHeroGroupSnapshot[i] = HeroGroupModel.instance:generateTempGroup(v)

				self.tempHeroGroupSnapshot[i]:setTemp(false)
			end
		end
	end
end

return Activity104Mo
