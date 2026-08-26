-- chunkname: @modules/logic/teaching/view/TeachingMainView.lua

module("modules.logic.teaching.view.TeachingMainView", package.seeall)

local TeachingMainView = class("TeachingMainView", BaseView)

function TeachingMainView:onInitView()
	self._simagefyleft = gohelper.findChildSingleImage(self.viewGO, "#simage_fy/#simage_fyleft")
	self._simagefyright = gohelper.findChildSingleImage(self.viewGO, "#simage_fy/#simage_fyright")
	self._gotopic = gohelper.findChild(self.viewGO, "#go_topic")
	self._gotopicitem = gohelper.findChild(self.viewGO, "#go_topic/#go_topicitem")
	self._golevel = gohelper.findChild(self.viewGO, "#go_level")
	self._goleft = gohelper.findChild(self.viewGO, "#go_level/#go_left")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_level/#go_left/#txt_name")
	self._goleftpassdone = gohelper.findChild(self.viewGO, "#go_level/#go_left/#txt_name/#go_leftpassdone")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_level/#go_left/#txt_name/#image_icon")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_level/#go_left/#scroll_view")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_level/#go_left/#scroll_view/Viewport/Content/go_desc/#txt_desc")
	self._simagesystem = gohelper.findChildSingleImage(self.viewGO, "#go_level/#go_left/#simage_system")
	self._goright = gohelper.findChild(self.viewGO, "#go_level/#go_right")
	self._goheroItem = gohelper.findChild(self.viewGO, "#go_level/#go_right/#go_heroItem")
	self._scrollroleview = gohelper.findChildScrollRect(self.viewGO, "#go_level/#go_right/#scroll_roleview")
	self._txtname1 = gohelper.findChildText(self.viewGO, "#go_level/#go_right/#scroll_roleview/Viewport/Content/title1/#txt_name1")
	self._gorole1 = gohelper.findChild(self.viewGO, "#go_level/#go_right/#scroll_roleview/Viewport/Content/#go_role1")
	self._txtname2 = gohelper.findChildText(self.viewGO, "#go_level/#go_right/#scroll_roleview/Viewport/Content/title2/#txt_name2")
	self._btnroletipicon = gohelper.findChildButtonWithAudio(self.viewGO, "#go_level/#go_right/#scroll_roleview/Viewport/Content/title2/#txt_name2/#btn_role_tip_icon")
	self._gorole2 = gohelper.findChild(self.viewGO, "#go_level/#go_right/#scroll_roleview/Viewport/Content/#go_role2")
	self._txttargetname1 = gohelper.findChildText(self.viewGO, "#go_level/#go_right/teachingtarget/info/target1/#txt_target_name_1")
	self._gotargetfinish1 = gohelper.findChild(self.viewGO, "#go_level/#go_right/teachingtarget/info/target1/#go_target_finish_1")
	self._txttargetname2 = gohelper.findChildText(self.viewGO, "#go_level/#go_right/teachingtarget/info/target2/#txt_target_name_2")
	self._gotargetfinish2 = gohelper.findChild(self.viewGO, "#go_level/#go_right/teachingtarget/info/target2/#go_target_finish_2")
	self._goreward = gohelper.findChild(self.viewGO, "#go_level/#go_right/#go_reward")
	self._gorewarddetailItem = gohelper.findChild(self.viewGO, "#go_level/#go_right/#go_reward/#go_rewarddetailItem")
	self._gorightunlock = gohelper.findChild(self.viewGO, "#go_level/#go_right/#go_rightunlock")
	self._btnrightstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightstart")
	self._txtrightstartcn = gohelper.findChildText(self.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightstart/#txt_rightstartcn")
	self._txtrightstarten = gohelper.findChildText(self.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightstart/#txt_rightstarten")
	self._btnrightfinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightfinish")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._gotipbg = gohelper.findChild(self.viewGO, "#go_tips/#go_tip_bg")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_tips/#go_tip_bg/#txt_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TeachingMainView:addEvents()
	self._btnroletipicon:AddClickListener(self._btnroletipiconOnClick, self)
	self._btnrightstart:AddClickListener(self._btnrightstartOnClick, self)
	self._btnrightfinish:AddClickListener(self._btnrightfinishOnClick, self)
end

function TeachingMainView:removeEvents()
	self._btnroletipicon:RemoveClickListener()
	self._btnrightstart:RemoveClickListener()
	self._btnrightfinish:RemoveClickListener()
end

function TeachingMainView:_btnroletipiconOnClick()
	self:refreshTipState(true)
end

function TeachingMainView:_btnrightstartOnClick()
	if self._selectTeachingId == nil then
		return
	end

	TeachingController.instance:enterEpisodeId(self._selectTeachingId)
end

function TeachingMainView:_btnrightfinishOnClick()
	if self._selectTeachingId == nil then
		return
	end

	TeachingController.instance:enterEpisodeId(self._selectTeachingId)
end

function TeachingMainView:_editableInitView()
	self:refreshTipState(false)

	self._tipClick = gohelper.getClick(self._gotips)

	self._tipClick:AddClickListener(self.tipClickCb, self)

	self._leftpassdoneAnim = self._goleftpassdone:GetComponent(gohelper.Type_Animator)

	local target1 = gohelper.findChild(self.viewGO, "#go_level/#go_right/teachingtarget/info/target1")
	local target2 = gohelper.findChild(self.viewGO, "#go_level/#go_right/teachingtarget/info/target2")

	self._target1Anim = target1:GetComponent(gohelper.Type_Animator)
	self._target2Anim = target2:GetComponent(gohelper.Type_Animator)
end

function TeachingMainView:tipClickCb()
	self:refreshTipState(false)
end

function TeachingMainView:refreshTipState(active)
	gohelper.setActive(self._gotips, active)
end

function TeachingMainView:onUpdateParam()
	return
end

function TeachingMainView:onOpen()
	self.addEventCb(self, TeachingController.instance, TeachingEvent.OnTeachingBonusUpdate, self._refreshSelectTeachingView, self)
	self.addEventCb(self, TeachingController.instance, TeachingEvent.OnTeachingInfoUpdate, self._refreshSelectTeachingView, self)
	self.addEventCb(self, TeachingController.instance, TeachingEvent.OnSelectTeachingId, self.refreshSelectTeachingId, self)

	if self.viewParam then
		local teachingId = self.viewParam.TeachingId

		if self.viewParam == nil then
			local allTeachingIds = TeachingModel.instance:getAllTeachingId()

			teachingId = allTeachingIds[1]
		end

		TeachingModel.instance:setSelectTeachingId(self.viewParam)
		AudioMgr.instance:trigger(AudioEnum3_7.Teaching.play_ui_open_teaching)
	end
end

function TeachingMainView:refreshSelectTeachingId()
	self._selectTeachingId = TeachingModel.instance:getSelectTeachingId()

	self:refreshTeachingList()
	self:_refreshSelectTeachingView(true)
end

function TeachingMainView:refreshTeachingList()
	if self._allTeachingList == nil then
		self._allTeachingList = self:getUserDataTb_()

		local allTeachingIds = TeachingModel.instance:getAllTeachingId()

		table.insert(allTeachingIds, -1)
		gohelper.CreateObjList(self, self._onRecordTabItem, allTeachingIds, self._gotopic, self._gotopicitem, TeachingTopicItem)
	else
		for _, cell_component in pairs(self._allTeachingList) do
			cell_component:setSelect(self._selectTeachingId)
		end
	end
end

function TeachingMainView:_onRecordTabItem(cell_component, data, index)
	cell_component:refreshItem(data, index)
	cell_component:setSelect(self._selectTeachingId)
	table.insert(self._allTeachingList, cell_component)
end

function TeachingMainView:_refreshSelectTeachingView(isRefreshFixInfo)
	self._status = TeachingModel.instance:getCurSelectTeachingStatus()
	self._config = TeachingConfig.instance:getTeachingConfig(self._selectTeachingId)

	local episodeDesc = TeachingConfig.instance:getEpisodeDescByTeachId(self._selectTeachingId)

	gohelper.setActive(self._btnrightfinish, self._status ~= TeachingEnum.TeachingStatus.NotFinish)
	gohelper.setActive(self._btnrightstart, self._status == TeachingEnum.TeachingStatus.NotFinish)

	local isFinish = self._status ~= TeachingEnum.TeachingStatus.NotFinish

	gohelper.setActive(self._goleftpassdone, isFinish)

	if episodeDesc then
		self._txttargetname1.text = episodeDesc[1] or ""
	end

	if episodeDesc then
		self._txttargetname2.text = episodeDesc[2] or ""
	end

	gohelper.setActive(self._gotargetfinish1, isFinish)
	gohelper.setActive(self._gotargetfinish2, isFinish)

	if self._allRewards == nil then
		self._allRewards = self:getUserDataTb_()

		local reward = self._config.bonus
		local rewards = string.split(reward, "|")

		gohelper.CreateObjList(self, self._onRecordRewardItem, rewards, self._goreward, self._gorewarddetailItem, TeachingRewardItem)
	else
		for _, rewardItem in ipairs(self._allRewards) do
			rewardItem:refreshItem(self._status, self._config)
		end
	end

	if self._allTeachingList then
		for _, cell_component in pairs(self._allTeachingList) do
			cell_component:refreshState()
		end
	end

	if isRefreshFixInfo then
		self._txtdesc.text = self._config.detail
		self._txtname.text = self._config.name
		self._txtname1.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("teaching_main_desc_1"), self._config.tagName)
		self._txtname2.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("teaching_main_desc_2"), self._config.tagName)
		self._txttips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("teaching_tips"), self._config.tagName)

		if self._config.icon then
			UISpriteSetMgr.instance:setV3a7TeachingSystemSprite(self._imageicon, self._config.icon)
		end

		if self._config.picture then
			self._simagesystem:LoadImage(self._config.picture)
		end

		self:refreshHero()
	end

	if isFinish and TeachingModel.instance:needShowFinishAni(self._selectTeachingId) then
		local aniName = "finish"

		if self._leftpassdoneAnim then
			self._leftpassdoneAnim:Play(aniName, 0, 0)
		end

		if self._target1Anim then
			self._target1Anim:Play(aniName, 0, 0)
		end

		if self._target2Anim then
			self._target2Anim:Play(aniName, 0, 0)
		end

		TeachingModel.instance:recordShowTeachingAni(self._selectTeachingId)
	end
end

function TeachingMainView:_onRecordRewardItem(cell_component, data, index)
	cell_component:refreshItem(self._status, self._config)
	table.insert(self._allRewards, cell_component)
end

function TeachingMainView:clearAllHeroData()
	if self._allHeroClick then
		for _, click in pairs(self._allHeroClick) do
			if click then
				click:RemoveClickListener()
			end
		end

		tabletool.clear(self._allHeroClick)
	end

	if self._allHeroIcons then
		for _, go in pairs(self._allHeroIcons) do
			gohelper.destroy(go)
		end

		tabletool.clear(self._allHeroIcons)
	end
end

function TeachingMainView:refreshHero()
	local allHero = HeroConfig.instance:getHeroListByBattleTag(self._config.battleTag)
	local facetsHero = CharacterDestinyConfig.instance:getHeroIdBydDestinyLastBattleTag(self._config.battleTag)

	if self._allHeroIcons == nil then
		self._allHeroIcons = self:getUserDataTb_()
		self._allHeroClick = self:getUserDataTb_()
	else
		self:clearAllHeroData()
	end

	for _, heroCo in ipairs(allHero) do
		local heroItem, gary, hero, click = self:getHeroItem(self._gorole1)
		local heroIcon = IconMgr.instance:getCommonHeroIconNew(hero)

		heroIcon:onUpdateHeroId(heroCo.id)

		local heroInfo = HeroModel.instance:getByHeroId(heroCo.id)

		gohelper.setActive(gary, heroInfo == nil)
		heroIcon:setScale(0.5)
		heroIcon:isShowLevel(false)
		click:AddClickListener(function()
			local var_19_0 = {
				isShowRecommed = true,
				heroId = heroCo.id,
				fromView = self.viewName
			}

			if heroInfo == nil then
				var_19_0.hideTab = CharacterRecommedEnum.TabSubType.DevelopGoals or nil
			end

			ViewMgr.instance:openView(ViewName.SummonHeroDetailView, var_19_0)
		end, nil)
		table.insert(self._allHeroIcons, heroItem)
		table.insert(self._allHeroClick, click)
		gohelper.setActive(heroItem, true)
	end

	if facetsHero then
		for _, heroId in ipairs(facetsHero) do
			local heroItem, gary, hero, click = self:getHeroItem(self._gorole2)
			local heroIcon = IconMgr.instance:getCommonHeroIconNew(hero)
			local heroCo = HeroConfig.instance:getHeroCO(heroId)

			heroIcon:onUpdateHeroId(heroCo.id)
			heroIcon:isShowLevel(false)
			heroIcon:setScale(0.5)

			local heroInfo = HeroModel.instance:getByHeroId(heroId)

			gohelper.setActive(gary, heroInfo == nil)
			click:AddClickListener(function()
				local var_20_0 = {
					isShowRecommed = true,
					heroId = heroCo.id,
					fromView = self.viewName
				}

				if heroInfo == nil then
					var_20_0.hideTab = CharacterRecommedEnum.TabSubType.DevelopGoals or nil
				end

				ViewMgr.instance:openView(ViewName.SummonHeroDetailView, var_20_0)
			end, nil)
			table.insert(self._allHeroIcons, heroItem)
			table.insert(self._allHeroClick, click)
			gohelper.setActive(heroItem, true)
		end
	end
end

function TeachingMainView:getHeroItem(parentGo)
	local heroItem = gohelper.clone(self._goheroItem, parentGo)
	local gary = gohelper.findChild(heroItem, "gary")
	local hero = gohelper.findChild(heroItem, "hero")
	local clickGo = gohelper.findChild(heroItem, "click")
	local click = gohelper.getClick(clickGo)

	return heroItem, gary, hero, click
end

function TeachingMainView:onClose()
	self.removeEventCb(self, TeachingController.instance, TeachingEvent.OnTeachingBonusUpdate, self._refreshSelectTeachingView, self)
	self.removeEventCb(self, TeachingController.instance, TeachingEvent.OnTeachingInfoUpdate, self._refreshSelectTeachingView, self)
	self.removeEventCb(self, TeachingController.instance, TeachingEvent.OnSelectTeachingId, self.refreshSelectTeachingId, self)
	self:clearAllHeroData()
end

function TeachingMainView:onDestroyView()
	if self._tipClick then
		self._tipClick:RemoveClickListener()

		self._tipClick = nil
	end
end

return TeachingMainView
