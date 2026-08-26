-- chunkname: @modules/logic/season/view1_2/Season1_2SettlementView.lua

module("modules.logic.season.view1_2.Season1_2SettlementView", package.seeall)

local Season1_2SettlementView = class("Season1_2SettlementView", BaseViewExtended)

function Season1_2SettlementView:onInitView()
	self._gosettlement = gohelper.findChild(self.viewGO, "#go_settlement")
	self._gospecialmarket = gohelper.findChild(self.viewGO, "#go_settlement/#go_specialmarket")
	self._simagespecialbg = gohelper.findChildSingleImage(self.viewGO, "#go_settlement/#go_specialmarket/#simage_specialbg")
	self._animationEvent = self._gosettlement:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_settlement/#btn_close")
	self._simagedecorate6 = gohelper.findChildSingleImage(self.viewGO, "#go_settlement/decorate/mask/#simage_decorate6")
	self._simagedecorate10 = gohelper.findChildSingleImage(self.viewGO, "#go_settlement/decorate/mask/#simage_decorate10")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_settlement/left/#simage_circlebg/#txt_index")
	self._txtlevelnamecn = gohelper.findChildText(self.viewGO, "#go_settlement/left/#txt_levelnamecn")
	self._gostageitem1 = gohelper.findChild(self.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem1")
	self._gostageitem2 = gohelper.findChild(self.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem2")
	self._gostageitem3 = gohelper.findChild(self.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem3")
	self._gostageitem4 = gohelper.findChild(self.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem4")
	self._gostageitem5 = gohelper.findChild(self.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem5")
	self._gostageitem6 = gohelper.findChild(self.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem6")
	self._gostageitem7 = gohelper.findChild(self.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem7")
	self._simageherodecorate = gohelper.findChildSingleImage(self.viewGO, "#go_settlement/right/herocard/#simage_herodecorate")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards")
	self._goprogress = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_bottom/#go_progress")
	self._txtprogress = gohelper.findChildText(self.viewGO, "#go_settlement/right/layout/#go_bottom/#go_progress/#txt_progress")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards/mask/#scroll_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._gohero1 = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero1")
	self._gohero2 = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero2")
	self._gohero3 = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero3")
	self._gohero4 = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero4")
	self._gosupercard = gohelper.findChild(self.viewGO, "#go_settlement/right/herocard/#go_supercard")
	self._gofightsucc = gohelper.findChild(self.viewGO, "#go_fightsucc")
	self._simagefightsuccbg = gohelper.findChildSingleImage(self.viewGO, "#go_fightsucc/#simage_fightsuccbg")
	self._btnclosetip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fightsucc/#btn_closetip")
	self._gocoverrecordpart = gohelper.findChild(self.viewGO, "#go_settlement/#go_cover_record_part")
	self._btncoverrecord = gohelper.findChildButtonWithAudio(self.viewGO, "#go_settlement/#go_cover_record_part/#btn_cover_record")
	self._txtcurroundcount = gohelper.findChildText(self.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	self._txtmaxroundcount = gohelper.findChildText(self.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	self._goCoverLessThan = gohelper.findChild(self.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	self._goCoverMuchThan = gohelper.findChild(self.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	self._goCoverEqual = gohelper.findChild(self.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/middle/#go_equal")
	self._gobottom = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_bottom")
	self._gospace = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_space")
	self._btnstat = gohelper.findChildButtonWithAudio(self.viewGO, "#go_settlement/right/layout/middle/#btn_stat")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._btncloseaward = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tips/#btn_closeaward")
	self._gorewardtip = gohelper.findChild(self.viewGO, "#go_tips/layout/vertical/#go_rewardtip")
	self._awardcontent = gohelper.findChild(self.viewGO, "#go_tips/layout/vertical/#go_rewardtip/#scroll_rewardtip/Viewport/Content")
	self._gorewardtipitem = gohelper.findChild(self.viewGO, "#go_tips/layout/vertical/#go_rewardtip/#scroll_rewardtip/Viewport/Content/#go_rewardtipitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_2SettlementView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnstat:AddClickListener(self._btnstatOnClick, self)
	self._btncloseaward:AddClickListener(self._btncloseawardOnClick, self)
	self.addClickCb(self, self._btncoverrecord, self._onBtnCoverRecordClick, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, self._onCoverDungeonRecordReply, self)
	FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
	self._animationEvent:AddEventListener("reward", self._onRewardShow, self)
end

function Season1_2SettlementView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnstat:RemoveClickListener()
	self._btncloseaward:RemoveClickListener()
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
	self._animationEvent:RemoveEventListener("reward")
end

function Season1_2SettlementView:_btnclosetipOnClick()
	self:_showAwardTip()
	gohelper.setActive(self._gofightsucc, false)
end

function Season1_2SettlementView:_btncloseawardOnClick()
	if Time.realtimeSinceStartup - self._startTime < 2 then
		return
	end

	self:_showSettlement()
end

function Season1_2SettlementView:_btnstatOnClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function Season1_2SettlementView:_showAwardTip()
	FightHelper.hideAllEntity()

	if self._episode_config.type == DungeonEnum.EpisodeType.Season and FightResultModel.instance.firstPass then
		gohelper.setActive(self._gotips, true)
		self:_showAwardTipsData()
	else
		self:_showSettlement()
	end
end

function Season1_2SettlementView:_showSettlement()
	gohelper.setActive(self._gotips, false)

	self._startTime = Time.realtimeSinceStartup

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_clearing)
	gohelper.setActive(self._gosettlement, true)
	gohelper.setActive(self._gospecialmarket, self._episode_config.type == DungeonEnum.EpisodeType.SeasonSpecial)
	self:_checkNewRecord()
	self:_detectCoverRecord()
	TaskDispatcher.runDelay(self._dailyShowHero, self, 0.6)
end

function Season1_2SettlementView:_onRewardShow()
	self:_showSettlementReward()
end

function Season1_2SettlementView:_dailyShowHero()
	self._heroIndex = 0

	TaskDispatcher.runRepeat(self._showHeroItem, self, 0.03, #self._heroList)
	TaskDispatcher.runDelay(self._showGetCardView, self, 1.5)
end

function Season1_2SettlementView:_showHeroItem()
	self._heroIndex = self._heroIndex + 1

	gohelper.setActive(self._heroList[self._heroIndex].viewGO, true)
end

function Season1_2SettlementView:_showGetCardView()
	if self.equip_cards then
		self._showTipsFlow = FlowSequence.New()

		self._showTipsFlow:addWork(Season1_2SettlementTipsWork.New())
		self._showTipsFlow:registerDoneListener(self._onShowTipsFlowDone, self)

		local data = {}

		data.delayTime = 0

		self._showTipsFlow:start(data)
	end
end

function Season1_2SettlementView:_onShowTipsFlowDone()
	self.equip_cards = nil
end

function Season1_2SettlementView:_checkNewRecord()
	if FightResultModel.instance.updateDungeonRecord then
		GameFacade.showToast(ToastEnum.FightNewRecord)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	end
end

function Season1_2SettlementView:_onCoverDungeonRecordReply(isCover)
	self._hasSendCoverRecord = true

	gohelper.setActive(self._gocoverrecordpart, false)

	if isCover then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
		GameFacade.showToast(ToastEnum.FightSuccIsCover)
	end
end

function Season1_2SettlementView:_detectCoverRecord()
	gohelper.setActive(self._gocoverrecordpart, FightResultModel.instance.canUpdateDungeonRecord or false)

	if FightResultModel.instance.canUpdateDungeonRecord then
		self._txtcurroundcount.text = FightResultModel.instance.newRecordRound or ""
		self._txtmaxroundcount.text = FightResultModel.instance.oldRecordRound or ""

		gohelper.setActive(self._goCoverLessThan, FightResultModel.instance.newRecordRound < FightResultModel.instance.oldRecordRound)
		gohelper.setActive(self._goCoverMuchThan, FightResultModel.instance.newRecordRound > FightResultModel.instance.oldRecordRound)
		gohelper.setActive(self._goCoverEqual, FightResultModel.instance.newRecordRound == FightResultModel.instance.oldRecordRound)

		self._txtcurroundcount.color = FightResultModel.instance.newRecordRound >= FightResultModel.instance.oldRecordRound and GameUtil.parseColor("#272525") or GameUtil.parseColor("#AC5320")
	end
end

function Season1_2SettlementView:_onBtnCoverRecordClick()
	DungeonRpc.instance:sendCoverDungeonRecordRequest(true)
end

function Season1_2SettlementView:_editableInitView()
	self._simagedecorate10:LoadImage(ResUrl.getSeasonIcon("img_circle.png"))
	self._simagefightsuccbg:LoadImage(ResUrl.getSeasonIcon("full/diejia_bj.png"))
	self._simageherodecorate:LoadImage(ResUrl.getSeasonIcon("jiesuan_zhujue.png"))
	self._simagespecialbg:LoadImage(ResUrl.getSeasonIcon("full/img_bg3.png"))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_succeed)
	gohelper.setActive(self._gofightsucc, true)
	gohelper.setActive(self._gosettlement, false)
	gohelper.setActive(self._gotips, false)

	self._fightsucc_click = gohelper.getClick(self._gofightsucc)
end

function Season1_2SettlementView:_btncloseOnClick()
	if Time.realtimeSinceStartup - self._startTime < 2.5 then
		return
	end

	if self.equip_cards then
		return
	end

	self:closeThis()

	local storyId = FightModel.instance:getAfterStory()

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		local param = {}

		param.mark = true
		param.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(storyId, param, function()
			FightSuccView.onStoryEnd()
		end)

		return
	end

	FightSuccView.onStoryEnd()
end

function Season1_2SettlementView:onOpen()
	self._startTime = Time.realtimeSinceStartup
	self._episode_config = lua_episode.configDict[FightResultModel.instance:getEpisodeId()]

	local layer = Activity104Model.instance:getBattleFinishLayer() or 1

	self._config = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), layer)

	if self._config then
		self._simagedecorate6:LoadImage(ResUrl.getV1A2SeasonIcon(string.format("icon/%s.png", self._config.stagePicture)))
	end

	self._txtindex.text = string.format("%02d", layer)
	self._txtlevelnamecn.text = self._episode_config.name

	local reward_list = {}

	tabletool.addValues(reward_list, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(reward_list, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(reward_list, FightResultModel.instance:getMaterialDataList())

	local equip_cards = {}

	for i = #reward_list, 1, -1 do
		local data = reward_list[i]

		if data.materilType == MaterialEnum.MaterialType.EquipCard then
			table.insert(equip_cards, data.materilId)
		end
	end

	self:_onHeroItemLoaded()

	if #equip_cards > 0 then
		self.equip_cards = equip_cards
	end

	self.reward_list = reward_list

	if FightResultModel.instance.firstPass then
		local showProgress = self._episode_config.type == DungeonEnum.EpisodeType.Season

		gohelper.setActive(self._goprogress, showProgress)

		if #reward_list == 0 then
			if FightResultModel.instance.firstPass then
				logError("服务器没有下发奖励")
			end

			gohelper.setActive(self._gorewards, false)
		end

		gohelper.setActive(self._gobottom, FightResultModel.instance.firstPass or #reward_list > 0)
		gohelper.setActive(self._gospace, not FightResultModel.instance.firstPass and not (#reward_list > 0))
		self:_setStages()

		self._reward_list = reward_list

		TaskDispatcher.runDelay(self._btnclosetipOnClick, self, 1.5)

		local animComp = CameraMgr.instance:getCameraRootAnimator()

		animComp.enabled = false
	end
end

function Season1_2SettlementView:_showSettlementReward()
	local parent_root = gohelper.findChild(self._scrollrewards.gameObject, "Viewport/Content")

	gohelper.addChild(self.viewGO, self._gorewarditem)
	self:com_createObjList(self._onRewardItemShow, self.reward_list, parent_root, self._gorewarditem, nil, 0.1)
end

function Season1_2SettlementView:_setStages()
	local stage = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), Activity104Model.instance:getBattleFinishLayer()).stage

	gohelper.setActive(self._gostageitem7, stage == 7)

	if self._episode_config.type == DungeonEnum.EpisodeType.SeasonSpecial then
		stage = 7

		gohelper.setActive(self._gostageitem7, false)
	end

	for i = 1, 7 do
		local infoDark = gohelper.findChildImage(self["_gostageitem" .. i], "dark")
		local infoLight = gohelper.findChildImage(self["_gostageitem" .. i], "light")

		gohelper.setActive(infoLight.gameObject, i <= stage)
		gohelper.setActive(infoDark.gameObject, stage < i)

		local color = i == 7 and "#B83838" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(infoLight, color)
	end
end

function Season1_2SettlementView:_onRewardItemShow(obj, data, index)
	local itemIconGO = gohelper.findChild(obj, "go_prop")

	if data.materilType == MaterialEnum.MaterialType.EquipCard then
		local cardItem = Season1_2CelebrityCardItem.New()

		cardItem:init(gohelper.findChild(itemIconGO, "cardicon"), data.materilId)

		self._equipAwardCards = self._equipAwardCards or {}

		table.insert(self._equipAwardCards, cardItem)
	else
		local itemIcon = IconMgr.instance:getCommonPropListItemIcon(itemIconGO)

		itemIcon._index = index

		function itemIcon.callback(item)
			item:setCountFontSize(40)
			item:hideName()
		end

		itemIcon:onUpdateMO(data)
	end
end

local HeroItemPosTab = {
	{
		Vector2.New(136.2, 196)
	},
	{
		Vector2.New(-92.3, 114),
		Vector2.New(149.7, 195.9)
	},
	{
		Vector2.New(-219.9, 195.9),
		Vector2.New(22.2, 116.1),
		Vector2.New(264.8, 195.9)
	},
	{
		Vector2.New(-340.6, 267.6),
		Vector2.New(-112.2, 195.9),
		Vector2.New(115, 115),
		Vector2.New(345.2, 195.9)
	}
}

function Season1_2SettlementView:_onHeroItemLoaded()
	self._heroList = {}
	self._hero_obj_list = self:getUserDataTb_()

	local setting = self.viewContainer:getSetting()
	local resPath = setting.otherRes.itemRes

	for i = 1, 4 do
		local hero_item = self.viewContainer:getResInst(resPath, self["_gohero" .. i])

		gohelper.setActive(hero_item, false)
		table.insert(self._hero_obj_list, hero_item)
	end

	gohelper.setActive(self._gosupercard, false)

	local fight_param = FightModel.instance:getFightParam()
	local is_replay = FightModel.instance.curFightModel

	if not is_replay then
		local hero_list = {}

		for i, v in ipairs(fight_param.mySideUids) do
			table.insert(hero_list, v)
		end

		for i, v in ipairs(fight_param.mySideSubUids) do
			table.insert(hero_list, v)
		end

		local equip_dic = {}

		for i, v in ipairs(fight_param.equips) do
			equip_dic[v.heroUid] = v
		end

		local equip104_dic = {}

		for i, v in ipairs(fight_param.activity104Equips) do
			equip104_dic[v.heroUid] = v
		end

		for i = 1, 4 do
			local hero_uid = hero_list[i]
			local equip = true

			goto label_26_0

			do
				local var_26_1
			end

			::label_26_0::

			var_26_1 = hero_uid ~= "0" and equip104_dic[hero_uid] and equip104_dic[hero_uid].equipUid or false

			local equip_104 = true

			goto label_26_1

			::label_26_1::

			local heroItem = self:openSubView(Season1_2SettlementHeroItem, self._hero_obj_list[i], nil, is_replay, hero_uid, equip, equip_104)

			if hero_uid ~= "0" then
				table.insert(self._heroList, heroItem)
			end
		end

		self:_refreshHeroItemPos()

		local character_uid = "-100000"

		if equip104_dic[character_uid] then
			if equip104_dic[character_uid].equipUid then
				if equip104_dic[character_uid].equipUid and equip104_dic[character_uid].equipUid ~= "0" then
					gohelper.setActive(self._gosupercard, true)
					self:openSubView(Season1_2CelebrityCardGetItem, Season1_2CelebrityCardItem.AssetPath, self._gosupercard, equip104_dic[character_uid].equipUid, true)
				end
			end
		end
	else
		FightRpc.instance:sendGetFightRecordGroupRequest(fight_param.episodeId)
	end
end

function Season1_2SettlementView:_refreshHeroItemPos()
	if self._heroList then
		if not #self._heroList then
			local count = 0

			if count <= 0 then
				return
			end

			local posCfg = HeroItemPosTab[count]

			for i = 1, count do
				recthelper.setAnchor(self._heroList[i].viewGO.transform.parent, posCfg[i].x, posCfg[i].y)
			end
		end
	end
end

function Season1_2SettlementView:_onGetFightRecordGroupReply(fightGroupMO)
	for i = 1, 4 do
		local obj = self._hero_obj_list[i]
		local hero = fightGroupMO:getHeroByIndex(i)
		local equip = fightGroupMO.replay_equip_data[hero]
		local equip_104 = fightGroupMO.replay_activity104Equip_data[hero]
		local heroItem = self:openSubView(Season1_2SettlementHeroItem, obj, nil, true, hero, equip, equip_104)

		if hero ~= "0" then
			table.insert(self._heroList, heroItem)
		end
	end

	local character_uid = "-100000"

	if fightGroupMO.replay_activity104Equip_data[character_uid] then
		local equipId = fightGroupMO.replay_activity104Equip_data[character_uid][1].equipId

		gohelper.setActive(self._gosupercard, equipId ~= 0)
		self:openSubView(Season1_2CelebrityCardGetItem, Season1_2CelebrityCardItem.AssetPath, self._gosupercard, nil, nil, equipId)
	end
end

function Season1_2SettlementView:_showAwardTipsData()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_clearing_unfold)

	self._startTime = Time.realtimeSinceStartup

	gohelper.setActive(self._gorewardtip, #self._reward_list > 0)
	self:_releaseAwardImage()
	self:com_createObjList(self._onAwardItemShow, self._reward_list, self._awardcontent, self._gorewardtipitem)
	self:_showPassData()
end

function Season1_2SettlementView:_showPassData()
	local curLayer = Activity104Model.instance:getBattleFinishLayer()
	local content = gohelper.findChild(self.viewGO, "#go_tips/layout/vertical/mask/#go_scrolllv/Viewport/Content")
	local last_config = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), curLayer - 1)
	local str = string.format("%02d", curLayer - 1)

	if not last_config then
		str = ""

		gohelper.setActive(gohelper.findChild(content, "#text1/pass"), false)
	end

	local text = gohelper.findChildText(content, "#text1/#txt_passindex1")

	text.text = str
	str = string.format("%02d", curLayer)
	text = gohelper.findChildText(content, "#text2/#txt_selectindex1")
	text.text = str

	local next_config = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), curLayer + 1)

	gohelper.setActive(gohelper.findChild(content, "#text3"), next_config)

	str = string.format("%02d", curLayer + 1)
	text = gohelper.findChildText(content, "#text3/#txt_passindex1")
	text.text = str

	local maxlayer = gohelper.findChild(content, "maxlayer")

	gohelper.setActive(maxlayer, not next_config)
	gohelper.setActive(gohelper.findChild(content, "seleted"), next_config)
end

function Season1_2SettlementView:_releaseAwardImage()
	if self._awardImage then
		for i, v in ipairs(self._awardImage) do
			v:UnLoadImage()
		end
	end

	if self._awardClick then
		for i, v in ipairs(self._awardClick) do
			v:RemoveClickListener()
		end
	end

	self._awardImage = self:getUserDataTb_()
	self._awardClick = self:getUserDataTb_()
end

function Season1_2SettlementView:_onAwardItemShow(obj, data, index)
	local image = gohelper.findChildSingleImage(obj, "simage_reward")
	local goHead = gohelper.findChild(obj, "#go_headiconpos")
	local imgHead = gohelper.findChildSingleImage(goHead, "#simage_headicon")
	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(data.materilType, data.materilId, true)

	if itemCfg.subType == ItemEnum.SubType.Portrait then
		gohelper.setActive(goHead, true)
		gohelper.setActive(image.gameObject, false)
		imgHead:LoadImage(iconPath)
	else
		gohelper.setActive(goHead, false)
		gohelper.setActive(image.gameObject, true)
		image:LoadImage(iconPath)
	end

	table.insert(self._awardImage, imgHead)
	table.insert(self._awardImage, image)

	local txt_rewardcount = gohelper.findChildText(obj, "txt_rewardcount")

	txt_rewardcount.text = luaLang("multiple") .. data.quantity

	local image_bg = gohelper.findChildImage(obj, "image_bg")

	if not itemCfg.rare then
		UISpriteSetMgr.instance:setSeasonSprite(image_bg, "img_pz_" .. itemCfg.rare, true)

		local image_circle = gohelper.findChildImage(obj, "image_circle")

		UISpriteSetMgr.instance:setSeasonSprite(image_circle, "bg_pinjidi_lanse_" .. itemCfg.rare)

		local click = gohelper.findChildClick(obj, "btnClick")

		click:AddClickListener(self._onAwardItemClick, self, data)
		table.insert(self._awardClick, click)

		if data.materilType == MaterialEnum.MaterialType.EquipCard then
			local cardItem = Season1_2CelebrityCardItem.New()

			cardItem:init(gohelper.findChild(obj, "cardicon"), data.materilId)

			self._equipAwardCards = self._equipAwardCards or {}

			table.insert(self._equipAwardCards, cardItem)
			gohelper.setActive(gohelper.findChild(obj, "image_circle"), false)
			gohelper.setActive(gohelper.findChild(obj, "simage_reward"), false)
			gohelper.setActive(gohelper.findChild(obj, "image_bg"), false)
		end
	end
end

function Season1_2SettlementView:_onAwardItemClick(data)
	MaterialTipController.instance:showMaterialInfo(data.materilType, data.materilId)
end

function Season1_2SettlementView:onClose()
	if self._equipAwardCards then
		for i, v in ipairs(self._equipAwardCards) do
			v:destroy()
		end

		self._equipAwardCards = nil
	end

	if self._showTipsFlow then
		self._showTipsFlow:stop()

		self._showTipsFlow = nil
	end

	TaskDispatcher.cancelTask(self._showHeroItem, self)
	TaskDispatcher.cancelTask(self._dailyShowHero, self)
	TaskDispatcher.cancelTask(self._showGetCardView, self)
	TaskDispatcher.cancelTask(self._btnclosetipOnClick, self)
	self._simagedecorate6:UnLoadImage()
	self._simagedecorate10:UnLoadImage()
	self._simagefightsuccbg:UnLoadImage()
	self._simageherodecorate:UnLoadImage()
	self._simagespecialbg:UnLoadImage()

	if FightResultModel.instance.canUpdateDungeonRecord and not self._hasSendCoverRecord then
		DungeonRpc.instance:sendCoverDungeonRecordRequest(false)
	end

	self:_releaseAwardImage()
end

return Season1_2SettlementView
