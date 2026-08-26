-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9SettlementView.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9SettlementView", package.seeall)

local Season123_1_9SettlementView = class("Season123_1_9SettlementView", BaseViewExtended)

function Season123_1_9SettlementView:onInitView()
	self._gosettlement = gohelper.findChild(self.viewGO, "#go_settlement")
	self._gospecialmarket = gohelper.findChild(self.viewGO, "#go_settlement/#go_specialmarket")
	self._simagespecialbg = gohelper.findChildSingleImage(self.viewGO, "#go_settlement/#go_specialmarket/#simage_specialbg")
	self._animationEvent = self._gosettlement:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_settlement/#btn_close")
	self._simagedecorate6 = gohelper.findChildSingleImage(self.viewGO, "#go_settlement/decorate/mask/#simage_decorate6")
	self._simagedecorate10 = gohelper.findChildSingleImage(self.viewGO, "#go_settlement/decorate/mask/#simage_decorate10")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_settlement/left/#simage_circlebg/#txt_index")
	self._txtlevelnamecn = gohelper.findChildText(self.viewGO, "#go_settlement/left/#txt_levelnamecn")
	self._simageherodecorate = gohelper.findChildSingleImage(self.viewGO, "#go_settlement/right/herocard/#simage_herodecorate")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards/mask/#scroll_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._gohero1 = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero1")
	self._gohero2 = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero2")
	self._gohero3 = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero3")
	self._gohero4 = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero4")
	self._gosupercard1 = gohelper.findChild(self.viewGO, "#go_settlement/right/herocard/#go_supercard1")
	self._gosupercard2 = gohelper.findChild(self.viewGO, "#go_settlement/right/herocard/#go_supercard2")
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
	self._gofriendpart = gohelper.findChild(self.viewGO, "#go_settlement/#go_cover_friend_part")
	self._txtfriendtip = gohelper.findChildText(self.viewGO, "#go_settlement/#go_cover_friend_part/tipbg/container/#txt_tips")
	self._btnconfirmfriend = gohelper.findChildButtonWithAudio(self.viewGO, "#go_settlement/#go_cover_friend_part/#btn_cover_friend")
	self._gobottom = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_bottom")
	self._gospace = gohelper.findChild(self.viewGO, "#go_settlement/right/layout/#go_space")
	self._btnstat = gohelper.findChildButtonWithAudio(self.viewGO, "#go_settlement/right/layout/middle/#btn_stat")
	self._totalTime = gohelper.findChildText(self.viewGO, "#go_settlement/right/layout/#go_bottom/totaltime/#go_bestcircle/#txt_time")
	self._totalTimeBlue = gohelper.findChildText(self.viewGO, "#go_settlement/right/layout/#go_bottom/totaltime/#go_bestcircle/#txt_timeblue")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_9SettlementView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnstat:AddClickListener(self._btnstatOnClick, self)
	self.addClickCb(self, self._btncoverrecord, self._onBtnCoverRecordClick, self)
	self.addClickCb(self, self._btnconfirmfriend, self._onBtnConfirmFriendClick, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, self._onCoverDungeonRecordReply, self)
	FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
	self._animationEvent:AddEventListener("reward", self._onRewardShow, self)
end

function Season123_1_9SettlementView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnstat:RemoveClickListener()
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
	self._animationEvent:RemoveEventListener("reward")
end

function Season123_1_9SettlementView:_btnstatOnClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function Season123_1_9SettlementView:_showSettlement()
	self._startTime = Time.realtimeSinceStartup

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_clearing)
	gohelper.setActive(self._gosettlement, true)
	gohelper.setActive(self._gospecialmarket, true)
	self:_checkNewRecord()
	self:_detectCoverRecord()
	self:_detectAddFriend()
	TaskDispatcher.runDelay(self._dailyShowHero, self, 0.6)
end

function Season123_1_9SettlementView:_onRewardShow()
	self:_showSettlementReward()
end

function Season123_1_9SettlementView:_dailyShowHero()
	self._heroIndex = 0

	TaskDispatcher.runRepeat(self._showHeroItem, self, 0.03, #self._heroList)
	TaskDispatcher.runDelay(self._showGetCardView, self, 1.5)
end

function Season123_1_9SettlementView:_showHeroItem()
	self._heroIndex = self._heroIndex + 1

	gohelper.setActive(self._heroList[self._heroIndex].viewGO, true)
end

function Season123_1_9SettlementView:_showGetCardView()
	if self.equip_cards then
		self._showTipsFlow = FlowSequence.New()

		self._showTipsFlow:addWork(Season123_1_9SettlementTipsWork.New())
		self._showTipsFlow:registerDoneListener(self._onShowTipsFlowDone, self)

		local data = {}

		data.delayTime = 0

		self._showTipsFlow:start(data)
	end
end

function Season123_1_9SettlementView:_onShowTipsFlowDone()
	self.equip_cards = nil
end

function Season123_1_9SettlementView:_checkNewRecord()
	if FightResultModel.instance.updateDungeonRecord then
		GameFacade.showToast(ToastEnum.FightNewRecord)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	end
end

function Season123_1_9SettlementView:_onCoverDungeonRecordReply(isCover)
	self._hasSendCoverRecord = true

	gohelper.setActive(self._gocoverrecordpart, false)

	if isCover then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
		GameFacade.showToast(ToastEnum.FightSuccIsCover)
	end
end

function Season123_1_9SettlementView:_detectCoverRecord()
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

function Season123_1_9SettlementView:_onBtnCoverRecordClick()
	DungeonRpc.instance:sendCoverDungeonRecordRequest(true)
end

function Season123_1_9SettlementView:_detectAddFriend()
	if not FightResultModel.instance.assistUserId then
		local assistUserId = 0
		local numAssistUserId = tonumber(assistUserId)
		local battleContext = Season123Model.instance:getBattleContext()

		if battleContext then
			if not battleContext.actId then
				local actId

				if battleContext then
					if not battleContext.stage then
						local stage
						local isShowAddFriend = not ((numAssistUserId ~= 0 or nil) and SocialModel.instance:isMyFriendByUserId(assistUserId)) and (actId and stage or nil) and Season123ProgressUtils.checkStageIsFinish(actId, stage)

						if isShowAddFriend then
							if not FightResultModel.instance.assistNickname then
								self._txtfriendtip.text = formatLuaLang("season123_add_assist_friend", FightResultModel.instance.assistNickname)
							end
						end

						gohelper.setActive(self._gofriendpart, isShowAddFriend)
					end
				end
			end
		end
	end
end

function Season123_1_9SettlementView:_onBtnConfirmFriendClick()
	if not FightResultModel.instance.assistUserId then
		local assistUserId = 0

		if assistUserId ~= 0 then
			local result = SocialController.instance:AddFriend(assistUserId, self._onAddAssistFriendReply, self)

			if not result then
				self:_onAddAssistFriendReply()
			end
		end
	end
end

function Season123_1_9SettlementView:_onAddAssistFriendReply()
	gohelper.setActive(self._gofriendpart, false)
end

function Season123_1_9SettlementView:_editableInitView()
	self._simagedecorate10:LoadImage(ResUrl.getSeasonIcon("img_circle.png"))
	self._simagefightsuccbg:LoadImage(ResUrl.getSeasonIcon("full/diejia_bj.png"))
	self._simageherodecorate:LoadImage(ResUrl.getSeasonIcon("jiesuan_zhujue.png"))
	self._simagespecialbg:LoadImage(ResUrl.getSeasonIcon("full/img_bg3.png"))

	self._gocardempty1 = gohelper.findChild(self._gosupercard1, "#go_supercardempty")
	self._gocardpos1 = gohelper.findChild(self._gosupercard1, "#go_supercardpos")
	self._gocardempty2 = gohelper.findChild(self._gosupercard2, "#go_supercardempty")
	self._gocardpos2 = gohelper.findChild(self._gosupercard2, "#go_supercardpos")

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_succeed)
	gohelper.setActive(self._gofightsucc, true)
	gohelper.setActive(self._gosettlement, false)

	self._fightsucc_click = gohelper.getClick(self._gofightsucc)
end

function Season123_1_9SettlementView:_btncloseOnClick()
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

function Season123_1_9SettlementView:onOpen()
	self._startTime = Time.realtimeSinceStartup
	self._episode_config = lua_episode.configDict[FightResultModel.instance:getEpisodeId()]
	self._battleContext = Season123Model.instance:getBattleContext()

	if not self._battleContext.layer then
		self._config = Season123Config.instance:getSeasonEpisodeCo(Season123Model.instance:getCurSeasonId(), self._battleContext.stage, self._battleContext.layer)

		local urlStr = Season123ProgressUtils.getResultBg(self._config.stagePicture)

		if not string.nilorempty(urlStr) then
			self._simagedecorate6:LoadImage(urlStr)
		end

		self._txtindex.text = string.format("%02d", self._battleContext.layer)
		self._txtlevelnamecn.text = self._episode_config.name

		Season123Controller.instance:checkAndHandleEffectEquip({
			actId = Season123Model.instance:getCurSeasonId(),
			stage = self._battleContext.stage,
			layer = self._battleContext.layer
		})
		self:_refreshRound()

		local reward_list = {}

		tabletool.addValues(reward_list, FightResultModel.instance:getFirstMaterialDataList())
		tabletool.addValues(reward_list, FightResultModel.instance:getExtraMaterialDataList())
		tabletool.addValues(reward_list, FightResultModel.instance:getMaterialDataList())

		if #reward_list == 0 then
			reward_list = self:getCurEpisodeRewards()
		end

		local equip_cards = {}

		for i = #reward_list, 1, -1 do
			local data = reward_list[i]

			if data.materilType == MaterialEnum.MaterialType.Season123EquipCard then
				table.insert(equip_cards, data.materilId)
			end
		end

		self:_onHeroItemLoaded()

		if #equip_cards > 0 then
			self.equip_cards = equip_cards
		end

		self.reward_list = reward_list

		TaskDispatcher.runDelay(self._delayClosetip, self, 1.5)

		if #reward_list == 0 then
			if FightResultModel.instance.firstPass then
				logError("服务器没有下发奖励")
			end

			gohelper.setActive(self._gorewards, false)
		end

		gohelper.setActive(self._gobottom, #reward_list > 0)

		self._reward_list = reward_list

		local animComp = CameraMgr.instance:getCameraRootAnimator()

		animComp.enabled = false

		NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)
	end
end

function Season123_1_9SettlementView:_refreshRound()
	local seasonMO = Season123Model.instance:getActInfo(self._battleContext.actId)

	if not seasonMO then
		return
	end

	if self._battleContext.stage and self._battleContext.layer then
		local stageMO = seasonMO:getStageMO(self._battleContext.stage)

		if not stageMO then
			return
		end

		local episodeMO = stageMO.episodeMap[self._battleContext.layer]

		if episodeMO and episodeMO.round then
			local totalTimeStr = tostring(episodeMO.round)
			local actId = self._battleContext.actId
			local stage = self._battleContext.stage
			local layer = self._battleContext.layer
			local isReduceRound = Season123Controller.instance:isReduceRound(actId, stage, layer)
			local passRoundFormat = isReduceRound and "<color=#eecd8c>%s</color>" or "%s"

			self._totalTime.text = string.format(passRoundFormat, totalTimeStr)
			self._totalTimeBlue.text = totalTimeStr
		end
	end
end

function Season123_1_9SettlementView:_showSettlementReward()
	local parent_root = gohelper.findChild(self._scrollrewards.gameObject, "Viewport/Content")

	gohelper.addChild(self.viewGO, self._gorewarditem)
	self:com_createObjList(self._onRewardItemShow, self.reward_list, parent_root, self._gorewarditem, nil, 0.1)
end

function Season123_1_9SettlementView:_onRewardItemShow(obj, data, index)
	local itemIconGO = gohelper.findChild(obj, "go_prop")
	local receiveGO = gohelper.findChild(obj, "go_receive")

	if data.materilType == MaterialEnum.MaterialType.Season123EquipCard then
		local cardItem = Season123_1_9CelebrityCardItem.New()

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
		itemIcon:_setItem()

		local hasGetReward = not FightResultModel.instance.firstPass
		local color = hasGetReward and "#7b7b7b" or "#ffffff"

		itemIcon:setItemColor(color)
		gohelper.setActive(receiveGO, hasGetReward)
	end
end

function Season123_1_9SettlementView:getCurEpisodeRewards()
	local actId = self._battleContext.actId
	local stage = self._battleContext.stage
	local layer = self._battleContext.layer
	local episodeCo = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer)

	if not episodeCo then
		return nil
	end

	local rewardDataTab = {}
	local rewards = DungeonModel.instance:getEpisodeFirstBonus(episodeCo.episodeId)
	local bonusTag = FightEnum.FightBonusTag.AdditionBonus

	for index, rewardItemData in ipairs(rewards) do
		local bonus = {
			materilType = rewardItemData[1],
			materilId = rewardItemData[2],
			quantity = rewardItemData[3]
		}

		if bonus.materilType ~= MaterialEnum.MaterialType.Faith and bonus.materilType ~= MaterialEnum.MaterialType.Exp then
			local materialDataMO = MaterialDataMO.New()

			materialDataMO.bonusTag = bonusTag

			materialDataMO:init(bonus)
			table.insert(rewardDataTab, materialDataMO)
		end
	end

	table.sort(rewardDataTab, FightResultModel._sortMaterial)

	return rewardDataTab
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

function Season123_1_9SettlementView:_onHeroItemLoaded()
	self._heroList = {}
	self._hero_obj_list = self:getUserDataTb_()

	local setting = self.viewContainer:getSetting()
	local resPath = setting.otherRes.itemRes

	for i = 1, 4 do
		local hero_item = self.viewContainer:getResInst(resPath, self["_gohero" .. i])

		gohelper.setActive(hero_item, false)
		table.insert(self._hero_obj_list, hero_item)
	end

	gohelper.setActive(self._gosupercard1, false)
	gohelper.setActive(self._gosupercard2, false)

	local fight_param = FightModel.instance:getFightParam()
	local battleId = FightModel.instance:getBattleId()
	local battleCO = battleId and lua_battle.configDict[battleId]

	if battleCO then
		if not battleCO.playerMax then
			local playerMax = ModuleEnum.HeroCountInGroup
			local is_replay = FightModel.instance.curFightModel

			if not is_replay then
				local trailDict = {}
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

				local equip123_dic = {}

				for i, v in ipairs(fight_param.activity104Equips) do
					equip123_dic[v.heroUid] = v
				end

				if fight_param.trialHeroList then
					for i, v in ipairs(fight_param.trialHeroList) do
						local pos = v.pos

						if pos < 0 then
							pos = playerMax - pos
						end

						trailDict[pos] = v

						table.insert(hero_list, pos, 0)
					end
				end

				for i = 1, 4 do
					if trailDict[i] then
						local trialCo = lua_hero_trial.configDict[trailDict[i].trialId][0]

						if trialCo then
							local hero_uid = tostring(trialCo.heroId - 1099511627776)
							local equip = trailDict[i].equipUid

							if equip123_dic[hero_uid] then
								local equip_104 = equip123_dic[hero_uid].equipUid
								local heroItem = self:openSubView(Season123_1_9SettlementHeroItem, self._hero_obj_list[i], nil, is_replay, nil, equip, equip_104, nil, trailDict[i])

								table.insert(self._heroList, heroItem)
							end
						end
					else
						local hero_uid = hero_list[i]
						local equip = true

						goto label_27_0

						do
							local var_27_3
						end

						::label_27_0::

						var_27_3 = hero_uid ~= "0" and equip123_dic[hero_uid] and equip123_dic[hero_uid].equipUid or false

						local equip_104 = true

						goto label_27_1

						::label_27_1::

						local heroItem = self:openSubView(Season123_1_9SettlementHeroItem, self._hero_obj_list[i], nil, is_replay, hero_uid, equip, equip_104)

						if hero_uid ~= "0" then
							table.insert(self._heroList, heroItem)
						end
					end
				end

				self:_refreshHeroItemPos()

				local character_uid = "-100000"

				if equip123_dic[character_uid] then
					local mainCardUids = equip123_dic[character_uid].equipUid

					if mainCardUids then
						self:setMainPosCardItemByUid(1, mainCardUids[1])
						self:setMainPosCardItemByUid(2, mainCardUids[2])
					end
				end
			else
				FightRpc.instance:sendGetFightRecordGroupRequest(fight_param.episodeId)
			end
		end
	end
end

function Season123_1_9SettlementView:setMainPosCardItemByUid(index, equipUid)
	local goParent = self["_gosupercard" .. tostring(index)]
	local actId = self._battleContext.actId
	local seasonMO = Season123Model.instance:getActInfo(actId)
	local slotIndex = Season123Model.instance:getUnlockCardIndex(Activity123Enum.MainCharPos, index)

	if not seasonMO.unlockIndexSet[slotIndex] then
		gohelper.setActive(goParent, false)
	else
		gohelper.setActive(goParent, true)

		local goEmpty = self["_gocardempty" .. tostring(index)]
		local goPos = self["_gocardpos" .. tostring(index)]

		if equipUid and equipUid ~= "0" then
			gohelper.setActive(goEmpty, false)
			gohelper.setActive(goPos, true)
			self:openSubView(Season123_1_9CelebrityCardGetItem, Season123_1_9CelebrityCardItem.AssetPath, goPos, equipUid, true)
		else
			gohelper.setActive(goEmpty, true)
			gohelper.setActive(goPos, false)
		end
	end
end

function Season123_1_9SettlementView:_refreshHeroItemPos()
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

function Season123_1_9SettlementView:_onGetFightRecordGroupReply(fightGroupMO)
	for i = 1, 4 do
		local obj = self._hero_obj_list[i]
		local hero = fightGroupMO:getHeroByIndex(i)
		local equip = fightGroupMO.replay_equip_data[hero]
		local equip_104 = fightGroupMO.replay_activity104Equip_data[hero]
		local replay_data = fightGroupMO.replay_hero_data[hero]

		if not replay_data then
			for _, v in pairs(fightGroupMO.replay_hero_data) do
				if v.heroId == hero then
					replay_data = v

					break
				end
			end
		end

		local heroItem = self:openSubView(Season123_1_9SettlementHeroItem, obj, nil, true, hero, equip, equip_104, replay_data)

		if hero ~= "0" then
			table.insert(self._heroList, heroItem)
		end
	end

	self:_refreshHeroItemPos()

	local character_uid = "-100000"

	if fightGroupMO.replay_activity104Equip_data[character_uid] then
		local mainEquip1 = fightGroupMO.replay_activity104Equip_data[character_uid][1]
		local mainEquip2 = fightGroupMO.replay_activity104Equip_data[character_uid][2]

		self:setMainPosCardItemById(1, mainEquip1)
		self:setMainPosCardItemById(2, mainEquip2)
	end
end

function Season123_1_9SettlementView:setMainPosCardItemById(index, mainEquip)
	local equipId

	if mainEquip then
		equipId = mainEquip.equipId
	end

	local goParent = self["_gosupercard" .. tostring(index)]
	local actId = self._battleContext.actId
	local seasonMO = Season123Model.instance:getActInfo(actId)
	local slotIndex = Season123Model.instance:getUnlockCardIndex(Activity123Enum.MainCharPos, index)

	if not seasonMO.unlockIndexSet[slotIndex] then
		gohelper.setActive(goParent, false)
	else
		gohelper.setActive(goParent, true)

		local goEmpty = self["_gocardempty" .. tostring(index)]
		local goPos = self["_gocardpos" .. tostring(index)]

		if equipId and equipId ~= 0 then
			gohelper.setActive(goEmpty, false)
			gohelper.setActive(goPos, true)
			self:openSubView(Season123_1_9CelebrityCardGetItem, Season123_1_9CelebrityCardItem.AssetPath, goPos, nil, nil, equipId)
		else
			gohelper.setActive(goEmpty, true)
			gohelper.setActive(goPos, false)
		end
	end
end

function Season123_1_9SettlementView:_delayClosetip()
	gohelper.setActive(self._gofightsucc, false)
	self:_showSettlement()
end

function Season123_1_9SettlementView:onClose()
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
	TaskDispatcher.cancelTask(self._delayClosetip, self)
	self._simagedecorate6:UnLoadImage()
	self._simagedecorate10:UnLoadImage()
	self._simagefightsuccbg:UnLoadImage()
	self._simageherodecorate:UnLoadImage()
	self._simagespecialbg:UnLoadImage()

	if FightResultModel.instance.canUpdateDungeonRecord and not self._hasSendCoverRecord then
		DungeonRpc.instance:sendCoverDungeonRecordRequest(false)
	end
end

return Season123_1_9SettlementView
