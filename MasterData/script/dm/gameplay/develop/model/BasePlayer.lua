-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/BasePlayer.lua

BasePlayer = class("BasePlayer", objectlua.Object, _M)

BasePlayer:has("_uid", {
	is = "rw"
})
BasePlayer:has("_rid", {
	is = "rw"
})
BasePlayer:has("_cid", {
	is = "rw"
})
BasePlayer:has("_headId", {
	is = "rw"
})
BasePlayer:has("_nickName", {
	is = "rw"
})
BasePlayer:has("_exp", {
	is = "rw"
})
BasePlayer:has("_vipLevel", {
	is = "rw"
})
BasePlayer:has("_level", {
	is = "rw"
})
BasePlayer:has("_combat", {
	is = "rw"
})
BasePlayer:has("_energyData", {
	is = "rw"
})
BasePlayer:has("_slogan", {
	is = "rw"
})
BasePlayer:has("_gender", {
	is = "rw"
})
BasePlayer:has("_city", {
	is = "rw"
})
BasePlayer:has("_birthday", {
	is = "rw"
})
BasePlayer:has("_tags", {
	is = "rw"
})
BasePlayer:has("_firstRecharge", {
	is = "rw"
})
BasePlayer:has("_rechargeRewards", {
	is = "rw"
})
BasePlayer:has("_buyPackItems", {
	is = "rw"
})
BasePlayer:has("_generalReward", {
	is = "rw"
})
BasePlayer:has("_firstUpdateBirthDay", {
	is = "rw"
})
BasePlayer:has("_cheatCount", {
	is = "rw"
})
BasePlayer:has("_curHeadFrame", {
	is = "rw"
})
BasePlayer:has("_headFrames", {
	is = "rw"
})
BasePlayer:has("_createTime", {
	is = "rw"
})
BasePlayer:has("_maxCombat", {
	is = "rw"
})
BasePlayer:has("_background", {
	is = "rw"
})
BasePlayer:has("_playerStageArena", {
	is = "rw"
})
BasePlayer:has("_stageArenafriends", {
	is = "r"
})
BasePlayer:has("_chessArena", {
	is = "r"
})
BasePlayer:has("_usedEmoji", {
	is = "rw"
})
BasePlayer:has("_unlockedEmoji", {
	is = "rw"
})
BasePlayer:has("_showHeroes", {
	is = "rw"
})
BasePlayer:has("_chatBubble", {
	is = "rw"
})
BasePlayer:has("_curChatBubbleId", {
	is = "rw"
})
BasePlayer:has("_titles", {
	is = "rw"
})
BasePlayer:has("_curTitleId", {
	is = "rw"
})
BasePlayer:has("_pushGiftList", {
	is = "r"
})
BasePlayer:has("_pushGiftListScene", {
	is = "r"
})

function BasePlayer:initialize(config)
	super.initialize(self)

	self._level = 0

	self:setLevel(0)

	self._vipLevel = 0
	self._combat = 0
	self._exp = 0
	self._firstRecharge = 0
	self._rechargeRewards = {}
	self._slogan = ""
	self._buyPackItems = {}
	self._generalReward = {}
	self._birthday = "2000-01-01"
	self._firstUpdateBirthDay = false
	self._cheatCount = 0
	self._curHeadFrame = ""
	self._headFrames = {}
	self._background = {}
	self._playerStageArena = {}
	self._stageArenafriends = {}
	self._chessArena = {}
	self._usedEmoji = {}
	self._unlockedEmoji = {}
	self._showHeroes = {}
	self._chatBubble = {}
	self._curChatBubbleId = ""
	self._titles = {}
	self._pushGiftList = {}
	self._pushGiftListScene = {}
end

function BasePlayer:synchronizeInfoDiff(diffData)
	if not diffData then
		return
	end

	if diffData.createTime then
		self:setCreateTime(diffData.createTime)
	end

	if diffData.level then
		self:setLevel(diffData.level)
	end

	if diffData.vipLevel then
		self:setVipLevel(diffData.vipLevel)
	end

	if diffData.uid then
		self:setUid(diffData.uid)
	end

	if diffData.rid then
		self:setRid(diffData.rid)
	end

	if diffData.cid then
		self:setCid(diffData.cid)
	end

	if diffData.heads and diffData.heads.currHead then
		self:setHeadId(tostring(diffData.heads.currHead))
	end

	if diffData.maxData and diffData.maxData.combat then
		self:setMaxCombat(tostring(diffData.maxData.combat))
	end

	if diffData.nickname then
		self:setNickName(diffData.nickname)
	end

	if diffData.vipLevel then
		self:setVipLevel(diffData.vipLevel)
	end

	if diffData.level then
		self:setLevel(diffData.level)
	end

	if diffData.combat then
		self:setCombat(diffData.combat)
	end

	if diffData.xp then
		self:setExp(diffData.xp)
	end

	if diffData.energy then
		self:setEnergyData(diffData.energy)
	end

	if diffData.slogan then
		self:setSlogan(Strings:get(diffData.slogan))
	end

	if diffData.gender then
		self:setGender(diffData.gender)
	end

	if diffData.city then
		self:setCity(diffData.city)
	end

	if diffData.birthday then
		self:setBirthday(diffData.birthday)
	end

	if diffData.tags then
		self:setTags(diffData.tags)
	end

	if diffData.firstRecharge then
		self:setFirstRecharge(diffData.firstRecharge)
	end

	if diffData.rechargeRewards then
		self:setRechargeRewards(diffData.rechargeRewards)
	end

	if diffData.buyPackItems then
		for i, v in pairs(diffData.buyPackItems) do
			local index = tonumber(i + 1)

			self._buyPackItems[index] = v
		end
	end

	if diffData.generalReward then
		for i, rewardType in pairs(diffData.generalReward) do
			self._generalReward[rewardType] = true
		end
	end

	if diffData.firstUpdateBirthDay ~= nil then
		self._firstUpdateBirthDay = diffData.firstUpdateBirthDay
	end

	if diffData.cheatCount then
		self:setCheatCount(diffData.cheatCount)
	end

	if diffData.curHeadFrame ~= nil then
		self._curHeadFrame = diffData.curHeadFrame
	end

	if diffData.headFrames ~= nil then
		self:setHeadFrames(diffData.headFrames)
	end

	if diffData.background ~= nil then
		self:setBackground(diffData.background)
	end

	if diffData.playerStageArena then
		for k, v in pairs(diffData.playerStageArena) do
			self._playerStageArena[k] = v
		end

		if diffData.playerStageArena.friendsInfoMap then
			self._stageArenafriends = {}

			local index = 1

			for i, v in pairs(diffData.playerStageArena.friendsInfoMap) do
				local info = LeadStageArenaHeroInfo:new()

				info:synchronize(v)

				self._stageArenafriends[index] = info
				index = index + 1
			end
		end
	end

	if diffData.chessArena then
		for k, v in pairs(diffData.chessArena) do
			if k == "rewards" then
				self._chessArena[k] = self._chessArena[k] or {}

				for id, st in pairs(v) do
					self._chessArena[k][id] = st
				end
			else
				self._chessArena[k] = v
			end
		end
	end

	if diffData.usedEmoji then
		self._usedEmoji = diffData.usedEmoji
	end

	if diffData.unlockedEmoji then
		for k, v in pairs(diffData.unlockedEmoji) do
			self._unlockedEmoji[k] = v
		end
	end

	if diffData.showHeroes then
		self._showHeroes = {}

		for i, v in pairs(diffData.showHeroes) do
			self._showHeroes[i + 1] = v
		end
	end

	if diffData.chatBubble then
		for k, v in pairs(diffData.chatBubble) do
			self._chatBubble[k] = v
		end
	end

	if diffData.curChatBubbleId then
		self._curChatBubbleId = diffData.curChatBubbleId
	end

	if diffData.title then
		for k, v in pairs(diffData.title) do
			self._titles[k] = v
		end
	end

	if diffData.curTitleId then
		self._curTitleId = diffData.curTitleId
	end

	if diffData.pushGift and diffData.pushGift.gifts then
		for id, value in pairs(diffData.pushGift.gifts or {}) do
			self._pushGiftList[id] = value / 1000
		end
	end

	if diffData.pushGiftScene then
		for id, v in pairs(diffData.pushGiftScene or {}) do
			self._pushGiftListScene[id] = v
		end
	end
end

function BasePlayer:deleteNewArenaReward(data)
	if data.rewards and self._chessArena then
		self._chessArena.rewards = {}
	end
end

function BasePlayer:deletePushGift(data)
	if data.gifts then
		for k, v in pairs(data.gifts or {}) do
			self._pushGiftList[k] = nil
			self._pushGiftListScene[k] = nil
		end
	end
end

function BasePlayer:setHeadFrames(data)
	for id, value in pairs(data) do
		self._headFrames[id] = value
	end
end

function BasePlayer:setBackground(data)
	for id, value in pairs(data) do
		self._background[value] = 1
	end
end
