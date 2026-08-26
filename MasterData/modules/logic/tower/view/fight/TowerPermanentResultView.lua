-- chunkname: @modules/logic/tower/view/fight/TowerPermanentResultView.lua

module("modules.logic.tower.view.fight.TowerPermanentResultView", package.seeall)

local TowerPermanentResultView = class("TowerPermanentResultView", BaseView)

function TowerPermanentResultView:onInitView()
	self._click = gohelper.getClick(self.viewGO)
	self.goFinish = gohelper.findChild(self.viewGO, "goFinish")
	self.goResult = gohelper.findChild(self.viewGO, "go_Result")
	self.goRewards = gohelper.findChild(self.viewGO, "go_Result/goReward")
	self.goReward = gohelper.findChild(self.viewGO, "go_Result/goReward/scroll_reward/Viewport/#go_rewards")
	self.btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "go_Result/#btn_Detail")
	self.goBossEmpty = gohelper.findChild(self.viewGO, "go_Result/goGroup/assistBoss/boss/#go_Empty")
	self.goBossRoot = gohelper.findChild(self.viewGO, "go_Result/goGroup/assistBoss/boss/root")
	self.simageBoss = gohelper.findChildSingleImage(self.viewGO, "go_Result/goGroup/assistBoss/boss/root/icon")
	self.txtBossName = gohelper.findChildTextMesh(self.viewGO, "go_Result/goGroup/assistBoss/boss/root/name")
	self.txtBossLev = gohelper.findChildTextMesh(self.viewGO, "go_Result/goGroup/assistBoss/boss/root/lev")
	self.imgBossCareer = gohelper.findChildImage(self.viewGO, "go_Result/goGroup/assistBoss/boss/root/career")
	self.goLimitDetail = gohelper.findChild(self.viewGO, "go_Result/LimitDetail")
	self.simageStageDetail = gohelper.findChildSingleImage(self.viewGO, "go_Result/LimitDetail/imgStage")
	self.simageWaveDetail = gohelper.findChildSingleImage(self.viewGO, "go_Result/LimitDetail/wavebg")
	self.txtTower = gohelper.findChildTextMesh(self.viewGO, "go_Result/LimitDetail/image_NameBG/txtTower")
	self.difficultyItems = self:getUserDataTb_()

	for i = 1, 3 do
		self.difficultyItems[i] = gohelper.findChild(self.viewGO, string.format("go_Result/LimitDetail/Difficulty/image_Difficulty%s", i))
	end

	self.txtScoreDetail = gohelper.findChildTextMesh(self.viewGO, "go_Result/LimitDetail/image_ScoreBG/#txt_Score")
	self.goPermanentDetail = gohelper.findChild(self.viewGO, "go_Result/PermanentDetail")
	self.imgStageDetail = gohelper.findChildImage(self.viewGO, "go_Result/PermanentDetail/imgStage")
	self.txtTowerPermanent = gohelper.findChildTextMesh(self.viewGO, "go_Result/PermanentDetail/image_NameBG/txtTower")
	self.goSchedule = gohelper.findChild(self.viewGO, "go_Result/PermanentDetail/LayoutGroup/Schedule")
	self.txtSchedule = gohelper.findChildTextMesh(self.viewGO, "go_Result/PermanentDetail/LayoutGroup/Schedule/image_ScheduleBG/txt_Schedule")
	self.goComplete = gohelper.findChild(self.viewGO, "go_Result/PermanentDetail/LayoutGroup/Complete")
	self.goEntry = gohelper.findChild(self.viewGO, "go_Entry")
	self.goEntryLimit = gohelper.findChild(self.viewGO, "go_Entry/#go_Limit")
	self.txtScore = gohelper.findChildTextMesh(self.viewGO, "go_Entry/#go_Limit/image_ScoreBG/#txt_Score")
	self.simageStageEntry = gohelper.findChildSingleImage(self.viewGO, "go_Entry/#go_Limit/imgStage")
	self.simageWaveEntry = gohelper.findChildSingleImage(self.viewGO, "go_Entry/#go_Limit/wavebg")
	self.goEntryPermanent = gohelper.findChild(self.viewGO, "go_Entry/#go_Permanent")
	self.imgStage = gohelper.findChildImage(self.viewGO, "go_Entry/#go_Permanent/imgStage")
	self.goScoreStar = gohelper.findChild(self.viewGO, "go_Result/LimitDetail/#go_scoreStar")
	self.goPointContent = gohelper.findChild(self.viewGO, "go_Result/LimitDetail/#go_scoreStar/#go_PointContent")
	self.goPointItem = gohelper.findChild(self.viewGO, "go_Result/LimitDetail/#go_scoreStar/#go_PointContent/#go_PointItem")

	gohelper.setActive(self.goFinish, false)
	gohelper.setActive(self.goEntry, false)
	gohelper.setActive(self.goResult, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerPermanentResultView:addEvents()
	self.addClickCb(self, self.btnDetail, self._onBtnRankClick, self)
	self.addClickCb(self, self._click, self._onClickClose, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function TowerPermanentResultView:removeEvents()
	self:removeClickCb(self.btnDetail)
	self:removeClickCb(self._click)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function TowerPermanentResultView:_editableInitView()
	return
end

function TowerPermanentResultView:_onClickClose()
	if not self.canClick then
		if self.popupFlow then
			local workList = self.popupFlow:getWorkList()
			local curWork = workList[self.popupFlow._curIndex]

			if curWork then
				curWork:onDone(true)
			end
		end

		return
	end

	self:closeThis()
end

function TowerPermanentResultView:_onBtnRankClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function TowerPermanentResultView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function TowerPermanentResultView:refreshParam()
	self.episodeId = DungeonModel.instance.curSendEpisodeId
	self.episodeConfig = DungeonConfig.instance:getEpisodeCO(self.episodeId)
	self.fightFinishParam = TowerModel.instance:getFightFinishParam()
	self.towerType = self.fightFinishParam.towerType
	self.towerId = self.fightFinishParam.towerId
	self.layerId = self.fightFinishParam.layerId
	self.score = self.fightFinishParam.score
	self.difficulty = self.fightFinishParam.difficulty
	self.bossLevel = self.fightFinishParam.bossLevel
	self.layer = self.fightFinishParam.layer
	self.isLimit = self.towerType == TowerEnum.TowerType.Limited
	self.layerConfig = self.isLimit and TowerConfig.instance:getLimitEpisodeConfig(self.layerId, self.difficulty) or TowerConfig.instance:getPermanentEpisodeCo(self.layerId)
end

function TowerPermanentResultView:refreshView()
	self:refreshEntry()
	self:refreshResult()

	local waitNamePlateToastList = AchievementToastModel.instance:getWaitNamePlateToastList()

	if not waitNamePlateToastList or #waitNamePlateToastList == 0 then
		self:startFlow()
	end
end

function TowerPermanentResultView:startFlow()
	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	self.popupFlow = FlowSequence.New()

	self.popupFlow:addWork(TowerBossResultShowFinishWork.New(self.goFinish, AudioEnum.Tower.play_ui_fight_explore))
	self.popupFlow:addWork(TowerBossResultShowFinishWork.New(self.goEntry, AudioEnum.Tower.play_ui_fight_ui_appear))
	self.popupFlow:addWork(TowerBossResultShowResultWork.New(self.goResult, AudioEnum.Tower.play_ui_fight_card_flip, self.onResultShowCallBack, self))
	self.popupFlow:registerDoneListener(self._onAllFinish, self)
	self.popupFlow:start()
end

function TowerPermanentResultView:onResultShowCallBack()
	if self._isComplete then
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_complete)
	end
end

function TowerPermanentResultView:refreshEntry()
	gohelper.setActive(self.goEntryPermanent, not self.isLimit)
	gohelper.setActive(self.goEntryLimit, self.isLimit)

	if self.isLimit then
		self.txtScore.text = tostring(self.score)

		self.simageStageEntry:LoadImage(string.format("singlebg/tower_singlebg/level/tower_level_stage_%s.png", self.layerConfig.entrance))
		self.simageWaveEntry:LoadImage(string.format("singlebg/tower_singlebg/level/tower_level_stage_%s_2.png", self.layerConfig.entrance))
	else
		local list = string.splitToNumber(self.layerConfig.episodeIds, "|")
		local index = tabletool.indexOf(list, self.episodeId)

		UISpriteSetMgr.instance:setTowerPermanentSprite(self.imgStage, string.format("towerpermanent_stage_%s_1", index))
	end
end

function TowerPermanentResultView:refreshResult()
	gohelper.setActive(self.goLimitDetail, self.isLimit)
	gohelper.setActive(self.goPermanentDetail, not self.isLimit)
	gohelper.setActive(self.goScoreStar, self.isLimit)

	if self.isLimit then
		self.txtScoreDetail.text = tostring(self.score)

		self.simageStageDetail:LoadImage(string.format("singlebg/tower_singlebg/level/tower_level_stage_%s.png", self.layerConfig.entrance))
		self.simageWaveDetail:LoadImage(string.format("singlebg/tower_singlebg/level/tower_level_stage_%s_2.png", self.layerConfig.entrance))

		self.txtTower.text = self.episodeConfig.name

		for i, v in ipairs(self.difficultyItems) do
			gohelper.setActive(v, i == self.difficulty)
		end

		local starLevel = TowerConfig.instance:getScoreToStarConfig(self.score)

		gohelper.setActive(self.goScoreStar, starLevel > 0)

		if starLevel > 0 then
			local starLevelList = {}

			for i = 1, starLevel do
				table.insert(starLevelList, i)
			end

			gohelper.CreateObjList(self, self.scoreStarShow, starLevelList, self.goPointContent, self.goPointItem)
		end
	else
		local list = string.splitToNumber(self.layerConfig.episodeIds, "|") or {}
		local index = tabletool.indexOf(list, self.episodeId)

		UISpriteSetMgr.instance:setTowerPermanentSprite(self.imgStageDetail, string.format("towerpermanent_stage_%s_1", index))

		self.txtTowerPermanent.text = self.episodeConfig.name

		local passCount = 0

		if self.layer and self.layer.episodeNOs then
			for i = 1, #self.layer.episodeNOs do
				local mo = self.layer.episodeNOs[i]

				if mo.status == 1 then
					passCount = passCount + 1
				end
			end
		end

		local episodeCount = #list
		local isComplete = episodeCount <= passCount

		self.txtSchedule.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerpermanentresultview_schedule"), passCount, episodeCount)

		gohelper.setActive(self.goSchedule, episodeCount > 1)

		self._isComplete = isComplete

		gohelper.setActive(self.goComplete, isComplete)
	end

	self:refreshHeroGroup()
	self:refreshRewards(self.goReward, self.goRewards)
end

function TowerPermanentResultView:scoreStarShow(obj, data, index)
	gohelper.setActive(obj, index <= data)
end

function TowerPermanentResultView:refreshRewards(goReward, goRewards)
	if self.rewardItems == nil then
		self.rewardItems = {}
	end

	local dataList = FightResultModel.instance:getMaterialDataList() or {}

	for i = 1, math.max(#self.rewardItems, #dataList) do
		local item = self.rewardItems[i]
		local data = dataList[i]

		if not item then
			item = IconMgr.instance:getCommonPropItemIcon(goReward)
			self.rewardItems[i] = item
		end

		gohelper.setActive(item.go, data ~= nil)

		if data then
			item:setMOValue(data.materilType, data.materilId, data.quantity)
			item:setScale(0.7)
			item:setCountTxtSize(51)
		end
	end

	gohelper.setActive(goRewards, #dataList ~= 0)
end

function TowerPermanentResultView:refreshHeroGroup()
	if self.heroItemList == nil then
		self.heroItemList = self:getUserDataTb_()
	end

	local fightParam = FightModel.instance:getFightParam()
	local heroEquipList = fightParam:getHeroEquipAndTrialMoList(true)

	for i = 1, 4 do
		local heroItem = self.heroItemList[i]

		if heroItem == nil then
			local go = gohelper.findChild(self.viewGO, string.format("go_Result/goGroup/Group/heroitem%s", i))

			heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, TowerBossResultHeroItem)
			self.heroItemList[i] = heroItem
		end

		local mo = heroEquipList[i]

		if mo then
			heroItem:setData(mo.heroMo, mo.equipMo)
		else
			heroItem:setData()
		end
	end

	local bossId = fightParam.assistBossId
	local bossConfig = TowerConfig.instance:getAssistBossConfig(bossId)
	local isEmpty = bossConfig == nil

	gohelper.setActive(self.goBossEmpty, isEmpty)
	gohelper.setActive(self.goBossRoot, not isEmpty)

	if not isEmpty then
		self.simageBoss:LoadImage(bossConfig.bossPic)

		self.txtBossName.text = bossConfig.name
		self.txtBossLev.text = tostring(self.bossLevel)

		UISpriteSetMgr.instance:setCommonSprite(self.imgBossCareer, string.format("lssx_%s", bossConfig.career))
	end
end

function TowerPermanentResultView:_onAllFinish()
	self.canClick = true
end

function TowerPermanentResultView:_onCloseViewFinish(viewName)
	if viewName == ViewName.AchievementNamePlateUnlockView then
		self:startFlow()
	end
end

function TowerPermanentResultView:onClose()
	FightController.onResultViewClose()
end

function TowerPermanentResultView:onDestroyView()
	self.simageBoss:UnLoadImage()
	self.simageWaveEntry:UnLoadImage()
	self.simageStageEntry:UnLoadImage()
	self.simageStageDetail:UnLoadImage()
	self.simageWaveDetail:UnLoadImage()

	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end
end

return TowerPermanentResultView
