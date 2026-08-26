-- chunkname: @modules/logic/herogrouppreset/view/HeroGroupPresetTeamHeroItem.lua

module("modules.logic.herogrouppreset.view.HeroGroupPresetTeamHeroItem", package.seeall)

local HeroGroupPresetTeamHeroItem = class("HeroGroupPresetTeamHeroItem", ListScrollCellExtend)

function HeroGroupPresetTeamHeroItem:onInitView()
	self._btnclickequip = gohelper.findChildButtonWithAudio(self.viewGO, "go_equipicon/#btn_clickequip")
	self._btnclickhero = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_clickhero")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupPresetTeamHeroItem:addEvents()
	self._btnclickequip:AddClickListener(self._btnclickequipOnClick, self)
	self._btnclickhero:AddClickListener(self._btnclickheroOnClick, self)
end

function HeroGroupPresetTeamHeroItem:removeEvents()
	self._btnclickequip:RemoveClickListener()
	self._btnclickhero:RemoveClickListener()
end

function HeroGroupPresetTeamHeroItem:_btnclickheroOnClick()
	if not self._unLock then
		local lockDesc, param = HeroGroupModel.instance:getPositionLockDesc(self._index)

		GameFacade.showToast(lockDesc, param)

		return
	end

	if HeroGroupPresetController.instance:isFightScene() then
		GameFacade.showToast(ToastEnum.HeroGroupPresetCannotEditTip)

		return
	end

	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.ClickHero, self._heroGroupMo, self._index)
end

function HeroGroupPresetTeamHeroItem:_btnclickequipOnClick()
	if not self._unLock then
		local lockDesc, param = HeroGroupModel.instance:getPositionLockDesc(self._index)

		GameFacade.showToast(lockDesc, param)

		return
	end

	if HeroGroupPresetController.instance:isFightScene() then
		GameFacade.showToast(ToastEnum.HeroGroupPresetCannotEditTip)

		return
	end

	local param = {
		heroMo = self._heroMO,
		equipMo = self._equipMO,
		posIndex = self._index - 1,
		fromView = EquipEnum.FromViewEnum.FromPresetPreviewView
	}

	if self.trialCO then
		param.heroMo = HeroGroupTrialModel.instance:getHeroMo(self.trialCO)

		if self.trialCO.equipId > 0 then
			param.equipMo = param.heroMo.trialEquipMo
		end
	end

	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.ClickEquip, self._heroGroupMo, param)
end

function HeroGroupPresetTeamHeroItem:_editableInitView()
	self.gocontainer = gohelper.findChild(self.viewGO, "go_container")
	self.simageheroicon = gohelper.findChildSingleImage(self.viewGO, "go_container/simage_heroicon")
	self.imagecareer = gohelper.findChildImage(self.viewGO, "go_container/image_career")
	self.goaidtag = gohelper.findChild(self.viewGO, "go_container/go_aidtag")
	self.gostorytag = gohelper.findChild(self.viewGO, "go_container/go_storytag")
	self.imageinsight = gohelper.findChildImage(self.viewGO, "go_container/level/layout/image_insight")
	self.txtlevel = gohelper.findChildText(self.viewGO, "go_container/level/layout/txt_level")
	self.goempty = gohelper.findChild(self.viewGO, "go_empty")
	self.golock = gohelper.findChild(self.viewGO, "go_lock")
	self.goleader = gohelper.findChild(self.viewGO, "go_container/go_leader")
	self.goequip = gohelper.findChild(self.viewGO, "go_equipicon")
	self.goequipempty = gohelper.findChild(self.viewGO, "go_equipicon/empty")
	self.equipicon = gohelper.findChildSingleImage(self.viewGO, "go_equipicon/equipicon")

	gohelper.setActive(self.goleader, false)
end

function HeroGroupPresetTeamHeroItem:_editableAddEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onDeleteEquip, self._showEquip, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onBreakSuccess, self._showEquip, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipStrengthenReply, self._showEquip, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipRefineReply, self._showEquip, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self._showEquip, self)
end

function HeroGroupPresetTeamHeroItem:_editableRemoveEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function HeroGroupPresetTeamHeroItem:_onCloseViewFinish(viewName)
	if viewName == ViewName.CharacterSkinView then
		self:_updateHeroIcon()
	end
end

function HeroGroupPresetTeamHeroItem:_updateHeroIcon()
	local skinConfig, heroConfig, heroId
	local heroData = self._heroData

	if heroData then
		heroConfig = HeroConfig.instance:getHeroCO(heroData.heroId)

		local heroMo = HeroModel.instance:getByHeroId(heroData.heroId)

		if heroMo then
			if not heroMo.skin then
				local skinId = heroConfig.skinId

				self.simageheroicon:LoadImage(ResUrl.getHeadIconSmall(SkinConfig.instance:getSkinCo(skinId).headIcon))
			end
		end
	end
end

function HeroGroupPresetTeamHeroItem:onUpdateMO(singleGroupMo, heroData, heroGroupMo, index)
	self._heroData = heroData
	self._heroGroupMo = heroGroupMo
	self._index = index
	self._singleGroupMo = singleGroupMo
	self._heroMO = singleGroupMo:getHeroMO()
	self.trialCO = singleGroupMo:getTrialCO()
	self._unLock = HeroGroupModel.instance:isPositionOpen(self._index)

	gohelper.setActive(self.golock, not self._unLock)
	gohelper.setActive(self.goequip, OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip))

	local skinConfig, heroConfig, showLevel, rankLevel, heroId

	if heroData then
		heroConfig = HeroConfig.instance:getHeroCO(heroData.heroId)

		local heroMo = HeroModel.instance:getByHeroId(heroData.heroId)

		if heroMo then
			if not heroMo.skin then
				local skinId = heroConfig.skinId

				skinConfig = SkinConfig.instance:getSkinCo(skinId)
				showLevel, rankLevel = HeroConfig.instance:getShowLevel(heroData.level)
			end
		end
	elseif self.trialCO then
		heroId = self.trialCO.heroId
		heroConfig = HeroConfig.instance:getHeroCO(self.trialCO.heroId)
		skinConfig = self.trialCO.skin > 0 and SkinConfig.instance:getSkinCo(self.trialCO.skin) or SkinConfig.instance:getSkinCo(heroConfig.skinId)
		showLevel, rankLevel = HeroConfig.instance:getShowLevel(self.trialCO.level)
	end

	gohelper.setActive(self.gocontainer, heroConfig)
	gohelper.setActive(self.goempty, not heroConfig)

	if heroConfig then
		gohelper.setActive(self.gostorytag, false)
		gohelper.setActive(self.goaidtag, self.trialCO)

		self.txtlevel.text = self:getShowLevelText(showLevel)

		if rankLevel > 1 then
			UISpriteSetMgr.instance:setHeroGroupSprite(self.imageinsight, "biandui_dongxi_" .. tostring(rankLevel - 1))
			gohelper.setActive(self.imageinsight.gameObject, true)
		else
			gohelper.setActive(self.imageinsight.gameObject, false)
		end

		self.simageheroicon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
		UISpriteSetMgr.instance:setCommonSprite(self.imagecareer, "lssx_" .. tostring(heroConfig.career))
	end

	self:_showEquip()

	local trialEquipCO

	if self.trialCO and self.trialCO.equipId > 0 then
		trialEquipCO = EquipConfig.instance:getEquipCo(self.trialCO.equipId)

		local equipCO = EquipConfig.instance:getEquipCo(self.trialCO.equipId)
		local showEquip = equipCO ~= nil

		gohelper.setActive(self.goequipempty, not showEquip)
		gohelper.setActive(self.equipicon, showEquip)

		if showEquip then
			self.equipicon:LoadImage(ResUrl.getEquipIcon(equipCO.icon))
		end
	end
end

function HeroGroupPresetTeamHeroItem:_showEquip()
	local heroGroupMo = self._heroGroupMo
	local index = self._index
	local equips = heroGroupMo and heroGroupMo:getPosEquips(index - 1).equipUid
	local equipId = equips and equips[1]

	if equipId then
		local var_12_0 = EquipModel.instance:getEquip(equipId)

		if not var_12_0 then
			if equipId then
				::label_12_0::

				var_12_0 = HeroGroupTrialModel.instance:getEquipMo(equipId)

				local equipMO = var_12_0
				local showEquip = equipMO ~= nil

				gohelper.setActive(self.goequipempty, not showEquip)
				gohelper.setActive(self.equipicon, showEquip)

				if showEquip then
					self.equipicon:LoadImage(ResUrl.getEquipIcon(equipMO.config.icon))
				end

				self._equipMO = equipMO
			end
		end
	end
end

function HeroGroupPresetTeamHeroItem:getShowLevelText(showLevel)
	return "<size=12>LV.</size>" .. tostring(showLevel)
end

function HeroGroupPresetTeamHeroItem:onDestroyView()
	return
end

return HeroGroupPresetTeamHeroItem
