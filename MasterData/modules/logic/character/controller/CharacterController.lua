-- chunkname: @modules/logic/character/controller/CharacterController.lua

module("modules.logic.character.controller.CharacterController", package.seeall)

local CharacterController = class("CharacterController", BaseController)

function CharacterController:onInit()
	self._statTalentInfo = nil
end

function CharacterController:reInit()
	self._statTalentInfo = nil
end

function CharacterController:onInitFinish()
	return
end

function CharacterController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self.registerCallback(self, CharacterEvent.characterFirstToShow, self._onCharacterFirstToShow, self)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
end

function CharacterController:_onCharacterFirstToShow(id)
	CharacterBackpackCardListModel.instance:setFirstShowCharacter(tonumber(id))
end

function CharacterController:openCharacterView(param, heroMOList, param2)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Role) then
		CharacterBackpackCardListModel.instance:setCharacterViewDragMOList(heroMOList)

		CharacterView._externalParam = param2

		ViewMgr.instance:openView(ViewName.CharacterView, param)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Role))
	end
end

function CharacterController:openCharacterTalentView(param)
	ViewMgr.instance:openView(ViewName.CharacterTalentView, param)
end

function CharacterController:openCharacterTalentChessView(param)
	ViewMgr.instance:openView(ViewName.CharacterTalentChessView, param)
end

function CharacterController:openCharacterTalentLevelUpView(param)
	ViewMgr.instance:openView(ViewName.CharacterTalentLevelUpView, param)
end

function CharacterController:openCharacterTalentLevelUpResultView(param)
	ViewMgr.instance:openView(ViewName.CharacterTalentLevelUpResultView, param)
end

function CharacterController:openCharacterTalentTipView(param)
	ViewMgr.instance:openView(ViewName.CharacterTalentTipView, param)
end

function CharacterController:openCharacterTipView(param)
	ViewMgr.instance:openView(ViewName.CharacterTipView, param)
end

function CharacterController:openCharacterSkinView(heroMo)
	ViewMgr.instance:openView(ViewName.CharacterSkinView, heroMo)
end

function CharacterController:openCharacterSkinTipView(skinIdOrViewParam)
	ViewMgr.instance:openView(ViewName.CharacterSkinTipView, skinIdOrViewParam)
end

function CharacterController:openCharacterSkinGainView(param)
	ViewMgr.instance:openView(ViewName.CharacterSkinGainView, param)
end

function CharacterController:openCharacterLevelUpView(heroMO, enterViewName)
	local viewSetting = ViewMgr.instance:getSetting(ViewName.CharacterLevelUpView)

	viewSetting.anim = enterViewName == ViewName.HeroGroupEditView and ViewAnim.CharacterLevelUpView2 or ViewAnim.CharacterLevelUpView

	ViewMgr.instance:openView(ViewName.CharacterLevelUpView, {
		heroMO = heroMO,
		enterViewName = enterViewName
	})
end

function CharacterController:openCharacterRankUpView(param)
	local heroId = param and param.heroId

	if heroId and HeroModel.instance:getByHeroId(heroId) then
		ViewMgr.instance:openView(ViewName.CharacterRankUpView, param)
	else
		GameFacade.showToast(ToastEnum.DontHaveCharacter)
	end
end

function CharacterController:openCharacterRankUpResultView(heroId)
	ViewMgr.instance:openView(ViewName.CharacterRankUpResultView, heroId)
end

function CharacterController:openCharacterSkinFullScreenView(skinCo, isImmediate, showEnum)
	ViewMgr.instance:openView(ViewName.CharacterSkinFullScreenView, {
		skinCo = skinCo,
		showEnum = showEnum or CharacterEnum.ShowSkinEnum.Static
	}, isImmediate)
end

function CharacterController:openCharacterDataView(param)
	ViewMgr.instance:openView(ViewName.CharacterDataView, param)
end

function CharacterController:openCharacterExSkillView(param)
	ViewMgr.instance:openView(ViewName.CharacterExSkillView, param)
end

function CharacterController:openCharacterGetView(param)
	ViewMgr.instance:openView(ViewName.CharacterGetView, param)
end

function CharacterController:openCharacterSkinGetDetailView(param)
	ViewMgr.instance:openView(ViewName.CharacterSkinGetDetailView, param)
end

function CharacterController:openCharacterTalentStyleView(param)
	ViewMgr.instance:openView(ViewName.CharacterTalentStyleView, param)
end

function CharacterController:openCharacterTalentStatView(param)
	ViewMgr.instance:openView(ViewName.CharacterTalentStatView, param)
end

function CharacterController:openCharacterSkillTalentView(param)
	if param.trialCo then
		OdysseyTalentModel.instance:setTrialCassandraTreeInfo()
		ViewMgr.instance:openView(ViewName.OdysseyTrialCharacterTalentView, param)
	else
		ViewMgr.instance:openView(ViewName.CharacterSkillTalentView, param)
	end
end

function CharacterController:openCharacterWeaponView(param)
	ViewMgr.instance:openView(ViewName.CharacterWeaponView, param)
end

function CharacterController:openCharacterWeaponEffectView(param)
	ViewMgr.instance:openView(ViewName.CharacterWeaponEffectView, param)
end

function CharacterController:enterCharacterBackpack(jumpTab)
	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 1.533)

	local param = {}

	param.jumpTab = jumpTab

	ViewMgr.instance:openView(ViewName.CharacterBackpackView, param)
end

function CharacterController:openCharacterSwitchView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CharacterSwitchView, param, isImmediate)
end

function CharacterController:openCharacterFilterView(param)
	ViewMgr.instance:openView(ViewName.CharacterBackpackSearchFilterView, param)
end

function CharacterController:closeCharacterFilterView()
	if ViewMgr.instance:isOpen(ViewName.CharacterBackpackSearchFilterView) then
		ViewMgr.instance:closeView(ViewName.CharacterBackpackSearchFilterView)
	end
end

function CharacterController:playRoleVoice(heroId)
	local voices = HeroModel.instance:getVoiceConfig(heroId, CharacterEnum.VoiceType.MainViewNoInteraction)

	if voices and #voices > 0 then
		local voiceCo = voices[1]
		local audio = voiceCo.audio

		AudioMgr.instance:trigger(audio)
	end
end

function CharacterController:SetAttriIcon(simage, id, color)
	UISpriteSetMgr.instance:setCommonSprite(simage, "icon_att_" .. tostring(id))

	local image = gohelper.onceAddComponent(simage.gameObject, typeof(UnityEngine.UI.Image))

	image.color = color or CharacterEnum.AttrLightColor
end

function CharacterController:dailyRefresh()
	HeroRpc.instance:sendHeroInfoListRequest()
end

function CharacterController:statCharacterData(eventName, heroId, dataId, viewTime, isHandbook)
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)

	if not heroConfig then
		return
	end

	local heroMO = HeroModel.instance:getByHeroId(heroId)

	if heroMO then
		if not heroMO.faith then
			local faith = 0
			local faithInfo = HeroConfig.instance:getFaithPercent(faith)

			if faithInfo then
				if not (faithInfo[1] * 100) then
					local faithLevel = 0
					local properties = {}

					properties[StatEnum.EventProperties.HeroId] = tonumber(heroId)
					properties[StatEnum.EventProperties.HeroName] = heroConfig.name
					properties[StatEnum.EventProperties.Faith] = faithLevel
					properties[StatEnum.EventProperties.Entrance] = isHandbook and luaLang("datatrack_entrance_handbook") or luaLang("datatrack_entrance_normal")

					if eventName == StatEnum.EventName.PlayerVoice then
						local langId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)
						local globalVoiceLang = GameConfig:GetCurVoiceShortcut()

						properties[StatEnum.EventProperties.VoiceId] = tostring(dataId or "")
						properties[StatEnum.EventProperties.CharVoiceLang] = usingDefaultLang and globalVoiceLang or langStr
						properties[StatEnum.EventProperties.GlobalVoiceLang] = globalVoiceLang
					elseif eventName == StatEnum.EventName.ReadHeroItem then
						-- block empty
					elseif eventName == StatEnum.EventName.ReadHeroCulture then
						properties[StatEnum.EventProperties.CultureId] = tostring(dataId or "")
					end

					if viewTime then
						properties[StatEnum.EventProperties.Time] = viewTime
					end

					StatController.instance:track(eventName, properties)
				end
			end
		end
	end
end

function CharacterController:statCharacterSkinVideoData(heroId, heroName, skinId, skinName)
	local eventName = StatEnum.EventName.ClickSkinVideoInlet
	local properties = {
		[StatEnum.EventProperties.HeroId] = heroId,
		[StatEnum.EventProperties.HeroName] = heroName,
		[StatEnum.EventProperties.skinId] = skinId,
		[StatEnum.EventProperties.skinName] = skinName
	}

	StatController.instance:track(eventName, properties)
end

function CharacterController:showCharacterGetToast(heroId, duplicateCount)
	local config = HeroConfig.instance:getHeroCO(heroId)
	local rewards = {}
	local reward

	if duplicateCount <= 0 then
		reward = config.firstItem
	else
		local constVal = CommonConfig.instance:getConstNum(ConstEnum.HeroDuplicateGetCount)

		reward = duplicateCount >= constVal - 1 and config.duplicateItem2 or config.duplicateItem .. "|" .. config.duplicateItemSpecial
	end

	if not string.nilorempty(reward) then
		local items = string.split(reward, "|")

		for i, item in ipairs(items) do
			local itemParams = string.splitToNumber(item, "#")
			local itemType = itemParams[1]
			local itemId = itemParams[2]
			local itemQuantity = itemParams[3]
			local mo = {}

			mo.config, mo.icon = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)
			mo.quantity = itemQuantity
			mo.desc = duplicateCount <= 0 and luaLang("character_first_tips") or luaLang("character_duplicate_tips")

			table.insert(rewards, mo)
		end
	end

	for i, mo in ipairs(rewards) do
		local toast = string.format("%s%s\n%s%s%s", mo.desc, config.name, mo.config.name, luaLang("multiple"), mo.quantity)

		GameFacade.showToastWithIcon(ToastEnum.IconId, mo.icon, toast)
	end
end

function CharacterController:showCharacterGetTicket(heroId, ticketId)
	if not ticketId then
		return
	end

	local cfg, icon = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, ticketId)
	local heroCo = HeroConfig.instance:getHeroCO(heroId)

	GameFacade.showToastWithIcon(ToastEnum.IconId, icon, string.format(luaLang("summon_limit_ticket_gain"), cfg.name))
end

function CharacterController:showCharacterGetItemToast(items, heroId, duplicateCount)
	if duplicateCount > 0 then
		local desc = luaLang("character_duplicate_tips")
		local heroCo = HeroConfig.instance:getHeroCO(heroId)

		for _, item in ipairs(items) do
			local config, icon = ItemModel.instance:getItemConfigAndIcon(item.materilType, item.materilId)
			local toast = string.format("%s%s\n%s%s%s", desc, heroCo.name, config.name, luaLang("multiple"), item.quantity)

			GameFacade.showToastWithIcon(ToastEnum.IconId, icon, toast)
		end
	end
end

function CharacterController:setTalentHeroId(id)
	self._talentHeroId = id
end

function CharacterController:getTalentHeroId()
	return self._talentHeroId
end

function CharacterController:statTalentStart(heroId)
	self._statTalentInfo = self:getStatTalentInfo(heroId)
end

function CharacterController:getStatTalentInfo(heroId)
	local statTalentInfo = {}
	local heroMO = HeroModel.instance:getByHeroId(heroId)
	local talentCubeInfos = heroMO and heroMO.talentCubeInfos

	if not talentCubeInfos then
		return nil
	end

	statTalentInfo.heroId = heroId
	statTalentInfo.talent = heroMO.talent
	statTalentInfo.dataDict = {}

	for i, data in ipairs(talentCubeInfos.data_list) do
		local _cubeId = data.cubeId

		if _cubeId == talentCubeInfos.own_main_cube_id then
			_cubeId = heroMO:getHeroUseStyleCubeId()
		end

		statTalentInfo.dataDict[string.format("%d_%d_%d_%d", _cubeId, data.direction, data.posX, data.posY)] = true
	end

	return statTalentInfo
end

function CharacterController:hasStatTalentInfoChanged(statTalentInfoStart, statTalentInfoEnd)
	if statTalentInfoStart.talent ~= statTalentInfoEnd.talent then
		return true
	end

	for key, _ in pairs(statTalentInfoStart.dataDict) do
		if not statTalentInfoEnd.dataDict[key] then
			return true
		end
	end

	for key, _ in pairs(statTalentInfoEnd.dataDict) do
		if not statTalentInfoStart.dataDict[key] then
			return true
		end
	end

	return false
end

function CharacterController:statTalentEnd(heroId)
	local statTalentInfoStart = self._statTalentInfo

	self._statTalentInfo = nil

	if not statTalentInfoStart or statTalentInfoStart.heroId ~= heroId then
		return
	end

	local statTalentInfoEnd = self:getStatTalentInfo(heroId)

	if not statTalentInfoEnd then
		return
	end

	local hasChanged = self:hasStatTalentInfoChanged(statTalentInfoStart, statTalentInfoEnd)

	if not hasChanged then
		return
	end

	self:stateTalent(heroId)
end

function CharacterController:stateTalent(heroId)
	local heroMO = HeroModel.instance:getByHeroId(heroId)

	if not heroMO then
		return
	end

	local talentCubeInfos = heroMO.talentCubeInfos
	local ruensStateArray = {}

	for id, ownData in pairs(talentCubeInfos.own_cube_dic) do
		local _cubeId = ownData.id

		if _cubeId == talentCubeInfos.own_main_cube_id then
			_cubeId = heroMO:getHeroUseStyleCubeId()
		end

		table.insert(ruensStateArray, {
			ruens_id = _cubeId,
			ruens_num = ownData.use,
			ruens_hold_num = ownData.own + ownData.use
		})
	end

	local ruensStateGroup = {}

	for i, data in ipairs(talentCubeInfos.data_list) do
		local _cubeId = data.cubeId

		if _cubeId == talentCubeInfos.own_main_cube_id then
			_cubeId = heroMO:getHeroUseStyleCubeId()
		end

		table.insert(ruensStateGroup, _cubeId)
	end

	StatController.instance:track(StatEnum.EventName.TalentRuensPreserve, {
		[StatEnum.EventProperties.HeroName] = heroMO.config.name,
		[StatEnum.EventProperties.TalentLevel] = heroMO.talent,
		[StatEnum.EventProperties.RuensStateArray] = ruensStateArray,
		[StatEnum.EventProperties.RuensStateGroup] = ruensStateGroup
	})
end

function CharacterController:tryStatAllTalent()
	local heroMOList = HeroModel.instance:getList()

	for i, heroMO in ipairs(heroMOList) do
		if heroMO.rank >= CharacterEnum.TalentRank then
			self:stateTalent(heroMO.heroId)
		end
	end
end

function CharacterController:trackInteractiveSkinDetails(heroId, skinId, clickType)
	local heroCfg = HeroConfig.instance:getHeroCO(heroId)

	if not heroCfg then
		return
	end

	local skinCo = SkinConfig.instance:getSkinCo(skinId)

	if not skinCo then
		return
	end

	local properties = {}

	properties[StatEnum.EventProperties.HeroId] = tonumber(heroId)
	properties[StatEnum.EventProperties.HeroName] = heroCfg.name
	properties[StatEnum.EventProperties.skinId] = skinId
	properties[StatEnum.EventProperties.skinName] = skinCo.characterSkin
	properties[StatEnum.EventProperties.clickType] = clickType

	StatController.instance:track(StatEnum.EventName.InteractiveSkinDetails, properties)
end

function CharacterController:useSkinGiftItem(itemId)
	local itemCount = ItemModel.instance:getItemCount(itemId)

	if not itemCount or itemCount <= 0 then
		return
	end

	local config = ItemConfig.instance:getItemCo(itemId)

	if config then
		if not config.effect then
			local effect = ""
			local param = GameUtil.splitString2(effect, true)

			if not param then
				return
			end

			local skinList = param[1]

			if not skinList or next(skinList) == nil then
				return
			end

			if self:checkHaveCompensate(skinList) and config.clientDisplayType ~= ItemEnum.clientDisplayType.SkinGift then
				self:handleSkinGiftHasCompensate(itemId)
			else
				self:handleSkinGiftNoCompensate(itemId)
			end
		end
	end
end

function CharacterController:checkHaveCompensate(skinList)
	for i, v in ipairs(skinList) do
		local skinConfig = SkinConfig.instance:getSkinCo(v)

		if not skinConfig then
			logError("皮肤折扣,不存在的皮肤id: " .. tostring(v))
		elseif not string.nilorempty(skinConfig.compensate) then
			return true
		end
	end

	return false
end

function CharacterController:handleSkinGiftNoCompensate(itemId)
	local param = {}

	param.type = SkinDiscountCompensateEnum.SelectDisplayType.Select
	param.itemId = itemId

	ViewMgr.instance:openView(ViewName.SkinSelfSelectView, param)
end

function CharacterController:handleSkinGiftHasCompensate(itemId)
	local param = {}

	param.type = SkinDiscountCompensateEnum.SelectDisplayType.Select
	param.itemId = itemId

	ViewMgr.instance:openView(ViewName.SkinDiscountCompensateSelectView, param)
end

function CharacterController:_onUseSkinGiftItemCallback(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.SkinGiftExChangeTips)
end

function CharacterController:_onGetInfoFinish()
	local value = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.HeroSearchFilterTags)

	CharacterSearchFilterModel.instance:refreshEditorLowTags(value)
end

CharacterController.instance = CharacterController.New()

return CharacterController
