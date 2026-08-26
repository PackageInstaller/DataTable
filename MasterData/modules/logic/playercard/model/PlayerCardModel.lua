-- chunkname: @modules/logic/playercard/model/PlayerCardModel.lua

module("modules.logic.playercard.model.PlayerCardModel", package.seeall)

local PlayerCardModel = class("PlayerCardModel", BaseModel)

function PlayerCardModel:onInit()
	self:reInit()
end

function PlayerCardModel:reInit()
	self.characterSwitchFlag = nil
	self._badgeMoDict = nil
	self._equipType = nil
	self._enterAnimType = nil
end

function PlayerCardModel:updateCardInfo(cardInfo, playerInfo)
	if playerInfo then
		if not playerInfo.userId then
			local userId = PlayerModel.instance:getMyUserId()

			if not userId then
				return
			end

			local mo = self:getById(userId)

			if not mo then
				mo = PlayerCardMO.New()

				mo:init(userId)
				self:addAtLast(mo)
			end

			mo:updateInfo(cardInfo, playerInfo)
			PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, userId)
			self:setShowRed()
		end
	end
end

function PlayerCardModel:setShowRed()
	self._showRed = false

	local list = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.PlayerBg)

	for _, co in ipairs(list) do
		local id = co.id
		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayerCardNewBgSkinRed) .. id
		local value = PlayerPrefsHelper.getNumber(key, 0)

		if value == 1 then
			self._showRed = true

			break
		end
	end
end

function PlayerCardModel:getShowRed()
	return self._showRed
end

function PlayerCardModel:updateSetting(showSettings)
	local mo = self:getCardInfo()

	if mo then
		mo:updateShowSetting(showSettings)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:updateProgressSetting(showSettings)
	local mo = self:getCardInfo()

	if mo then
		mo:updateProgressSetting(showSettings)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:updateBaseInfoSetting(showSettings)
	local mo = self:getCardInfo()

	if mo then
		mo:updateBaseInfoSetting(showSettings)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:updateHeroCover(heroCover)
	local mo = self:getCardInfo()

	if mo then
		mo:updateHeroCover(heroCover)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:updateThemeId(themeId)
	local mo = self:getCardInfo()

	if mo then
		mo:updateThemeId(themeId)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:updateCritter(critterId, skinId)
	local mo = self:getCardInfo()

	if mo then
		mo:updateCritter(critterId, skinId)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:updateAchievement(showAchievement)
	local mo = self:getCardInfo()

	if mo then
		mo:updateAchievement(showAchievement)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:getCardInfo(userId)
	userId = userId or PlayerModel.instance:getMyUserId()

	return self:getById(userId)
end

function PlayerCardModel:getShowAchievement()
	local mo = self:getCardInfo()

	if mo then
		return mo:getShowAchievement()
	end
end

function PlayerCardModel:themeIsUnlock(themeId)
	return true
end

function PlayerCardModel:isCharacterSwitchFlag()
	return self.characterSwitchFlag
end

function PlayerCardModel:setCharacterSwitchFlag(value)
	self.characterSwitchFlag = value
end

function PlayerCardModel:setSelectCritterUid(critterUid)
	local mo = self:getCardInfo()

	if mo then
		return mo:setSelectCritterUid(critterUid)
	end
end

function PlayerCardModel:getSelectCritterUid()
	local mo = self:getCardInfo()

	if mo then
		return mo:getSelectCritterUid()
	end
end

function PlayerCardModel:getPlayerCardSkinId()
	local mo = self:getCardInfo()

	if mo then
		return mo:getThemeId()
	end
end

function PlayerCardModel:isSpecialCardSkin(skinId)
	if not self._speialCardSkins then
		local constCo = lua_playercard_const.configDict[5]

		if constCo and not string.nilorempty(constCo.value2) then
			self._speialCardSkins = string.splitToNumber(constCo.value2, "#")
		end
	end

	return LuaUtil.tableContains(self._speialCardSkins, skinId)
end

function PlayerCardModel:setSelectSkinMO(skinMO)
	self.selectSkinMO = skinMO
end

function PlayerCardModel:getSelectSkinMO()
	return self.selectSkinMO or nil
end

function PlayerCardModel:setIsOpenSkinView(state)
	self.isopenskin = state
end

function PlayerCardModel:getIsOpenSkinView()
	return self.isopenskin
end

function PlayerCardModel:setSelectHero(heroId, skinId)
	self.selectHeroId = heroId
	self.selectSkinId = skinId
end

function PlayerCardModel:getSelectHero()
	return self.selectHeroId, self.selectSkinId
end

function PlayerCardModel:checkHeroDiff()
	local heroId, skinId, _, isL2d = self:getCardInfo():getMainHero()

	if heroId ~= self.selectHeroId or skinId ~= self.selectSkinId then
		return false
	end

	return true
end

function PlayerCardModel:getCritterOpen()
	local isCritterUnlock = CritterModel.instance:isCritterUnlock(false)
	local allCritterList = CritterModel.instance:getAllCritters()

	return isCritterUnlock and #allCritterList > 0
end

function PlayerCardModel:setHideBadgeFromOthers(isHide)
	local mo = self:getCardInfo()

	if mo then
		local settings = mo:setShowSetting(PlayerCardEnum.ShowSettingsType.HideBadgeFormOther, isHide and "1" or "0")

		PlayerCardRpc.instance:sendSetPlayerCardShowSettingRequest(settings)
	end
end

function PlayerCardModel:_initBadgeMos()
	self._badgeMoDict = {}

	for _, co in ipairs(lua_playercard_badge.configList) do
		local mo = PlayerCardBadgeMO.New()

		mo:initMO(co)

		self._badgeMoDict[co.id] = mo
	end
end

function PlayerCardModel:getBadgeMos()
	if not self._badgeMoDict then
		self:_initBadgeMos()
	end

	return self._badgeMoDict
end

function PlayerCardModel:getBadgeMoById(id)
	if not self._badgeMoDict then
		self:_initBadgeMos()
	end

	return self._badgeMoDict[id]
end

function PlayerCardModel:isShowBadgeGetView()
	local key = PlayerModel.instance:getPlayerPrefsKey("ShowBadgeGetViewToday")
	local today = ServerTime.getServerTimeToday(true)
	local saveToday = PlayerPrefsHelper.getNumber(key, 0)

	return today ~= saveToday
end

function PlayerCardModel:setShowBadgeGetView(isShow)
	local key = PlayerModel.instance:getPlayerPrefsKey("ShowBadgeGetViewToday")
	local today = ServerTime.getServerTimeToday(true)

	PlayerPrefsHelper.setNumber(key, isShow and 0 or today)
end

function PlayerCardModel:isShowEnterAnimSettingNewReddot(skinId)
	skinId = skinId or self:getPlayerCardSkinId()

	local themeInfo = PlayerCardEnum.Theme[skinId]

	if not themeInfo or not themeInfo.EnterAnim then
		return false
	end

	local key = "NewPlayerCardContentView_EnterAnimSettingNewReddot_" .. skinId

	return GameUtil.playerPrefsGetNumberByUserId(key, 0) == 0
end

function PlayerCardModel:cancelShowEnterAnimSettingNewReddot(skinId)
	skinId = skinId or self:getPlayerCardSkinId()

	local key = "NewPlayerCardContentView_EnterAnimSettingNewReddot_" .. skinId

	GameUtil.playerPrefsSetNumberByUserId(key, 1)
end

PlayerCardModel.instance = PlayerCardModel.New()

return PlayerCardModel
