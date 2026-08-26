-- chunkname: @modules/logic/player/model/PlayerModel.lua

module("modules.logic.player.model.PlayerModel", package.seeall)

local PlayerModel = class("PlayerModel", BaseModel)

function PlayerModel:onInit()
	self._userId = 0
	self._name = ""
	self._portrait = 0
	self._level = 0
	self._exp = 0
	self._signature = ""
	self._birthday = ""
	self._showHeros = {}
	self._simpleProperties = {}
	self._registerTime = 0
	self._lastLoginTime = 0
	self._lastLogoutTime = 0
	self._heroRareNNCount = 0
	self._heroRareNCount = 0
	self._heroRareRCount = 0
	self._heroRareSRCount = 0
	self._heroRareSSRCount = 0
	self._lastEpisodeId = 0
	self._levelup = 0
	self._preCommitFeedBackTime = -1
	self._bg = 0
	self._canRename = false
	self._canRenameFlagMonth = nil
	self._playerInfo = nil
	self._showAchievement = nil
	self._totalLoginDays = 0

	self:updateAssistRewardCountData(0, 0, true)
end

function PlayerModel:reInit()
	self._simpleProperties = {}
	self._playerInfo = nil

	self:updateAssistRewardCountData(0, 0, true)
end

function PlayerModel:setPlayerinfo(info)
	local oldLevel = self._level
	local oldLastEpisodeId = self._lastEpisodeId

	self._userId = info.userId
	self._name = info.name
	self._portrait = info.portrait
	self._level = info.level
	self._exp = info.exp
	self._signature = info.signature
	self._birthday = info.birthday
	self._registerTime = info.registerTime
	self._lastLoginTime = info.lastLoginTime
	self._lastLogoutTime = info.lastLogoutTime
	self._heroRareNNCount = info.heroRareNNCount
	self._heroRareNCount = info.heroRareNCount
	self._heroRareRCount = info.heroRareRCount
	self._heroRareSRCount = info.heroRareSRCount
	self._heroRareSSRCount = info.heroRareSSRCount
	self._lastEpisodeId = info.lastEpisodeId
	self._showAchievement = info.showAchievement
	self._bg = info.bg
	self._totalLoginDays = info.totalLoginDays

	self:_checkHeroinfo(info.showHeros)
	PlayerController.instance:dispatchEvent(PlayerEvent.ChangePlayerinfo, info)

	if oldLevel < self._level and oldLevel ~= 0 then
		SDKMgr.instance:upgradeRole(StatModel.instance:generateRoleInfo())
		PlayerController.instance:dispatchEvent(PlayerEvent.PlayerLevelUp, oldLevel, self._level)

		self._levelup = self._level - oldLevel
	end

	if oldLastEpisodeId ~= 0 and self._lastEpisodeId ~= oldLastEpisodeId then
		SDKMgr.instance:updateRole(StatModel.instance:generateRoleInfo())
	end

	if OpenConfig.instance:isShowWaterMarkConfig() then
		self:showWaterMark()
	end

	ActivityEnterMgr.instance:init()
end

function PlayerModel:getAndResetPlayerLevelUp()
	self._levelup = 0

	return self._levelup
end

function PlayerModel:_checkHeroinfo(showHeros)
	self._showHeros = {}

	for i = 1, #showHeros do
		if showHeros[i].heroId == 0 then
			showHeros[i] = 0
		end

		table.insert(self._showHeros, showHeros[i])
	end

	for i = 1, 3 do
		if i > #self._showHeros then
			self._showHeros[i] = 0
		end
	end
end

function PlayerModel:getPlayinfo()
	self._playerInfo = self._playerInfo or {}

	local playerinfo = self._playerInfo

	playerinfo.userId = self._userId
	playerinfo.name = self._name
	playerinfo.portrait = self._portrait
	playerinfo.level = self._level
	playerinfo.exp = self._exp
	playerinfo.signature = self._signature
	playerinfo.birthday = self._birthday
	playerinfo.showHeros = self._showHeros
	playerinfo.registerTime = self._registerTime
	playerinfo.lastLoginTime = self._lastLoginTime
	playerinfo.lastLogoutTime = self._lastLogoutTime
	playerinfo.heroRareNNCount = self._heroRareNNCount
	playerinfo.heroRareNCount = self._heroRareNCount
	playerinfo.heroRareRCount = self._heroRareRCount
	playerinfo.heroRareSRCount = self._heroRareSRCount
	playerinfo.heroRareSSRCount = self._heroRareSSRCount
	playerinfo.lastEpisodeId = self._lastEpisodeId
	playerinfo.showAchievement = self._showAchievement
	playerinfo.bg = self._bg
	playerinfo.totalLoginDays = self._totalLoginDays

	return self._playerInfo
end

function PlayerModel:getExpNowAndMax()
	local exp_now = self._exp
	local exp_max = 0

	if self._level < CommonConfig.instance:getConstNum(ConstEnum.PlayerMaxLev) then
		exp_max = PlayerConfig.instance:getPlayerLevelCO(self._level + 1).exp
	else
		exp_max = PlayerConfig.instance:getPlayerLevelCO(self._level).exp
		exp_now = exp_max
	end

	return {
		exp_now,
		exp_max
	}
end

function PlayerModel:getPlayerLevel()
	return self._level
end

function PlayerModel:setPlayerName(name)
	self._name = name

	self:_changePlayerbassinfo()
	PlayerController.instance:dispatchEvent(PlayerEvent.ChangePlayerName)
end

function PlayerModel:getPlayerName()
	return self._name
end

function PlayerModel:setPlayerSignature(signature)
	self._signature = signature

	self:_changePlayerbassinfo()
end

function PlayerModel:setPlayerBirthday(birthday)
	self._birthday = birthday

	self:_changePlayerbassinfo()
end

function PlayerModel:setPlayerPortrait(portrait)
	PlayerController.instance:dispatchEvent(PlayerEvent.SetPortrait, portrait)

	self._portrait = portrait

	self:_changePlayerbassinfo()
end

function PlayerModel:setShowHeroUniqueIds()
	PlayerController.instance:dispatchEvent(PlayerEvent.SetShowHero, self._showHeros)
end

function PlayerModel:_changePlayerbassinfo()
	local info = self:getPlayinfo()

	PlayerController.instance:dispatchEvent(PlayerEvent.PlayerbassinfoChange, info)
end

function PlayerModel:getShowHeros()
	return self._showHeros
end

function PlayerModel:getShowHeroUid()
	local showids = {}

	for i = 1, #self._showHeros do
		if self._showHeros[i] ~= 0 then
			local uid = HeroModel.instance:getByHeroId(self._showHeros[i].heroId).uid

			table.insert(showids, uid)
		else
			table.insert(showids, 0)
		end
	end

	return showids
end

function PlayerModel:setShowHero(num, id)
	self._showHeros[num] = id ~= 0 and self:_setSimpleinfo(id) or 0
end

function PlayerModel:_setSimpleinfo(id)
	local hero = HeroModel.instance:getByHeroId(id)
	local Simpleinfo = {}

	Simpleinfo.uid = hero.uid
	Simpleinfo.heroId = hero.heroId
	Simpleinfo.level = hero.level
	Simpleinfo.rank = hero.rank
	Simpleinfo.exSkillLevel = hero.exSkillLevel
	Simpleinfo.skin = hero.skin

	return Simpleinfo
end

function PlayerModel:updateAssistRewardCountData(rewardCount, hasReceiveAssistBonus, notDispatchEvent)
	self._assistRewardCount = rewardCount or 0
	self._hasReceiveAssistBonus = hasReceiveAssistBonus or 0

	if notDispatchEvent then
		return
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.UpdateAssistRewardCount)
end

function PlayerModel:getAssistRewardCount()
	return self._assistRewardCount or 0
end

function PlayerModel:isHasAssistReward()
	local result = false
	local isReachingLimit = self:isGetAssistRewardReachingLimit()

	if isReachingLimit then
		return result
	end

	local assistRewardCount = self:getAssistRewardCount()

	result = assistRewardCount and assistRewardCount > 0

	return result
end

function PlayerModel:getMaxAssistRewardCount()
	local result = CommonConfig.instance:getConstNum(ConstEnum.AssistRewardMaxNum)

	return result or 0
end

function PlayerModel:getHasReceiveAssistBonus()
	return self._hasReceiveAssistBonus or 0
end

function PlayerModel:isGetAssistRewardReachingLimit()
	local maxAssistRewardCount = self:getMaxAssistRewardCount()
	local hasReceiveAssistBonus = self:getHasReceiveAssistBonus()

	return maxAssistRewardCount <= hasReceiveAssistBonus
end

function PlayerModel:updateSimpleProperties(simpleProperties)
	for i, v in ipairs(simpleProperties) do
		self:updateSimpleProperty(v)
	end
end

local simplePropertyMoFactory = {
	[PlayerEnum.SimpleProperty.SkinState] = KeyValueSimplePropertyMO,
	[PlayerEnum.SimpleProperty.MainSceneSkinRedDot] = KeyValueSimplePropertyMO,
	[PlayerEnum.SimpleProperty.NuoDiKaNewSkill] = KeyValueSimplePropertyMO
}

function PlayerModel:_getSimplePropMo(id)
	local mo = self._simpleProperties[id]

	if not mo then
		if not simplePropertyMoFactory[id] then
			mo = simplePropertyMoFactory[id].New()
			self._simpleProperties[id] = mo
		end
	end

	return mo
end

function PlayerModel:updateSimpleProperty(simpleProperty)
	self._simpleProperties = self._simpleProperties or {}

	local mo = self:_getSimplePropMo(simpleProperty.id)

	mo:init(simpleProperty)
end

function PlayerModel:forceSetSimpleProperty(id, value)
	local mo = self._simpleProperties[id]

	if mo then
		mo.property = value
	end
end

function PlayerModel:getSimpleProperty(id)
	if self._simpleProperties then
		local mo = self._simpleProperties[id]

		return mo and mo.property
	end

	return nil
end

function PlayerModel:getPropKeyValue(propertyId, id, defaultValue)
	local mo = self:_getSimplePropMo(propertyId)

	return mo:getValue(id, defaultValue)
end

function PlayerModel:setPropKeyValue(propertyId, id, value)
	local mo = self:_getSimplePropMo(propertyId)

	mo:setValue(id, value)
end

function PlayerModel:getPropKeyValueString(propertyId)
	local mo = self:_getSimplePropMo(propertyId)

	return mo:getString()
end

function PlayerModel:getMyUserId()
	return self._userId
end

function PlayerModel:isPlayerSelf(uid)
	local myUserId = self:getMyUserId()

	return (myUserId and uid or nil) and uid == myUserId
end

function PlayerModel:logout()
	return
end

function PlayerModel:showWaterMark()
	ViewMgr.instance:openView(ViewName.WaterMarkView, {
		userId = self._userId
	})
end

function PlayerModel:changeWaterMarkStatus(isShow)
	if not self.waterMarkView then
		self:showWaterMark()
	end

	if isShow then
		self.waterMarkView:showWaterMark()
	else
		self.waterMarkView:hideWaterMark()
	end
end

function PlayerModel:getPreFeedBackTime()
	return self._preCommitFeedBackTime
end

function PlayerModel:setPreFeedBackTime()
	self._preCommitFeedBackTime = Time.time
end

function PlayerModel:setMainThumbnail(value)
	self._mainThumbnail = value
end

function PlayerModel:GMSetMainThumbnail()
	if isDebugBuild then
		local gmOpenMainThumbnail = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewOpenMainThumbnail, 0) == 1

		if gmOpenMainThumbnail then
			self._mainThumbnail = false

			logError("GM设置了登录开启缩略页，请知悉！")
		end
	end
end

function PlayerModel:getMainThumbnail()
	return self._mainThumbnail
end

local fineHours = 18000

function PlayerModel:setCanRename(val)
	self._canRename = val == true

	local dt = os.date("*t", ServerTime.nowInLocal() - fineHours)

	if dt then
		self._canRenameFlagMonth = dt.month
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.RenameFlagUpdate)
end

function PlayerModel:setExtraRename(extraRename)
	self.extraRenameCount = extraRename
end

function PlayerModel:getExtraRename()
	return self.extraRenameCount or 0
end

function PlayerModel:checkCanRenameReset()
	local dt = os.date("*t", ServerTime.nowInLocal() - fineHours)

	if dt and self._canRenameFlagMonth ~= nil and self._canRenameFlagMonth ~= dt.month then
		logNormal("CanRenameFlag Reset")
		self:setCanRename(true)
	end
end

function PlayerModel:getCanRename()
	return self._canRename
end

function PlayerModel:getShowAchievement()
	return self._showAchievement
end

function PlayerModel:getPlayerPrefsKey(key)
	return key .. self._userId
end

function PlayerModel:getPlayerRegisterTime()
	return self._registerTime
end

PlayerModel.instance = PlayerModel.New()

return PlayerModel
