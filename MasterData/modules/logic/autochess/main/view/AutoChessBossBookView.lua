-- chunkname: @modules/logic/autochess/main/view/AutoChessBossBookView.lua

module("modules.logic.autochess.main.view.AutoChessBossBookView", package.seeall)

local AutoChessBossBookView = class("AutoChessBossBookView", BaseView)

function AutoChessBossBookView:onInitView()
	self._scrollBoss = gohelper.findChildScrollRect(self.viewGO, "#scroll_Boss")
	self._goBossItem = gohelper.findChild(self.viewGO, "#scroll_Boss/viewport/content/#go_BossItem")
	self._goBadge = gohelper.findChild(self.viewGO, "#go_Badge")
	self._goDetail = gohelper.findChild(self.viewGO, "#go_Detail")
	self._goBossMesh = gohelper.findChild(self.viewGO, "#go_Detail/critters/#go_BossMesh")
	self._txtHp = gohelper.findChildText(self.viewGO, "#go_Detail/critters/Hp/#txt_Hp")
	self._txtAttack = gohelper.findChildText(self.viewGO, "#go_Detail/critters/Attack/#txt_Attack")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Detail/#txt_Name")
	self._goUnlock = gohelper.findChild(self.viewGO, "#go_Detail/#go_Unlock")
	self._txtUnlock = gohelper.findChildText(self.viewGO, "#go_Detail/#go_Unlock/#txt_Unlock")
	self._scrollDesc = gohelper.findChildScrollRect(self.viewGO, "#go_Detail/#scroll_Desc")
	self._txtSkillName = gohelper.findChildText(self.viewGO, "#go_Detail/#scroll_Desc/viewport/content/#txt_SkillName")
	self._txtSkillDesc = gohelper.findChildText(self.viewGO, "#go_Detail/#scroll_Desc/viewport/content/#txt_SkillDesc")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessBossBookView:_editableInitView()
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.actMo = Activity182Model.instance:getActMo()
	self.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goBossMesh, AutoChessMeshComp)
	self.chessCfgList = {}
	self.newBossIdList = {}
end

function AutoChessBossBookView:onOpen()
	self.bossCfgList = lua_auto_chess_boss.configList
	self.bossItemList = {}

	for k, cfg in ipairs(self.bossCfgList) do
		local bossItem = self:getUserDataTb_()
		local go = gohelper.cloneInPlace(self._goBossItem)

		bossItem.transform = go.transform
		bossItem.goSelectBg = gohelper.findChild(go, "go_selectbg")

		local goLock = gohelper.findChild(go, "go_lock")
		local imageTabL = gohelper.findChildImage(go, "go_lock/image_tab")

		UISpriteSetMgr.instance:setAutoChessSprite(imageTabL, cfg.smallImage)

		local txtUnlock = gohelper.findChildText(go, "go_lock/txt_unlock")
		local unlockLvl = AutoChessConfig.instance:getBossUnlockLevel(cfg.id)

		txtUnlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_warnlevel_unlock"), unlockLvl)

		local goUnlock = gohelper.findChild(go, "go_unlock")
		local imageTab = gohelper.findChildImage(go, "go_unlock/image_tab")

		UISpriteSetMgr.instance:setAutoChessSprite(imageTab, cfg.smallImage)

		bossItem.goSelect = gohelper.findChild(go, "go_select")

		local btnClick = gohelper.findChildButtonWithAudio(go, "btn_click")

		self.addClickCb(self, btnClick, self._btnOnClick, self, k)

		bossItem.goNew = gohelper.findChild(go, "go_new")
		self.bossItemList[k] = bossItem

		local unlockLevel = AutoChessConfig.instance:getBossUnlockLevel(cfg.id)
		local isLock = unlockLevel > self.actMo.warnLevel

		if not isLock then
			local isNew = AutoChessHelper.getUnlockReddot(AutoChessStrEnum.ClientReddotKey.Boss, cfg.id)

			if isNew then
				self.newBossIdList[#self.newBossIdList + 1] = cfg.id
			end

			gohelper.setActive(bossItem.goNew, isNew)
		end

		gohelper.setActive(goLock, isLock)
		gohelper.setActive(goUnlock, not isLock)

		self.chessCfgList[k] = AutoChessConfig.instance:getChessCfg(cfg.id)
	end

	gohelper.setActive(self._goBossItem, false)
	self:_btnOnClick(1, true)
end

function AutoChessBossBookView:_btnOnClick(index, manually)
	if self.selectIndex == index then
		return
	end

	self.selectIndex = index

	for k, item in ipairs(self.bossItemList) do
		gohelper.setActive(item.goSelect, k == index)
		gohelper.setActive(item.goSelectBg, k == index)

		local z = k == index and 5.6 or 0

		transformhelper.setLocalRotation(item.transform, 0, 0, z)
	end

	if manually then
		self:refreshInfo()
	else
		self.anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(self.refreshInfo, self, 0.16)
	end
end

function AutoChessBossBookView:refreshInfo()
	local config = self.chessCfgList[self.selectIndex]

	self.meshComp:setData(config.image, true)

	self._txtName.text = config.name
	self._txtHp.text = config.hp
	self._txtAttack.text = config.attack
	self._txtSkillDesc.text = config.skillDesc

	local unlockLvl = AutoChessConfig.instance:getBossUnlockLevel(config.id)

	self._txtUnlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_warnlevel_unlock"), unlockLvl)

	gohelper.setActive(self._goUnlock, unlockLvl > self.actMo.warnLevel)
end

function AutoChessBossBookView:onDestroyView()
	if #self.newBossIdList > 0 then
		for _, id in ipairs(self.newBossIdList) do
			AutoChessHelper.setUnlockReddot(AutoChessStrEnum.ClientReddotKey.Boss, id)
		end

		AutoChessController.instance:dispatchEvent(AutoChessEvent.updateCultivateReddot)
	end

	TaskDispatcher.cancelTask(self.refreshInfo, self)
end

return AutoChessBossBookView
