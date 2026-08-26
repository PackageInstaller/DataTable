-- chunkname: @modules/logic/seasonver/act166/view/Season166ResultView.lua

module("modules.logic.seasonver.act166.view.Season166ResultView", package.seeall)

local Season166ResultView = class("Season166ResultView", BaseView)

function Season166ResultView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._goBaseInfo = gohelper.findChild(self.viewGO, "Left/#go_BaseInfo")
	self._simageBase = gohelper.findChildSingleImage(self.viewGO, "Left/#go_BaseInfo/#simage_Base")
	self._txtBase = gohelper.findChildText(self.viewGO, "Left/#go_BaseInfo/#txt_Base")
	self._imageStar1 = gohelper.findChildImage(self.viewGO, "Left/#go_BaseInfo/Star/star1/#image_Star1")
	self._imageStar2 = gohelper.findChildImage(self.viewGO, "Left/#go_BaseInfo/Star/star2/#image_Star2")
	self._imageStar3 = gohelper.findChildImage(self.viewGO, "Left/#go_BaseInfo/Star/star3/#image_Star3")
	self._txtScore = gohelper.findChildText(self.viewGO, "Left/#go_BaseInfo/Score/#txt_Score")
	self._goNewRecord = gohelper.findChild(self.viewGO, "Left/#go_BaseInfo/Score/#go_NewRecord")
	self._txtNewRecord = gohelper.findChildText(self.viewGO, "Left/#go_BaseInfo/Score/#go_NewRecord/#txt_NewRecord")
	self._goTrainInfo = gohelper.findChild(self.viewGO, "Left/#go_TrainInfo")
	self._txtTrain = gohelper.findChildText(self.viewGO, "Left/#go_TrainInfo/#txt_Train")
	self._goEpisode1 = gohelper.findChild(self.viewGO, "Left/#go_TrainInfo/Episode/Episode1/#go_Episode1")
	self._goEpisode2 = gohelper.findChild(self.viewGO, "Left/#go_TrainInfo/Episode/Episode2/#go_Episode2")
	self._goEpisode3 = gohelper.findChild(self.viewGO, "Left/#go_TrainInfo/Episode/Episode3/#go_Episode3")
	self._goEpisode4 = gohelper.findChild(self.viewGO, "Left/#go_TrainInfo/Episode/Episode4/#go_Episode4")
	self._goEpisode5 = gohelper.findChild(self.viewGO, "Left/#go_TrainInfo/Episode/Episode5/#go_Episode5")
	self._goEpisode6 = gohelper.findChild(self.viewGO, "Left/#go_TrainInfo/Episode/Episode6/#go_Episode6")
	self._simagePlayerHead = gohelper.findChildSingleImage(self.viewGO, "Left/Player/PlayerHead/#simage_PlayerHead")
	self._txtPlayerName = gohelper.findChildText(self.viewGO, "Left/Player/#txt_PlayerName")
	self._txtTime = gohelper.findChildText(self.viewGO, "Left/Player/#txt_Time")
	self._gostarList = gohelper.findChild(self.viewGO, "Right/heroitem/heroitemani/hero/vertical/#go_starList")
	self._imagetalent = gohelper.findChildImage(self.viewGO, "Right/TalentTree/#image_talent")
	self._gotalentReddot = gohelper.findChild(self.viewGO, "Right/TalentTree/#go_talentReddot")
	self._goReward = gohelper.findChild(self.viewGO, "Right/#go_Reward")
	self._goRewardRoot = gohelper.findChild(self.viewGO, "Right/#go_Reward/#go_RewardRoot")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "BtnGroup/#btn_close")
	self._btnRank = gohelper.findChildButtonWithAudio(self.viewGO, "BtnGroup/#btn_Rank")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166ResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnRank:AddClickListener(self._btnRankOnClick, self)
end

function Season166ResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnRank:RemoveClickListener()
end

local url = "singlebg/seasonver/result/%s.png"

function Season166ResultView:_btncloseOnClick()
	self:closeThis()
end

function Season166ResultView:_btnRankOnClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function Season166ResultView:_editableInitView()
	self.heroItemList = {}
end

function Season166ResultView:onUpdateParam()
	return
end

function Season166ResultView:onOpen()
	self.result = Season166Model.instance:getFightResult()

	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	self:_initPlayerInfo()
	self:_initHeroGroup()
	self:_refreshReward()
	self:_initTalentInfo()

	if episode_config.type == DungeonEnum.EpisodeType.Season166Base then
		gohelper.setActive(self._goTrainInfo, false)
		self:_refreshBaseInfo()
		gohelper.setActive(self._goBaseInfo, true)
	else
		gohelper.setActive(self._goBaseInfo, false)
		self:_refreshTrainInfo()
		gohelper.setActive(self._goTrainInfo, true)
	end
end

function Season166ResultView:onClose()
	Season166Model.instance:clearFightResult()
	FightController.onResultViewClose()
end

function Season166ResultView:onDestroyView()
	return
end

function Season166ResultView:_refreshBaseInfo()
	local baseCfg = Season166Config.instance:getSeasonBaseSpotCo(self.result.activityId, self.result.id)

	self._txtBase.text = GameUtil.setFirstStrSize(baseCfg.name, 81)

	local resPath = string.format(url, "season166_result_level" .. baseCfg.baseId)

	self._simageBase:LoadImage(resPath)

	local scoreLevelCfg = Season166BaseSpotModel.instance:getScoreLevelCfg(self.result.activityId, self.result.id, self.result.totalScore)

	if scoreLevelCfg then
		if not scoreLevelCfg.star then
			local starCnt = 0

			for i = 1, 3 do
				local key = "_imageStar" .. i

				gohelper.setActive(self[key], i <= starCnt)

				if scoreLevelCfg and scoreLevelCfg.level == 4 then
					UISpriteSetMgr.instance:setSeason166Sprite(self[key], "season166_result_bulb3")
				end
			end

			gohelper.setActive(self._goNewRecord, self.result.isHighestScore)

			self._txtScore.text = self.result.totalScore
		end
	end
end

function Season166ResultView:_refreshTrainInfo()
	local trainCfgList = Season166Config.instance:getSeasonTrainCos(self.result.activityId)

	for i = 1, 6 do
		local trainCfg = trainCfgList[i]

		if trainCfg then
			local isPass

			if trainCfg.trainId == self.result.id then
				self._txtTrain.text = GameUtil.setFirstStrSize(trainCfg.name, 98)
				isPass = true
			else
				isPass = Season166Model.instance:isTrainPass(self.result.activityId, trainCfg.trainId)
			end

			gohelper.setActive(self["_goEpisode" .. i], isPass)
		end
	end
end

function Season166ResultView:_refreshReward()
	local itemRoot = gohelper.findChild(self.viewGO, "Right/#go_Reward/#go_RewardRoot/item")
	local dataList = FightResultModel.instance:getMaterialDataList()

	if #dataList > 0 then
		for i = 1, #dataList do
			local parent = gohelper.clone(itemRoot, self._goRewardRoot, "item" .. i)
			local data = dataList[i]
			local item = IconMgr.instance:getCommonItemIcon(parent)

			item:setMOValue(data.materilType, data.materilId, data.quantity)
			item:setScale(0.8)
			recthelper.setAnchorY(item.tr, 10)
			gohelper.setActive(parent, true)
		end

		gohelper.setActive(self._goReward, true)
	else
		gohelper.setActive(self._goReward, false)
	end
end

function Season166ResultView:_initPlayerInfo()
	local playerInfo = PlayerModel.instance:getPlayinfo()
	local portrait = playerInfo.portrait

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simagePlayerHead)

	self._liveHeadIcon:setLiveHead(portrait)

	self._txtTime.text = TimeUtil.getServerDateToString()
	self._txtPlayerName.text = playerInfo.name
end

function Season166ResultView:_initHeroGroup()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

	local heroItem = gohelper.findChild(self.viewGO, "Right/heroitem")
	local group1 = gohelper.findChild(self.viewGO, "Right/Group1")
	local group2 = gohelper.findChild(self.viewGO, "Right/Group2")

	for i = 1, 8 do
		local parent = i < 5 and group1 or group2
		local itemGo = gohelper.clone(heroItem, parent)

		self.heroItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, Season166ResultHeroItem)

		gohelper.setActive(itemGo, true)
	end

	self:_refreshHeroGroup()
end

function Season166ResultView:_refreshHeroGroup()
	local fightParam = FightModel.instance:getFightParam()
	local heroEquipList, subHeroEquipList = fightParam:getHeroEquipMoListWithTrial()

	for i = 1, 4 do
		local heroItem = self.heroItemList[i]
		local mo = heroEquipList[i]

		if mo then
			heroItem:setData(mo.heroMo, mo.equipMo)
		end

		local subHeroItem = self.heroItemList[i + 4]
		local subMo = subHeroEquipList[i]

		if subMo then
			subHeroItem:setData(subMo.heroMo, subMo.equipMo)
		end
	end
end

function Season166ResultView:_initTalentInfo()
	local context = Season166Model.instance:getBattleContext()

	if context then
		local actId = Season166Model.instance:getCurSeasonId()
		local talentId = context.talentId
		local talentInfo = Season166Model.instance:getTalentInfo(actId, talentId)
		local talentCfg = lua_activity166_talent.configDict[actId][talentId]
		local talentStyleCfg = lua_activity166_talent_style.configDict[talentId][talentInfo.level]
		local name = "season166_talentree_btn_talen" .. talentCfg.sortIndex

		UISpriteSetMgr.instance:setSeason166Sprite(self._imagetalent, name)

		for i = 1, 3 do
			local slot = gohelper.findChild(self.viewGO, "Right/TalentTree/equipslot/" .. i)
			local imageSlot = gohelper.findChildImage(self.viewGO, "Right/TalentTree/equipslot/" .. i .. "/light")

			UISpriteSetMgr.instance:setSeason166Sprite(imageSlot, "season166_talentree_pointl" .. tostring(talentCfg.sortIndex))
			gohelper.setActive(slot, i <= talentStyleCfg.slot)
			gohelper.setActive(imageSlot, i <= #talentInfo.skillIds)

			local effectGo = gohelper.findChild(slot, "light/" .. talentCfg.sortIndex)

			gohelper.setActive(effectGo, i <= #talentInfo.skillIds)
		end
	end
end

return Season166ResultView
