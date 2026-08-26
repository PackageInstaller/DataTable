-- chunkname: @modules/logic/rouge/view/RougeHeroGroupFightMiscView.lua

module("modules.logic.rouge.view.RougeHeroGroupFightMiscView", package.seeall)

local RougeHeroGroupFightMiscView = class("RougeHeroGroupFightMiscView", BaseView)

function RougeHeroGroupFightMiscView:onInitView()
	self._btnbag = gohelper.findChildButtonWithAudio(self.viewGO, "rouge/#btn_bag")
	self._btnliupai = gohelper.findChildButtonWithAudio(self.viewGO, "rouge/#btn_liupai")
	self._imageicon = gohelper.findChildImage(self.viewGO, "rouge/#btn_liupai/liupai/#image_icon")
	self._godetail = gohelper.findChild(self.viewGO, "rouge/#btn_liupai/liupai/#go_detail")
	self._txtdec = gohelper.findChildText(self.viewGO, "rouge/#btn_liupai/liupai/#go_detail/#txt_dec")
	self._gozhouyu = gohelper.findChild(self.viewGO, "rouge/#btn_liupai/#go_zhouyu")
	self._goskillitem = gohelper.findChild(self.viewGO, "rouge/#btn_liupai/#go_zhouyu/#go_skillitem")
	self._txttitle = gohelper.findChildText(self.viewGO, "rouge/leftbg/#txt_title")
	self._txttitleen = gohelper.findChildText(self.viewGO, "rouge/leftbg/#txt_title/#txt_en")
	self._godetail2 = gohelper.findChild(self.viewGO, "rouge/#btn_liupai/#go_zhouyu/#go_detail2")
	self._txtdec2 = gohelper.findChildText(self.viewGO, "rouge/#btn_liupai/#go_zhouyu/#go_detail2/#txt_dec2")
	self._imageskillicon = gohelper.findChildImage(self.viewGO, "rouge/#btn_liupai/#go_zhouyu/#go_detail2/icon")
	self._gorouge = gohelper.findChild(self.viewGO, "rouge")
	self._aniamtor = gohelper.onceAddComponent(self._gorouge, gohelper.Type_Animator)
	self._skillItemList = self:getUserDataTb_()

	self:_initCapacity()
	self:_updateHeroList()
end

function RougeHeroGroupFightMiscView:_initCapacity()
	local volume = gohelper.findChild(self.viewGO, "rouge/bg/volume")
	local capacity = RougeModel.instance:getTeamCapacity()

	self._rougeCapacityComp = RougeCapacityComp.Add(volume, 0, capacity, true, RougeCapacityComp.SpriteType2)
end

function RougeHeroGroupFightMiscView:addEvents()
	self._btnbag:AddClickListener(self._btnbagOnClick, self)
	self._btnliupai:AddClickListener(self._btnliupaiOnClick, self)
end

function RougeHeroGroupFightMiscView:removeEvents()
	self._btnbag:RemoveClickListener()
	self._btnliupai:RemoveClickListener()
end

function RougeHeroGroupFightMiscView:_setBtnStatus(isSelected, normalGo, selectedGo)
	gohelper.setActive(normalGo, not isSelected)
	gohelper.setActive(selectedGo, isSelected)
end

function RougeHeroGroupFightMiscView:_btnbagOnClick()
	RougeController.instance:openRougeCollectionChessView()
end

function RougeHeroGroupFightMiscView:_btnliupaiOnClick()
	self._showDetail = true

	gohelper.setActive(self._godetail, true)
end

function RougeHeroGroupFightMiscView:onOpen()
	self.addEventCb(self, RougeHeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, self._onClickHeroGroupAssitItem, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, self._onClickHeroGroupItem, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._updateHeroList, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, self._onTouchScreenUp, self)

	self._season = RougeConfig1.instance:season()
	self._rougeInfo = RougeModel.instance:getRougeInfo()

	local styleId = RougeModel.instance:getStyle()

	self._styleConfig = RougeConfig1.instance:getStyleConfig(styleId)

	gohelper.setActive(self._godetail, false)
	gohelper.setActive(self._godetail2, false)
	self:_initIcon()
	self:_initSkill()
	self:_initEpisodeName()
end

function RougeHeroGroupFightMiscView:_initEpisodeName()
	self._txttitle.text = ""
	self._txttitleen.text = ""

	local episodeId = RougeHeroGroupModel.instance.episodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		return
	end

	self._txttitleen.text = episodeCo.name_En

	local name = episodeCo.name
	local len = utf8.len(name)

	if len <= 0 then
		return
	end

	self._txttitle.text = string.format("<size=77>%s</size>%s", utf8.sub(name, 1, 2), utf8.sub(name, 2, len + 1))
end

function RougeHeroGroupFightMiscView:_initIcon()
	local style = self._rougeInfo.style
	local season = self._rougeInfo.season
	local styleCo = lua_rouge_style.configDict[season][style]

	self._txtdec.text = styleCo.desc

	UISpriteSetMgr.instance:setRouge2Sprite(self._imageicon, string.format("%s_light", styleCo.icon))
end

function RougeHeroGroupFightMiscView:_initSkill()
	local totalSkills = RougeDLCHelper.getCurrentUseStyleFightSkills(self._styleConfig.id)
	local rougeConfig = RougeOutsideModel.instance:config()
	local useMap = {}

	for index, skillMo in ipairs(totalSkills) do
		local skillItem = self:_getOrCreateSkillItem(index)
		local skillCo = rougeConfig:getSkillCo(skillMo.type, skillMo.skillId)
		local icon = skillCo and skillCo.icon

		if not string.nilorempty(icon) then
			UISpriteSetMgr.instance:setRouge2Sprite(skillItem.imagenormalicon, icon, true)
			UISpriteSetMgr.instance:setRouge2Sprite(skillItem.imagselecticon, icon .. "_light", true)
		else
			logError(string.format("未配置肉鸽流派技能图标, 技能类型 = %s, 技能id = %s", skillMo.type, skillMo.skillId))
		end

		self["_skillDesc" .. index] = skillCo and skillCo.desc
		self["_skillIcon" .. index] = skillCo and skillCo.icon

		gohelper.setActive(skillItem.viewGO, true)

		useMap[skillItem] = true
	end

	for _, skillItem in ipairs(self._skillItemList) do
		if not useMap[skillItem] then
			gohelper.setActive(skillItem.viewGO, false)
		end
	end

	gohelper.setActive(self._gozhouyu, totalSkills and #totalSkills > 0)
end

function RougeHeroGroupFightMiscView:_getOrCreateSkillItem(index)
	if self._skillItemList then
		local skillItem = self._skillItemList[index]

		if not self._skillItemList then
			skillItem = self:getUserDataTb_()
			self._skillItemList.viewGO = gohelper.cloneInPlace(self._goskillitem, "item_" .. index)
			self._skillItemList.gonormal = gohelper.findChild(self._skillItemList.viewGO, "go_normal")
			self._skillItemList.imagenormalicon = gohelper.findChildImage(self._skillItemList.viewGO, "go_normal/image_icon")
			self._skillItemList.goselect = gohelper.findChild(self._skillItemList.viewGO, "go_select")
			self._skillItemList.imagselecticon = gohelper.findChildImage(self._skillItemList.viewGO, "go_select/image_icon")
			self._skillItemList.btnclick = gohelper.findChildButtonWithAudio(self._skillItemList.viewGO, "btn_click")

			self._skillItemList.btnclick:AddClickListener(self._btnskillOnClick, self, index)
			table.insert(self._skillItemList, self._skillItemList)
		end

		return self._skillItemList
	end
end

function RougeHeroGroupFightMiscView:_btnskillOnClick(index)
	self._showTips = true
	self._txtdec2.text = self["_skillDesc" .. index]

	UISpriteSetMgr.instance:setRouge2Sprite(self._imageskillicon, self["_skillIcon" .. index], true)
	gohelper.setActive(self._godetail2, false)
	gohelper.setActive(self._godetail2, true)
	gohelper.setAsLastSibling(self._godetail2)
	self:_refreshAllBtnStatus(index)
end

function RougeHeroGroupFightMiscView:_refreshAllBtnStatus(selectBtnIndex)
	for index, skillItem in ipairs(self._skillItemList) do
		local isSelect = selectBtnIndex == index

		self:_setBtnStatus(isSelect, skillItem.gonormal, skillItem.goselect)
	end
end

function RougeHeroGroupFightMiscView:_removeAllSkillClickListener()
	if self._skillItemList then
		for _, skillItem in pairs(self._skillItemList) do
			if skillItem.btnclick then
				skillItem.btnclick:RemoveClickListener()
			end
		end
	end
end

function RougeHeroGroupFightMiscView:_onTouchScreenUp()
	if self._showDetail then
		self._showDetail = false
	else
		gohelper.setActive(self._godetail, false)
	end

	if self._showTips then
		self._showTips = false

		return
	end

	gohelper.setActive(self._godetail2, false)
	self:_refreshAllBtnStatus()
end

function RougeHeroGroupFightMiscView:_onClickHeroGroupAssitItem(id)
	self:_openRougeHeroGroupEditView(id, RougeEnum.HeroGroupEditType.FightAssit)
end

function RougeHeroGroupFightMiscView:_onClickHeroGroupItem(id)
	self:_openRougeHeroGroupEditView(id, RougeEnum.HeroGroupEditType.Fight)
end

function RougeHeroGroupFightMiscView:_openRougeHeroGroupEditView(id, type)
	local heroGroupMO = RougeHeroGroupModel.instance:getCurGroupMO()
	local equips = heroGroupMO:getPosEquips(id - 1).equipUid
	local mo = RougeHeroSingleGroupModel.instance:getById(id)
	local heroMo = mo and mo:getHeroMO()
	local curCapacity, totalCapacity = self._rougeCapacityComp:getCurNum(), self._rougeCapacityComp:getMaxNum()
	local selectHeroCapacity = heroMo and RougeConfig1.instance:getRoleCapacity(heroMo.config.rare) or 0
	local param = {}

	param.singleGroupMOId = id
	param.originalHeroUid = RougeHeroSingleGroupModel.instance:getHeroUid(id)
	param.equips = equips
	param.heroGroupEditType = type
	param.selectHeroCapacity = selectHeroCapacity
	param.curCapacity = curCapacity
	param.totalCapacity = totalCapacity

	ViewMgr.instance:openView(ViewName.RougeHeroGroupEditView, param)
end

function RougeHeroGroupFightMiscView:_updateHeroList()
	local curCapacity = 0

	for i = 1, RougeEnum.FightTeamHeroNum do
		local mo = RougeHeroSingleGroupModel.instance:getById(i)
		local heroMo = mo and mo:getHeroMO()

		curCapacity = curCapacity + RougeController.instance:getRoleStyleCapacity(heroMo, i > RougeEnum.FightTeamNormalHeroNum)
	end

	self._rougeCapacityComp:updateCurNum(curCapacity)
end

function RougeHeroGroupFightMiscView:onOpenFinish()
	local checkNeedContinueFight = RougeController.instance:checkNeedContinueFight()

	if checkNeedContinueFight then
		self._canvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))
		self._canvasGroup.interactable = false
		self._canvasGroup.blocksRaycasts = false

		TaskDispatcher.cancelTask(self._delayModifyCanvasGroup, self)
		TaskDispatcher.runDelay(self._delayModifyCanvasGroup, self, 5)
	end
end

function RougeHeroGroupFightMiscView:_delayModifyCanvasGroup()
	if not self._canvasGroup then
		return
	end

	self._canvasGroup.interactable = true
	self._canvasGroup.blocksRaycasts = true
end

function RougeHeroGroupFightMiscView:onClose()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, self._onTouchScreenUp, self)
	TaskDispatcher.cancelTask(self._delayModifyCanvasGroup, self)
	self._aniamtor:Play("close", 0, 0)
	self:_removeAllSkillClickListener()
end

return RougeHeroGroupFightMiscView
