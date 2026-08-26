-- chunkname: @modules/logic/tower/view/bosstower/TowerBossSpEpisodeView.lua

module("modules.logic.tower.view.bosstower.TowerBossSpEpisodeView", package.seeall)

local TowerBossSpEpisodeView = class("TowerBossSpEpisodeView", BaseView)

function TowerBossSpEpisodeView:onInitView()
	self.simageBoss = gohelper.findChildSingleImage(self.viewGO, "root/episodeNode/BOSS/#simage_BossPic")
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "root/episodeNode/nameBg/txtName")
	self.simageShadow = gohelper.findChildSingleImage(self.viewGO, "root/episodeNode/BOSS/#simage_BossShadow")
	self.txtLev = gohelper.findChildTextMesh(self.viewGO, "root/episodeNode/#go_episodes/Bottom/txtCurEpisode")
	self.goEpisodeInfo = gohelper.findChild(self.viewGO, "root/episodeInfo")
	self.txtEpisodeIndex = gohelper.findChildTextMesh(self.goEpisodeInfo, "Title/txtIndex")
	self.txtEpisodeName = gohelper.findChildTextMesh(self.goEpisodeInfo, "Title/txtTitle")
	self.txtEpisodeNameEn = gohelper.findChildTextMesh(self.goEpisodeInfo, "Title/txt_TitleEn")
	self.txtEpisodeDesc = gohelper.findChildTextMesh(self.goEpisodeInfo, "desc/Viewport/content")
	self._gorecommendattr = gohelper.findChild(self.goEpisodeInfo, "#go_recommendAttr")
	self._gorecommendattrlist = gohelper.findChild(self._gorecommendattr, "attrlist")
	self._goattritem = gohelper.findChild(self.goEpisodeInfo, "#go_recommendAttr/attrlist/#go_attritem")
	self._txtrecommonddes = gohelper.findChildTextMesh(self.goEpisodeInfo, "#go_recommendAttr/#txt_recommonddes")
	self._txtrecommendlevel = gohelper.findChildText(self.goEpisodeInfo, "recommend/#txt_recommendLevel")
	self.btnStart = gohelper.findChildButtonWithAudio(self.goEpisodeInfo, "btnStart")
	self.btnReStart = gohelper.findChildButtonWithAudio(self.goEpisodeInfo, "btnReStart")
	self.btnTeach = gohelper.findChildButtonWithAudio(self.viewGO, "root/episodeInfo/btnTeach")
	self.goTeachFinish = gohelper.findChild(self.viewGO, "root/episodeInfo/btnTeach/go_teachFinish")
	self.animTeachFinishEffect = gohelper.findChild(self.viewGO, "root/episodeInfo/btnTeach/go_teachFinish/go_hasget"):GetComponent(gohelper.Type_Animator)
	self.goRewards = gohelper.findChild(self.goEpisodeInfo, "Reward/scroll_reward/Viewport/#go_rewards")
	self.goItem = gohelper.findChild(self.goRewards, "goItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerBossSpEpisodeView:addEvents()
	self.addClickCb(self, self.btnStart, self._onBtnStartClick, self)
	self.addClickCb(self, self.btnReStart, self._onBtnStartClick, self)
	self.addClickCb(self, self.btnTeach, self._onBtnTeachClick, self)
end

function TowerBossSpEpisodeView:removeEvents()
	self:removeClickCb(self.btnStart)
	self:removeClickCb(self.btnReStart)
	self:removeClickCb(self.btnTeach)
end

function TowerBossSpEpisodeView:_editableInitView()
	return
end

function TowerBossSpEpisodeView:_onBtnStartClick()
	if not self.selectLayerId then
		return
	end

	local param = {}

	param.towerType = self.towerType
	param.towerId = self.towerId
	param.layerId = self.selectLayerId

	local layerConfig = self.episodeMo:getEpisodeConfig(self.towerId, self.selectLayerId)

	param.episodeId = layerConfig.episodeId

	TowerController.instance:enterFight(param)
end

function TowerBossSpEpisodeView:_onBtnTeachClick()
	local param = {}

	param.towerType = self.towerType
	param.towerId = self.towerId

	TowerController.instance:openTowerBossTeachView(param)
end

function TowerBossSpEpisodeView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function TowerBossSpEpisodeView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function TowerBossSpEpisodeView:refreshParam()
	self.episodeConfig = self.viewParam.episodeConfig
	self.towerId = self.episodeConfig.towerId
	self.towerType = TowerEnum.TowerType.Boss
	self.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(self.towerType)
	self.towerConfig = TowerConfig.instance:getBossTowerConfig(self.towerId)
	self.towerMo = TowerModel.instance:getTowerInfoById(self.towerType, self.towerId)
	self.bossConfig = TowerConfig.instance:getAssistBossConfig(self.towerConfig.bossId)
	self.bossInfo = TowerAssistBossModel.instance:getById(self.towerConfig.bossId)
	self.selectLayerId = self.episodeConfig.layerId

	if self.viewParam.isTeach then
		self:_onBtnTeachClick()
	end
end

function TowerBossSpEpisodeView:refreshView()
	self.txtName.text = self.towerConfig.name

	if self.bossInfo then
		self.txtLev.text = self.bossInfo.level or 0
	end

	self.simageBoss:LoadImage(self.bossConfig.bossPic)
	self.simageShadow:LoadImage(self.bossConfig.bossShadowPic)
	self:refreshEpisodeList()
	self:refreshEpisodeInfo()
end

function TowerBossSpEpisodeView:refreshEpisodeList()
	local episodes = self.episodeMo:getSpEpisodes(self.towerId)

	if self.episodeItems == nil then
		self.episodeItems = {}
	end

	for i = 1, 3 do
		local item = self.episodeItems[i]

		if not item then
			local go = gohelper.findChild(self.viewGO, string.format("root/episodeNode/#go_episodes/episodeItem%s", i))

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, TowerBossSpEpisodeItem)
			self.episodeItems[i] = item
		end

		item:updateItem(episodes[i], i, self)
	end
end

function TowerBossSpEpisodeView:isSelectEpisode(layerId)
	return self.selectLayerId == layerId
end

function TowerBossSpEpisodeView:onClickEpisode(layerId)
	if not layerId then
		return
	end

	local isSelect = self:isSelectEpisode(layerId)

	if isSelect then
		return
	end

	local isOpen = self.towerMo:isSpLayerOpen(layerId)

	if not isOpen then
		GameFacade.showToast(ToastEnum.NotStart)

		return
	end

	local isUnlock = self.towerMo:isLayerUnlock(layerId, self.episodeMo)

	if not isUnlock then
		GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)

		return
	end

	self.selectLayerId = layerId

	if self.episodeItems then
		for i, v in ipairs(self.episodeItems) do
			v:updateSelect()
		end
	end

	self:refreshEpisodeInfo()
end

function TowerBossSpEpisodeView:refreshEpisodeInfo()
	self.isPassLayer = self.towerMo.passLayerId >= self.selectLayerId

	local layerConfig = self.episodeMo:getEpisodeConfig(self.towerId, self.selectLayerId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(layerConfig.episodeId)
	local index = self.episodeMo:getEpisodeIndex(self.towerId, self.selectLayerId)

	self.txtEpisodeIndex.text = string.format("SP-%s", index)
	self.txtEpisodeName.text = episodeConfig.name
	self.txtEpisodeNameEn.text = episodeConfig.name_En
	self.txtEpisodeDesc.text = episodeConfig.desc

	local recommendLevel = FightHelper.getBattleRecommendLevel(episodeConfig.battleId)

	self._txtrecommendlevel.text = recommendLevel >= 0 and HeroConfig.instance:getLevelDisplayVariant(recommendLevel) or ""

	local battleCo = lua_battle.configDict[episodeConfig.battleId]
	local monsterGroupIds = string.splitToNumber(battleCo.monsterGroupIds, "#")
	local recommended = FightHelper.getAttributeCounter(monsterGroupIds)

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, self._gorecommendattrlist, self._goattritem)

	self._txtrecommonddes.text = #recommended == 0 and luaLang("new_common_none") or ""

	self:refreshRewards(layerConfig.firstReward)
	gohelper.setActive(self.btnReStart, self.isPassLayer)
	gohelper.setActive(self.btnStart, not self.isPassLayer)
	self:refreshTeachUI()
end

function TowerBossSpEpisodeView:refreshTeachUI()
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

function TowerBossSpEpisodeView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function TowerBossSpEpisodeView:refreshRewards(rewardStr)
	if self.rewardItems == nil then
		self.rewardItems = {}
	end

	local list = GameUtil.splitString2(rewardStr, true) or {}

	for i = 1, math.max(#self.rewardItems, #list) do
		local item = self.rewardItems[i]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self.goItem)
			item.goReward = gohelper.findChild(item.go, "reward")
			item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.goReward)
			item.goHasGet = gohelper.findChild(item.go, "#goHasGet")
			self.rewardItems[i] = item
		end

		gohelper.setActive(item.go, list[i] ~= nil)

		if list[i] then
			item.itemIcon:setMOValue(list[i][1], list[i][2], list[i][3], nil, true)
			item.itemIcon:setScale(0.7)
			item.itemIcon:setCountTxtSize(51)
			gohelper.setActive(item.goHasGet, self.isPassLayer)
		end
	end
end

function TowerBossSpEpisodeView:onClose()
	return
end

function TowerBossSpEpisodeView:onDestroyView()
	self.simageBoss:UnLoadImage()
	self.simageShadow:UnLoadImage()
end

return TowerBossSpEpisodeView
