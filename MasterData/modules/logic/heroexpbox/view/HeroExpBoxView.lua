-- chunkname: @modules/logic/heroexpbox/view/HeroExpBoxView.lua

module("modules.logic.heroexpbox.view.HeroExpBoxView", package.seeall)

local HeroExpBoxView = class("HeroExpBoxView", BaseView)

function HeroExpBoxView:onInitView()
	self._txtTips = gohelper.findChildText(self.viewGO, "pickchoice/TipsBG/tip/#txt_Tips")
	self._imageicon = gohelper.findChildImage(self.viewGO, "pickchoice/TipsBG/tip/#image_icon")
	self._txtTips1 = gohelper.findChildText(self.viewGO, "pickchoice/TipsBG/tip/#txt_Tips1")
	self._txtTitle = gohelper.findChildText(self.viewGO, "pickchoice/Title")
	self._gotip2 = gohelper.findChild(self.viewGO, "pickchoice/Tips2")
	self._txtnum = gohelper.findChildText(self.viewGO, "pickchoice/Tips2/#txt_num")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "pickchoice/#btn_confirm")
	self._txtconfirm = gohelper.findChildText(self.viewGO, "pickchoice/#btn_confirm/Text")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "pickchoice/#btn_cancel")
	self._scrollhero = gohelper.findChildScrollRect(self.viewGO, "#scroll_hero")
	self._gohas = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_has")
	self._gohasroot = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_has/#go_hasroot")
	self._golock = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_lock")
	self._txtlocked = gohelper.findChildText(self.viewGO, "#scroll_hero/Viewport/Content/#go_lock/title/#txt_locked")
	self._golockroot = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_lock/#go_lockroot")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroExpBoxView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self.addEventCb(self, HeroExpBoxController.instance, HeroExpBoxEvent.SelectHeroItem, self.refreshSelectHeroItem, self)
end

function HeroExpBoxView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self.removeEventCb(self, HeroExpBoxController.instance, HeroExpBoxEvent.SelectHeroItem, self.refreshSelectHeroItem, self)
end

function HeroExpBoxView:_btnconfirmOnClick()
	if self._isConver then
		ItemRpc.instance:sendUseItemRequest(self._itemData, 0, self.closeThis, self)
	elseif self:_isUnselectedHero() then
		GameFacade.showToast(ToastEnum.SelectHero)
	else
		local heroId = HeroExpBoxModel.instance:getSelectHeroId()
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)

		GameFacade.showMessageBox(MessageBoxIdDefine.HeroExpBoxConfirm, MsgBoxEnum.BoxType.Yes_No, self._confirmCallBack, nil, nil, self, nil, nil, heroConfig.name)
	end
end

function HeroExpBoxView:_confirmCallBack()
	local heroId = HeroExpBoxModel.instance:getSelectHeroId()

	ItemRpc.instance:sendUseItemRequest(self._itemData, heroId, self.closeThis, self)
end

function HeroExpBoxView:_btncancelOnClick()
	self:closeThis()
end

function HeroExpBoxView:_isUnselectedHero()
	return HeroExpBoxModel.instance:getSelectHeroId() == nil
end

function HeroExpBoxView:refreshSelectHeroItem()
	local isUnselectedHero = self:_isUnselectedHero()
	local count = isUnselectedHero and 0 or 1

	self._txtnum.text = count >= 1 and string.format("%d/%d", count, 1) or string.format("<color=%s>%d</color>/%d", "#D87173", count, 1)

	ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, isUnselectedHero and not self._isConver)

	for i = 1, #self._hasHeroItems do
		self._hasHeroItems[i]:refreshSelect()
	end

	gohelper.setActive(self._gotip2, not self._isConver)
end

function HeroExpBoxView:_editableInitView()
	self._hasHeroItems = self:getUserDataTb_()
	self._lockHeroItems = self:getUserDataTb_()
end

function HeroExpBoxView:onUpdateParam()
	return
end

function HeroExpBoxView:onOpen()
	self._itemId = self.viewParam.itemId
	self._itemData = {
		{
			quantity = 1,
			materialId = self._itemId
		}
	}

	self:_refreshHero()
	self:refreshSelectHeroItem()
end

function HeroExpBoxView:_refreshHero()
	local heroMoList = HeroExpBoxModel.instance:getBoxHeroMoList(self._itemId)

	self._hasList = {}
	self._lockList = {}

	for i, mo in ipairs(heroMoList) do
		if mo:getHeroMo() then
			if not self._hasList then
				local tb = self._lockList

				table.insert(tb, mo)
			end
		end
	end

	table.sort(self._hasList, self.sortHasHero)
	table.sort(self._lockList, self.sortLockHero)

	self._hasCanSelectHero = false

	for i, mo in ipairs(self._hasList) do
		local item = self:_getHeroItem(i, false)

		item:onUpdateMO(mo)

		local status = mo:getStatus()

		if status == HeroExpBoxEnum.HeroStatus.Normal then
			self._hasCanSelectHero = true
		end
	end

	for i, mo in ipairs(self._lockList) do
		local item = self:_getHeroItem(i, true)

		item:onUpdateMO(mo)
	end

	for i = 1, #self._hasHeroItems do
		gohelper.setActive(self._hasHeroItems[i].viewGO, i <= #self._hasList)
	end

	for i = 1, #self._lockHeroItems do
		gohelper.setActive(self._lockHeroItems[i].viewGO, i <= #self._lockList)
	end

	gohelper.setActive(self._gohas, #self._hasList > 0)
	gohelper.setActive(self._golock, #self._lockList > 0)

	local tipStr = "p_v2a2_fivestarsupgradepickchoiceview_txt_tips"

	self._isConver = false

	if #self._lockList == 0 and not self._hasCanSelectHero then
		tipStr = "HeroExpBoxItem_Tip1"
		self._isConver = true

		local lang = luaLang("HeroExpBoxItem_Tip2")
		local effect = HeroExpBoxModel.instance:getBoxEffect(self._itemId)
		local overflowCurrency = effect.overflowCurrency
		local co = ItemModel.instance:getItemConfig(overflowCurrency[1], overflowCurrency[2])

		self._txtTips1.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, co.name, overflowCurrency[3])

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageicon, co.icon .. "_1", true)
	end

	self._txtTips.text = luaLang(tipStr)

	gohelper.setActive(self._imageicon.gameObject, self._isConver)
	gohelper.setActive(self._txtTips1.gameObject, self._isConver)

	local confirmStr = self._isConver and "HeroExpBoxView_ConfirmBtn1" or "p_selfselectsixchoiceview_txt_confirm"

	self._txtconfirm.text = luaLang(confirmStr)

	local titleStr = self._isConver and "p_v3a4_destiny_pickchoiceview_txt_title1" or "p_v3a4_destiny_pickchoiceview_txt_tile"

	self._txtTitle.text = luaLang(titleStr)
end

function HeroExpBoxView.sortHasHero(a, b)
	local a_status = a:getStatus()
	local b_status = b:getStatus()

	if a_status == b_status then
		local a_heroExp = a:getExSkillLevel()
		local b_heroExp = b:getExSkillLevel()

		if a_heroExp == b_heroExp then
			local a_level = a:getHeroMo().level
			local b_level = b:getHeroMo().level

			if a_level == b_level then
				return a.heroId < b.heroId
			end

			return b_level < a_level
		end

		return b_heroExp < a_heroExp
	end

	return a_status < b_status
end

function HeroExpBoxView.sortLockHero(a, b)
	return a.heroId < b.heroId
end

function HeroExpBoxView:_getHeroItem(index, isLock)
	if isLock then
		if not self._lockHeroItems then
			local tb = self._hasHeroItems
			local item = tb[index]

			if not item then
				if isLock then
					if not self._golockroot then
						local root = self._gohasroot
						local path = self.viewContainer:getSetting().otherRes[1]
						local childGO = self:getResInst(path, root, "hero_" .. index)

						item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, HeroExpBoxItem)

						table.insert(tb, item)
					end
				end
			end

			return item
		end
	end
end

function HeroExpBoxView:onClose()
	HeroExpBoxModel.instance:setSelectHeroId()
end

function HeroExpBoxView:onDestroyView()
	return
end

return HeroExpBoxView
