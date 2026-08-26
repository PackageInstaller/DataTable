-- chunkname: @modules/logic/udimo/view/UdimoInfoView.lua

module("modules.logic.udimo.view.UdimoInfoView", package.seeall)

local UdimoInfoView = class("UdimoInfoView", BaseViewExtended)

function UdimoInfoView:onInitView()
	self._txtNum = gohelper.findChildText(self.viewGO, "Root/Left/#txt_Num")
	self._goallinfo = gohelper.findChild(self.viewGO, "Root/Right")
	self._gorightup = gohelper.findChild(self.viewGO, "Root/Right/Up")
	self._txtName = gohelper.findChildText(self.viewGO, "Root/Right/Up/image_TitleBG/#txt_Name")
	self._goUnLocked = gohelper.findChild(self.viewGO, "Root/Right/Up/#go_Unlocked")
	self._goUnEquip = gohelper.findChild(self.viewGO, "Root/Right/Up/#go_Unlocked/#go_UnEquip")
	self._btnIn = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/Up/#go_Unlocked/#go_UnEquip/#btn_In")
	self._goEquip = gohelper.findChild(self.viewGO, "Root/Right/Up/#go_Unlocked/#go_Equip")
	self._btnOut = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/Up/#go_Unlocked/#go_Equip/#btn_Out")
	self._gospineNode = gohelper.findChild(self.viewGO, "Root/Right/Up/#go_spine")
	self._goLocked = gohelper.findChild(self.viewGO, "Root/Right/Up/#go_Locked")
	self._btnGet = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/Up/#go_Locked/#btn_Get")
	self._goEmpty = gohelper.findChild(self.viewGO, "Root/Right/Down/#go_Empty")
	self._txtEmpty = gohelper.findChildText(self.viewGO, "Root/Right/Down/#go_Empty/image_Bubble/#txt_Empty")
	self._goinfo = gohelper.findChild(self.viewGO, "Root/Right/Down/#go_info")
	self._txtTime = gohelper.findChildText(self.viewGO, "Root/Right/Down/#go_info/#txt_Time")
	self._goinfoContent = gohelper.findChild(self.viewGO, "Root/Right/Down/#go_info/ScrollView/Viewport/Content")
	self._goinfoItem = gohelper.findChild(self.viewGO, "Root/Right/Down/#go_info/ScrollView/Viewport/Content/#go_Item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function UdimoInfoView:addEvents()
	self._btnIn:AddClickListener(self._btnInOnClick, self)
	self._btnOut:AddClickListener(self._btnOutOnClick, self)
	self._btnGet:AddClickListener(self._btnGetOnClick, self)
	self._animEventWrap:AddEventListener("switch", self._onSwitchUdimo, self)
	self.addEventCb(self, UdimoController.instance, UdimoEvent.OnSelectInfoHeadItem, self._onSelectHeadItem, self)
	self.addEventCb(self, UdimoController.instance, UdimoEvent.OnChangeUidmoShow, self._onChangeUdimoShow, self)
end

function UdimoInfoView:removeEvents()
	self._btnIn:RemoveClickListener()
	self._btnOut:RemoveClickListener()
	self._btnGet:RemoveClickListener()
	self._animEventWrap:RemoveAllEventListener()
	self.removeEventCb(self, UdimoController.instance, UdimoEvent.OnSelectInfoHeadItem, self._onSelectHeadItem, self)
	self.removeEventCb(self, UdimoController.instance, UdimoEvent.OnChangeUidmoShow, self._onChangeUdimoShow, self)
end

function UdimoInfoView:_btnInOnClick()
	local selectedUdimoId = UdimoInfoListModel.instance:getSelectedUdimoId()

	UdimoController.instance:changUdimoShow(selectedUdimoId, true)
end

function UdimoInfoView:_btnOutOnClick()
	local selectedUdimoId = UdimoInfoListModel.instance:getSelectedUdimoId()

	UdimoController.instance:changUdimoShow(selectedUdimoId, false)
end

function UdimoInfoView:_btnGetOnClick()
	return
end

function UdimoInfoView:_onSwitchUdimo()
	self:refreshSelectedUdimoInfo()
end

function UdimoInfoView:_onSelectHeadItem(isOpen)
	if isOpen then
		self:refreshSelectedUdimoInfo()
	else
		self._animatorPlayer:Play("switch")
	end
end

function UdimoInfoView:_onChangeUdimoShow()
	self:refresh(true)
end

function UdimoInfoView:_editableInitView()
	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._infoAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._gorightup)

	self:clearUISpine()

	self._uiSpine = GuiSpine.Create(self._gospineNode, false)

	local uiCameraGO = CameraMgr.instance:getUICameraGO()
	local uiCustomCameraData = uiCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	self._originalUseRoleMask = uiCustomCameraData.useRoleMask
	uiCustomCameraData.useRoleMask = true
end

function UdimoInfoView:onUpdateParam()
	return
end

function UdimoInfoView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Udimo.play_ui_utim_xinxi)
	UdimoController.instance:selectInfoViewHeadItem(nil, true)
	self:refresh()
end

function UdimoInfoView:refresh(isPlay)
	self:refreshShowingCount()
	self:refreshSelectedUdimoInfo(isPlay)
end

function UdimoInfoView:refreshShowingCount()
	local lang = luaLang("room_wholesale_weekly_revenue")
	local showingCount = UdimoModel.instance:getUseUdimoCount()
	local maxShowingCount = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.MaxShowUdimoCount, true)

	self._txtNum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, showingCount, maxShowingCount)
end

function UdimoInfoView:refreshSelectedUdimoInfo(isPlay)
	local selectedUdimoId = UdimoInfoListModel.instance:getSelectedUdimoId()

	if not selectedUdimoId then
		gohelper.setActive(self._goallinfo, false)

		return
	end

	gohelper.setActive(self._goallinfo, true)

	local hasUnlock = UdimoModel.instance:isUnlockUdimo(selectedUdimoId)

	if hasUnlock then
		if isPlay then
			local isUse = UdimoModel.instance:isUseUdimo(selectedUdimoId)

			gohelper.setActive(self._goUnEquip, true)
			gohelper.setActive(self._goEquip, true)
			self._infoAnimatorPlayer:Play(isUse and "settled" or "evacuate", self.setEquipGOActive, self)

			if isUse then
				AudioMgr.instance:trigger(AudioEnum.Udimo.play_ui_utim_ruzhu)
			end
		else
			self:setEquipGOActive()
			self._infoAnimatorPlayer:Play("idle")
		end

		self._txtTime.text = UdimoModel.instance:getUdimoGetTimeStr(selectedUdimoId)

		local infoList = UdimoModel.instance:getInfoList(selectedUdimoId)

		self:com_createObjList(self.onShowInfoItem, infoList, self._goinfoContent, self._goinfoItem)
	else
		self._txtEmpty.text = ""
	end

	gohelper.setActive(self._goUnLocked, hasUnlock)
	gohelper.setActive(self._goinfo, hasUnlock)
	gohelper.setActive(self._goLocked, not hasUnlock)
	gohelper.setActive(self._goEmpty, not hasUnlock)

	self._txtName.text = UdimoConfig.instance:getName(selectedUdimoId)

	local res = UdimoConfig.instance:getUdimoSpineRes(selectedUdimoId)
	local spinePath = ResUrl.getUdimoPrefab(res, "ui")
	local curSpinePath = self._uiSpine:getResPath()
	local spineGo = self._uiSpine:getSpineGo()

	if spinePath and spinePath ~= curSpinePath or gohelper.isNil(spineGo) then
		gohelper.destroy(self._outlineEffGO)

		self._outlineEffGO = nil

		self._uiSpine:setResPath(spinePath, self._onSpineLoaded, self, true)
	end
end

function UdimoInfoView:_onSpineLoaded()
	if not self._uiSpine then
		return
	end

	local spineTr = self._uiSpine:getSpineTr()
	local selectedUdimoId = UdimoInfoListModel.instance:getSelectedUdimoId()
	local spineParam = UdimoConfig.instance:getUdimoSpineUIParam(selectedUdimoId)

	if spineParam then
		if not spineParam[1] then
			local posX = 0

			if spineParam then
				if not spineParam[2] then
					local posY = 0

					if spineParam then
						if not spineParam[3] then
							local scale = 1

							recthelper.setAnchor(spineTr, posX, posY)
							transformhelper.setLocalScale(spineTr, scale, scale, 1)

							local spineGraphic = self._uiSpine:getSkeletonGraphic()

							if spineGraphic then
								spineGraphic.raycastTarget = false
							end

							TaskDispatcher.cancelTask(self._checkSpineFreeze, self)
							TaskDispatcher.runDelay(self._checkSpineFreeze, self, 0.01)
						end
					end
				end
			end
		end
	end
end

function UdimoInfoView:_checkSpineFreeze()
	if not self._uiSpine then
		return
	end

	local selectedUdimoId = UdimoInfoListModel.instance:getSelectedUdimoId()
	local hasUnlock = UdimoModel.instance:isUnlockUdimo(selectedUdimoId)

	self._uiSpine:setFreezeState(not hasUnlock)

	self.outLineEffResPath = ResUrl.getEffect(UdimoEnum.Const.UdimoUIOutlineEff)

	if GameResMgr.IsFromEditorDir then
		self.outLineEffResAbPath = nil
	else
		self.outLineEffResAbPath = FightHelper.getEffectAbPath(self.outLineEffResPath)
	end

	self:com_loadAsset(self.outLineEffResAbPath or self.outLineEffResPath, self._onOutlineEffLoaded)
end

function UdimoInfoView:_onOutlineEffLoaded(loader)
	if self._uiSpine then
		local spineGo = self._uiSpine:getSpineGo()

		if gohelper.isNil(self._uiSpine) then
			return
		end

		local tarPrefab = loader:GetResource(self.outLineEffResPath)

		self._outlineEffGO = gohelper.clone(tarPrefab, self._uiSpine)
	end
end

function UdimoInfoView:setEquipGOActive()
	local selectedUdimoId = UdimoInfoListModel.instance:getSelectedUdimoId()
	local isUse = UdimoModel.instance:isUseUdimo(selectedUdimoId)

	gohelper.setActive(self._goUnEquip, not isUse)
	gohelper.setActive(self._goEquip, isUse)
end

function UdimoInfoView:onShowInfoItem(obj, data, index)
	local icon = gohelper.findChildImage(obj, "#image_Icon")

	UISpriteSetMgr.instance:setUdimoSprite(icon, data.icon)

	local txtDescr = gohelper.findChildText(obj, "#txt_Descr")

	txtDescr.text = data.text
end

function UdimoInfoView:clearUISpine()
	TaskDispatcher.cancelTask(self._checkSpineFreeze, self)

	if not self._uiSpine then
		return
	end

	self._uiSpine:doClear()

	self._uiSpine = nil
end

function UdimoInfoView:onClose()
	self:clearUISpine()

	local uiCameraGO = CameraMgr.instance:getUICameraGO()
	local uiCustomCameraData = uiCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	uiCustomCameraData.useRoleMask = self._originalUseRoleMask
	self._originalUseRoleMask = nil
end

function UdimoInfoView:onDestroyView()
	return
end

return UdimoInfoView
