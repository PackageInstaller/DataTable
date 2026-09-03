-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/model/GalleryPartyManage.lua

require("dm.gameplay.gallery.model.GalleryParty")
require("dm.gameplay.gallery.model.GalleryMemory")
require("dm.gameplay.gallery.model.GalleryLegend")
require("dm.gameplay.gallery.model.GalleryMessage")
require("dm.gameplay.gallery.model.GalleryMemoryPack")

local cjson = require("cjson.safe")

GalleryPartyManage = class("GalleryPartyManage", objectlua.Object, _M)

GalleryPartyManage:has("_partyMap", {
	is = "rw"
})
GalleryPartyManage:has("_partyArray", {
	is = "rw"
})
GalleryPartyManage:has("_memoryTypeMap", {
	is = "rw"
})
GalleryPartyManage:has("_albumPhotos", {
	is = "rw"
})
GalleryPartyManage:has("_albumPhotosMap", {
	is = "rw"
})
GalleryPartyManage:has("_partyRewardMap", {
	is = "rw"
})
GalleryPartyManage:has("_dateTimes", {
	is = "rw"
})
GalleryPartyManage:has("_totalLoveLevel", {
	is = "rw"
})
GalleryPartyManage:has("_unlockPhotos", {
	is = "rw"
})
GalleryPartyManage:has("_todayDateHeroes", {
	is = "rw"
})
GalleryPartyManage:has("_partyRewardStatusMap", {
	is = "rw"
})
GalleryPartyManage:has("_storyLoves", {
	is = "rw"
})
GalleryPartyManage:has("_heroRewards", {
	is = "rw"
})
GalleryPartyManage:has("_memoryStoryPacksMap", {
	is = "rw"
})

FuncBonusType = {
	attr = {
		"album_icon_gift.png"
	},
	date = {
		"album_icon_date.png",
		Strings:get("GALLERY_UI31")
	},
	gift = {
		"album_icon_gift.png",
		Strings:get("GALLERY_UI30")
	}
}
AlbumVerbType = {
	KBG = "BGPIC"
}
GalleryFuncName = {
	kGift = "gift",
	kDate = "date"
}
GalleryRewardCon = {
	HeroStar = "totalStar",
	HeroNum = "heroNum",
	HeroLove = "totalLoveLv"
}

function GalleryPartyManage:initialize()
	self._partyMap = {}
	self._partyArray = {}
	self._memoryTypeMap = {}
	self._albumPhotos = {}
	self._albumPhotosMap = {}
	self._partyRewardMap = {}
	self._nextPartyTasks = {}
	self._dateTimes = 0
	self._totalLoveLevel = 0
	self._unlockPhotos = {}
	self._todayDateHeroes = {}
	self._partyRewardStatusMap = {}
	self._afkMaps = {}
	self._storyLoves = {}
	self._heroRewards = {}
	self._legendList = {}
	self._messageList = {}
	self._memoryStoryPacksMap = {}
end

function GalleryPartyManage:initPartyMap()
	local config = ConfigReader:getDataTable("GalleryParty")
	local allHeroObj

	for id, partyConfig in pairs(config) do
		local partyObj = GalleryParty:new(partyConfig.Party)

		if self._partyMap == nil then
			self._partyMap = {}
		end

		self._partyMap[partyConfig.Party] = partyObj

		if self._partyArray[partyConfig.Type] == nil then
			self._partyArray[partyConfig.Type] = {}
		end

		if partyConfig.Party == "AllHero" then
			allHeroObj = partyObj
		else
			self._partyArray[partyConfig.Type][#self._partyArray[partyConfig.Type] + 1] = partyObj
		end
	end

	for key, value in pairs(self._partyArray) do
		value[#value + 1] = allHeroObj
	end

	for key, value in pairs(self._partyArray) do
		table.sort(value, function(a, b)
			return a:getOrder() < b:getOrder()
		end)
	end
end

function GalleryPartyManage:initGalleryRewards()
	self._partyRewardMap = {}

	local partyMap = self:getPartyMap()

	for partyType, value in pairs(partyMap) do
		for i = 1, #value:getRewardIds() do
			local rewardId = value:getRewardIds()[i]
			local config = ConfigReader:getRecordById("GalleryPartyReward", rewardId)
			local targetType = next(config.Condition)
			local data = {
				status = 0,
				currentNum = 0,
				name = Strings:get(config.ConditionName),
				desc = Strings:get(config.ConditionDesc),
				rewardId = config.Reward,
				galleryRewardId = rewardId,
				nextTaskIds = config.Next,
				targetType = GalleryRewardCon[targetType],
				targetNum = config.Condition[targetType]
			}

			if #config.Next > 0 then
				for index = 1, #config.Next do
					self._nextPartyTasks[#self._nextPartyTasks + 1] = config.Next[index]
				end
			end

			self._partyRewardMap[partyType] = self._partyRewardMap[partyType] or {}
			self._partyRewardMap[partyType][rewardId] = data
		end
	end
end

function GalleryPartyManage:initGalleryMemory()
	local keys = ConfigReader:getKeysOfTable("GalleryMemory")

	for i = 1, #keys do
		local id = keys[i]
		local type = ConfigReader:getDataByNameIdAndKey("GalleryMemory", id, "Type")

		self:insertMemory(type, id)
	end
end

function GalleryPartyManage:initGalleryMemoryStory()
	local keys = ConfigReader:getKeysOfTable("GalleryMemoryStory")

	for i = 1, #keys do
		local id = keys[i]
		local type = ConfigReader:getDataByNameIdAndKey("GalleryMemoryStory", id, "Type")

		self:insertMemoryStory(type, id)
	end

	local unlockMemory = ConfigReader:getRecordById("ConfigValue", "UNLOCKMEMORY")

	if unlockMemory then
		local list = unlockMemory.content.TASK

		for i = 1, #list do
			self:updateMemoryActivityStoryById(list[i], true)
		end
	end

	self._initMemoryStory = true
end

function GalleryPartyManage:canRevieveReward(id)
	local data = self._partyRewardMap[id]

	if data == nil then
		return false, false
	end

	for i, v in pairs(data) do
		if v.status == TaskStatus.kFinishNotGet then
			return true, true
		end
	end

	return false, true
end

function GalleryPartyManage:getHeroInfos(heroId)
	local infoTitles = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroInfoList", "content")
	local heroConfig = ConfigReader:requireRecordById("HeroBase", heroId)
	local config = ConfigReader:getRecordById("GalleryHeroInfo", heroId)

	return {
		cvname = Strings:get(heroConfig.CVName),
		info1 = {
			Strings:get(infoTitles.InfoDesc1),
			config.InfoDesc1
		},
		info2 = {
			Strings:get(infoTitles.InfoDesc2),
			config.InfoDesc2
		},
		info3 = {
			Strings:get(infoTitles.InfoDesc3),
			config.InfoDesc3
		},
		info4 = {
			Strings:get(infoTitles.InfoDesc4),
			config.InfoDesc4
		},
		info5 = {
			Strings:get(infoTitles.InfoDesc5),
			config.InfoDesc5
		},
		info6 = {
			Strings:get(infoTitles.InfoDesc6),
			config.InfoDesc6
		},
		info7 = {
			Strings:get(infoTitles.InfoDesc7),
			config.InfoDesc7
		},
		info8 = {
			Strings:get(infoTitles.InfoDesc8),
			config.InfoDesc8
		},
		info9 = {
			Strings:get(infoTitles.InfoDesc9),
			config.InfoDesc9
		},
		gossips = config.GossipDesc,
		bg = config.BGPic .. ".png"
	}
end

function GalleryPartyManage:getHeroStory(heroId)
	local config = ConfigReader:getRecordById("GalleryHeroInfo", heroId)
	local storys = {}

	for i = 1, #config.HeroStory do
		storys[#storys + 1] = {
			title = config.HeroStory[i].title,
			desc = config.HeroStory[i].desc,
			condition = config.HeroStory[i].need
		}
	end

	return storys
end

function GalleryPartyManage:getCurLoveMaxExp(heroId, loveLevel)
	local config = ConfigReader:requireRecordById("HeroLove", heroId)

	return config.Likability[loveLevel] or config.Likability[1]
end

function GalleryPartyManage:getCurLoveExtraBonus(heroId, loveLevel)
	local data = {}
	local totalExp = self:getCurLoveMaxExp(heroId, loveLevel)
	local infos = self:getHeroInfos(heroId)
	local stories = self:getHeroStory(heroId)

	for i = 1, 9 do
		local infoData = infos["info" .. i]
		local desc = next(infoData[2])
		local condi = infoData[2][desc]

		if loveLevel == condi[1] or loveLevel == condi[1] - 1 and condi[2] == 0 then
			data[#data + 1] = {
				type = "attr",
				descType = "desc",
				param = {
					infoData[1]
				},
				proportion = tonumber(condi[2]) / totalExp,
				image = FuncBonusType.attr[1]
			}
		end
	end

	for i = 1, #stories do
		local condi = stories[i].condition

		if loveLevel == condi[1] or loveLevel == condi[1] - 1 and condi[2] == 0 then
			data[#data + 1] = {
				type = "attr",
				descType = "past",
				param = {
					Strings:get("GALLERY_UI37", {
						page = i
					})
				},
				proportion = tonumber(condi[2]) / totalExp,
				image = FuncBonusType.attr[1]
			}
		end
	end

	return data
end

function GalleryPartyManage:getAttrDesc(effectId)
	local effectConfig = ConfigReader:requireRecordById("SkillAttrEffect", effectId)
	local desc = AttributeCategory:getAttName(effectConfig.AttrType[1])
	local attrNum = SkillAttribute:getAddNumByConfig(effectConfig, 1, 0)

	if AttributeCategory:getAttNameAttend(effectConfig.AttrType[1]) ~= "" then
		attrNum = attrNum * 100 .. "%"
	end

	return {
		desc,
		attrNum
	}
end

function GalleryPartyManage:getShowAttrList(effectIds)
	local attr = {}
	local effects = effectIds

	for i = 1, #effects do
		local descs = self:getAttrDesc(effects[i])
		local attrType = ConfigReader:requireRecordById("SkillAttrEffect", effects[i]).AttrType[1]

		if not attr[attrType] then
			attr[attrType] = descs
		elseif type(descs[2]) == "number" then
			attr[attrType][2] = attr[attrType][2] + descs[2]
		end
	end

	return attr
end

function GalleryPartyManage:syncMemoryData(data)
	local dataType = type

	if not self._initMemory then
		self._initMemory = true

		self:initGalleryMemory()
	end

	if not self._initMemoryStory then
		self._initMemoryStory = true

		self:initGalleryMemoryStory()
	end

	for type, value in pairs(data) do
		for id, memory in pairs(value) do
			assert(dataType(memory) == "table", "来自服务器数据：剧情id为" .. type .. "不是在数组结构内")
			self:insertMemory(type, id)
			self._memoryTypeMap[type][id]:sync(memory)

			if type == GalleryMemoryType.STORY and self._memoryTypeMap[type][id]:getUnlock() then
				local MemoryPack = self:getMemoryPackByStoryId(id)

				if MemoryPack then
					MemoryPack:setStatus(1)
				end
			end
		end
	end

	self:updateMemoryStoryByForce()

	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)

	developSystem:dispatch(Event:new(EVT_GET_NEW_STORY))
end

function GalleryPartyManage:insertMemory(type, id)
	self._memoryTypeMap[type] = self._memoryTypeMap[type] or {}
	self._memoryTypeMap[type][id] = self._memoryTypeMap[type][id] or GalleryMemory:new(id)
end

function GalleryPartyManage:getMemoryValueByType(type)
	if not self._memoryTypeMap[type] then
		return nil
	end

	local totalNum = 0
	local num = 0
	local temp

	if type == GalleryMemoryType.STORY then
		for id, value in pairs(self._memoryStoryPacksMap[GalleryMemoryPackType.ACTIVI]) do
			temp = self:getMemoryStoryValueByData(self._memoryStoryPacksMap[GalleryMemoryPackType.ACTIVI][id])
			totalNum = totalNum + temp[2]
			num = num + temp[1]
		end

		for id, value in pairs(self._memoryStoryPacksMap[GalleryMemoryPackType.STORY]) do
			temp = self:getMemoryStoryValueByData(self._memoryStoryPacksMap[GalleryMemoryPackType.STORY][id])
			totalNum = totalNum + temp[2]
			num = num + temp[1]
		end
	else
		for i, v in pairs(self._memoryTypeMap[type]) do
			if v:getCanshow() then
				totalNum = totalNum + 1

				if v:getUnlock() then
					num = num + 1
				end
			end
		end
	end

	return {
		num,
		totalNum
	}
end

function GalleryPartyManage:getMemoryStoryValueByData(data)
	local totalNum = 0
	local num = 0
	local storys = data:getStorys() or nil
	local type = data:getType()

	if storys then
		for i = 1, #storys do
			local story = storys[i]

			for id, value in pairs(story.id) do
				local memory = self._memoryTypeMap[GalleryMemoryType.STORY][value]

				if DEBUG ~= 0 then
					assert(memory, "memory not find in local database....id.." .. value)
				end

				if memory and memory:getCanshow() then
					if memory:getUnlock() then
						num = num + 1
						totalNum = totalNum + 1
					elseif type ~= GalleryMemoryPackType.ACTIVI then
						totalNum = totalNum + 1
					end
				end
			end
		end
	end

	return {
		num,
		totalNum
	}
end

function GalleryPartyManage:getMemoriesByType(type)
	if not self._memoryTypeMap[type] then
		local showMemory = {}

		for id, value in pairs(self._memoryTypeMap[type]) do
			if value:getCanshow() then
				if (type == GalleryMemoryType.ACTIVI and not value:getUnlock() or nil) and false then
					table.insert(showMemory, value)
				end
			end
		end

		table.sort(showMemory, function(a, b)
			return a:getNumber() < b:getNumber()
		end)

		return showMemory
	end
end

function GalleryPartyManage:checkNewMemoryByTime(type, time)
	if not self._memoryTypeMap[type] then
		for id, value in pairs(self._memoryTypeMap[type]) do
			if value:getCanshow() and value:getUnlock() then
				local date = tonumber(value:getDate()) or 0

				if time < date then
					return true
				end
			end
		end

		return false
	end
end

function GalleryPartyManage:checkNewMemoryIdByTime(type, id, time)
	if not self._memoryTypeMap[type] or not self._memoryTypeMap[type][id] or time == nil or _G.type(time) ~= "number" then
		return false
	end

	if not self._memoryTypeMap[type][id]._date then
		local date = 0

		if time < tonumber(date) then
			return true
		end

		return false
	end
end

function GalleryPartyManage:getFirstNewMemoryByType(type, timestamp)
	local res

	if not self._memoryTypeMap[type] then
		for id, value in pairs(self._memoryTypeMap[type]) do
			if value:getCanshow() and value:getUnlock() then
				local date = value:getDate() or 0

				if timestamp < tonumber(date) and (not res or res:getNumber() > value:getNumber()) then
					res = value
				end
			end
		end

		return res or nil
	end
end

function GalleryPartyManage:updateMemoryActivityStoryById(id, isForce)
	if id then
		local memoryPack = self._memoryStoryPacksMap[GalleryMemoryPackType.ACTIVI][id]

		if not memoryPack:getUnlock() then
			if isForce then
				memoryPack:setForceUnlock(1)
			else
				memoryPack:setStatus(1)
			end
		end
	end
end

function GalleryPartyManage:updateMemoryStoryByForce(id)
	if not id then
		local unlockMemory = ConfigReader:getRecordById("ConfigValue", "UNLOCKMEMORY")

		if not unlockMemory then
			return
		end

		local list = unlockMemory.content.TASK

		for i = 1, #list do
			self:updateMemoryStoryByForce(list[i])
		end

		return
	end

	if id then
		local memoryPack = self._memoryStoryPacksMap[GalleryMemoryPackType.ACTIVI][id]

		if memoryPack:getForceUnlock() then
			local storys = memoryPack:getStorys()

			if storys then
				for k, v in pairs(storys) do
					for key, value in pairs(v.id) do
						local memory = self._memoryTypeMap[GalleryMemoryType.STORY][value]

						if not memory:getUnlock() then
							memory:sync({
								memoryStatus = 1
							})
						end
					end
				end
			end
		end
	end
end

function GalleryPartyManage:getFirstNewMemoryStoryById(id, timestamp)
	local res
	local storys = self._memoryStoryPacksMap[GalleryMemoryPackType.ACTIVI][id]:getStorys() or {}

	for k, v in pairs(storys) do
		for key, value in pairs(v.id) do
			local memory = self._memoryTypeMap[GalleryMemoryType.STORY][value]

			if memory:getCanshow() and memory:getUnlock() then
				local date = memory:getDate() or 0

				if date and date ~= "" and timestamp < tonumber(date) and (not res or res:getNumber() > memory:getNumber()) then
					res = memory
				end
			end
		end
	end

	return res or nil
end

function GalleryPartyManage:insertMemoryStory(type, id)
	self._memoryStoryPacksMap[type] = self._memoryStoryPacksMap[type] or {}
	self._memoryStoryPacksMap[type][id] = self._memoryStoryPacksMap[type][id] or GalleryMemoryPack:new(id)
end

function GalleryPartyManage:getMemoryPackByStoryId(storyId)
	if not self._memoryStoryPacksMap then
		return nil
	end

	for _, value in pairs(self._memoryStoryPacksMap[GalleryMemoryPackType.ACTIVI]) do
		local storys = value:getStorys() or {}

		for _, v in pairs(storys) do
			for k, id in pairs(v.id) do
				if id == storyId then
					return value
				end
			end
		end
	end

	for _, value in pairs(self._memoryStoryPacksMap[GalleryMemoryPackType.STORY]) do
		local storys = value:getStorys() or {}

		for _, v in pairs(storys) do
			for k, id in pairs(v.id) do
				if id == storyId then
					return value
				end
			end
		end
	end
end

function GalleryPartyManage:getMemoriePacksByType(type)
	if not self._memoryStoryPacksMap[type] then
		local showMemory = {}

		for id, value in pairs(self._memoryStoryPacksMap[type]) do
			if (type == GalleryMemoryPackType.ACTIVI and not value:getUnlock() or nil) and false then
				table.insert(showMemory, value)
			end
		end

		table.sort(showMemory, function(a, b)
			return a:getNumber() < b:getNumber()
		end)

		return showMemory
	end
end

function GalleryPartyManage:getMemorieStorysById(type, id)
	local storys = self._memoryStoryPacksMap[type][id]:getStorys() or nil
	local showMemory = {}
	local eliteShowMemory = {}

	if storys then
		for i = 1, #storys do
			local story = storys[i]

			for id, value in pairs(story.id) do
				local memory = self._memoryTypeMap[GalleryMemoryType.STORY][value]

				if memory:getCanshow() then
					if (type == GalleryMemoryPackType.ACTIVI and not memory:getUnlock() or nil) and false then
						if story.type == "NORMAL" then
							table.insert(showMemory, memory)
						elseif story.type == "ELITE" then
							table.insert(eliteShowMemory, memory)
						end
					end
				end
			end
		end
	end

	table.sort(showMemory, function(a, b)
		return a:getNumber() < b:getNumber()
	end)
	table.sort(eliteShowMemory, function(a, b)
		return a:getNumber() < b:getNumber()
	end)

	return showMemory, eliteShowMemory
end

function GalleryPartyManage:syncAlbumData(data)
	self._albumPhotosMap = {}
	self._albumPhotos = {}

	for key, value in pairs(data) do
		local index = tonumber(key) + 1

		value = cjson.decode(value)
		value.index = index
		self._albumPhotosMap[value.id] = value
		self._albumPhotos[#self._albumPhotos + 1] = value
	end

	table.sort(self._albumPhotos, function(a, b)
		return a.index > b.index
	end)
end

function GalleryPartyManage:syncRewardData(data)
	if not self._initGalleryReward then
		self._initGalleryReward = true

		self:initGalleryRewards()
	end

	for partyType, value in pairs(data) do
		if self._partyRewardMap[partyType] then
			for id, v in pairs(value) do
				if self._partyRewardMap[partyType][id] then
					self._partyRewardMap[partyType][id].status = v
				end
			end
		end
	end
end

function GalleryPartyManage:getPartyRewardMap(partyType)
	local tasks = self._partyRewardMap[partyType]
	local showTasks = {}

	for taskId, value in pairs(tasks) do
		if value.status == TaskStatus.kGet and #value.nextTaskIds > 0 then
			for i = 1, #value.nextTaskIds do
				local nextTaskId = value.nextTaskIds[i]

				showTasks[#showTasks + 1] = value

				if tasks[nextTaskId].status == TaskStatus.kGet and #tasks[nextTaskId].nextTaskIds == 0 or tasks[nextTaskId].status ~= TaskStatus.kGet then
					showTasks[#showTasks + 1] = tasks[nextTaskId]
				end
			end
		elseif not self:checkIsNextTask(taskId) then
			showTasks[#showTasks + 1] = value
		end
	end

	table.sort(showTasks, function(a, b)
		local statusPriorityMap = {
			[TaskStatus.kFinishNotGet] = 1,
			[TaskStatus.kUnfinish] = 2,
			[TaskStatus.kGet] = 3
		}

		if a.status == b.status then
			return a.rewardId < b.rewardId
		else
			return statusPriorityMap[a.status] < statusPriorityMap[b.status]
		end
	end)

	return showTasks
end

function GalleryPartyManage:getPartyRewardStatusMap(partyType)
	return self._partyRewardStatusMap[partyType] or {}
end

function GalleryPartyManage:checkIsNextTask(id)
	for i = 1, #self._nextPartyTasks do
		if id == self._nextPartyTasks[i] then
			return true
		end
	end

	return false
end

function GalleryPartyManage:syncGalleryData(data)
	if data.unlockPhotos then
		self._unlockPhotos = {}

		for key, value in pairs(data.unlockPhotos) do
			local config = ConfigReader:requireRecordById("GalleryPhoto", value)

			if config and config.Type == AlbumVerbType.KBG then
				self._unlockPhotos[#self._unlockPhotos + 1] = config.Path .. ".jpg"
			end
		end
	end

	if data.heroDateTimes and data.heroDateTimes.value then
		self._dateTimes = data.heroDateTimes.value
	end

	if data.totalLoveLevel then
		self._totalLoveLevel = data.totalLoveLevel
	end

	if data.todayDateHeroes then
		self._todayDateHeroes = {}

		for key, value in pairs(data.todayDateHeroes) do
			self._todayDateHeroes[#self._todayDateHeroes + 1] = value
		end
	end

	if data.partyStats then
		for partyType, value in pairs(data.partyStats) do
			self._partyRewardStatusMap[partyType] = self._partyRewardStatusMap[partyType] or {
				[GalleryRewardCon.HeroNum] = 0,
				[GalleryRewardCon.HeroLove] = 0,
				[GalleryRewardCon.HeroStar] = 0
			}

			if value[GalleryRewardCon.HeroNum] then
				self._partyRewardStatusMap[partyType][GalleryRewardCon.HeroNum] = value[GalleryRewardCon.HeroNum]
			end

			if value[GalleryRewardCon.HeroStar] then
				self._partyRewardStatusMap[partyType][GalleryRewardCon.HeroStar] = value[GalleryRewardCon.HeroStar]
			end

			if value[GalleryRewardCon.HeroLove] then
				self._partyRewardStatusMap[partyType][GalleryRewardCon.HeroLove] = value[GalleryRewardCon.HeroLove]
			end
		end
	end

	if data.afkMaps then
		for k, v in pairs(data.afkMaps) do
			self._afkMaps[k] = v
		end
	end

	if data.storyLoves then
		for k, v in pairs(data.storyLoves) do
			self._storyLoves[v] = true
		end
	end

	if data.heroRewards then
		for k, v in pairs(data.heroRewards) do
			self._heroRewards[v] = true
		end
	end

	if data.legend then
		self:syncLegendData(data.legend)
	end

	if data.activityMemoryStory then
		local map = data.activityMemoryStory.TASK

		if map then
			for k, v in pairs(map) do
				self:updateMemoryActivityStoryById(v)
			end
		end
	end
end

function GalleryPartyManage:syncGalleryDelData(data)
	if data.afkMaps then
		for k, v in pairs(data.afkMaps) do
			if self._afkMaps[k] then
				self._afkMaps[k] = nil
			end
		end
	end
end

function GalleryPartyManage:getStoryLoveSta(id)
	return self._storyLoves[id]
end

function GalleryPartyManage:syncLegendData(data)
	if not self._initLegend then
		self._initLegend = true

		local ids = ConfigReader:getKeysOfTable("HerosLegendBase")

		for i = 1, #ids do
			local id = ids[i]

			self._legendList[id] = self._legendList[id] or GalleryLegend:new(id)
		end
	end

	for id, value in pairs(data) do
		self._legendList[id] = self._legendList[id] or GalleryLegend:new(id)

		self._legendList[id]:sync(value)
	end
end

function GalleryPartyManage:getLegendList()
	local list = {}

	for i, v in pairs(self._legendList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a:getSort() < b:getSort()
	end)

	return list
end

function GalleryPartyManage:getLegendById(id)
	return self._legendList[id]
end

function GalleryPartyManage:syncMessageData(data)
	if not self._initMessage then
		self._initMessage = true

		local ids = ConfigReader:getKeysOfTable("InfoBase")

		for i = 1, #ids do
			local id = ids[i]

			self._messageList[id] = self._messageList[id] or GalleryMessage:new(id)
		end
	end

	for id, value in pairs(data) do
		self._messageList[id] = self._messageList[id] or GalleryMessage:new(id)

		self._messageList[id]:sync(value)
	end
end

function GalleryPartyManage:getMessageCount()
	local ids = ConfigReader:getKeysOfTable("InfoBase")

	return #ids
end

function GalleryPartyManage:getMessageList()
	local list = {}

	for i, v in pairs(self._messageList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a:getSort() < b:getSort()
	end)

	return list
end

function GalleryPartyManage:getMessageById(id)
	return self._messageList[id]
end
