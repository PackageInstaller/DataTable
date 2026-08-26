-- chunkname: @modules/logic/herogrouppreset/view/HeroGroupPresetTowerAssistBossItem.lua

module("modules.logic.herogrouppreset.view.HeroGroupPresetTowerAssistBossItem", package.seeall)

local HeroGroupPresetTowerAssistBossItem = class("HeroGroupPresetTowerAssistBossItem", ListScrollCellExtend)

function HeroGroupPresetTowerAssistBossItem:onInitView()
	self.goOpen = gohelper.findChild(self.viewGO, "root/go_open")
	self.goLock = gohelper.findChild(self.viewGO, "root/go_lock")
	self.goSelected = gohelper.findChild(self.viewGO, "root/go_selected")
	self.goUnSelect = gohelper.findChild(self.viewGO, "root/go_unselect")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "click")
	self.btnSure = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnSure")
	self.goSureBg = gohelper.findChild(self.viewGO, "root/btnSure/bg")
	self.btnCancel = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnCancel")
	self.goLevel = gohelper.findChild(self.viewGO, "root/level")
	self.txtLevel = gohelper.findChildTextMesh(self.viewGO, "root/level/#txt_level")
	self.goArrow = gohelper.findChild(self.viewGO, "root/level/#go_Arrow")
	self.goTrial = gohelper.findChild(self.viewGO, "root/go_trial")
	self.goTrialEffect = gohelper.findChild(self.viewGO, "root/#saoguang")
	self.hasPlayTrialEffect = false
	self.itemList = {}

	self:createItem(self.goOpen)
	self:createItem(self.goLock)
	self:createItem(self.goSelected)
	self:createItem(self.goUnSelect)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupPresetTowerAssistBossItem:addEvents()
	self.addClickCb(self, self.btnClick, self.onBtnClick, self)
	self.addClickCb(self, self.btnSure, self.onBtnSure, self)
	self.addClickCb(self, self.btnCancel, self.onBtnCancel, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.ResetTalent, self._onResetTalent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.ActiveTalent, self._onActiveTalent, self)
end

function HeroGroupPresetTowerAssistBossItem:removeEvents()
	self:removeClickCb(self.btnClick)
	self:removeClickCb(self.btnSure)
	self:removeClickCb(self.btnCancel)
end

function HeroGroupPresetTowerAssistBossItem:_editableInitView()
	return
end

function HeroGroupPresetTowerAssistBossItem:_onResetTalent(talentId)
	self:refreshTalent()
end

function HeroGroupPresetTowerAssistBossItem:_onActiveTalent(talentId)
	self:refreshTalent()
end

function HeroGroupPresetTowerAssistBossItem:onBtnSure()
	do
		local heroGroupMO = self:_getHeroGroupMo()

		heroGroupMO:setAssistBossId(self._mo.bossId)
		self:saveGroup()

		return
	end

	if not self._mo then
		return
	end

	local isLock = self._mo.isLock == 1 and not self.isLimitedTrial

	if isLock then
		GameFacade.showToast(ToastEnum.TowerAssistBossLock)

		return
	end

	local param = TowerModel.instance:getRecordFightParam()

	if param.isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)

		return
	end

	local isBossTower = param.towerType == TowerEnum.TowerType.Boss

	if isBossTower then
		GameFacade.showToast(ToastEnum.TowerAssistBossCannotChange)

		return
	end

	if TowerModel.instance:isBossBan(self._mo.bossId) then
		GameFacade.showToast(ToastEnum.TowerAssistBossBan, self._mo.config.name)

		return
	end

	local heroGroupMO = self:_getHeroGroupMo()

	heroGroupMO:setAssistBossId(self._mo.bossId)
	self:saveGroup()
end

function HeroGroupPresetTowerAssistBossItem:onBtnCancel()
	local param = TowerModel.instance:getRecordFightParam()

	if param.isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)

		return
	end

	local isBossTower = param.towerType == TowerEnum.TowerType.Boss

	if isBossTower then
		GameFacade.showToast(ToastEnum.TowerAssistBossCannotChange)

		return
	end

	local heroGroupMO = self:_getHeroGroupMo()

	heroGroupMO:setAssistBossId(0)
	self:saveGroup()
end

function HeroGroupPresetTowerAssistBossItem:_getHeroGroupMo()
	if self._viewParam.otherParam and self._viewParam.otherParam.heroGroupMO then
		return self._viewParam.otherParam.heroGroupMO
	end

	return HeroGroupModel.instance:getCurGroupMO()
end

function HeroGroupPresetTowerAssistBossItem:saveGroup()
	if self._viewParam.otherParam and self._viewParam.otherParam.saveGroup then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		self._viewParam.otherParam.saveGroup()

		return
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
end

function HeroGroupPresetTowerAssistBossItem:onBtnClick()
	do return end

	if not self._mo then
		return
	end

	local isLock = self._mo.isLock == 1 and not self.isLimitedTrial

	if isLock then
		GameFacade.showToast(ToastEnum.TowerAssistBossLock)

		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossDetailView, {
		bossId = self._mo.bossId,
		isFromHeroGroup = self._mo.isFromHeroGroup
	})
end

function HeroGroupPresetTowerAssistBossItem:createItem(go)
	local item = self:getUserDataTb_()

	item.go = go
	item.txtName = gohelper.findChildTextMesh(go, "name/#txt_name")
	item.imgCareer = gohelper.findChildImage(go, "career")
	item.simageBoss = gohelper.findChildSingleImage(go, "#simage_bossicon")
	item.goTxtOpen = gohelper.findChild(go, "toptips")
	self.itemList[go] = item
end

function HeroGroupPresetTowerAssistBossItem:onUpdateMO(mo, viewParam)
	self._mo = mo
	self._viewParam = viewParam

	local curTowerType = TowerModel.instance:getCurTowerType()
	local islimitedTower = curTowerType == TowerEnum.TowerType.Limited
	local isLock = mo.isLock == 1 and not islimitedTower

	isLock = false

	local activeGO = self.goOpen

	if mo.isFromHeroGroup then
		activeGO = mo.isSelect and self.goSelected or self.goUnSelect

		gohelper.setActive(self.btnSure, not mo.isSelect)
		gohelper.setActive(self.btnCancel, mo.isSelect)

		local isGray = mo.isBanOrder == 1 or isLock

		ZProj.UGUIHelper.SetGrayscale(self.goSureBg, isGray)
	else
		gohelper.setActive(self.btnSure, false)
		gohelper.setActive(self.btnCancel, false)
	end

	for k, v in pairs(self.itemList) do
		self:updateItem(v, (isLock or nil) and self.goLock)
	end

	local showLev = not isLock

	showLev = false

	gohelper.setActive(self.goLevel, false)

	if showLev then
		local curBossLevel = 1

		if self._mo.bossInfo and not self._mo.bossInfo:getTempState() then
			curBossLevel = self._mo.bossInfo.level

			local limitedTrialLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

			self.isLimitedTrial = islimitedTower and curBossLevel < limitedTrialLevel

			if self.isLimitedTrial then
				curBossLevel = limitedTrialLevel

				TowerAssistBossModel.instance:setLimitedTrialBossInfo(self._mo.bossInfo)
			else
				self._mo.bossInfo:setTrialInfo(0, 0)
				self._mo.bossInfo:refreshTalent()
			end
		else
			curBossLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

			TowerAssistBossModel.instance:getTempUnlockTrialBossMO(self._mo.id)

			self.isLimitedTrial = true
		end

		local bossLev = curBossLevel

		self.txtLevel.text = tostring(bossLev)

		SLFramework.UGUI.GuiHelper.SetColor(self.txtLevel, self.isLimitedTrial and "#81A8DC" or "#DCAE70")
	end

	gohelper.setActive(self.goTrial, self.isLimitedTrial)
	gohelper.setActive(self.goTrialEffect, false)
	gohelper.setActive(self.goTrialEffect, self.isLimitedTrial and not self.hasPlayTrialEffect)

	self.hasPlayTrialEffect = true

	self:refreshTalent()
end

function HeroGroupPresetTowerAssistBossItem:refreshTalent()
	gohelper.setActive(self.goArrow, self._mo.bossInfo and self._mo.bossInfo:hasTalentCanActive() and not self.isLimitedTrial or false)
end

function HeroGroupPresetTowerAssistBossItem:updateItem(item, activeGO)
	local isActive = item.go == activeGO

	gohelper.setActive(item.go, isActive)

	if not isActive then
		return
	end

	item.txtName.text = self._mo.config.name

	UISpriteSetMgr.instance:setCommonSprite(item.imgCareer, string.format("lssx_%s", self._mo.config.career))
	item.simageBoss:LoadImage(self._mo.config.bossPic)
	gohelper.setActive(item.goTxtOpen, false)
end

function HeroGroupPresetTowerAssistBossItem:onDestroyView()
	for k, v in pairs(self.itemList) do
		v.simageBoss:UnLoadImage()
	end
end

return HeroGroupPresetTowerAssistBossItem
