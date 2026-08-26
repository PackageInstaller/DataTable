-- chunkname: @modules/logic/playercard/controller/PlayerCardController.lua

module("modules.logic.playercard.controller.PlayerCardController", package.seeall)

local PlayerCardController = class("PlayerCardController", BaseController)

function PlayerCardController:reInit()
	self.viewParam = nil
	self._curPlayBgmId = nil
	self._playingBgmAudioId = nil
end

function PlayerCardController:openPlayerCardView(param)
	self.viewParam = param or {}

	if param then
		if not param.userId then
			local userId = PlayerModel.instance:getMyUserId()
			local isSelf = PlayerModel.instance:isPlayerSelf(userId)

			self.viewParam.userId = userId

			if isSelf then
				PlayerCardRpc.instance:sendGetPlayerCardInfoRequest(self._openPlayerCardView, self)
			else
				PlayerCardRpc.instance:sendGetOtherPlayerCardInfoRequest(userId, self._openPlayerCardView, self)
			end
		end
	end
end

function PlayerCardController:_openPlayerCardView(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.NewPlayerCardContentView, self.viewParam)
end

function PlayerCardController:playChangeEffectAudio()
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_seal_cutting_eft)
end

function PlayerCardController:saveAchievement()
	local taskIdList, groupId = PlayerCardAchievementSelectListModel.instance:getSaveRequestParam()

	PlayerCardRpc.instance:sendSetPlayerCardShowAchievementRequest(taskIdList, groupId)
end

function PlayerCardController:statStart()
	local cardinfo = PlayerCardModel.instance:getCardInfo()

	if not cardinfo:isSelf() then
		return
	end

	self.startTime = ServerTime.now()
end

function PlayerCardController:statEnd()
	local cardinfo = PlayerCardModel.instance:getCardInfo()

	if not cardinfo:isSelf() then
		return
	end

	local heroCover = cardinfo.heroCover
	local heroId, skinId, heroName, skinName = self:getStatHeroCover(heroCover)
	local achievementNameList, groupNameList, achievementCount = self:getStatAchievement()
	local progresslist = self:getStatProgress()
	local baseinfolist = self:getStatBaseInfo()
	local critterid, crittername = self:getStatCritter()
	local skinname = self:getSkinName()
	local headname = self:getHeadName()

	StatController.instance:track(StatEnum.EventName.ExitPlayerCard, {
		[StatEnum.EventProperties.Time] = self:getUseTime(),
		[StatEnum.EventProperties.HeroId] = heroId,
		[StatEnum.EventProperties.skinId] = skinId,
		[StatEnum.EventProperties.HeroName] = heroName,
		[StatEnum.EventProperties.skinName] = skinName,
		[StatEnum.EventProperties.DisplaySingleAchievementName] = achievementNameList,
		[StatEnum.EventProperties.DisplayGroupAchievementName] = groupNameList,
		[StatEnum.EventProperties.MedalNum] = achievementCount,
		[StatEnum.EventProperties.GameProgress] = progresslist,
		[StatEnum.EventProperties.BaseInfomation] = baseinfolist,
		[StatEnum.EventProperties.CritterId] = critterid,
		[StatEnum.EventProperties.CritterName] = crittername,
		[StatEnum.EventProperties.PlayerCardSkinName] = skinname,
		[StatEnum.EventProperties.HeadName] = headname
	})
end

function PlayerCardController:statSetHeroCover(heroParam)
	local heroId, skinId, heroName, skinName = self:getStatHeroCover(heroParam)

	StatController.instance:track(StatEnum.EventName.PlaycardSetHeroCover, {
		[StatEnum.EventProperties.HeroId] = heroId,
		[StatEnum.EventProperties.skinId] = skinId,
		[StatEnum.EventProperties.HeroName] = heroName,
		[StatEnum.EventProperties.skinName] = skinName
	})
end

function PlayerCardController:getStatHeroCover(heroParam)
	local param = string.splitToNumber(heroParam, "#")
	local heroId = param[1]
	local skinId = param[2]
	local heroName = ""

	if not string.nilorempty(heroId) then
		heroName = HeroConfig.instance:getHeroCO(heroId).name
	end

	return heroId, skinId, heroName, (not string.nilorempty(skinId) or nil) and SkinConfig.instance:getSkinCo(skinId).name
end

function PlayerCardController:statSetAchievement()
	local achievementNameList, groupNameList, num = self:getStatAchievement()

	StatController.instance:track(StatEnum.EventName.PlaycardDisplayMedal, {
		[StatEnum.EventProperties.DisplaySingleAchievementName] = achievementNameList,
		[StatEnum.EventProperties.DisplayGroupAchievementName] = groupNameList,
		[StatEnum.EventProperties.MedalNum] = num
	})
end

function PlayerCardController:getStatAchievement()
	local showStr = PlayerCardModel.instance:getShowAchievement()

	if not showStr or string.nilorempty(showStr) then
		return nil, nil, nil
	end

	local singeTaskSet, groupTaskSet = AchievementUtils.decodeShowStr(showStr)
	local achievementNameList = self:getAchievementNameListByTaskId(singeTaskSet)
	local groupNameList = self:getGroupNameListByTaskId(groupTaskSet)
	local cardinfo = PlayerCardModel.instance:getCardInfo()
	local num = cardinfo.achievementCount

	return achievementNameList, groupNameList, num
end

function PlayerCardController:statSetProgress()
	local list = self:getStatProgress()

	StatController.instance:track(StatEnum.EventName.PlaycardSetGameProgress, {
		[StatEnum.EventProperties.GameProgress] = list
	})
end

function PlayerCardController:getStatProgress()
	local list = {}
	local cardinfo = PlayerCardModel.instance:getCardInfo()
	local dict = cardinfo:getProgressSetting()

	if dict and #dict > 0 then
		for _, selectmo in ipairs(dict) do
			local type = selectmo[2]
			local co = PlayerCardConfig.instance:getCardProgressById(type)
			local name = co.name
			local value = cardinfo:getProgressByIndex(type)

			table.insert(list, name)
			table.insert(list, value)
		end
	end

	return list
end

function PlayerCardController:getStatBaseInfo()
	local list = {}
	local cardinfo = PlayerCardModel.instance:getCardInfo()
	local co = PlayerCardConfig.instance:getCardBaseInfoById(1)
	local name = co.name
	local value = cardinfo:getBaseInfoByIndex(1)

	table.insert(list, name)
	table.insert(list, value)

	local dict = cardinfo:getBaseInfoSetting()

	if dict and #dict > 0 then
		for _, selectmo in ipairs(dict) do
			local type = selectmo[2]
			local co = PlayerCardConfig.instance:getCardBaseInfoById(type)
			local name = co.name
			local value = cardinfo:getBaseInfoByIndex(type)

			table.insert(list, name)
			table.insert(list, value)
		end
	end

	return list
end

function PlayerCardController:statSetBaseInfo()
	local list = self:getStatBaseInfo()

	StatController.instance:track(StatEnum.EventName.PlaycardSetBasicInfomation, {
		[StatEnum.EventProperties.BaseInfomation] = list
	})
end

function PlayerCardController:statSetCritter()
	local critterid, crittername = self:getStatCritter()

	StatController.instance:track(StatEnum.EventName.PlaycardSetCritter, {
		[StatEnum.EventProperties.CritterId] = critterid,
		[StatEnum.EventProperties.CritterName] = crittername
	})
end

function PlayerCardController:getStatCritter()
	local isCritterOpen = PlayerCardModel.instance:getCritterOpen()
	local critterid, crittername = ""

	if isCritterOpen then
		local cardinfo = PlayerCardModel.instance:getCardInfo()
		local critterid, isMute = cardinfo:getCritter()

		if not string.nilorempty(critterid) then
			crittername = CritterConfig.instance:getCritterName(critterid)
		end
	end

	return critterid, crittername
end

function PlayerCardController:getAchievementNameListByTaskId(taskSet)
	local achievementNameList = {}
	local achievementIdDict = {}

	if taskSet and #taskSet > 0 then
		for _, taskId in ipairs(taskSet) do
			local taskCO = AchievementConfig.instance:getTask(taskId)

			if taskCO and not achievementIdDict[taskCO.achievementId] then
				local achievementCfg = AchievementConfig.instance:getAchievement(taskCO.achievementId)

				if achievementCfg then
					if not achievementCfg.name then
						local achievementName = ""

						table.insert(achievementNameList, achievementName)

						achievementIdDict[taskCO.achievementId] = true
					end
				end
			end
		end
	end

	return achievementNameList
end

function PlayerCardController:getUseTime()
	return (self.startTime or nil) and ServerTime.now() - self.startTime
end

function PlayerCardController:getGroupNameListByTaskId(taskSet)
	local groupNameList = {}
	local groupIdDict = {}

	if taskSet and #taskSet > 0 then
		for _, taskId in ipairs(taskSet) do
			local taskCO = AchievementConfig.instance:getTask(taskId)

			if taskCO then
				local achievementCfg = AchievementConfig.instance:getAchievement(taskCO.achievementId)
				local groupId = achievementCfg and achievementCfg.groupId
				local groupCfg = AchievementConfig.instance:getGroup(groupId)

				if groupCfg and not groupIdDict[groupId] then
					if groupCfg then
						if not groupCfg.name then
							local groupName = ""

							table.insert(groupNameList, groupName)

							groupIdDict[groupId] = true
						end
					end
				end
			end
		end
	end

	return groupNameList
end

function PlayerCardController:getSkinName()
	local cardinfo = PlayerCardModel.instance:getCardInfo()
	local themeId = cardinfo:getThemeId()

	if themeId ~= 0 then
		local config = ItemConfig.instance:getItemCo(themeId)

		return config.name
	end

	return "默认"
end

function PlayerCardController:getHeadName()
	local playerinfo = PlayerModel.instance:getPlayinfo()
	local usedIcon = playerinfo.portrait
	local config = lua_item.configDict[usedIcon]

	return config.name
end

function PlayerCardController:ShowChangeBgSkin(id, materialDataMOList, isHideEquipBtn)
	ViewMgr.instance:openView(ViewName.PlayerCardGetView, {
		id = id,
		isHideEquipBtn = isHideEquipBtn
	})

	self._cacheMaterialDataMOList = materialDataMOList

	self:setBgSkinRed(id, true)
	PlayerCardModel.instance:setShowRed()
end

function PlayerCardController:showPropChangeBgSkin(id, isHideEquipBtn)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.PlayerCardGetView, {
		id = id,
		isHideEquipBtn = isHideEquipBtn
	})
	self:setBgSkinRed(id, true)
	PlayerCardModel.instance:setShowRed()
end

function PlayerCardController:openSimpleShowView()
	if not self._cacheMaterialDataMOList or #self._cacheMaterialDataMOList < 1 then
		return
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, self._cacheMaterialDataMOList)

	self._cacheMaterialDataMOList = nil
end

function PlayerCardController:setPlayerCardSkin(id)
	PlayerCardRpc.instance:sendSetPlayerCardThemeRequest(id)

	local themeInfo = PlayerCardEnum.Theme[id]

	if themeInfo and themeInfo.isJustEquipedShow then
		SocialModel.instance:setSelectSocialBg(true)
	end
end

function PlayerCardController:getBgSkinRed(id)
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayerCardNewBgSkinRed) .. id

	return PlayerPrefsHelper.getNumber(key, 0)
end

function PlayerCardController:setBgSkinRed(id, needShowReddot)
	local value = needShowReddot and 1 or 0
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayerCardNewBgSkinRed) .. id

	PlayerPrefsHelper.setNumber(key, value)
end

function PlayerCardController:getCurViewParam()
	return self.viewParam
end

function PlayerCardController:openBadgeGetView(id, getApproach, materials)
	ViewMgr.instance:openView(ViewName.PlayerCardBadgeGetView, {
		id = id,
		getApproach = getApproach,
		materials = materials
	})
end

function PlayerCardController:checkPlayCardSpecialBgm(skinId)
	local themeInfo = PlayerCardEnum.Theme[skinId]

	if themeInfo and themeInfo.BgmId then
		if self._curPlayBgmId == themeInfo.BgmId then
			return
		end

		self._curPlayBgmId = themeInfo.BgmId

		AudioMgr.instance:trigger(AudioEnum.UI.Pause_MainMusic)

		self._playingBgmAudioId = AudioMgr.instance:trigger(themeInfo.BgmId)

		return
	end

	if self._curPlayBgmId then
		self:stopCardSpecialBgm()
	end
end

function PlayerCardController:stopCardSpecialBgm()
	local socialViewContainer = ViewMgr.instance:getContainer(ViewName.SocialView)
	local skinId

	if socialViewContainer and socialViewContainer:isOpen() then
		skinId = socialViewContainer.viewParam and socialViewContainer.viewParam.skinId

		if not skinId then
			local selfBg = SocialModel.instance:isSelectSocialBg()

			if selfBg then
				skinId = PlayerCardModel.instance:getPlayerCardSkinId()
			else
				local selectFriend = SocialModel.instance:getSelectFriend()

				if selectFriend then
					local playerMO = SocialModel.instance:getPlayerMO(selectFriend)

					skinId = playerMO.bg
				end
			end
		end
	end

	local playerCardView = ViewMgr.instance:getContainer(ViewName.NewPlayerCardContentView)

	if playerCardView and playerCardView:isOpen() then
		skinId = playerCardView:getShowSkinId()
	end

	if skinId then
		local themeInfo = PlayerCardEnum.Theme[skinId]

		if themeInfo and themeInfo.BgmId then
			if self._curPlayBgmId == themeInfo.BgmId then
				return
			end

			self._curPlayBgmId = themeInfo.BgmId

			if self._playingBgmAudioId then
				AudioMgr.instance:stopPlayingID(self._playingBgmAudioId)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Pause_MainMusic)

			self._playingBgmAudioId = AudioMgr.instance:trigger(themeInfo.BgmId)

			return
		end
	end

	self._curPlayBgmId = nil

	if self._playingBgmAudioId then
		AudioMgr.instance:stopPlayingID(self._playingBgmAudioId)

		self._playingBgmAudioId = nil
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Resume_MainMusic)
end

PlayerCardController.instance = PlayerCardController.New()

return PlayerCardController
