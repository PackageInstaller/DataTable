-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/controller/RewardSystem.lua

RewardSystem = class("RewardSystem", legs.Actor)

function RewardSystem:initialize(developSystem)
	super.initialize(self)

	self._developSystem = developSystem
end

function RewardSystem:userInject(injector)
	return
end

RewardType = {
	kHero = 3,
	kTitle = 35,
	kEquipExplore = 11,
	kEquip = 6,
	kExp = 1,
	kRewardLink = 9,
	kChatBubble = 36,
	kGalleryMemory = 16,
	kBuff = 17,
	kSpecialValue = 4,
	kInvalid = -1,
	kKernel = 5,
	kShow = 99,
	kHeadFrame = 14,
	kDecorate = 20,
	kItem = 2,
	kBackground = 22,
	kTSoul = 34,
	kRTPKEmoji = 30,
	kMessage = 37,
	kSurface = 7,
	kStory = "STORY"
}
RewardRandomType = {
	kOnce = "Once",
	kTimes = "Times",
	kOnce2 = "Once2",
	kQQLevel = "QQLevel",
	kSeeds = "Seeds",
	kArrays = "Arrays",
	kVIP = "VIP",
	kLevel = "Level",
	kTimesResetByMaxValue = "TimesResetByMaxValue",
	kFixed = "Fixed"
}

local kTypeCodeMap = {
	{
		["0"] = "Exp",
		["1"] = "xxx"
	},
	[4] = {
		["1"] = ConfigReader:getRecordById("ConfigValue", "ActiveRewardChange").content,
		["8"] = ConfigReader:getRecordById("ConfigValue", "PansLabGOLDChange").content
	}
}
local kRewardConfig = {
	[RewardType.kRewardLink] = {
		name = Strings:get(ConfigReader:getDataByNameIdAndKey("ConfigValue", "MysteryItemName", "content")),
		desc = Strings:get(ConfigReader:getDataByNameIdAndKey("ConfigValue", "MysteryItemDesc", "content"))
	},
	[RewardType.kStory] = {
		name = Strings:get(ConfigReader:getDataByNameIdAndKey("ConfigValue", "StoryItemName", "content")),
		desc = Strings:get(ConfigReader:getDataByNameIdAndKey("ConfigValue", "StoryItemDesc", "content"))
	}
}

function RewardSystem:getFixedAmount(rewardId)
	if rewardId then
		local Reward = ConfigReader:getRecordById("Reward", rewardId)

		if Reward and Reward.Content then
			local firstData = Reward.Content[1]

			return firstData and firstData.amount
		end
	end
end

function RewardSystem.class:getName(rewardData)
	local info = rewardData
	local rewardConfig = kRewardConfig[rewardData.type]

	if rewardConfig then
		return rewardConfig.name
	end

	if rewardData.type ~= nil and rewardData.code ~= nil then
		info = self:parseInfo(rewardData)
	end

	assert(info ~= nil, "error:rewardData=nil")
	assert(info.id ~= nil, "error:id error")

	local id = tostring(info.id)

	if info.rewardType then
		if info.rewardType == RewardType.kSurface then
			local config = ConfigReader:getRecordById("Surface", id)

			if config and config.Id then
				return Strings:get(config.Name)
			end
		elseif info.rewardType == RewardType.kHero then
			local config = ConfigReader:getRecordById("HeroBase", id)

			if config and config.Id then
				return Strings:get(config.Name)
			end
		elseif info.rewardType == RewardType.kEquip or info.rewardType == RewardType.kEquipExplore then
			local config = ConfigReader:getRecordById("HeroEquipBase", id)

			if config and config.Id then
				return Strings:get(config.Name)
			end
		elseif info.rewardType == RewardType.kBackground then
			local config = ConfigReader:getRecordById("HomeBackground", id)

			if config and config.Id then
				return Strings:get(config.Information.name)
			end
		elseif info.rewardType == RewardType.kRTPKEmoji then
			local config = ConfigReader:getRecordById("MasterFace", id)

			if config and config.Id then
				return Strings:get(config.EMJName)
			end
		elseif info.rewardType == RewardType.kTSoul then
			local config = ConfigReader:getRecordById("Tsoul", id)

			if config and config.Id then
				return Strings:get(config.Name) .. "x" .. rewardData.amount
			end
		elseif info.rewardType == RewardType.kChatBubble then
			local config = ConfigReader:getRecordById("ChatBubble", id)

			if config and config.Id then
				return Strings:get(config.Name)
			end
		elseif info.rewardType == RewardType.kTitle then
			local config = ConfigReader:getRecordById("PlayerTitle", id)

			if config and config.Id then
				return Strings:get(config.Name)
			end
		end
	end

	local config = ConfigReader:getRecordById("ItemConfig", id)

	if config and config.Id then
		return Strings:get(config.Name)
	end

	config = ConfigReader:getRecordById("ResourcesIcon", id)

	if config then
		return Strings:get(config.Name)
	end

	config = ConfigReader:getRecordById("Skill", id)

	if config and config.Id then
		return Strings:get(config.Name)
	end

	config = ConfigReader:getRecordById("MasterCoreBase", id)

	if config and config.Id then
		return Strings:get(config.Name)
	end

	config = ConfigReader:getRecordById("PlayerHeadFrame", id)

	if config and config.Id then
		return Strings:get(config.Name)
	end

	return ""
end

function RewardSystem.class:getQuality(rewardData)
	local info = rewardData

	if rewardData.type == RewardType.kRewardLink or rewardData.type == RewardType.kStory then
		return rewardData.quality
	end

	if rewardData.type ~= nil and rewardData.code ~= nil then
		info = self:parseInfo(rewardData)
	end

	assert(info ~= nil, "error:rewardData=nil")
	assert(info.id ~= nil, "error:id error")

	local id = tostring(info.id)

	if info.rewardType then
		if info.rewardType == RewardType.kSurface then
			local config = ConfigReader:getRecordById("Surface", id)

			if config and config.Id then
				return config.Quality
			end
		elseif info.rewardType == RewardType.kHero then
			local config = ConfigReader:getRecordById("HeroBase", id)

			if config and config.Id then
				local qualityConfig = ConfigReader:getRecordById("HeroQuality", config.BaseQualityAttr)

				return math.floor(qualityConfig.Quality / 10)
			end
		elseif info.rewardType == RewardType.kEquip or info.rewardType == RewardType.kEquipExplore then
			local config = ConfigReader:getRecordById("HeroEquipBase", id)

			if config and config.Id then
				return config.Rareity
			end
		end
	end

	local config = ConfigReader:getRecordById("ResourcesIcon", id)

	if config then
		local index

		if rewardData.amount then
			for i, num in ipairs(config.Segmentation) do
				if num > rewardData.amount then
					index = i - 1

					break
				end
			end

			index = index ~= nil and math.max(index, 1) or math.min(#config.Segmentation, #config.LargeIcons)
		else
			index = 1
		end

		local var_5_0 = rewardData.quality

		if not rewardData.quality then
			var_5_0 = config.Quality[index]

			if not config.Quality[index] then
				return config.Quality[1]
			end
		end
	end

	config = ConfigReader:getRecordById("ItemConfig", id)

	if config and config.Id then
		return config.Quality
	end

	config = ConfigReader:getRecordById("HeroBase", id)

	if config and config.Id then
		local qualityConfig = ConfigReader:getRecordById("HeroQuality", config.BaseQualityAttr)

		return math.floor(qualityConfig.Quality / 10)
	end

	config = ConfigReader:getRecordById("MasterCoreBase", id)

	if config and config.Id then
		return config.Quality
	end

	config = ConfigReader:getRecordById("Tsoul", id)

	if config and config.Id then
		return config.Rareity
	end
end

function RewardSystem.class:getDesc(rewardData)
	local info = rewardData
	local rewardConfig = kRewardConfig[rewardData.type]

	if rewardConfig then
		return rewardConfig.name
	end

	if rewardData.type ~= nil and rewardData.code ~= nil then
		info = self:parseInfo(rewardData)
	end

	assert(info ~= nil, "error:rewardData=nil")
	assert(info.id ~= nil, "error:id error")

	local id = tostring(info.id)

	if info.rewardType then
		if info.rewardType == RewardType.kSurface then
			local config = ConfigReader:getRecordById("Surface", id)

			if config and config.Id then
				return Strings:get(config.LongDesc)
			end
		elseif info.rewardType == RewardType.kHero then
			local config = ConfigReader:getRecordById("HeroBase", id)

			if config and config.Id then
				return Strings:get(config.ShortDesc)
			end
		elseif info.rewardType == RewardType.kEquip or info.rewardType == RewardType.kEquipExplore then
			local config = ConfigReader:getRecordById("HeroEquipBase", id)

			if config and config.Id then
				return Strings:get(config.Desc)
			end
		elseif info.rewardType == RewardType.kBackground then
			local config = ConfigReader:getRecordById("HomeBackground", id)

			if config and config.Id then
				return Strings:get(config.Information.desc)
			end
		elseif info.rewardType == RewardType.kRTPKEmoji then
			local config = ConfigReader:getRecordById("MasterFace", id)

			if config and config.Id then
				return Strings:get(config.Log)
			end
		elseif info.rewardType == RewardType.kChatBubble then
			local config = ConfigReader:getRecordById("ChatBubble", id)

			if config and config.Id then
				return Strings:get(config.Desc)
			end
		end
	end

	local config = ConfigReader:getRecordById("ItemConfig", id)

	if config and config.Id then
		return Strings:get((config.FunctionDesc ~= "" or nil) and (config.FunctionDesc or config.Desc))
	end

	config = ConfigReader:getRecordById("ResourcesIcon", id)

	if config then
		return Strings:get(config.Desc)
	end

	config = ConfigReader:getRecordById("Skill", id)

	if config and config.Id then
		return config.desc
	end

	config = ConfigReader:getRecordById("PlayerHeadFrame", id)

	if config and config.Id then
		return Strings:get(config.Desc)
	end

	config = ConfigReader:getRecordById("PlayerTitle", id)

	if config and config.Id then
		return Strings:get(config.Desc)
	end

	return ""
end

function RewardSystem.class:getResource(id)
	local config = ConfigReader:getRecordById("ResourcesIcon", id)

	if config then
		return config.Resource
	end

	config = ConfigReader:getRecordById("ItemConfig", id)

	if config then
		return config.Resource
	end
end

function RewardSystem.class:parseInfo(rewardData)
	if rewardData.type == RewardType.kRewardLink or rewardData.type == RewardType.kStory then
		rewardData.id = "random"

		return rewardData
	end

	if rewardData.type == RewardType.kShow then
		local info = {}

		info.rewardType = RewardType.kShow
		info.icon = rewardData.icon or ""
		info.title = rewardData.title or ""
		info.desc = rewardData.desc or ""
		info.tips = rewardData.tips or ""

		return info
	end

	assert(rewardData ~= nil, "error:rewardData=nil")
	assert(rewardData.type ~= nil and rewardData.code ~= nil and rewardData.amount ~= nil, "error:config error")

	if rewardData.typeValue then
		rewardData.type = rewardData.typeValue
	end

	local intType = tonumber(rewardData.type)
	local strCode = tostring(rewardData.code)
	local info = {
		amount = rewardData.amount,
		rewardType = intType,
		clipIndex = rewardData.clipIndex,
		showEquipAmount = rewardData.showEquipAmount
	}

	if kTypeCodeMap[intType] then
		if intType == 4 then
			info.id = kTypeCodeMap[intType][strCode]
		else
			info.id = kTypeCodeMap[intType][strCode]

			assert(info.id ~= nil, "error:no code=" .. tostring(rewardData.code) .. " of type " .. tostring(intType))

			local config = ConfigReader:getRecordById("ResourcesIcon", info.id)
			local index

			for i, num in ipairs(config.Segmentation) do
				if num > info.amount then
					index = i - 1

					break
				end
			end

			index = index ~= nil and math.max(index, 1) or #config.Segmentation
			info.quality = config.Quality[index]
		end
	elseif intType == RewardType.kHero then
		info.id = rewardData.code
		info.star = rewardData.amount
		info.level = 1

		local heroConfig = ConfigReader:getRecordById("HeroBase", info.id)

		if heroConfig ~= nil then
			local qualityConfig = ConfigReader:getRecordById("HeroQuality", heroConfig.BaseQualityAttr)

			info.quality = qualityConfig.Quality
			info.modelId = info.modelId or heroConfig.BattleModel
		end
	elseif intType == RewardType.kBuff then
		info.id = rewardData.code
		info.buffType = rewardData.buffType or "Buff"
		info.desc = rewardData.desc
		info.title = rewardData.title
		info.icon = rewardData.icon
	else
		info.id = intType == RewardType.kTSoul and rewardData.code or rewardData.code
	end

	return info
end

function RewardSystem:isCurrency(Reward)
	return Reward and Reward.type == RewardType.kCurrency
end

function RewardSystem.class:getRewardsById(id, param)
	if not id or id == "" then
		return {}
	end

	local config = ConfigReader:requireRecordById("Reward", id)
	local type = config.RandomType
	local rewards = config.Content

	if type == RewardRandomType.kFixed then
		local showRewards = {}

		for i = 1, #rewards do
			if rewards[i].code ~= 3 then
				table.insert(showRewards, rewards[i])
			end
		end

		return showRewards
	elseif type == RewardRandomType.kLevel or type == RewardRandomType.kVIP then
		if param then
			return rewards[param] or {}
		end

		local showRewards = {}

		for i = 1, #rewards do
			for level, data in pairs(rewards[i]) do
				for index = 1, #data do
					showRewards[#showRewards + 1] = data[index]
				end
			end
		end

		return showRewards
	elseif type == RewardRandomType.kOnce or type == RewardRandomType.kOnce2 or type == RewardRandomType.kTimes or type == RewardRandomType.kTimesResetByMaxValue or type == RewardRandomType.kArrays then
		local showRewards = {}

		for i = 1, #rewards do
			for level, data in pairs(rewards[i]) do
				for index = 1, #data do
					showRewards[#showRewards + 1] = data[index]
				end
			end
		end

		return showRewards
	elseif type == RewardRandomType.kSeeds then
		-- block empty
	end

	return {}
end

function RewardSystem.class:checkIsComposeItem(info)
	local result = false

	if ((info.type or nil) and info.type) == RewardType.kItem then
		local config = ConfigReader:getRecordById("ItemConfig", tostring((info.code or nil) and info.code))

		if config and config.Id and config.Type == ItemTypes.K_COMPOSE then
			result = true
		end
	end

	return result
end
