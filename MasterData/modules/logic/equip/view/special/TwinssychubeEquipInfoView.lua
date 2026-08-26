-- chunkname: @modules/logic/equip/view/special/TwinssychubeEquipInfoView.lua

module("modules.logic.equip.view.special.TwinssychubeEquipInfoView", package.seeall)

local TwinssychubeEquipInfoView = class("TwinssychubeEquipInfoView", BaseView)

function TwinssychubeEquipInfoView:onInitView()
	self._gotips = gohelper.findChild(self.viewGO, "root/#go_tips")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gomasktip = gohelper.findChild(self.viewGO, "#bg_blackmask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TwinssychubeEquipInfoView:addEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self.onEquipChange, self)
end

function TwinssychubeEquipInfoView:removeEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self.onEquipChange, self)
end

function TwinssychubeEquipInfoView:onEquipChange()
	for i, item in ipairs(self._equips) do
		item.panel:_refresh()
	end
end

function TwinssychubeEquipInfoView:_onCloseViewFinish(viewName)
	if viewName == ViewName.EquipInfoTeamShowView then
		self:_refresh(false)
	end
end

function TwinssychubeEquipInfoView:_editableInitView()
	local gomiddle = gohelper.findChild(self.viewGO, "root/middle")

	self._animMiddle = gomiddle:GetComponent(typeof(UnityEngine.Animator))
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._equips = self:getUserDataTb_()

	for index, id in ipairs(CharacterEnum.TwinssychubeEquip) do
		local item = self:getUserDataTb_()

		item.roleRoot = gohelper.findChild(self.viewGO, "root/middle/role" .. index)
		item.btnlock = gohelper.findChildButtonWithAudio(item.roleRoot, "mask/#btn_lock")
		item.txtlock = gohelper.findChildText(item.roleRoot, "mask/#btn_lock/#txt_lock")
		item.rolelock = gohelper.findChild(item.roleRoot, "mask/role_lock")
		item.roleunlock = gohelper.findChild(item.roleRoot, "mask/role_unlock")
		item.anim = item.roleRoot:GetComponent(typeof(UnityEngine.Animator))

		local goPanel = gohelper.findChild(self.viewGO, "root/panel_" .. index)

		item.panel = MonoHelper.addNoUpdateLuaComOnceToGo(goPanel, TwinssychubeEquipInfoPanel)

		item.panel:initPanel(index, id)

		item.id = id
		self._equips[index] = item
	end
end

function TwinssychubeEquipInfoView:_refreshView(isOpen)
	self._heroMo = self.viewParam and self.viewParam.heroMo

	if not self._heroMo then
		return
	end

	local isActivate = EquipModel.instance:isActivateTwinssychubeEquip(self._heroMo)

	if self._heroMo then
		local heroEquipMo = EquipModel.instance:getEquip(self._heroMo.defaultEquipUid)
		local animName = "idle"

		if isActivate then
			animName = "all_unlock"
		end

		for i, item in ipairs(self._equips) do
			item.panel:onUpdateMO(self._heroMo, isOpen)

			local isEuqip = heroEquipMo and heroEquipMo.config.id == item.id
			local isHad = EquipModel.instance:haveEquip(item.id)

			if not isActivate and isEuqip then
				animName = i == 1 and "left" or "right"
			end

			local isUnlock = isActivate or isEuqip

			gohelper.setActive(item.btnlock.gameObject, not isUnlock)
			gohelper.setActive(item.rolelock, not isUnlock)
			gohelper.setActive(item.roleunlock, isUnlock)

			if not isUnlock then
				local txt = isHad and "p_sp02_twinspsychubeequipinfoview_2" or "p_sp02_twinspsychubeequipinfoview_3"

				item.txtlock.text = luaLang(txt)
			end

			local isNewUnlock = GameUtil.playerPrefsGetNumberByUserId(EquipEnum.sp02TwinssychubeUnlockKey .. item.id, 0) == 0
			local isPlayUnlock = isActivate or isEuqip

			if isPlayUnlock then
				item.isPlayUnlock = isOpen and isNewUnlock or not self._isPlayUnlock
			end

			self._isPlayUnlock = isPlayUnlock
		end

		if self._middleAnimName ~= animName then
			self._animMiddle:Play(animName, 0, 0)

			self._middleAnimName = animName
		end

		if isOpen then
			TaskDispatcher.runDelay(self._playUnlockAnim, self, 0.6)
		else
			self:_playUnlockAnim()
		end
	end
end

function TwinssychubeEquipInfoView:_playUnlockAnim()
	for i, item in ipairs(self._equips) do
		if item.isPlayUnlock then
			local animName = "unlock"

			if item.animName ~= animName then
				item.anim:Play(animName, 0, 0)
			end

			item.animName = animName
		end
	end
end

function TwinssychubeEquipInfoView:onUpdateParam()
	return
end

function TwinssychubeEquipInfoView:onOpen()
	self:_refresh(true)
	AudioMgr.instance:trigger(AudioEnum3_10.Twinssychube.play_ui_langchao_link_entry)
end

function TwinssychubeEquipInfoView:_refresh(isOpen)
	self:_refreshView(isOpen)

	if EquipModel.instance:isShowActivateDoubleTip() then
		self:_showTip()
	end
end

function TwinssychubeEquipInfoView:_showTip()
	gohelper.setActive(self._gomasktip, true)
	gohelper.setActive(self._gotips, true)
	TaskDispatcher.runDelay(self._hideTip, self, 1)
	AudioMgr.instance:trigger(AudioEnum3_10.Twinssychube.play_ui_langchao_link_additional_activation)
end

function TwinssychubeEquipInfoView:_hideTip()
	gohelper.setActive(self._gomasktip, false)
	gohelper.setActive(self._gotips, false)
	EquipModel.instance:setShowActivateDoubleTip(false)
end

function TwinssychubeEquipInfoView:onClose()
	TaskDispatcher.cancelTask(self._hideTip, self)
	TaskDispatcher.cancelTask(self._playUnlockAnim, self)
end

function TwinssychubeEquipInfoView:onDestroyView()
	for _, item in ipairs(self._equips) do
		item.btnlock:RemoveClickListener()
	end
end

return TwinssychubeEquipInfoView
