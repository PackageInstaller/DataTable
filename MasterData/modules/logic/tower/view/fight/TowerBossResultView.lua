-- chunkname: @modules/logic/tower/view/fight/TowerBossResultView.lua

module("modules.logic.tower.view.fight.TowerBossResultView", package.seeall)

local TowerBossResultView = class("TowerBossResultView", BaseView)

function TowerBossResultView:onInitView()
	self._click = gohelper.getClick(self.viewGO)
	self.goFinish = gohelper.findChild(self.viewGO, "goFinish")
	self.goBossLevChange = gohelper.findChild(self.viewGO, "goBossLevChange")
	self.txtLev1 = gohelper.findChildTextMesh(self.goBossLevChange, "goLev/Lv1/txtLev1")
	self.txtLev2 = gohelper.findChildTextMesh(self.goBossLevChange, "goLev/Lv2/txtLev2")
	self.goResult = gohelper.findChild(self.viewGO, "goResult")
	self.goInfo = gohelper.findChild(self.goResult, "goInfo")
	self.txtLev = gohelper.findChildTextMesh(self.goInfo, "Lv/txtLev")
	self.goAttrItem = gohelper.findChild(self.goInfo, "attrInfo/attrItem")

	gohelper.setActive(self.goAttrItem, false)

	self.goTalentPoint = gohelper.findChild(self.goInfo, "attrInfo/talentPoint")
	self.txtTalentPoint = gohelper.findChildTextMesh(self.goTalentPoint, "value")
	self.goRewards = gohelper.findChild(self.goResult, "goReward")
	self.goReward = gohelper.findChild(self.goResult, "goReward/scroll_reward/Viewport/#go_rewards")
	self.goSpResult = gohelper.findChild(self.viewGO, "goSpResult")
	self.goHeroItem = gohelper.findChild(self.viewGO, "goSpResult/goGroup/Group/heroitem")
	self.simageSpBoss = gohelper.findChildSingleImage(self.viewGO, "goSpResult/goBoss/imgBoss")
	self.txtSpTower = gohelper.findChildTextMesh(self.viewGO, "goSpResult/goBoss/txtTower")
	self.txtSpIndex = gohelper.findChildTextMesh(self.viewGO, "goSpResult/goBoss/episodeItem/goOpen/txtCurEpisode")
	self.goEpisodeItem = gohelper.findChild(self.viewGO, "goSpResult/goBoss/episodeItem")
	self.goSpRewards = gohelper.findChild(self.viewGO, "goSpResult/goReward")
	self.goSpReward = gohelper.findChild(self.viewGO, "goSpResult/goReward/scroll_reward/Viewport/#go_rewards")
	self.btnRank = gohelper.findChildButtonWithAudio(self.viewGO, "goResult/#btn_Rank")
	self.btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "goSpResult/#btn_Detail")
	self.goBoss = gohelper.findChild(self.viewGO, "goBoss")
	self.simageBoss = gohelper.findChildSingleImage(self.viewGO, "goBoss/imgBoss")
	self.txtTower = gohelper.findChildTextMesh(self.goBoss, "txtTower")

	gohelper.setActive(self.goFinish, false)
	gohelper.setActive(self.goBossLevChange, false)
	gohelper.setActive(self.goResult, false)
	gohelper.setActive(self.goInfo, false)
	gohelper.setActive(self.goSpResult, false)
	gohelper.setActive(self.goBoss, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerBossResultView:addEvents()
	self.addClickCb(self, self.btnDetail, self._onBtnRankClick, self)
	self.addClickCb(self, self.btnRank, self._onBtnRankClick, self)
	self.addClickCb(self, self._click, self._onClickClose, self)
end

function TowerBossResultView:removeEvents()
	self:removeClickCb(self.btnDetail)
	self:removeClickCb(self.btnRank)
	self:removeClickCb(self._click)
end

function TowerBossResultView:_editableInitView()
	return
end

function TowerBossResultView:_onClickClose()
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

function TowerBossResultView:_onBtnRankClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function TowerBossResultView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function TowerBossResultView:refreshParam()
	self.episodeId = DungeonModel.instance.curSendEpisodeId
	self.episodeConfig = DungeonConfig.instance:getEpisodeCO(self.episodeId)
	self.fightFinishParam = TowerModel.instance:getFightFinishParam()
	self.towerType = self.fightFinishParam.towerType
	self.towerId = self.fightFinishParam.towerId
	self.layerId = self.fightFinishParam.layerId
	self.towerConfig = TowerConfig.instance:getBossTowerConfig(self.towerId)
	self.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(self.towerType)
	self.layerConfig = self.episodeMo:getEpisodeConfig(self.towerId, self.layerId)
	self.bossConfig = TowerConfig.instance:getAssistBossConfig(self.towerConfig.bossId)
	self.isTeach = self.towerType == TowerEnum.TowerType.Boss and self.layerId == 0
end

function TowerBossResultView:refreshView()
	self.txtTower.text = self.towerConfig.name

	self.simageBoss:LoadImage(self.bossConfig.bossPic)

	if self.layerConfig then
		local isSp = self.layerConfig.openRound > 0

		if isSp or self.isTeach then
			self:refreshSp()
		else
			self:refreshAttr()
		end

		self:refreshLev()

		local var_9_1

		if isSp or self.isTeach then
			var_9_1 = self.goSpReward or self.goReward

			local var_9_2

			if isSp or self.isTeach then
				var_9_2 = self.goSpRewards or self.goRewards
			end
		end

		self:refreshRewards(var_9_1, var_9_2)
		self:startFlow(isSp)
	end
end

function TowerBossResultView:startFlow(isSp)
	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	self.popupFlow = FlowSequence.New()

	self.popupFlow:addWork(TowerBossResultShowFinishWork.New(self.goFinish, AudioEnum.Tower.play_ui_fight_explore))
	self.popupFlow:addWork(TowerBossResultShowLevChangeWork.New(self.goBossLevChange, self.goBoss, self.isBossLevChange))
	self.popupFlow:addWork(TowerBossResultShowResultWork.New((isSp or self.isTeach or nil) and (self.goSpResult or self.goResult), AudioEnum.Tower.play_ui_fight_explore))
	self.popupFlow:registerDoneListener(self._onAllFinish, self)
	self.popupFlow:start()
end

function TowerBossResultView:refreshRewards(goReward, goRewards)
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

function TowerBossResultView:refreshLev()
	if self.isTeach then
		self.isBossLevChange = false

		return
	end

	local bossLev = self.layerConfig.bossLevel
	local preEpisodeConfig = self.episodeMo:getEpisodeConfig(self.towerId, self.layerConfig.preLayerId)

	if preEpisodeConfig then
		if not preEpisodeConfig.bossLevel then
			local preLev = 0

			self.isBossLevChange = bossLev ~= preLev

			if not self.isBossLevChange then
				return
			end

			self.txtLev1.text = tostring(preLev)
			self.txtLev2.text = tostring(bossLev)
		end
	end
end

function TowerBossResultView:refreshAttr()
	gohelper.setActive(self.goInfo, true)

	if self.attrItems == nil then
		self.attrItems = {}
	end

	local bossLev = self.layerConfig.bossLevel
	local levConfig = TowerConfig.instance:getAssistDevelopConfig(self.towerConfig.bossId, bossLev)
	local talentPoint = levConfig and levConfig.talentPoint

	self.txtLev.text = tostring(bossLev)

	local attrList = GameUtil.splitString2(levConfig and levConfig.attribute, true) or {}

	for i = 1, math.max(#self.attrItems, #attrList) do
		local item = self.attrItems[i]

		if not item then
			item = self:createAttrItem(i)
			self.attrItems[i] = item
		end

		self:refreshAttrItem(item, attrList[i])
	end

	local talentPointUp = talentPoint and talentPoint > 0 or false

	gohelper.setActive(self.goTalentPoint, talentPointUp)

	if talentPointUp then
		gohelper.setAsLastSibling(self.goTalentPoint)

		self.txtTalentPoint.text = string.format("+%s", talentPoint)
	end
end

function TowerBossResultView:createAttrItem(index)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.cloneInPlace(self.goAttrItem, string.format("attrItem%s", index))
	item.icon = gohelper.findChildImage(item.go, "icon")
	item.txtName = gohelper.findChildTextMesh(item.go, "name")
	item.txtValue = gohelper.findChildTextMesh(item.go, "value")

	return item
end

function TowerBossResultView:refreshAttrItem(item, data)
	gohelper.setActive(item.go, data ~= nil)

	if data then
		local attrId = data[1]
		local value = data[2]
		local co = HeroConfig.instance:getHeroAttributeCO(attrId)

		item.txtName.text = co.name
		item.txtValue.text = string.format("+%s%%", value * 0.1)

		UISpriteSetMgr.instance:setCommonSprite(item.icon, string.format("icon_att_%s", attrId))
	end
end

function TowerBossResultView:refreshSp()
	self.simageSpBoss:LoadImage(self.bossConfig.bossPic)

	self.txtSpTower.text = self.towerConfig.name

	if not self.isTeach then
		self.txtSpIndex.text = self.episodeMo:getEpisodeIndex(self.towerId, self.layerId)
	end

	gohelper.setActive(self.goEpisodeItem, not self.isTeach)
	self:refreshHeroGroup()
end

function TowerBossResultView:refreshHeroGroup()
	if self.heroItemList == nil then
		self.heroItemList = self:getUserDataTb_()
	end

	local fightParam = FightModel.instance:getFightParam()
	local heroEquipList = fightParam:getHeroEquipAndTrialMoList(true)

	for i = 1, 4 do
		local heroItem = self.heroItemList[i]
		local mo = heroEquipList[i]

		if mo then
			if heroItem == nil then
				local go = gohelper.findChild(self.viewGO, string.format("goSpResult/goGroup/Group/heroitem%s", i))

				heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, TowerBossResultHeroItem)
				self.heroItemList[i] = heroItem
			end

			heroItem:setData(mo.heroMo, mo.equipMo)
		end
	end
end

function TowerBossResultView:_onAllFinish()
	self.canClick = true
end

function TowerBossResultView:onClose()
	FightController.onResultViewClose()
end

function TowerBossResultView:onDestroyView()
	self.simageSpBoss:UnLoadImage()
	self.simageBoss:UnLoadImage()

	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end
end

return TowerBossResultView
