-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedView.lua

module("modules.logic.character.view.recommed.CharacterRecommedView", package.seeall)

local CharacterRecommedView = class("CharacterRecommedView", BaseView)

function CharacterRecommedView:onInitView()
	self._simagebgimg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bgimg")
	self._goheroinfo = gohelper.findChild(self.viewGO, "left/bottom/#go_heroinfo")
	self._txtheroname = gohelper.findChildText(self.viewGO, "left/bottom/#go_heroinfo/#txt_heroname")
	self._golv = gohelper.findChild(self.viewGO, "left/bottom/#go_heroinfo/#go_lv")
	self._imagelvicon = gohelper.findChildImage(self.viewGO, "left/bottom/#go_heroinfo/#go_lv/lv/#image_lvicon")
	self._txtlv = gohelper.findChildText(self.viewGO, "left/bottom/#go_heroinfo/#go_lv/lv/#txt_lv")
	self._imagetalenticon = gohelper.findChildImage(self.viewGO, "left/bottom/#go_heroinfo/#go_lv/talent/#image_talenticon")
	self._txttalentlv = gohelper.findChildText(self.viewGO, "left/bottom/#go_heroinfo/#go_lv/talent/#txt_talentlv")
	self._btnchangehero = gohelper.findChildButtonWithAudio(self.viewGO, "left/bottom/#btn_changehero")
	self._gospine = gohelper.findChild(self.viewGO, "left/#go_spine")
	self._gochangehero = gohelper.findChild(self.viewGO, "#go_changehero")
	self._btnchangeheroclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_changehero/#btn_changeheroclose")
	self._gotab1 = gohelper.findChild(self.viewGO, "right/top/#go_tab1")
	self._gotab2 = gohelper.findChild(self.viewGO, "right/top/#go_tab2")
	self._goscroll = gohelper.findChild(self.viewGO, "right/#go_scroll")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRecommedView:addEvents()
	self._btnchangehero:AddClickListener(self._btnchangeheroOnClick, self)
	self._btnchangeheroclose:AddClickListener(self._btnchangeherocloseOnClick, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnChangeHero, self._cuthHero, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._refreshHeroInfo, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshHeroInfo, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshHeroInfo, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, self._onJumpView, self)
end

function CharacterRecommedView:removeEvents()
	self._btnchangehero:RemoveClickListener()
	self._btnchangeheroclose:RemoveClickListener()
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnChangeHero, self._cuthHero, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._refreshHeroInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshHeroInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshHeroInfo, self)
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, self._onJumpView, self)
end

function CharacterRecommedView:_btnchangeherocloseOnClick()
	self.playChangeHeroAnimPlayer(self, CharacterRecommedEnum.AnimName.Close, self._hideChageHero, self)
end

function CharacterRecommedView:_btnchangeheroOnClick()
	gohelper.setActive(self._gochangehero.gameObject, true)
	self.playChangeHeroAnimPlayer(self, CharacterRecommedEnum.AnimName.Open, nil, self)
end

function CharacterRecommedView:_editableInitView()
	return
end

function CharacterRecommedView:onUpdateParam()
	return
end

function CharacterRecommedView:_hideChageHero()
	gohelper.setActive(self._gochangehero.gameObject, false)
	gohelper.setActive(self._golv, self._hideTab ~= CharacterRecommedEnum.TabSubType.DevelopGoals)
end

function CharacterRecommedView:onOpen()
	self._selectTab = self.viewParam.defaultTabId or CharacterRecommedEnum.TabSubType.RecommedGroup
	self._hideTab = self.viewParam.hideTab

	self:_initTab()
	self:_refreshHero(self.viewParam.heroId)
	self:_hideChageHero()
	self.playViewAnimPlayer(self, CharacterRecommedEnum.AnimName.Open, nil, self)
end

function CharacterRecommedView:_onJumpView(type)
	if type ~= CharacterRecommedEnum.JumpView.Dungeon then
		self:closeThis()
	end
end

function CharacterRecommedView:_refreshHero(heroId)
	if self._heroId == heroId then
		return
	end

	self._heroId = heroId

	self:_refreshHeroInfo()
end

function CharacterRecommedView:_cuthHero(heroId)
	if self._heroId == heroId then
		return
	end

	self._heroId = heroId

	self:playViewAnim(CharacterRecommedEnum.AnimName.Switch, 0, 0)
	TaskDispatcher.cancelTask(self._cuthHeroCb, self)
	TaskDispatcher.runDelay(self._cuthHeroCb, self, 0.16)
end

function CharacterRecommedView:_cuthHeroCb()
	self:_refreshHeroInfo()
	CharacterRecommedController.instance:dispatchEvent(CharacterRecommedEvent.OnCutHeroAnimCB, self._heroId)
end

function CharacterRecommedView:_refreshHeroInfo()
	local heroRecommendMO = CharacterRecommedModel.instance:getHeroRecommendMo(self._heroId)
	local heroConfig = heroRecommendMO:getHeroConfig()

	self._txtheroname.text = CharacterRecommedModel.instance:getHeroName(heroConfig.name, 52)

	local level = heroRecommendMO:getHeroLevel()
	local rank = heroRecommendMO:getHeroRank()
	local talent = heroRecommendMO:getTalentLevel()
	local showLevel = HeroConfig.instance:getShowLevel(level)

	self._txtlv.text = string.format("Lv.%s", showLevel)

	if rank > 1 then
		UISpriteSetMgr.instance:setUiCharacterSprite(self._imagelvicon, "character_recommend_targeticon" .. rank + 3, true)
		gohelper.setActive(self._imagelvicon.gameObject, true)
	else
		gohelper.setActive(self._imagelvicon.gameObject, false)
	end

	self._txttalentlv.text = string.format("Lv.%s", talent)

	UISpriteSetMgr.instance:setUiCharacterSprite(self._imagetalenticon, "character_recommend_targeticon3", true)
	gohelper.setActive(self._btnchangehero.gameObject, heroRecommendMO:isOwnHero())

	local isShowRecommendTab = heroRecommendMO:isShowTeam() or heroRecommendMO:isShowEquip()

	gohelper.setActive(self._gotab1, isShowRecommendTab)
	self:_statEnterView(self._heroId)
end

function CharacterRecommedView:_initTab()
	if self._tabItems then
		return
	end

	self._tabItems = self:getUserDataTb_()

	for _, tab in pairs(CharacterRecommedEnum.TabSubType) do
		local item = self:_getTabItem(tab)

		gohelper.setActive(item.go, self._hideTab ~= tab)
		gohelper.setActive(item.goselect, tab == self._selectTab)
	end
end

function CharacterRecommedView:_getTabItem(tab)
	if self._tabItems[tab] then
		return self._tabItems[tab]
	end

	local go = gohelper.findChild(self.viewGO, "right/top/#go_tab" .. tab)

	if not go then
		logError("缺少这个页签:" .. tab)

		return
	end

	local item = self:getUserDataTb_()

	item.go = go
	item.goselect = gohelper.findChild(go, "#go_select")
	item.btntab = gohelper.findChildButtonWithAudio(go, "#btn_tab")

	item.btntab:AddClickListener(self._onClickTab, self, tab)

	self._tabItems[tab] = item

	return item
end

function CharacterRecommedView:_onClickTab(tab)
	if self._selectTab == tab then
		return
	end

	self._selectTab = tab

	self.viewContainer:cutTab(tab)
	self:_onRefreshTab()
end

function CharacterRecommedView:_onRefreshTab()
	if self._tabItems then
		for tab, item in pairs(self._tabItems) do
			gohelper.setActive(item.goselect, tab == self._selectTab)
		end
	end
end

function CharacterRecommedView:playViewAnim(animName, layer, normalizedTime)
	self._viewAnim = self._viewAnim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._viewAnim then
		self._viewAnim.enabled = true

		self._viewAnim:Play(animName, layer, normalizedTime)
	end
end

function CharacterRecommedView:playViewAnimPlayer(animName, cb, cbobj)
	self._viewAnimPlayer = self._viewAnimPlayer or SLFramework.AnimatorPlayer.Get(self.viewGO)

	if self._viewAnimPlayer then
		self._viewAnimPlayer:Play(animName, cb, cbobj)
	end
end

function CharacterRecommedView:playChangeHeroAnimPlayer(animName, cb, cbobj)
	self._changeHeroAnimPlayer = self._changeHeroAnimPlayer or SLFramework.AnimatorPlayer.Get(self._gochangehero)

	if self._changeHeroAnimPlayer then
		self._changeHeroAnimPlayer:Play(animName, cb, cbobj)
	end
end

function CharacterRecommedView:onClose()
	if self._tabItems then
		for _, item in pairs(self._tabItems) do
			item.btntab:RemoveClickListener()
		end
	end

	self._tabItems = nil

	TaskDispatcher.cancelTask(self._cuthHeroCb, nil)

	if ViewMgr.instance:isOpen(ViewName.SummonADView) then
		ViewMgr.instance:closeView(ViewName.SummonADView)
		VirtualSummonScene.instance:close(true)
	end
end

function CharacterRecommedView:onDestroyView()
	return
end

function CharacterRecommedView:_statEnterView(heroId)
	if self._lastStatId == heroId then
		return
	end

	self._lastStatId = heroId

	local heroCfg = HeroConfig.instance:getHeroCO(heroId)

	if heroCfg then
		local chineseViewNameStr = (StatViewNameEnum.ChineseViewName[self.viewName] or self.viewName) .. "-" .. (heroCfg.name or "")

		StatViewController.instance:trackViewName(chineseViewNameStr)
	end
end

return CharacterRecommedView
