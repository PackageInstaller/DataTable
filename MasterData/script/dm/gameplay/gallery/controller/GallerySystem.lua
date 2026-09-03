-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/controller/GallerySystem.lua

require("dm.gameplay.gallery.model.GalleryPartyManage")

GallerySystem = class("GallerySystem", Facade, _M)

GallerySystem:has("_service", {
	is = "r"
}):injectWith("GalleryService")
GallerySystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GallerySystem:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
GallerySystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
GallerySystem:has("_partyManage", {
	is = "r"
})
GallerySystem:has("_dateOptions", {
	is = "rw"
})
GallerySystem:has("_customDataSystem", {
	is = "rw"
}):injectWith("CustomDataSystem")
GallerySystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
GallerySystem:has("_curDate", {
	is = "rw"
})
GallerySystem:has("_taskListModel", {
	is = "r"
}):injectWith("TaskListModel")

function GallerySystem:initialize()
	super.initialize(self)

	self._partyManage = GalleryPartyManage:new()

	self._partyManage:initPartyMap()
	self._partyManage:initGalleryMemoryStory()

	self._dateOptions = {}
end

function GallerySystem:checkEnabled(param)
	local unlock, tips = self._systemKeeper:isUnlock("Hero_Gallery")

	return unlock, tips
end

function GallerySystem:tryEnter(param)
	local unlock, tips = self:checkEnabled(param)

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

	local function callback()
		local view = self:getInjector():getInstance("GalleryBookView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
	end

	self._bagSystem = self._developSystem:getBagSystem()

	self._bagSystem:mainInfoURSuite(callback)
end

function GallerySystem:getPartyArray()
	return self._partyManage:getPartyArray()
end

function GallerySystem:getPartyMap()
	return self._partyManage:getPartyMap()
end

function GallerySystem:getCurNums(heroIds)
	local heroSystem = self._developSystem:getHeroSystem()
	local curNum = 0
	local totalNum = #heroIds

	for i = 1, totalNum do
		if heroSystem:hasHero(heroIds[i]) then
			curNum = curNum + 1
		end
	end

	return curNum, totalNum
end

function GallerySystem:getHeroInfos(heroId)
	local infos = self._partyManage:getHeroInfos(heroId)
	local config = ConfigReader:getRecordById("HeroBase", heroId)

	return {
		name = Strings:get(config.Name),
		cvname = infos.cvname,
		info1 = {
			infos.info1[1],
			self:checkCanshow(heroId, infos.info1[2])
		},
		info2 = {
			infos.info2[1],
			self:checkCanshow(heroId, infos.info2[2])
		},
		info3 = {
			infos.info3[1],
			self:checkCanshow(heroId, infos.info3[2])
		},
		info4 = {
			infos.info4[1],
			self:checkCanshow(heroId, infos.info4[2])
		},
		info5 = {
			infos.info5[1],
			self:checkCanshow(heroId, infos.info5[2])
		},
		info6 = {
			infos.info6[1],
			self:checkCanshow(heroId, infos.info6[2])
		},
		info7 = {
			infos.info7[1],
			self:checkCanshow(heroId, infos.info7[2])
		},
		info8 = {
			infos.info8[1],
			self:checkCanshow(heroId, infos.info8[2])
		},
		info9 = {
			infos.info9[1],
			self:checkCanshow(heroId, infos.info9[2])
		},
		gossips = infos.gossips,
		bg = infos.bg
	}
end

function GallerySystem:checkCanshow(heroId, condition)
	local heroSystem = self._developSystem:getHeroSystem()

	if not heroSystem:hasHero(heroId) then
		return Strings:get("GALLERY_UI9")
	end

	local hero = heroSystem:getHeroById(heroId)
	local desc = next(condition)
	local condi = condition[desc]

	if hero:getLoveLevel() > condi[1] or hero:getLoveLevel() == condi[1] and hero:getLoveExp() >= condi[2] then
		return Strings:get(desc)
	end

	return Strings:get("GALLERY_UI9")
end

function GallerySystem:getHeroStory(heroId)
	local heroSystem = self._developSystem:getHeroSystem()
	local hero = heroSystem:getHeroById(heroId)
	local stories = self._partyManage:getHeroStory(heroId)
	local showStories = {}

	for i = 1, #stories do
		local targetLevel = stories[i].condition[1]
		local targetExp = stories[i].condition[2]
		local targetShowLevel = targetLevel
		local loveExp = hero:getLoveModule():getLoveExpByLevel(targetShowLevel)
		local targetShowExp = targetExp

		if targetShowExp == loveExp then
			targetShowLevel = targetShowLevel + 1
			targetShowExp = 0
		end

		showStories[#showStories + 1] = {
			title = Strings:get(stories[i].title),
			desc = Strings:get(stories[i].desc),
			unlock = targetLevel < hero:getLoveLevel() or hero:getLoveLevel() == targetLevel and targetExp <= hero:getLoveExp(),
			targetLevel = targetShowLevel,
			targetExp = targetShowExp
		}
	end

	return showStories
end

function GallerySystem:isPastOpen(heroId)
	local heroSystem = self._developSystem:getHeroSystem()
	local hero = heroSystem:getHeroById(heroId)
	local stories = self._partyManage:getHeroStory(heroId)

	if stories[1] then
		local targetLevel = stories[1].condition[1]
		local targetExp = stories[1].condition[2]
		local targetShowLevel = targetLevel
		local loveExp = hero:getLoveModule():getLoveExpByLevel(targetShowLevel)
		local targetShowExp = targetExp

		if targetShowExp == loveExp then
			targetShowLevel = targetShowLevel + 1
			targetShowExp = 0
		end

		local unlock = targetLevel < hero:getLoveLevel() or hero:getLoveLevel() == targetLevel and targetExp <= hero:getLoveExp()

		return unlock, targetShowLevel, targetShowExp
	end

	return false
end

function GallerySystem:getGalleryRule()
	return (ConfigReader:getDataByNameIdAndKey("ConfigValue", "GalleryRule", "content"))
end

function GallerySystem:canRevieveReward(id)
	return self._partyManage:canRevieveReward(id)
end

function GallerySystem:getRewardDataByType(partyType)
	return self._partyManage:getPartyRewardMap(partyType)
end

function GallerySystem:getRewardStatusByType(partyType)
	return self._partyManage:getPartyRewardStatusMap(partyType)
end

function GallerySystem:getCurLoveMaxExp(heroId, loveLevel)
	return self._partyManage:getCurLoveMaxExp(heroId, loveLevel)
end

function GallerySystem:getCurLoveExtraBonus(heroId, loveLevel)
	local showBonus = {}
	local heroBonus = {}
	local galleryBonus = self._partyManage:getCurLoveExtraBonus(heroId, loveLevel)
	local heroSystem = self._developSystem:getHeroSystem()

	if heroSystem:hasHero(heroId) then
		local hero = heroSystem:getHeroById(heroId)

		heroBonus = hero:getLoveModule():getCurLoveExtraBonus(loveLevel)
	end

	local function comparePro(showBonus, bonus)
		for i = 1, #showBonus do
			if bonus.proportion * 100 == showBonus[i].proportion * 100 then
				return i
			end
		end

		return false
	end

	for i = 1, #heroBonus do
		local image, descType

		if heroBonus[i].type == "date" then
			image = heroBonus[i].image
		end

		if heroBonus[i].descType then
			descType = heroBonus[i].descType
		end

		local index = comparePro(showBonus, heroBonus[i])

		if not index then
			showBonus[#showBonus + 1] = heroBonus[i]

			if descType then
				showBonus[#showBonus].descType = descType
			end
		else
			if image then
				showBonus[index].image = image
			end

			if descType then
				showBonus[index].descType = descType
			end

			local param1 = showBonus[index].param
			local param2 = heroBonus[i].param

			if param1 and param2 then
				for j = 1, #param2 do
					param1[#param1 + 1] = param2[j]
				end
			end
		end
	end

	for i = 1, #galleryBonus do
		local image, descType

		if galleryBonus[i].type == "date" then
			image = galleryBonus[i].image
		end

		if galleryBonus[i].descType then
			descType = galleryBonus[i].descType
		end

		local index = comparePro(showBonus, galleryBonus[i])

		if not index then
			showBonus[#showBonus + 1] = galleryBonus[i]

			if descType then
				showBonus[#showBonus].descType = descType
			end
		else
			if image then
				showBonus[index].image = image
			end

			if descType then
				showBonus[index].descType = descType
			end

			local param1 = showBonus[index].param
			local param2 = galleryBonus[i].param

			if param1 and param2 then
				for j = 1, #param2 do
					param1[#param1 + 1] = param2[j]
				end
			end
		end
	end

	return showBonus
end

function GallerySystem:getMemoryValueByType(type)
	return self._partyManage:getMemoryValueByType(type)
end

function GallerySystem:getMemoryStoryValueByData(type)
	return self._partyManage:getMemoryStoryValueByData(type)
end

function GallerySystem:getMemoriesByType(type)
	return self._partyManage:getMemoriesByType(type)
end

function GallerySystem:getMemoryStoryValue()
	return self._partyManage:getMemoryStoryValue()
end

function GallerySystem:getMemoriePacksByType(type)
	return self._partyManage:getMemoriePacksByType(type)
end

function GallerySystem:getMemorieStorysById(type, id)
	return self._partyManage:getMemorieStorysById(type, id)
end

function GallerySystem:getAlbumBackgrounds()
	local backgrounds = {}
	local unlockPhotos = self._partyManage:getUnlockPhotos()

	for i = 1, #unlockPhotos do
		if not table.indexof(backgrounds, unlockPhotos[i]) then
			backgrounds[#backgrounds + 1] = unlockPhotos[i]
		end
	end

	return backgrounds
end

function GallerySystem:getAlbumPhotos()
	return self._partyManage:getAlbumPhotos()
end

function GallerySystem:getAlbumPhotosMap()
	return self._partyManage:getAlbumPhotosMap()
end

function GallerySystem:getAlbumPhotosLimit()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "PhotoNum", "content") or 1
end

function GallerySystem:getAlbumPhotoHeroesLimit()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "PhotoHeroNum", "content") or 1
end

function GallerySystem:getTotalLoveLevel()
	return self._partyManage:getTotalLoveLevel()
end

function GallerySystem:getHeroDateTimes()
	return self._partyManage:getDateTimes()
end

function GallerySystem:getTodayDateHeroes()
	return self._partyManage:getTodayDateHeroes()
end

function GallerySystem:isHeroTodayDate(heroId)
	return table.indexof(self:getTodayDateHeroes(), heroId)
end

function GallerySystem:getGiftItemList()
	local allEntries = self:getGiftItemEntryList()
	local list = {}

	for _, entry in pairs(allEntries) do
		local item = entry.item
		local data = {}

		data.id = item:getId()
		data.itemId = item:getId()
		data.sort = item:getSort()
		data.allCount = entry.count
		data.quality = item:getQuality()
		data.exp = self:getGiftAddExpByQuality(item:getQuality())
		data.eatCount = 0
		list[#list + 1] = data
	end

	return list
end

function GallerySystem:getGiftAddExpByQuality(quality)
	local giftAttr = ConfigReader:getDataByNameIdAndKey("ConfigValue", "GalleryGiftAttr", "content")

	for qua, exp in pairs(giftAttr) do
		if quality == tonumber(qua) then
			return exp
		end
	end

	return 0
end

function GallerySystem:getGiftItemEntryList()
	local function filterFunc(entry)
		if entry.item and entry.count and entry.count > 0 and entry.item:getSubType() == ItemTypes.k_GALLERY_GIFT then
			return true
		end
	end

	local bagSystem = self._developSystem:getBagSystem()

	return (bagSystem:getBag():getEntries(filterFunc))
end

function GallerySystem:doReset(resetId, value)
	value = value or 0

	if resetId == ResetId.kGalleryDateTimes then
		self._partyManage:setDateTimes(value)
		self:dispatch(Event:new(EVT_GALLERY_DATE_RESETR_SUCC))
	end
end

function GallerySystem:getLoveAddAttr()
	local list = {}
	local totalLoveLevel = self:getTotalLoveLevel()
	local effectIds = ConfigReader:getDataByNameIdAndKey("ConfigValue", "GalleryMasterLoveAttr", "content")

	for i = 1, #effectIds do
		list[#list + 1] = SkillPrototype:getAttrEffectDesc(effectIds[i], totalLoveLevel, {})
	end

	return list
end

function GallerySystem:getHeroRewards()
	return self._partyManage:getHeroRewards()
end

function GallerySystem:getLegendList()
	return self._partyManage:getLegendList()
end

function GallerySystem:getMessageList()
	return self._partyManage:getMessageList()
end

function GallerySystem:getMessageCount()
	return self._partyManage:getMessageCount()
end

function GallerySystem:getMessageById(id)
	local heroSystem = self._developSystem:getHeroSystem()

	return (self._partyManage:getMessageById(id))
end

function GallerySystem:getSkillAttrList()
	return self._partyManage:getSkillAttrList()
end

function GallerySystem:getUnlockStatus()
	local messageList = self:getMessageList()

	for i = 1, #messageList do
		local item = messageList[i]
		local itemId = item:getItemId()
		local hasCount = self._developSystem:getBagSystem():getItemCount(itemId)
		local composeCount = item:getComposeNum()

		if item:getLevel() == 0 and composeCount <= hasCount then
			return true
		end
	end

	return false
end

function GallerySystem:getLegendById(id)
	local heroSystem = self._developSystem:getHeroSystem()
	local legend = self._partyManage:getLegendById(id)
	local tasks = legend:getTasks()
	local heroes = legend:getHeroes()
	local heroNum = 0
	local starNum = 0

	for heroId, v in pairs(heroes) do
		local hero = heroSystem:getHeroById(heroId)

		if hero then
			heroNum = heroNum + 1
			starNum = starNum + hero:getStar()
		end
	end

	for i = 1, #tasks do
		local task = tasks[i]

		if task:getId() == 1 then
			task:setCurrentNum(heroNum)
		else
			task:setCurrentNum(starNum)
		end
	end

	return legend
end

function GallerySystem:checkIsShowRedPoint()
	local unlock, tips = self._systemKeeper:isUnlock("Hero_Gallery")

	if not unlock then
		return false
	end

	local newMemory = self:checkNewMemory()

	if newMemory then
		return true
	end

	local canReceive = self:checkcanReceive()

	if canReceive then
		return true
	end

	local canGetHeroReward = self:checkCanGetHeroReward()

	if canGetHeroReward then
		return true
	end

	self._bagSystem = self._developSystem:getBagSystem()

	if self._bagSystem:getURMapRedPoint() then
		return true
	end

	if self:getUnlockStatus() then
		return true
	end

	if self._taskSystem:hasMessageTaskRedPoint() then
		return true
	end

	return false
end

function GallerySystem:setLastViewTimeOfMemory(type)
	local serverrid = self._developSystem:getPlayer():getRid()
	local t = self._developSystem:getCurServerTime()

	cc.UserDefault:getInstance():setStringForKey(serverrid .. "_" .. type .. "_timestamp", tostring(t))
end

function GallerySystem:getLastViewTimeOfMemory(type)
	local serverrid = self._developSystem:getPlayer():getRid()
	local ts = tonumber(cc.UserDefault:getInstance():getStringForKey(serverrid .. "_" .. type .. "_timestamp"))

	if not ts then
		ts = 0

		cc.UserDefault:getInstance():setStringForKey(serverrid .. "_" .. type .. "_timestamp", tostring(0))
	end

	return ts
end

function GallerySystem:isNewMemory(data)
	if not data or data.class._NAME ~= "GalleryMemory" then
		return false
	end

	return self:checkNewMemoryId(data._config.Type, data._id)
end

function GallerySystem:checkNewMemoryId(type, id)
	if not type or not id then
		return false
	end

	if type == GalleryMemoryType.STORY then
		return self:getActivityStoryRedPoint(id)
	end

	local time = self:getLastViewTimeOfMemory(type)

	if time == nil or _G.type(time) ~= "number" then
		return false
	end

	return self._partyManage:checkNewMemoryIdByTime(type, id, time)
end

function GallerySystem:checkNewMemoryByType(type)
	if not type then
		return false
	end

	if type == GalleryMemoryType.ACTIVI or type == GalleryMemoryType.HERO then
		local timestamp = self:getLastViewTimeOfMemory(type)

		if timestamp == nil or _G.type(timestamp) ~= "number" then
			return false
		end

		return self._partyManage:checkNewMemoryByTime(type, timestamp)
	end

	if type == GalleryMemoryType.STORY then
		return self:getStoryPackRedPoint()
	end

	return false
end

function GallerySystem:getFirstNewMemoryByType(type, storyId)
	if not type then
		return nil
	end

	if type == GalleryMemoryType.ACTIVI or type == GalleryMemoryType.HERO then
		local timestamp = self:getLastViewTimeOfMemory(type)

		if timestamp == nil or _G.type(timestamp) ~= "number" then
			return nil
		end

		return self._partyManage:getFirstNewMemoryByType(type, timestamp)
	end

	if type == GalleryMemoryType.STORY and storyId then
		local timestamp = self:getLastViewTimeOfMemory(storyId)

		if timestamp == nil or _G.type(timestamp) ~= "number" then
			return nil
		end

		return self._partyManage:getFirstNewMemoryByType(storyId, timestamp)
	end

	return nil
end

function GallerySystem:getFirstNewMemoryPackByType(type)
	if not type or type ~= GalleryMemoryType.STORY then
		return nil
	end

	local res
	local memories = self:getMemoriePacksByType(GalleryMemoryPackType.ACTIVI)

	for id, value in pairs(memories) do
		repeat
			if value:getUnlock() then
				local timestamp = self:getLastViewTimeOfMemory(value:getId())

				if timestamp == nil or _G.type(timestamp) ~= "number" then
					break
				end

				if self._partyManage:getFirstNewMemoryStoryById(value:getId(), timestamp) and (not res or res:getNumber() > value:getNumber()) then
					res = value
				end

				do break end
				break
			end
		until true
	end

	return res or nil
end

function GallerySystem:checkNewMemory(type)
	return not type and (self:checkNewMemoryByType(GalleryMemoryType.ACTIVI) or self:checkNewMemoryByType(GalleryMemoryType.STORY) or self:checkNewMemoryByType(GalleryMemoryType.HERO)) or self:checkNewMemoryByType(type)
end

function GallerySystem:checkcanReceive(partyId)
	if not partyId then
		local partyMap = self:getPartyMap()

		for key, v in pairs(partyMap) do
			local partyType = v:getPartyId()
			local canReceive = self:canRevieveReward(partyType)

			if canReceive then
				return true
			end
		end

		return false
	end

	return (self:canRevieveReward(partyId))
end

function GallerySystem:checkCanGetHeroReward(partyId)
	local partyMap = self:getPartyMap()

	if partyId then
		return (self:checkCanGetHeroRewardById(partyId))
	end

	local heroSystem = self._developSystem:getHeroSystem()
	local heroRewards = self:getHeroRewards()

	for key, v in pairs(partyMap) do
		local heroIds = v:getHeroIds()
		local specialHeroIds = self:getAlbumFeminineHeroForRareityString(v:getPartyId())

		for i = 1, #heroIds do
			local heroId = heroIds[i]
			local hero = heroSystem:getHeroById(heroId)
			local canGet = not heroRewards[heroId]

			if hero and canGet then
				return true
			end
		end

		for i = 1, #specialHeroIds do
			local heroId = specialHeroIds[i]
			local hero = heroSystem:getHeroById(heroId)
			local canGet = not heroRewards[heroId]

			if hero and canGet then
				return true
			end
		end
	end

	return false
end

function GallerySystem:checkCanGetHeroRewardById(partyId)
	local partyMap = self:getPartyMap()
	local heroRewards = self:getHeroRewards()
	local heroIds = partyMap[partyId]:getHeroIds()
	local specialHeroIds = self:getAlbumFeminineHeroForRareityString(partyMap[partyId]:getPartyId())
	local heroSystem = self._developSystem:getHeroSystem()

	for i = 1, #heroIds do
		local heroId = heroIds[i]
		local canGet = not heroRewards[heroId]
		local hero = heroSystem:getHeroById(heroId)

		if hero and canGet then
			return true
		end
	end

	for i = 1, #specialHeroIds do
		local heroId = specialHeroIds[i]
		local canGet = not heroRewards[heroId]
		local hero = heroSystem:getHeroById(heroId)

		if hero and canGet then
			return true
		end
	end

	return false
end

function GallerySystem:requestGalleryPartyReward(params, callback)
	self:getService():requestGalleryPartyReward(params, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_GALLERY_BOX_GET_SUCC, response))
		end
	end)
end

function GallerySystem:requestGalleryAlbumSave(photoData, callback)
	local params = {
		photoMessage = photoData
	}

	self:getService():requestGalleryAlbumSave(params, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_GALLERY_TAKE_PHOTO_SUCC, response))
		end
	end)
end

function GallerySystem:requestMessageCompose(msgCardId, callback)
	local params = {
		msgCardId = msgCardId
	}

	self:getService():requestMessageCompose(params, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_MESSAGE_COMPOSE_SUCC, response))
		end
	end)
end

function GallerySystem:requestMessageLevelUp(msgCardId, callback)
	local params = {
		msgCardId = msgCardId
	}

	self:getService():requestMessageLevelUp(params, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_MESSAGE_LEVELUP_SUCC, response))
		end
	end)
end

function GallerySystem:requestGalleryAlbumDelete(photoIndex, callback)
	local params = {
		photoIndex = tonumber(photoIndex)
	}

	self:getService():requestGalleryAlbumDelete(params, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_GALLERY_DELETE_PHOTO_SUCC, response))
		end
	end)
end

function GallerySystem:requestSendGift(params, callback)
	params = {
		heroId = params.heroId,
		itemId = params.itemId,
		amount = params.amount
	}

	self:getService():requestSendGift(params, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_GALLERY_SEND_GIFT_SUCC, response))
		end
	end)
end

function GallerySystem:requestHeroDate(params, callback)
	params = {
		heroId = params.heroId,
		storyIndex = params.storyIndex,
		options = params.options
	}

	self:getService():requestHeroDate(params, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback()
		end
	end)
end

function GallerySystem:requestUpdateAfkList(params, callback)
	params = {
		list = params.herolist
	}

	self:getService():requestUpdateAfkList(params, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response)
		end
	end)
end

function GallerySystem:requestDoAfkEvent(params, callback)
	params = {
		heroId = params.heroId,
		itemId = params.itemId
	}

	self:getService():requestDoAfkEvent(params, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response)
		end
	end)
end

function GallerySystem:requestGalleryHeroReward(params, callback)
	params = {
		heroId = params.heroId
	}

	self:getService():requestGalleryHeroReward(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_GALLERY_HEROREWARD_SUCC, response))
		end
	end)
end

function GallerySystem:getAlbumFeminineHeroForRareityString(Party)
	local heroIds = {}
	local party_Rareity = RareityStringToNumber[Party]

	if party_Rareity then
		local Hero_Album_Feminine = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Album_Feminine", "content")

		for i = 1, #Hero_Album_Feminine do
			local hero = self._developSystem:getHeroSystem():getHeroById(Hero_Album_Feminine[i])

			if ((hero or nil) and hero:getRarity()) == party_Rareity then
				heroIds[#heroIds + 1] = Hero_Album_Feminine[i]
			end
		end
	end

	return heroIds
end

function GallerySystem:getStoryPackRedPoint()
	return self:getStoryPackRedPointByType(GalleryMemoryPackType.ACTIVI)
end

function GallerySystem:getStoryPackRedPointByType(type)
	if type == GalleryMemoryPackType.ACTIVI then
		return self:checkActivityStoryRedPoint()
	end

	return false
end

function GallerySystem:checkActivityStoryRedPoint()
	local list = self:getMemoriePacksByType(GalleryMemoryPackType.ACTIVI)

	for index, value in pairs(list) do
		if self:getActivityStoryPackRedPoint(value:getType(), value:getId()) then
			return true
		end
	end

	return false
end

function GallerySystem:getActivityStoryPackRedPoint(type, packId)
	local list1, list2 = self:getMemorieStorysById(type, packId)

	for index, story in ipairs(list1) do
		if self:getActivityStoryRedPoint(story:getId()) then
			return true
		end
	end

	for index, story in ipairs(list2) do
		if self:getActivityStoryRedPoint(story:getId()) then
			return true
		end
	end

	return false
end

function GallerySystem:getActivityStoryRedPoint(storyId)
	return self:getActivityStorySaveStatus(storyId) > 0
end

function GallerySystem:getActivityStorySaveStatus(storyId)
	local unlock, tips = self:checkEnabled()

	if not unlock then
		return 0
	end

	return cc.UserDefault:getInstance():getIntegerForKey(self:getActivityStoryUserDefaultKey(storyId), 0)
end

function GallerySystem:setActivityStorySaveStatus(storyId, save)
	if not storyId then
		return
	end

	local userStr = self:getActivityStoryUserDefaultKey(storyId)

	if save then
		cc.UserDefault:getInstance():setIntegerForKey(userStr, self._gameServerAgent:remoteTimestamp())
	else
		cc.UserDefault:getInstance():setIntegerForKey(userStr, 0)
	end
end

function GallerySystem:getActivityStoryUserDefaultKey(storyId)
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local idStr = string.split(developSystem:getPlayer():getRid(), "_")

	return "ACTIVITY_STORY_REDPOINT_" .. storyId .. idStr[1]
end

function GallerySystem:setMessageSaveNewStatus(messageId, save)
	if not messageId then
		return
	end

	local userStr = self:getMessageSaveNewDefaultKey(messageId)

	if save then
		cc.UserDefault:getInstance():setIntegerForKey(userStr, self._gameServerAgent:remoteTimestamp())
	else
		cc.UserDefault:getInstance():setIntegerForKey(userStr, 0)
	end
end

function GallerySystem:getMessageSaveNewDefaultKey(messageId)
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local idStr = string.split(developSystem:getPlayer():getRid(), "_")

	return "MESSAGE_NEW_" .. messageId .. idStr[1]
end

function GallerySystem:getMessageSaveNewStatus(messageId)
	return cc.UserDefault:getInstance():getIntegerForKey(self:getMessageSaveNewDefaultKey(messageId), 0)
end

function GallerySystem:getStoryIdByStoryLink(link, pointId)
	local data = ConfigReader:getDataTable("GalleryMemory")

	for storyId, value in pairs(data) do
		if value.StoryLink == link then
			if pointId then
				if value.Condition[1].params[2] == pointId then
					return storyId
				end
			else
				return storyId
			end
		end
	end

	return nil
end

function GallerySystem:isShowSkip()
	local curDate = self:getCurDate()
	local heroData = curDate.heroData
	local storyOption = curDate.storyOption
	local storyIndex = curDate.storyIndex
	local lastDate1 = heroData:getLastDate()
	local lastDate = lastDate1[tostring(storyIndex)] or {}

	if #lastDate < #storyOption then
		return false
	end

	local skip = true

	for index, value in ipairs(storyOption) do
		local v = lastDate[index]

		if v.point ~= value[v.index] then
			skip = false
		end
	end

	return skip
end

function GallerySystem:getDateOptionsValue()
	local options = self._dateOptions
	local curDate = self:getCurDate()
	local heroData = curDate.heroData
	local storyOption = curDate.storyOption
	local storyIndex = curDate.storyIndex
	local lastDate1 = heroData:getLastDate()
	local lastDate = lastDate1[tostring(storyIndex)] or {}
	local opts = {}
	local loves = 0

	if #options >= #lastDate then
		opts = options

		for index, optionIndex in ipairs(options) do
			if storyOption[index] and storyOption[index][optionIndex] then
				loves = loves + storyOption[index][optionIndex]
			end
		end
	else
		for index, value in ipairs(lastDate) do
			if options[index] then
				opts[index] = options[index]
				loves = loves + storyOption[index][opts[index]]
			else
				opts[index] = value.index
				loves = loves + value.point
			end
		end
	end

	return opts, loves
end
