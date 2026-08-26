-- chunkname: @modules/logic/versionactivity2_7/towergift/view/CharacterDestinyStoneUpView.lua

module("modules.logic.versionactivity2_7.towergift.view.CharacterDestinyStoneUpView", package.seeall)

local CharacterDestinyStoneUpView = class("CharacterDestinyStoneUpView", BaseView)

function CharacterDestinyStoneUpView:onInitView()
	self._godrag = gohelper.findChild(self.viewGO, "#go_drag")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#image_icon")
	self._txtstonename = gohelper.findChildText(self.viewGO, "root/#txt_stonename")
	self._gostone = gohelper.findChild(self.viewGO, "root/#go_stone")
	self._gooncefull = gohelper.findChild(self.viewGO, "root/btn/#go_oncefull")
	self._btnoncefull = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#go_oncefull/#btn_oncefull")
	self._gohasoncefull = gohelper.findChild(self.viewGO, "root/btn/#go_hasoncefull")
	self._gopoint = gohelper.findChild(self.viewGO, "root/point/#go_point")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goreshape = gohelper.findChild(self.viewGO, "root/#go_reshape")
	self._btnreshape = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_reshape/#btn_reshape")
	self._goreshapeeffect = gohelper.findChild(self.viewGO, "root/#go_reshapeeffect")
	self._goreshapeItem = gohelper.findChild(self.viewGO, "root/#go_reshapeeffect/#scroll_reshape")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDestinyStoneUpView:addEvents()
	self._btnoncefull:AddClickListener(self._btnoncefullOnClick, self)
	self._btnreshape:AddClickListener(self._btnreshapeOnClick, self)
	self.addEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUnlockStoneReply, self._onUnlockStoneReply, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
end

function CharacterDestinyStoneUpView:removeEvents()
	self._btnoncefull:RemoveClickListener()
	self._btnreshape:RemoveClickListener()
	self.removeEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUnlockStoneReply, self._onUnlockStoneReply, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
end

function CharacterDestinyStoneUpView:_btnreshapeOnClick()
	self:_showReshape(not self._isShowReshape, true)
end

function CharacterDestinyStoneUpView:_btnoncefullOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.CharacterDestinyStoneUpView, MsgBoxEnum.BoxType.Yes_No, self._useStoneUpTicket, nil, nil, self, nil, nil)
end

function CharacterDestinyStoneUpView:_useCallback()
	return
end

function CharacterDestinyStoneUpView:_useStoneUpTicket()
	local data = {}
	local o = {}

	o.materialId = self._materialId
	o.quantity = 1

	table.insert(data, o)
	ItemRpc.instance:sendUseItemRequest(data, self._curStoneMo.stoneId)
end

function CharacterDestinyStoneUpView:_onItemChanged()
	gohelper.setActive(self._gooncefull, false)
	gohelper.setActive(self._gohasoncefull, true)
	self:_playAnim()
	DestinyStoneGiftPickChoiceController.instance:dispatchEvent(DestinyStoneGiftPickChoiceEvent.hadStoneUp)
end

function CharacterDestinyStoneUpView:_playAnim()
	if self._isSlotMaxLevel then
		self._animator:Play("allup", 0, 0)
		self:_refreshStoneItem()
	elseif not self._curStoneMo.isUnlock then
		self._animator:Play("allup", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_unlock)

		function self._cb()
			TaskDispatcher.cancelTask(self._cb, self)
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2BPSP.play_ui_checkpoint_doom_disappear)
		end

		TaskDispatcher.runDelay(self._cb, self, 2.6)
		self:_refreshStoneItem()
	else
		self._animator:Play("allup", 0, 0)
		TaskDispatcher.runDelay(self._onPlayAnimBack, self, 2.6)
	end
end

function CharacterDestinyStoneUpView:_onPlayAnimBack()
	TaskDispatcher.cancelTask(self._onPlayAnimBack, self)

	if self._effectItems then
		for rank, item in ipairs(self._effectItems) do
			local isCanPlay = self._heroMO.destinyStoneMo:isCanPlayAttrUnlockAnim(self._curStoneMo.stoneId, rank)

			gohelper.setActive(item.gounlock, isCanPlay)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2BPSP.play_ui_checkpoint_doom_disappear)
	self:_refreshStoneItem()
end

function CharacterDestinyStoneUpView:_onUnlockStoneReply(heroId, stoneId)
	if self._curStoneMo then
		self._curStoneMo:refresUnlock(true)
	end

	self:_refreshStoneItem()
	gohelper.setActive(self._root, true)
	gohelper.setActive(self._gounlockstone, false)
end

function CharacterDestinyStoneUpView:_editableInitView()
	self._simagestone = gohelper.findChildSingleImage(self.viewGO, "root/#go_stone/#simage_stone")
	self._simagepre = gohelper.findChildSingleImage(self.viewGO, "root/#go_prestone/#btn_prestone")
	self._simagenext = gohelper.findChildSingleImage(self.viewGO, "root/#go_nextstone/#btn_nextstone")
	self._gounlockstone = gohelper.findChild(self.viewGO, "unlockstone")
	self._root = gohelper.findChild(self.viewGO, "root")
	self._goeffect = gohelper.findChild(self.viewGO, "root/effectItem")
	self._imgstone = gohelper.findChildImage(self.viewGO, "root/#go_stone/#simage_stone")
	self._goEquip = gohelper.findChild(self.viewGO, "root/#go_stone/#equip")
	self._animRoot = self._root:GetComponent(typeof(UnityEngine.Animator))
	self._animPlayerRoot = ZProj.ProjAnimatorPlayer.Get(self._root)
	self._animPlayerUnlockStone = ZProj.ProjAnimatorPlayer.Get(self._gounlockstone)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag.gameObject)
	self._goreshapeVX = gohelper.findChild(self.viewGO, "root/#go_stone/#reshape")
	self._simagereshape = gohelper.findChildSingleImage(self.viewGO, "root/#go_stone/#reshape/#simage_stone")
	self._simagestoneName = gohelper.findChildSingleImage(self.viewGO, "root/#simage_reshapeTitle")
	self._imagestoneName = gohelper.findChildImage(self.viewGO, "root/#simage_reshapeTitle")
	self._goreshapeselect = gohelper.findChild(self._btnreshape.gameObject, "selected")
	self._goreshapeunselect = gohelper.findChild(self._btnreshape.gameObject, "unselect")
	self._reshapeAnim = self._goreshape:GetComponent(typeof(UnityEngine.Animator))

	self:_initReshapeItem()
end

function CharacterDestinyStoneUpView:onUpdateParam()
	return
end

function CharacterDestinyStoneUpView:_addEvents()
	return
end

function CharacterDestinyStoneUpView:_removeEvents()
	return
end

function CharacterDestinyStoneUpView:onOpen()
	self:_addEvents()

	self._isShowReshape = false
	self._effectItems = self:getUserDataTb_()
	self._effectitemPrefab = gohelper.findChild(self._goeffect, "#scroll_effect")

	for i = 1, CharacterDestinyEnum.EffectItemCount do
		local item = self:_getEffectItem(i)

		gohelper.setActive(item.root, true)
	end

	self._materialId = self.viewParam.materialId
	self._heroMO = self.viewParam.heroMo
	self._curStoneMo = self.viewParam.stoneMo
	self._destinyStoneMo = self._heroMO.destinyStoneMo
	self._isSlotMaxLevel = self._destinyStoneMo:isSlotMaxLevel()

	if self._curStoneMo then
		if not self._unlockStoneView then
			self._unlockStoneView = MonoHelper.addNoUpdateLuaComOnceToGo(self._gounlockstone, CharacterDestinyUnlockStoneComp)

			self._unlockStoneView:setStoneView(self)
		end

		self._unlockStoneView:onUpdateMo(self._heroMO.heroId, self._curStoneMo.stoneId)
		self:_refreshStoneItem()
	end

	gohelper.setActive(self._root, true)
end

function CharacterDestinyStoneUpView:_getEffectItem(index)
	local item = self._effectItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.findChild(self._goeffect, index)

		item.go = go
		item.root = gohelper.clone(self._effectitemPrefab, go)
		item.lockicon = gohelper.findChildImage(item.root, "Viewport/Content/#go_decItem/#txt_dec/#go_lockicon")
		item.unlockicon = gohelper.findChildImage(item.root, "Viewport/Content/#go_decItem/#txt_dec/#go_unlockicon")
		item.txt = gohelper.findChildText(item.root, "Viewport/Content/#go_decItem/#txt_dec")
		item.gounlock = gohelper.findChild(item.root, "Viewport/Content/#go_decItem/#unlock")
		item.canvasgroup = item.root:GetComponent(typeof(UnityEngine.CanvasGroup))
		self._effectItems[index] = item
	end

	return item
end

function CharacterDestinyStoneUpView:_refreshStoneItem()
	if self._curStoneMo then
		self._levelCos = self._curStoneMo:getFacetCo()

		local conusmeCo = self._curStoneMo.conusmeCo

		if self._levelCos then
			for i, item in ipairs(self._effectItems) do
				local co = self._levelCos[i]

				item.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(item.txt.gameObject, SkillDescComp)

				item.skillDesc:updateInfo(item.txt, co.desc, self._heroMO.heroId)
				item.skillDesc:setTipParam(0, Vector2(300, 100))

				if self._curStoneMo.isUnlock then
					local isUnlock = i <= self._heroMO.destinyStoneMo.rank
					local color = item.txt.color

					color.a = isUnlock and 1 or 0.43
					item.txt.color = color

					if isUnlock then
						local color = item.unlockicon.color

						color.a = isUnlock and 1 or 0.43
						item.unlockicon.color = color
					else
						local color = item.lockicon.color

						color.a = isUnlock and 1 or 0.43
						item.lockicon.color = color
					end

					gohelper.setActive(item.lockicon.gameObject, not isUnlock)
					gohelper.setActive(item.unlockicon.gameObject, isUnlock)
				end
			end
		end

		gohelper.setActive(self._goEquip, self._curStoneMo.isUse)

		if conusmeCo then
			local name, icon = self._curStoneMo:getNameAndIcon()

			self._txtstonename.text = name

			self._simagestone:LoadImage(icon)
			self._simagereshape:LoadImage(icon)

			local tenp = CharacterDestinyEnum.SlotTend[conusmeCo.tend]
			local tendIcon = tenp.TitleIconName

			UISpriteSetMgr.instance:setUiCharacterSprite(self._imageicon, tendIcon)

			self._txtstonename.color = GameUtil.parseColor(tenp.TitleColor)
		end

		local isUnlock = self._curStoneMo.isUnlock

		if isUnlock then
			if not Color.white then
				self._imgstone.color = Color(0.5, 0.5, 0.5, 1)
			end
		end
	end

	self._pointItems = self._pointItems or self:getUserDataTb_()

	local isReshapeStone = self._curStoneMo:isReshape()

	gohelper.setActive(self._goreshape, isReshapeStone)
	gohelper.setActive(self._goreshapeVX, isReshapeStone)
	gohelper.setActive(self._txtstonename.gameObject, not isReshapeStone)
	gohelper.setActive(self._simagestoneName.gameObject, isReshapeStone)

	if isReshapeStone then
		local resName = self._curStoneMo.stoneId

		self._simagestoneName:LoadImage(ResUrl.getTxtDestinyIcon(resName), function()
			self._imagestoneName:SetNativeSize()
		end)
	end

	self:_showReshape(self._isShowReshape, false)
	self:_refreshReshape()
end

function CharacterDestinyStoneUpView:_getPointItem(index)
	local item = self._pointItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gopoint, index)

		item.go = go
		item.normal = gohelper.findChild(go, "normal")
		item.select = gohelper.findChild(go, "select")
		self._pointItems[index] = item
	end

	return item
end

function CharacterDestinyStoneUpView:_showReshape(show, isPlayAnim)
	gohelper.setActive(self._goreshapeselect, show)
	gohelper.setActive(self._goreshapeunselect, not show)

	self._isShowReshape = show

	TaskDispatcher.cancelTask(self._showReshapeEffect, self)

	if isPlayAnim then
		self._reshapeAnim:Play(CharacterDestinyEnum.SlotViewAnim.Switch, 0, 0)

		if show then
			if not CharacterDestinyEnum.StoneViewAnim.Switch_reshape then
				local animName = CharacterDestinyEnum.StoneViewAnim.Switch_normal

				self._animRoot:Play(animName, 0, 0)
				TaskDispatcher.runDelay(self._showReshapeEffect, self, 0.16)
			end
		end
	else
		self:_showReshapeEffect()
	end
end

function CharacterDestinyStoneUpView:_showReshapeEffect()
	gohelper.setActive(self._goeffect, not self._isShowReshape)
	gohelper.setActive(self._goreshapeeffect, self._isShowReshape)
end

function CharacterDestinyStoneUpView:_refreshReshape()
	local descList = self._curStoneMo:getReshapeDesc()
	local count = 0
	local isEquipReshapeAttr = self._destinyStoneMo:getEquipReshapeStoneCo(self._curStoneMo) ~= nil

	if descList then
		count = #descList

		for i = 1, #descList do
			local item = self._reshapeItems[i]
			local lang = luaLang("character_destinystone_reshape_lv")

			item.titleTxt.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, i)
			item.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(item.descTxt.gameObject, SkillDescComp)

			item.skillDesc:updateInfo(item.descTxt, descList[i], self._heroMO.heroId)
			item.skillDesc:setTipParam(0, Vector2(300, 100))

			item.cg.alpha = isEquipReshapeAttr and 1 or 0.43
		end
	end

	for i = 1, #self._reshapeItems do
		gohelper.setActive(self._reshapeItems[i].go, i <= count)
	end
end

function CharacterDestinyStoneUpView:_initReshapeItem()
	gohelper.setActive(self._goreshapeItem, false)

	self._reshapeItems = self:getUserDataTb_()

	for index = 1, 5 do
		local item = self._reshapeItems[index]

		if not item then
			item = self:getUserDataTb_()

			local root = gohelper.findChild(self._goreshapeeffect, index)
			local go = gohelper.clone(self._goreshapeItem, root, "item" .. index)

			item.go = root
			item.descTxt = gohelper.findChildText(go, "Viewport/Content/#go_reshapeItem")
			item.titleTxt = gohelper.findChildText(go, "Viewport/Content/#go_reshapeItem/title")
			item.cg = root:GetComponent(typeof(UnityEngine.CanvasGroup))
			self._reshapeItems[index] = item

			gohelper.setActive(go, true)
		end
	end
end

function CharacterDestinyStoneUpView:onClose()
	TaskDispatcher.cancelTask(self._cb, self)
	TaskDispatcher.cancelTask(self._onPlayAnimBack, self)
end

function CharacterDestinyStoneUpView:onDestroyView()
	self:_removeEvents()
	self._simagestone:UnLoadImage()
	self._simagereshape:UnLoadImage()
end

return CharacterDestinyStoneUpView
