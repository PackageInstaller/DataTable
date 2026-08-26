-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaEquipView.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEquipView", package.seeall)

local AiZiLaEquipView = class("AiZiLaEquipView", BaseView)

function AiZiLaEquipView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._goequipitem = gohelper.findChild(self.viewGO, "Left/Sticker1/#go_equipitem")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Right/#txt_Title")
	self._txtEffect = gohelper.findChildText(self.viewGO, "Right/#txt_Effect")
	self._txtNextEffect = gohelper.findChildText(self.viewGO, "Right/#txt_Effect/#txt_NextEffect")
	self._goLv = gohelper.findChild(self.viewGO, "Right/#go_Lv")
	self._txtlevel = gohelper.findChildText(self.viewGO, "Right/#go_Lv/#txt_level")
	self._txtnextlevel = gohelper.findChildText(self.viewGO, "Right/#go_Lv/#txt_nextlevel")
	self._scrolluplevelItem = gohelper.findChildScrollRect(self.viewGO, "Right/#go_Lv/#scroll_uplevelItem")
	self._gouplevelItems = gohelper.findChild(self.viewGO, "Right/#go_Lv/#scroll_uplevelItem/Viewport/#go_uplevelItems")
	self._btnuplevel = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Lv/Btn/#btn_uplevel")
	self._goRedPoint = gohelper.findChild(self.viewGO, "Right/#go_Lv/Btn/#btn_uplevel/#go_RedPoint")
	self._btnunUplevel = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Lv/Btn/#btn_unUplevel")
	self._goLvMax = gohelper.findChild(self.viewGO, "Right/#go_LvMax")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaEquipView:addEvents()
	self._btnuplevel:AddClickListener(self._btnuplevelOnClick, self)
	self._btnunUplevel:AddClickListener(self._btnunUplevelOnClick, self)
end

function AiZiLaEquipView:removeEvents()
	self._btnuplevel:RemoveClickListener()
	self._btnunUplevel:RemoveClickListener()
end

function AiZiLaEquipView:_btnclickOnClick()
	return
end

function AiZiLaEquipView:_btnuplevelOnClick()
	if self._isLockUpLevel then
		GameFacade.showToast(ToastEnum.V1a5AiZiLaUpLevelInGame)

		return
	end

	if not self._equipCfg then
		local equipCfg = self._nextEquipCfg

		if equipCfg and equipCfg.equipId and not self:_isLockType(equipCfg.typeId) then
			self:_setLockType(equipCfg.typeId, 0.5)
			Activity144Rpc.instance:sendAct144UpgradeEquipRequest(self._actId, equipCfg.equipId)
		end
	end
end

function AiZiLaEquipView:_btnunUplevelOnClick()
	GameFacade.showToast((self._isLockUpLevel or nil) and (ToastEnum.V1a5AiZiLaUpLevelInGame or ToastEnum.V1a5AiZiLaUpLevelItemLack))
end

function AiZiLaEquipView:_editableInitView()
	self._animator = self.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	self._animatorRight = gohelper.findChildComponent(self.viewGO, "Right", AiZiLaEnum.ComponentType.Animator)
	self._equipItemList = {}
	self._actId = VersionActivity1_5Enum.ActivityId.AiZiLa
	self._equipCoTypeList = AiZiLaConfig.instance:getEquipCoTypeList(self._actId)
	self._upLevelNextTimeDic = {}

	for i, cfg in ipairs(self._equipCoTypeList) do
		local parentGO = gohelper.findChild(self.viewGO, "Left/Sticker" .. i)
		local cloneGO = gohelper.clone(self._goequipitem, parentGO, "go_equipitem")
		local equipItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGO, AiZiLaEquipItem, self)

		if self._selectTypeId == nil then
			self._selectTypeId = cfg.typeId
		end

		equipItem:setCfg(cfg)
		table.insert(self._equipItemList, equipItem)
	end

	gohelper.setActive(self._goequipitem, false)

	self._goodsItemGo = self:getResInst(AiZiLaGoodsItem.prefabPath2, self.viewGO)

	gohelper.setActive(self._goodsItemGo, false)
end

function AiZiLaEquipView:onUpdateParam()
	return
end

function AiZiLaEquipView:onOpen()
	self._isLockUpLevel = ViewMgr.instance:isOpen(ViewName.AiZiLaGameView)

	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self.closeThis, self)
	end

	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.UISelectEquipType, self._onSelectEquitType, self)
	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.OnEquipUpLevel, self._onEquipUpLevel, self)
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper2)
	self:refreshUI()
end

function AiZiLaEquipView:onClose()
	return
end

function AiZiLaEquipView:onDestroyView()
	TaskDispatcher.cancelTask(self._onDelayRefreshUI, self)
end

function AiZiLaEquipView:_onEquipUpLevel(newEquipId)
	local actId = AiZiLaModel.instance:getCurActivityID()
	local equipCfg = AiZiLaConfig.instance:getEquipCo(actId, newEquipId)

	if equipCfg then
		if self._selectTypeId == equipCfg.typeId and self._animatorRight then
			self:_refreshData()

			if not self._isDelayRefreshUIIng then
				self._isDelayRefreshUIIng = true

				self._animatorRight:Play("refresh", 0, 0)
				self:_setLockType(equipCfg.typeId, 0.53)
				TaskDispatcher.runDelay(self._onDelayRefreshUI, self, 0.5)
				AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_equip_update)
			end
		else
			self:refreshUI()
		end

		self:_refreshEquipItemUpLevel(equipCfg.typeId)
	else
		self:refreshUI()
	end
end

function AiZiLaEquipView:_onDelayRefreshUI()
	self._isDelayRefreshUIIng = false

	self:refreshUI()
end

function AiZiLaEquipView:_onSelectEquitType(typeId)
	self._selectTypeId = typeId

	self:refreshUI()
end

function AiZiLaEquipView:_refreshData()
	self._selectEquipMO = AiZiLaModel.instance:getEquipMO(self._selectTypeId)

	if self._selectEquipMO then
		self._equipCfg = self._selectEquipMO:getConfig()
		self._nextEquipCfg = self._selectEquipMO:getNextConfig()
		self._costparams = self._selectEquipMO:getCostParams()
	else
		self._equipCfg = nil
		self._nextEquipCfg = self:_findInitCfg(self._selectTypeId)
		self._costparams = AiZiLaHelper.getCostParams(self._nextEquipCfg)
	end
end

function AiZiLaEquipView:refreshUI()
	self:_refreshData()

	local isMaxLevel = false

	if self._selectEquipMO then
		isMaxLevel = self._selectEquipMO:isMaxLevel()
		self._txtlevel.text = formatLuaLang("v1a5_aizila_level", self._equipCfg.level)
		self._txtEffect.text = formatLuaLang("v1a5_aizila_equip_effect", self._equipCfg.effectDesc)
		self._txtTitle.text = self._equipCfg.name
	else
		self._txtlevel.text = luaLang("v1a5_aizila_nolevel")
		self._txtEffect.text = luaLang("v1a5_aizila_equip_noeffect")
		self._txtTitle.text = self._nextEquipCfg.name
	end

	if not isMaxLevel then
		self._txtnextlevel.text = formatLuaLang("v1a5_aizila_level", self._nextEquipCfg.level)
		self._txtNextEffect.text = formatLuaLang("v1a5_aizila_equip_effect_nextlv", self._nextEquipCfg.effectDesc)

		local isCan = not self._isLockUpLevel and AiZiLaHelper.checkCostParams(self._costparams)

		gohelper.setActive(self._btnuplevel, isCan)
		gohelper.setActive(self._btnunUplevel, not isCan)
		RedDotController.instance:addRedDot(self._goRedPoint, RedDotEnum.DotNode.V1a5AiZiLaEquipUpLevel, self._selectTypeId)
	end

	gohelper.setActive(self._goLvMax, isMaxLevel)
	gohelper.setActive(self._goLv, not isMaxLevel)
	gohelper.setActive(self._txtnextlevel, not isMaxLevel)
	gohelper.setActive(self._txtNextEffect, not isMaxLevel)
	gohelper.CreateObjList(self, self._onShowUplevelItem, self._costparams, self._gouplevelItems, self._goodsItemGo, AiZiLaGoodsItem)
	self:_refreshEquipItem()
end

function AiZiLaEquipView:_onShowUplevelItem(cell_component, data, index)
	cell_component:onUpdateMO(data)

	if cell_component._isUpLevelInit ~= true then
		cell_component._isUpLevelInit = true

		cell_component:setShowCount(true, false)
	end

	local count = data.itemNum
	local quantity = AiZiLaModel.instance:getItemQuantity(data.itemId)
	local color = quantity < count and "#de4618" or "#4a7900"

	cell_component:setCountStr(string.format("<color=%s>%s</color><color=#3C322B>/%s</color>", color, quantity, count))
end

function AiZiLaEquipView:_findInitCfg(typeId)
	for i, equipCfg in ipairs(self._equipCoTypeList) do
		if equipCfg.typeId == typeId then
			return equipCfg
		end
	end
end

function AiZiLaEquipView:_refreshEquipItem()
	for i, item in ipairs(self._equipItemList) do
		item:onSelect(item:getTypeId() == self._selectTypeId)
		item:refreshUI(self._isLockUpLevel)
	end
end

function AiZiLaEquipView:_refreshEquipItemUpLevel(typeId)
	for i, item in ipairs(self._equipItemList) do
		if item:getTypeId() == typeId then
			item:refreshUpLevel()
		end
	end
end

function AiZiLaEquipView:playViewAnimator(animName)
	if self._animator then
		self._animator.enabled = true

		self._animator:Play(animName, 0, 0)
	end
end

function AiZiLaEquipView:_isLockType(equipType)
	if equipType and self._upLevelNextTimeDic[equipType] and self._upLevelNextTimeDic[equipType] > Time.time then
		return true
	end

	return false
end

function AiZiLaEquipView:_setLockType(equipType, lockTime)
	if equipType and lockTime then
		self._upLevelNextTimeDic[equipType] = Time.time + lockTime
	end
end

return AiZiLaEquipView
