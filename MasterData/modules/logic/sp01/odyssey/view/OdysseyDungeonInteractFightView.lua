-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonInteractFightView.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonInteractFightView", package.seeall)

local OdysseyDungeonInteractFightView = class("OdysseyDungeonInteractFightView", BaseView)

function OdysseyDungeonInteractFightView:onInitView()
	self._gofightPanel = gohelper.findChild(self.viewGO, "#go_fightPanel")
	self._imagelevelIcon = gohelper.findChildImage(self.viewGO, "#go_fightPanel/panel/common/level/#image_levelIcon")
	self._txtenemyLevel = gohelper.findChildText(self.viewGO, "#go_fightPanel/panel/common/level/#image_levelIcon/#txt_enemyLevel")
	self._btnenemyLevel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fightPanel/panel/common/level/#image_levelIcon/#btn_enemyLevel")
	self._txtfightName = gohelper.findChildText(self.viewGO, "#go_fightPanel/panel/common/level/#txt_fightName")
	self._btnenemyInfo = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fightPanel/panel/common/level/#txt_fightName/#btn_enemyInfo")
	self._golevelTip = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/common/level/#go_levelTip")
	self._btnlevelCloseTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fightPanel/panel/#btn_levelCloseTip")
	self._txtlevelTip = gohelper.findChildText(self.viewGO, "#go_fightPanel/panel/common/level/#go_levelTip/bg/#txt_levelTip")
	self._imagetagLarge = gohelper.findChildImage(self.viewGO, "#go_fightPanel/panel/common/enemyTag/#image_tagLarge")
	self._goenemyTagItem = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/common/enemyTag/#go_enemyTagItem")
	self._txtrecommend = gohelper.findChildText(self.viewGO, "#go_fightPanel/panel/common/recommendLevel/#txt_recommend")
	self._txtfightDesc = gohelper.findChildText(self.viewGO, "#go_fightPanel/panel/common/scroll_fightDesc/Viewport/Content/#txt_fightDesc")
	self._goreward = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/common/#go_reward")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/common/#go_reward/scroll_reward/Viewport/#go_rewardContent")
	self._gorewardItem = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/common/#go_reward/scroll_reward/Viewport/#go_rewardContent/#go_rewardItem")
	self._btnfight = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fightPanel/panel/common/#btn_fight")
	self._txtfight = gohelper.findChildText(self.viewGO, "#go_fightPanel/panel/common/#btn_fight/#txt_fight")
	self._goequipReward = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_equipReward")
	self._goequipSuit = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_equipSuit")
	self._txtequipSuit = gohelper.findChildText(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_equipSuit/#txt_equipSuit")
	self._imageequipSuit = gohelper.findChildImage(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_equipSuit/#image_icon")
	self._btnchangeSuit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_equipSuit/#btn_changeSuit")
	self._goequipContent = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_equipReward/reward/scroll_equip/Viewport/#go_equipContent")
	self._goequipItem = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_equipReward/reward/scroll_equip/Viewport/#go_equipContent/#go_equipItem")
	self._gosuitSelectTip = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitSelectTip")
	self._btnsuitCloseTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitSelectTip/#btn_suitCloseTip")
	self._gosuitSelectContent = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitSelectTip/#go_suitSelectContent")
	self._gosuitSelectItem = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitSelectTip/#go_suitSelectContent/#go_suitSelectItem")
	self._gosuitInfoTip = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitInfoTip")
	self._imagesuitIcon = gohelper.findChildImage(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitInfoTip/suit/suitName/#image_icon")
	self._txtsuitName = gohelper.findChildText(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitInfoTip/suit/suitName/#txt_suitName")
	self._gosuitInfoContent = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitInfoTip/suit/#go_suitInfoContent")
	self._gosuitInfoItem = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitInfoTip/suit/#go_suitInfoContent/#go_suitInfoItem")
	self._goconquerReward = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_conquerReward")
	self._goconquerHasget = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_conquerReward/conquerReward/icon/#go_conquerHasget")
	self._imageconquerBar = gohelper.findChildImage(self.viewGO, "#go_fightPanel/panel/#go_conquerReward/conquerReward/conquerBar/#image_conquerBar")
	self._txtconquerTimes = gohelper.findChildText(self.viewGO, "#go_fightPanel/panel/#go_conquerReward/conquerReward/#txt_conquerTimes")
	self._txtconquerTotalTimes = gohelper.findChildText(self.viewGO, "#go_fightPanel/panel/#go_conquerReward/conquerReward/#txt_conquerTimes/#txt_conquerTotalTimes")
	self._btnconquer = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fightPanel/panel/#go_conquerReward/conquerReward/#btn_conquer")
	self._goconquerTip = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_conquerReward/#go_conquerTip")
	self._btnconquerCloseTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fightPanel/panel/#go_conquerReward/#go_conquerTip/#btn_conquerCloseTip")
	self._scrollconquer = gohelper.findChildScrollRect(self.viewGO, "#go_fightPanel/panel/#go_conquerReward/#go_conquerTip/#scroll_conquer")
	self._goconquerContent = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_conquerReward/#go_conquerTip/#scroll_conquer/Viewport/#go_conquerContent")
	self._goconquerRewardItem = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_conquerReward/#go_conquerTip/#scroll_conquer/Viewport/#go_conquerContent/#go_conquerRewardItem")
	self._gomyth = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_myth")
	self._gorecord = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_record")
	self._imagerecord = gohelper.findChildImage(self.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_record/#image_record")
	self._goEmptyRecord = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_record/#go_emptyRecord")
	self._txtrecord = gohelper.findChildText(self.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_record/#txt_record")
	self._btnrecord = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_record/#btn_record")
	self._goaddition = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_addition")
	self._goadditionContent = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_addition/#go_additionContent")
	self._goadditionItem = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_addition/#go_additionContent/#go_additionItem")
	self._btnaddition = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_addition/#btn_addition")
	self._gorecordRewardTip = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_myth/#go_recordRewardTip")
	self._btnrecordCloseTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fightPanel/panel/#go_myth/#go_recordRewardTip/#btn_recordCloseTip")
	self._gorecordContent = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_myth/#go_recordRewardTip/#go_recordContent")
	self._gorecordItem = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_myth/#go_recordRewardTip/#go_recordContent/#go_recordItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyDungeonInteractFightView:addEvents()
	self._btnlevelCloseTip:AddClickListener(self._btnLevelCloseTipOnClick, self)
	self._btnsuitCloseTip:AddClickListener(self._btnSuitCloseTipOnClick, self)
	self._btnconquerCloseTip:AddClickListener(self._btnConquerCloseTipOnClick, self)
	self._btnrecordCloseTip:AddClickListener(self._btnRecordCloseTipOnClick, self)
	self._btnenemyLevel:AddClickListener(self._btnenemyLevelOnClick, self)
	self._btnenemyInfo:AddClickListener(self._btnenemyInfoOnClick, self)
	self._btnfight:AddClickListener(self._btnfightOnClick, self)
	self._btnchangeSuit:AddClickListener(self._btnchangeSuitOnClick, self)
	self._btnconquer:AddClickListener(self._btnconquerOnClick, self)
	self._btnrecord:AddClickListener(self._btnrecordOnClick, self)
	self._btnaddition:AddClickListener(self._btnadditionOnClick, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.RefreshMercenarySuit, self.refreshMercenaryUI, self)
end

function OdysseyDungeonInteractFightView:removeEvents()
	self._btnlevelCloseTip:RemoveClickListener()
	self._btnsuitCloseTip:RemoveClickListener()
	self._btnconquerCloseTip:RemoveClickListener()
	self._btnrecordCloseTip:RemoveClickListener()
	self._btnenemyLevel:RemoveClickListener()
	self._btnenemyInfo:RemoveClickListener()
	self._btnfight:RemoveClickListener()
	self._btnchangeSuit:RemoveClickListener()
	self._btnconquer:RemoveClickListener()
	self._btnrecord:RemoveClickListener()
	self._btnaddition:RemoveClickListener()
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.RefreshMercenarySuit, self.refreshMercenaryUI, self)
end

OdysseyDungeonInteractFightView.normalDescHeight = 271
OdysseyDungeonInteractFightView.smallDescHeight = 162

function OdysseyDungeonInteractFightView:_btnenemyLevelOnClick()
	self:showLevelSuppressTip(true)
end

function OdysseyDungeonInteractFightView:_btnLevelCloseTipOnClick()
	self:showLevelSuppressTip(false)
end

function OdysseyDungeonInteractFightView:_btnchangeSuitOnClick()
	gohelper.setActive(self._gosuitSelectTip, true)
end

function OdysseyDungeonInteractFightView:_btnSuitCloseTipOnClick()
	gohelper.setActive(self._gosuitInfoTip, false)
	gohelper.setActive(self._gosuitSelectTip, false)
end

function OdysseyDungeonInteractFightView:_btnconquerOnClick()
	gohelper.setActive(self._goconquerTip, true)
end

function OdysseyDungeonInteractFightView:_btnConquerCloseTipOnClick()
	gohelper.setActive(self._goconquerTip, false)
end

function OdysseyDungeonInteractFightView:_btnrecordOnClick()
	gohelper.setActive(self._gorecordRewardTip, true)
end

function OdysseyDungeonInteractFightView:_btnRecordCloseTipOnClick()
	gohelper.setActive(self._gorecordRewardTip, false)
end

function OdysseyDungeonInteractFightView:_btnadditionOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = self.ruleList,
		offSet = {
			-200,
			-176
		}
	})
end

function OdysseyDungeonInteractFightView:_btnenemyInfoOnClick()
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self.fightElementConfig.episodeId)

	EnemyInfoController.instance:openEnemyInfoViewByBattleId(episodeConfig.battleId)
end

function OdysseyDungeonInteractFightView:_btnfightOnClick()
	if self.fightEpisodeCo.beforeStory > 0 then
		if self.fightEpisodeCo.afterStory > 0 then
			if not StoryModel.instance:isStoryFinished(self.fightEpisodeCo.afterStory) then
				self:playStoryAndEnterFight(self.fightEpisodeCo.beforeStory)

				return
			end
		else
			local isElementFinish = OdysseyDungeonModel.instance:isElementFinish(self.elementConfig.id)

			if not isElementFinish then
				self:playStoryAndEnterFight(self.fightEpisodeCo.beforeStory)

				return
			end
		end
	end

	self:enterFight()
end

function OdysseyDungeonInteractFightView:_editableInitView()
	self.rewardItemTab = self:getUserDataTb_()
	self.rewardOuteritemTab = self:getUserDataTb_()
	self.multiRewardItemTab = self:getUserDataTb_()
	self.suitSelectItemTab = self:getUserDataTb_()
	self.fightUIHandleFunc = {
		[OdysseyEnum.FightType.Normal] = OdysseyDungeonInteractFightView.refreshNormalUI,
		[OdysseyEnum.FightType.Elite] = OdysseyDungeonInteractFightView.refreshNormalUI,
		[OdysseyEnum.FightType.Mercenary] = OdysseyDungeonInteractFightView.refreshMercenaryUI,
		[OdysseyEnum.FightType.Religion] = OdysseyDungeonInteractFightView.refreshNormalUI,
		[OdysseyEnum.FightType.Conquer] = OdysseyDungeonInteractFightView.refreshConquerUI,
		[OdysseyEnum.FightType.Myth] = OdysseyDungeonInteractFightView.refreshMythUI
	}
	self._txtEnemyTag = gohelper.findChildText(self._goenemyTagItem, "txt_tag")
	self._imageEnemyTag = gohelper.findChildImage(self._goenemyTagItem, "image_tag")
	self._gofightDesc = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/common/scroll_fightDesc")
	self._goConquerBar = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_conquerReward/conquerReward/conquerBar")
	self._goequipSuitEffect = gohelper.findChild(self.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_equipSuit/vx_eff")
	self._conquerBarWith = recthelper.getWidth(self._goConquerBar.transform)

	gohelper.setActive(self._btnlevelCloseTip, false)
	gohelper.setActive(self._goequipSuitEffect, false)
	gohelper.setActive(self._gosuitInfoTip, false)
	gohelper.setActive(self._gosuitSelectTip, false)
end

function OdysseyDungeonInteractFightView:onUpdateParam()
	return
end

function OdysseyDungeonInteractFightView:onOpen()
	self.elementConfig = self.viewParam.config
	self.elementType = self.elementConfig.type
	self.fightElementConfig = OdysseyConfig.instance:getElementFightConfig(self.elementConfig.id)
	self.elementMO = OdysseyDungeonModel.instance:getElementMo(self.elementConfig.id)
end

function OdysseyDungeonInteractFightView:refreshFightPanel()
	self:showLevelSuppressTip(false, true)
	self:refreshCommonUI()
	self:hideAllSpUI()

	local handleFunc = self.fightUIHandleFunc[self.fightElementConfig.type]

	if handleFunc then
		handleFunc(self)
	end
end

function OdysseyDungeonInteractFightView:refreshCommonUI()
	local curHeroLevel = OdysseyModel.instance:getHeroCurLevelAndExp()

	self.fightEpisodeCo = DungeonConfig.instance:getEpisodeCO(self.fightElementConfig.episodeId)

	local enemyLevel = self.fightElementConfig.enemyLevel

	self._txtenemyLevel.text = curHeroLevel < enemyLevel and string.format("<#E76969>%s</color>", enemyLevel) or enemyLevel
	self._txtfightName.text = self.fightElementConfig.title
	self._txtfightDesc.text = self.fightElementConfig.desc

	local recommendLevel = FightHelper.getBattleRecommendLevel(self.fightEpisodeCo.battleId)

	self._txtrecommend.text = recommendLevel >= 0 and HeroConfig.instance:getLevelDisplayVariant(recommendLevel) or ""
	self._txtfight.text = luaLang("toughbattle_mainview_txt_start")

	local mercenaryType = self.fightElementConfig.type == OdysseyEnum.FightType.Mercenary and tonumber(self.fightElementConfig.param) or 0
	local tagLang = OdysseyEnum.FightElementTagLang[self.fightElementConfig.type][mercenaryType]

	self._txtEnemyTag.text = luaLang(tagLang)

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageEnemyTag, string.format("%s_0", OdysseyEnum.FightElementTagIcon[self.fightElementConfig.type]), true)
	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imagetagLarge, string.format("%s_2", OdysseyEnum.FightElementTagIcon[self.fightElementConfig.type]))
	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imagelevelIcon, OdysseyEnum.FightElementEnemyIcon[self.fightElementConfig.type])
end

function OdysseyDungeonInteractFightView:showLevelSuppressTip(showState, isAuto)
	local curHeroLevel = OdysseyModel.instance:getHeroCurLevelAndExp()
	local enemyLevel = self.fightElementConfig.enemyLevel
	local saveLevelSuppressKey = OdysseyEnum.LocalSaveKey.FightLevelSuppress
	local saveLevelSuppressValue = GameUtil.playerPrefsGetNumberByUserId(saveLevelSuppressKey, 0)
	local levelDifference = curHeroLevel - enemyLevel
	local levelSuppressConfig = OdysseyConfig.instance:getLevelSuppressConfig(levelDifference)

	self._txtlevelTip.text = levelSuppressConfig.tips

	gohelper.setActive(self._golevelTip, showState)
	gohelper.setActive(self._btnlevelCloseTip, showState)

	if saveLevelSuppressValue == 0 and curHeroLevel < enemyLevel and isAuto then
		GameUtil.playerPrefsSetNumberByUserId(saveLevelSuppressKey, 1)
		gohelper.setActive(self._golevelTip, true)
	end
end

function OdysseyDungeonInteractFightView:hideAllSpUI()
	gohelper.setActive(self._goequipReward, false)
	gohelper.setActive(self._goconquerReward, false)
	gohelper.setActive(self._gomyth, false)
	gohelper.setActive(self._goreward, false)
end

function OdysseyDungeonInteractFightView:refreshNormalUI()
	gohelper.setActive(self._goreward, true)
	gohelper.setActive(self._gorewardItem, false)

	local episodeId = self.fightElementConfig.episodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local rewardCo = lua_bonus.configDict[episodeConfig.firstBonus]

	if episodeConfig.firstBonus > 0 and rewardCo then
		local outerItemRewardList = GameUtil.splitString2(rewardCo.fixBonus)

		for index, rewardData in ipairs(outerItemRewardList) do
			local rewardItem = self.rewardOuteritemTab[index]

			if not rewardItem then
				rewardItem = {
					go = gohelper.clone(self._gorewardItem, self._gorewardContent, "rewardOuterItem_" .. index)
				}
				rewardItem.itemGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[1], rewardItem.go)
				rewardItem.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(rewardItem.itemGO, OdysseyItemIcon)
				self.rewardOuteritemTab[index] = rewardItem
			end

			local dataParam = {
				type = tonumber(rewardData[1]),
				id = tonumber(rewardData[2])
			}

			rewardItem.itemIcon:initRewardItemInfo(OdysseyEnum.RewardItemType.OuterItem, dataParam, tonumber(rewardData[3]))
			gohelper.setActive(rewardItem.go, true)
		end

		for index = #outerItemRewardList + 1, #self.rewardOuteritemTab do
			local rewardItem = self.rewardOuteritemTab[index]

			if rewardItem then
				gohelper.setActive(rewardItem.go, false)
			end
		end
	end

	local rewardList = GameUtil.splitString2(self.fightElementConfig.reward)

	for index, rewardData in ipairs(rewardList) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				go = gohelper.clone(self._gorewardItem, self._gorewardContent, "rewardItem_" .. index)
			}
			rewardItem.itemGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[1], rewardItem.go)
			rewardItem.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(rewardItem.itemGO, OdysseyItemIcon)
			self.rewardItemTab[index] = rewardItem
		end

		rewardItem.itemIcon:initRewardItemInfo(rewardData[1], tonumber(rewardData[2]), tonumber(rewardData[3]))
		gohelper.setActive(rewardItem.go, true)
	end

	for index = #rewardList + 1, #self.rewardItemTab do
		local rewardItem = self.rewardItemTab[index]

		if rewardItem then
			gohelper.setActive(rewardItem.go, false)
		end
	end
end

function OdysseyDungeonInteractFightView:refreshMercenaryUI()
	gohelper.setActive(self._goequipReward, true)

	self.mercenaryType = tonumber(self.fightElementConfig.param)

	local suitConstId = OdysseyEnum.MercenaryTypeToSuit[self.mercenaryType]
	local suitConstConfig = OdysseyConfig.instance:getConstConfig(suitConstId)
	local canSelectSuit = not string.nilorempty(suitConstConfig.value)

	gohelper.setActive(self._goequipSuit, canSelectSuit)

	if canSelectSuit then
		local suitIdList = string.splitToNumber(suitConstConfig.value, "#")

		self.curSuitId = OdysseyModel.instance:getMercenaryTypeSuit(self.mercenaryType)

		local suitConfig = OdysseyConfig.instance:getEquipSuitConfig(self.curSuitId)

		self._txtequipSuit.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_get_rateup"), suitConfig.name)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageequipSuit, suitConfig.icon)
		self:refreshSuitSelectTip(suitIdList)
		self:playSuitSelectEffect()
	end

	self:createAndRefreshMercenaryReward()
end

function OdysseyDungeonInteractFightView:createAndRefreshMercenaryReward()
	gohelper.setActive(self._goequipItem, false)

	local rewardInfoList = {}
	local rewardItemList = GameUtil.splitString2(self.fightElementConfig.reward)
	local dropEquipId = self.fightElementConfig.randomDrop
	local equipDropConfig = OdysseyConfig.instance:getEquipDropConfig(dropEquipId)
	local suitRareInfoList = GameUtil.splitString2(equipDropConfig.dropRare, true)

	for index, rewardData in ipairs(rewardItemList) do
		local rewardInfo = {}

		rewardInfo.isEquipSuit = false
		rewardInfo.data = rewardData

		table.insert(rewardInfoList, rewardInfo)
	end

	table.sort(suitRareInfoList, function(a, b)
		return tonumber(a[1]) > tonumber(b[1])
	end)

	for index, rewardData in ipairs(suitRareInfoList) do
		local rewardInfo = {}

		rewardInfo.isEquipSuit = true
		rewardInfo.data = rewardData

		table.insert(rewardInfoList, rewardInfo)
	end

	for index, rewardInfo in ipairs(rewardInfoList) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				go = gohelper.clone(self._goequipItem, self._goequipContent, "rewardItem_" .. index)
			}
			rewardItem.itemGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[1], rewardItem.go)
			rewardItem.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(rewardItem.itemGO, OdysseyItemIcon)
			self.rewardItemTab[index] = rewardItem
		end

		if rewardInfo.isEquipSuit then
			rewardItem.itemIcon:showUnknowSuitIcon(rewardInfo.data[1])
		else
			rewardItem.itemIcon:initRewardItemInfo(rewardInfo.data[1], tonumber(rewardInfo.data[2]), tonumber(rewardInfo.data[3]))
		end

		gohelper.setActive(rewardItem.go, true)
	end

	for index = #rewardInfoList + 1, #self.rewardItemTab do
		local rewardItem = self.rewardItemTab[index]

		if rewardItem then
			gohelper.setActive(rewardItem.go, false)
		end
	end
end

function OdysseyDungeonInteractFightView:playSuitSelectEffect()
	if self.curSuitId and self.lastSuitId and self.curSuitId ~= self.lastSuitId then
		gohelper.setActive(self._goequipSuitEffect, false)
		gohelper.setActive(self._goequipSuitEffect, true)
	end

	self.lastSuitId = self.curSuitId
end

function OdysseyDungeonInteractFightView:refreshSuitSelectTip(suitIdList)
	self.isSuitLongPress = false

	gohelper.CreateObjList(self, self.onSuitSelectTipShow, suitIdList, self._gosuitSelectContent, self._gosuitSelectItem)
end

function OdysseyDungeonInteractFightView:onSuitSelectTipShow(obj, data, index)
	local selectItem = self.suitSelectItemTab[index]

	if not selectItem then
		selectItem = {
			go = obj
		}
		selectItem.imageSuitIcon = gohelper.findChildImage(selectItem.go, "image_suitIcon")
		selectItem.txtSuitName = gohelper.findChildText(selectItem.go, "txt_suitName")
		selectItem.btnSuitSelect = gohelper.findChildButtonWithAudio(selectItem.go, "btn_select")
		selectItem.btnSuitClickLongPrees = SLFramework.UGUI.UILongPressListener.Get(selectItem.btnSuitSelect.gameObject)

		selectItem.btnSuitClickLongPrees:SetLongPressTime({
			0.5,
			99999
		})

		selectItem.goSelect = gohelper.findChild(selectItem.go, "btn_select/go_select")
		self.suitSelectItemTab[index] = selectItem
	end

	selectItem.suitConfig = OdysseyConfig.instance:getEquipSuitConfig(data)
	selectItem.txtSuitName.text = selectItem.suitConfig.name

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(selectItem.imageSuitIcon, selectItem.suitConfig.icon)
	selectItem.btnSuitSelect:AddClickListener(self._onSuitSelectClick, self, selectItem)
	selectItem.btnSuitClickLongPrees:AddLongPressListener(self._onSuitEffectInfoClick, self, selectItem)
	gohelper.setActive(selectItem.goSelect, data == self.curSuitId)
end

function OdysseyDungeonInteractFightView:_onSuitEffectInfoClick(selectItem)
	gohelper.setActive(self._gosuitInfoTip, true)

	self._txtsuitName.text = selectItem.suitConfig.name

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imagesuitIcon, selectItem.suitConfig.icon)

	self.suitEffectList = OdysseyConfig.instance:getEquipSuitAllEffect(selectItem.suitConfig.id)

	gohelper.CreateObjList(self, self.onSuitEffectInfoTipShow, self.suitEffectList, self._gosuitInfoContent, self._gosuitInfoItem)

	self.isSuitLongPress = true
end

function OdysseyDungeonInteractFightView:onSuitEffectInfoTipShow(obj, data, index)
	local go = obj
	local txtSuitInfo = gohelper.findChildText(go, "txt_suitInfo")
	local goLine = gohelper.findChild(go, "go_line")
	local skillDesc = HeroSkillModel.instance:skillDesToSpot(data.effect, "#CC492F", "#485E92")

	txtSuitInfo.text = SkillHelper.buildDesc(skillDesc)

	local fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(txtSuitInfo.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(txtSuitInfo, self._onHyperLinkClick, self)
	fixTmpBreakLine:refreshTmpContent(txtSuitInfo)
	gohelper.setActive(goLine, index ~= #self.suitEffectList)
end

function OdysseyDungeonInteractFightView:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipView(tonumber(effId), clickPosition)
end

function OdysseyDungeonInteractFightView:_onSuitSelectClick(selectItem)
	if self.isSuitLongPress then
		self.isSuitLongPress = false

		return
	end

	self.curSuitId = selectItem.suitConfig.id

	OdysseyRpc.instance:sendOdysseyFightMercenarySetDropRequest(self.mercenaryType, self.curSuitId)

	for _, suitSelectItem in ipairs(self.suitSelectItemTab) do
		gohelper.setActive(suitSelectItem.goSelect, suitSelectItem.suitConfig.id == self.curSuitId)
	end

	self._txtequipSuit.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_get_rateup"), selectItem.suitConfig.name)

	gohelper.setActive(self._gosuitInfoTip, false)
	gohelper.setActive(self._gosuitSelectTip, false)
end

function OdysseyDungeonInteractFightView:refreshConquerUI()
	gohelper.setActive(self._goconquerTip, false)
	gohelper.setActive(self._goconquerReward, true)

	local fightRewardList = string.split(self.fightElementConfig.reward, "@")

	if #fightRewardList and #fightRewardList > 0 then
		if not #fightRewardList then
			local allWaveCount = 1
			local conquestInfoData = self.elementMO:getConquestEleData()

			if conquestInfoData then
				self.curConquestHighWave = conquestInfoData.highWave or 0
			end

			local barWidth = self.curConquestHighWave / allWaveCount * self._conquerBarWith

			recthelper.setWidth(self._imageconquerBar.gameObject.transform, barWidth)

			self._txtconquerTimes.text = self.curConquestHighWave
			self._txtconquerTotalTimes.text = "/" .. allWaveCount

			gohelper.setActive(self._goconquerHasget, self.curConquestHighWave == allWaveCount)
			self:createRewardItem(fightRewardList, self._goconquerRewardItem, self._goconquerContent)

			for index, rewardItem in ipairs(self.multiRewardItemTab) do
				for _, itemIcon in ipairs(rewardItem.itemIconTab) do
					gohelper.setActive(itemIcon.itemGet, index <= self.curConquestHighWave)
				end

				rewardItem.txt.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_conquest_wave"), GameUtil.getNum2Chinese(index))
			end
		end
	end
end

function OdysseyDungeonInteractFightView:refreshMythUI()
	gohelper.setActive(self._gomyth, true)
	gohelper.setActive(self._gorecordRewardTip, false)

	local mythInfoData = self.elementMO:getMythicEleData()

	if mythInfoData then
		if not mythInfoData.evaluation then
			local curRecodeLevel = 0

			self._txtrecord.text = curRecodeLevel > 0 and luaLang("odyssey_dungeon_mapselectinfo_mythRecord" .. curRecodeLevel) or luaLang("odyssey_myth_record_empty")

			if curRecodeLevel > 0 then
				UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imagerecord, "pingji_d_" .. curRecodeLevel)
			end

			gohelper.setActive(self._imagerecord.gameObject, curRecodeLevel > 0)
			gohelper.setActive(self._goEmptyRecord, curRecodeLevel == 0)

			local paramData = GameUtil.splitString2(self.fightElementConfig.param, true)
			local fightRewardList = string.split(self.fightElementConfig.reward, "@")

			self:createRewardItem(fightRewardList, self._gorecordItem, self._gorecordContent)

			for index, rewardItem in ipairs(self.multiRewardItemTab) do
				for _, itemIcon in ipairs(rewardItem.itemIconTab) do
					gohelper.setActive(itemIcon.itemGet, index <= curRecodeLevel)
				end

				rewardItem.imageRecord = gohelper.findChildImage(rewardItem.go, "image_record")

				UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(rewardItem.imageRecord, "pingji_x_" .. index)

				local fightTaskDescConfig = OdysseyConfig.instance:getFightTaskDescConfig(paramData[index][2])

				rewardItem.txt.text = fightTaskDescConfig.desc
			end

			local episodeId = self.fightElementConfig.episodeId
			local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
			local battleCo = lua_battle.configDict[episodeConfig.battleId]
			local canShowAddition = not string.nilorempty(battleCo.AdditionRule)

			gohelper.setActive(self._goaddition, canShowAddition)
			recthelper.setHeight(self._gofightDesc.transform, (canShowAddition or nil) and (OdysseyDungeonInteractFightView.smallDescHeight or OdysseyDungeonInteractFightView.normalDescHeight))

			if canShowAddition then
				self.ruleList = FightStrUtil.instance:getSplitString2Cache(battleCo.AdditionRule, true, "|", "#")

				gohelper.CreateObjList(self, self.onAdditionalRuleShow, self.ruleList, self._goadditionContent, self._goadditionItem)
			end
		end
	end
end

function OdysseyDungeonInteractFightView:onAdditionalRuleShow(obj, data, index)
	local targetId = data[1]
	local ruleId = data[2]
	local ruleCo = lua_rule.configDict[ruleId]
	local go = obj

	if ruleCo then
		gohelper.setActive(go, true)

		local ruleicon = gohelper.findChildImage(go, "image_ruleicon")
		local tagicon = gohelper.findChildImage(go, "image_ruleicon/image_tagicon")

		UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)
		UISpriteSetMgr.instance:setDungeonLevelRuleSprite(ruleicon, ruleCo.icon)
	else
		gohelper.setActive(go, false)
	end
end

function OdysseyDungeonInteractFightView:createRewardItem(fightRewardList, rewardItemGO, rewardItemContentGO)
	gohelper.setActive(rewardItemGO, false)

	for index, rewardStr in ipairs(fightRewardList) do
		local rewardItem = self.multiRewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				go = gohelper.clone(rewardItemGO, rewardItemContentGO, "rewardItem" .. index)
			}
			rewardItem.txt = gohelper.findChildText(rewardItem.go, "txt_desc")
			rewardItem.itemContent = gohelper.findChild(rewardItem.go, "go_rewardContent")
			rewardItem.itemGO = gohelper.findChild(rewardItem.go, "go_rewardContent/go_rewardItem")
			rewardItem.itemIconTab = {}

			self:createRewardItemIcon(rewardStr, rewardItem.itemGO, rewardItem.itemContent, rewardItem.itemIconTab)

			self.multiRewardItemTab[index] = rewardItem
		end

		gohelper.setActive(rewardItem.go, true)
	end
end

function OdysseyDungeonInteractFightView:createRewardItemIcon(rewardStr, rewardItemGO, rewardItemContentGO, itemIconTab)
	gohelper.setActive(rewardItemGO, false)

	local rewardList = GameUtil.splitString2(rewardStr)

	for index, rewardData in ipairs(rewardList) do
		local rewardItem = itemIconTab[index]

		if not rewardItem then
			rewardItem = {
				go = gohelper.clone(rewardItemGO, rewardItemContentGO, "rewardItem_" .. index)
			}
			rewardItem.itemPos = gohelper.findChild(rewardItem.go, "go_itemPos")
			rewardItem.itemGet = gohelper.findChild(rewardItem.go, "go_get")
			rewardItem.itemGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[1], rewardItem.itemPos)
			rewardItem.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(rewardItem.itemGO, OdysseyItemIcon)
			itemIconTab[index] = rewardItem
		end

		rewardItem.itemIcon:initRewardItemInfo(rewardData[1], tonumber(rewardData[2]), tonumber(rewardData[3]))
		gohelper.setActive(rewardItem.go, true)
	end

	for index = #rewardList + 1, #itemIconTab do
		local rewardItem = itemIconTab[index]

		if rewardItem then
			gohelper.setActive(rewardItem.go, false)
		end
	end
end

function OdysseyDungeonInteractFightView:enterFight()
	local param = {
		episodeId = self.fightEpisodeCo.id,
		elementId = self.elementConfig.id
	}

	OdysseyDungeonModel.instance:setLastElementFightParam(param)
	DungeonFightController.instance:enterFight(self.fightEpisodeCo.chapterId, self.fightEpisodeCo.id)
end

function OdysseyDungeonInteractFightView:playStoryAndEnterFight(storyId, noCheckFinish)
	if not noCheckFinish and StoryModel.instance:isStoryFinished(storyId) then
		self:enterFight()

		return
	end

	local param = {}

	param.mark = true
	param.episodeId = self.fightEpisodeCo.id

	StoryController.instance:playStory(storyId, param, self.enterFight, self)
end

function OdysseyDungeonInteractFightView:onClose()
	if #self.suitSelectItemTab > 0 then
		for index, suitSelectItem in ipairs(self.suitSelectItemTab) do
			suitSelectItem.btnSuitSelect:RemoveClickListener()
			suitSelectItem.btnSuitClickLongPrees:RemoveLongPressListener()
		end
	end
end

function OdysseyDungeonInteractFightView:onDestroyView()
	return
end

return OdysseyDungeonInteractFightView
