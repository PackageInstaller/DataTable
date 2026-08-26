-- chunkname: @modules/logic/tower/view/bosstower/TowerBossEpisodeView.lua

module("modules.logic.tower.view.bosstower.TowerBossEpisodeView", package.seeall)

local TowerBossEpisodeView = class("TowerBossEpisodeView", BaseView)

function TowerBossEpisodeView:onInitView()
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "root/episodeNode/nameBg/txtName")
	self.btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "root/Right/btnStart")
	self.btnTeach = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnTeach")
	self.goTeachFinish = gohelper.findChild(self.viewGO, "root/btnTeach/go_teachFinish")
	self.animTeachFinishEffect = gohelper.findChild(self.viewGO, "root/btnTeach/go_teachFinish/go_hasget"):GetComponent(gohelper.Type_Animator)
	self.goRewards = gohelper.findChild(self.viewGO, "root/Right/Reward/scroll_reward/Viewport/#go_rewards")
	self.goAttrInfo = gohelper.findChild(self.viewGO, "root/Right/attrInfo")
	self.goLevItem = gohelper.findChild(self.viewGO, "root/Right/attrInfo/levItem")
	self.txtCurLev = gohelper.findChildTextMesh(self.goLevItem, "curLev")
	self.txtNextLev = gohelper.findChildTextMesh(self.goLevItem, "nextLev")
	self.goAttrItem = gohelper.findChild(self.viewGO, "root/Right/attrInfo/attrItem")

	gohelper.setActive(self.goAttrItem, false)

	self.goTalentPoint = gohelper.findChild(self.viewGO, "root/Right/attrInfo/talentPoint")
	self.txtTalentPoint = gohelper.findChildTextMesh(self.goTalentPoint, "value")
	self.goSkillUnlock = gohelper.findChild(self.viewGO, "root/Right/attrInfo/skillUnlock")
	self.imgSkillUnlock = gohelper.findChildImage(self.viewGO, "root/Right/attrInfo/skillUnlock/icon")
	self.goBossUnlock = gohelper.findChild(self.viewGO, "root/Right/attrInfo/bossUnlock")
	self.txtPreIndex = gohelper.findChildTextMesh(self.viewGO, "root/episodeNode/Levels/indexBg2/txtCurEpisode")
	self.txtCurIndex = gohelper.findChildTextMesh(self.viewGO, "root/episodeNode/Levels/indexBg3/txtCurEpisode")
	self.txtNextIndex = gohelper.findChildTextMesh(self.viewGO, "root/episodeNode/Levels/indexBg4/txtCurEpisode")
	self.simageBoss = gohelper.findChildSingleImage(self.viewGO, "root/episodeNode/BOSS/#simage_BossPic")
	self.simageShadow = gohelper.findChildSingleImage(self.viewGO, "root/episodeNode/BOSS/#simage_BossShadow")
	self.animLevels = gohelper.findChildComponent(self.viewGO, "root/episodeNode/Levels", gohelper.Type_Animator)
	self.goLevels = gohelper.findChild(self.viewGO, "root/episodeNode/Levels")
	self.goRight = gohelper.findChild(self.viewGO, "root/Right")
	self.goLevMax = gohelper.findChild(self.viewGO, "root/#go_levelmax")
	self.txtMaxLevel = gohelper.findChildTextMesh(self.viewGO, "root/#go_levelmax/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerBossEpisodeView:addEvents()
	self.addClickCb(self, self.btnStart, self._onBtnStartClick, self)
	self.addClickCb(self, self.btnTeach, self._onBtnTeachClick, self)
end

function TowerBossEpisodeView:removeEvents()
	self:removeClickCb(self.btnStart)
	self:removeClickCb(self.btnTeach)
end

function TowerBossEpisodeView:_editableInitView()
	return
end

function TowerBossEpisodeView:_onBtnStartClick()
	if not self.episodeConfig then
		return
	end

	local param = {}

	param.towerType = self.towerType
	param.towerId = self.towerId
	param.layerId = self.episodeConfig.layerId
	param.episodeId = self.episodeConfig.episodeId

	TowerController.instance:enterFight(param)
end

function TowerBossEpisodeView:_onBtnTeachClick()
	local param = {}

	param.towerType = self.towerType
	param.towerId = self.towerId
	param.lastFightTeachId = self.viewParam.lastFightTeachId

	TowerController.instance:openTowerBossTeachView(param)

	self.viewParam.lastFightTeachId = 0
end

function TowerBossEpisodeView:_onMove()
	self:refreshCurLayerId()
	self:refreshLayerInfo()
end

function TowerBossEpisodeView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function TowerBossEpisodeView:onOpen()
	self:refreshParam()
	self:refreshView()

	if self.needChangeLayer then
		UIBlockMgr.instance:startBlock("delayMove")
		TaskDispatcher.runDelay(self.delayMove, self, 1)
	end
end

function TowerBossEpisodeView:delayMove()
	UIBlockMgr.instance:endBlock("delayMove")
	self.animLevels:Play("move")
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_boss_swtich)
	TaskDispatcher.runDelay(self._onMove, self, 0.167)
end

function TowerBossEpisodeView:refreshParam()
	self.episodeConfig = self.viewParam.episodeConfig
	self.towerId = self.episodeConfig.towerId
	self.towerType = TowerEnum.TowerType.Boss
	self.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(self.towerType)
	self.towerConfig = TowerConfig.instance:getBossTowerConfig(self.towerId)
	self.bossConfig = TowerConfig.instance:getAssistBossConfig(self.towerConfig.bossId)
	self.towerInfo = TowerModel.instance:getTowerInfoById(self.towerType, self.towerId)

	self:refreshCurLayerId()

	if self.viewParam.isTeach then
		self:_onBtnTeachClick()
	end
end

function TowerBossEpisodeView:refreshCurLayerId()
	if self.viewParam then
		if self.viewParam then
			self.curLayer = self.viewParam
			self.viewParam.passLayerId = nil
		else
			self.curLayer = self.episodeConfig.layerId
		end

		self.needChangeLayer = self.curLayer ~= self.episodeConfig.layerId
	end
end

function TowerBossEpisodeView:refreshView()
	self.txtName.text = self.towerConfig.name

	self.simageBoss:LoadImage(self.bossConfig.bossPic)
	self.simageShadow:LoadImage(self.bossConfig.bossShadowPic)
	self:refreshLayerInfo()
end

function TowerBossEpisodeView:refreshLayerInfo()
	local isMax = not self.needChangeLayer and self.towerInfo:isLayerPass(self.curLayer, self.episodeMo)

	gohelper.setActive(self.goLevMax, isMax)
	gohelper.setActive(self.goLevels, not isMax)
	gohelper.setActive(self.goRight, not isMax)

	if not isMax then
		self:refreshIndex()
		self:refreshRewards(self.episodeConfig.firstReward)
		self:refreshAttr()
	else
		self.txtMaxLevel.text = tostring(self.episodeMo:getEpisodeIndex(self.towerId, self.curLayer))
	end

	self:refreshTeachUI()
end

function TowerBossEpisodeView:refreshTeachUI()
	local isAllTeachFinish = TowerBossTeachModel.instance:isAllEpisodeFinish(self.towerConfig.bossId)

	gohelper.setActive(self.goTeachFinish, isAllTeachFinish)

	local saveFinishEffectKey = TowerBossTeachModel.instance:getTeachFinishEffectSaveKey(self.towerConfig.bossId)
	local saveValue = TowerController.instance:getPlayerPrefs(saveFinishEffectKey, 0)

	if saveValue == 0 and isAllTeachFinish then
		self.animTeachFinishEffect:Play("go_hasget_in", 0, 0)
		TowerController.instance:setPlayerPrefs(saveFinishEffectKey, 1)
	else
		self.animTeachFinishEffect:Play("go_hasget_idle", 0, 0)
	end
end

function TowerBossEpisodeView:refreshIndex()
	local episodeConfig = self.episodeMo:getEpisodeConfig(self.towerId, self.curLayer)

	self.txtCurIndex.text = tostring(self.episodeMo:getEpisodeIndex(self.towerId, self.curLayer))

	local nextLayer = self.episodeMo:getNextEpisodeLayer(self.towerId, self.curLayer)

	if nextLayer then
		local layerConfig = self.episodeMo:getEpisodeConfig(self.towerId, nextLayer)
		local isSp = layerConfig.openRound > 0

		self.txtNextIndex.text = isSp and "" or tostring(self.episodeMo:getEpisodeIndex(self.towerId, nextLayer))
	else
		self.txtNextIndex.text = ""
	end

	local preLayer = episodeConfig.preLayerId

	self.txtPreIndex.text = preLayer and preLayer > 0 and tostring(self.episodeMo:getEpisodeIndex(self.towerId, preLayer)) or ""
end

function TowerBossEpisodeView:refreshRewards(rewardStr)
	if self.rewardItems == nil then
		self.rewardItems = {}
	end

	local list = GameUtil.splitString2(rewardStr, true) or {}

	for i = 1, math.max(#self.rewardItems, #list) do
		local item = self.rewardItems[i]

		if not item then
			item = IconMgr.instance:getCommonPropItemIcon(self.goRewards)
			self.rewardItems[i] = item
		end

		gohelper.setActive(item.go, list[i] ~= nil)

		if list[i] then
			item:setMOValue(list[i][1], list[i][2], list[i][3], nil, true)
			item:setScale(0.7)
			item:setCountTxtSize(51)
		end
	end
end

function TowerBossEpisodeView:refreshAttr()
	if self.attrItems == nil then
		self.attrItems = {}
	end

	local bossId = self.towerConfig.bossId
	local bossLev = self.episodeConfig.bossLevel
	local preEpisodeConfig = self.episodeMo:getEpisodeConfig(self.towerId, self.episodeConfig.preLayerId)

	if preEpisodeConfig then
		if not preEpisodeConfig.bossLevel then
			local preLev = 0
			local levConfig = TowerConfig.instance:getAssistDevelopConfig(bossId, bossLev)
			local talentPoint = levConfig and levConfig.talentPoint

			self.txtCurLev.text = string.format("Lv.%s", preLev)
			self.txtNextLev.text = string.format("Lv.%s", bossLev)

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
				self.txtTalentPoint.text = string.format("+%s", talentPoint)
			end

			gohelper.setActive(self.goBossUnlock, bossLev == 1)

			local activeSkillIndex
			local skills = TowerConfig.instance:getPassiveSKills(bossId)

			for i, v in ipairs(skills) do
				local lev = TowerConfig.instance:getPassiveSkillActiveLev(bossId, v[1])

				if lev == bossLev then
					activeSkillIndex = i

					break
				end
			end

			gohelper.setActive(self.goSkillUnlock, activeSkillIndex ~= nil)

			if activeSkillIndex then
				UISpriteSetMgr.instance:setCommonSprite(self.imgSkillUnlock, string.format("icon_att_%s", activeSkillIndex + 221))
			end
		end
	end
end

function TowerBossEpisodeView:createAttrItem(index)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.cloneInPlace(self.goAttrItem, string.format("attrItem%s", index))
	item.icon = gohelper.findChildImage(item.go, "icon")
	item.txtName = gohelper.findChildTextMesh(item.go, "name")
	item.txtValue = gohelper.findChildTextMesh(item.go, "value")

	return item
end

function TowerBossEpisodeView:refreshAttrItem(item, data)
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

function TowerBossEpisodeView:onOpenFinish()
	return
end

function TowerBossEpisodeView:onClose()
	return
end

function TowerBossEpisodeView:onDestroyView()
	UIBlockMgr.instance:endBlock("delayMove")
	TaskDispatcher.cancelTask(self.delayMove, self)
	TaskDispatcher.cancelTask(self._onMove, self)
	self.simageShadow:UnLoadImage()
	self.simageBoss:UnLoadImage()
end

return TowerBossEpisodeView
