-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8EquipBookView.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8EquipBookView", package.seeall)

local Season123_1_8EquipBookView = class("Season123_1_8EquipBookView", BaseView)

function Season123_1_8EquipBookView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._gotarget = gohelper.findChild(self.viewGO, "left/#go_target")
	self._goctrl = gohelper.findChild(self.viewGO, "left/#go_target/#go_ctrl")
	self._gotargetcardpos = gohelper.findChild(self.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos")
	self._gocarditem = gohelper.findChild(self.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos/#go_carditem")
	self._gotouch = gohelper.findChild(self.viewGO, "left/#go_target/#go_touch")
	self._txtcardname = gohelper.findChildText(self.viewGO, "left/#go_target/#txt_cardname")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "left/#go_target/#scroll_desc")
	self._godescContent = gohelper.findChild(self.viewGO, "left/#go_target/#scroll_desc/Viewport/#go_descContent")
	self._godescitem = gohelper.findChild(self.viewGO, "left/#go_target/#scroll_desc/Viewport/#go_descContent/#go_descitem")
	self._btncompose = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_compose")
	self._gonormalcomposebg = gohelper.findChild(self.viewGO, "left/#btn_compose/#go_normalComposebg")
	self._golockcomposebg = gohelper.findChildImage(self.viewGO, "left/#btn_compose/#go_lockComposeBg")
	self._imagecomposeCoin = gohelper.findChildImage(self.viewGO, "left/#btn_compose/#image_composeCoin")
	self._txtcomposeNum = gohelper.findChildText(self.viewGO, "left/#btn_compose/#txt_composeNum")
	self._btndecompose = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_decompose")
	self._gonormaldecomposebg = gohelper.findChild(self.viewGO, "left/#btn_decompose/#go_normalDecomposebg")
	self._golockdecomposebg = gohelper.findChildImage(self.viewGO, "left/#btn_decompose/#go_lockDecomposeBg")
	self._imagedecomposeCoin = gohelper.findChildImage(self.viewGO, "left/#btn_decompose/#image_decomposeCoin")
	self._txtdecomposeNum = gohelper.findChildText(self.viewGO, "left/#btn_decompose/#txt_decomposeNum")
	self._scrollcardlist = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_cardlist")
	self._btnbatchDecompose = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_batchDecompose")
	self._gorighttop = gohelper.findChild(self.viewGO, "right/#go_righttop")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._godecomposeEffect = gohelper.findChild(self.viewGO, "left/#go_target/#fengjie")
	self._gocomposeEffect = gohelper.findChild(self.viewGO, "left/#go_target/#hecheng")
	self._btnskipEffect = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skipEffect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_8EquipBookView:addEvents()
	self._btncompose:AddClickListener(self._btncomposeOnClick, self)
	self._btndecompose:AddClickListener(self._btndecomposeOnClick, self)
	self._btnbatchDecompose:AddClickListener(self._btnbatchDecomposeOnClick, self)
	self._btnskipEffect:AddClickListener(self._btnskipEffectOnClick, self)
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnEquipBookItemChangeSelect, self.onChangeSelectCard, self)
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnRefleshEquipBookView, self.refreshEquipBook, self)
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnItemChange, self.refreshUI, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshUI, self)
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnDecomposeEffectPlay, self.doDecompose, self)
end

function Season123_1_8EquipBookView:removeEvents()
	self._btncompose:RemoveClickListener()
	self._btndecompose:RemoveClickListener()
	self._btnbatchDecompose:RemoveClickListener()
	self._btnskipEffect:RemoveClickListener()
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.OnEquipBookItemChangeSelect, self.onChangeSelectCard, self)
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.OnRefleshEquipBookView, self.refreshEquipBook, self)
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.OnItemChange, self.refreshUI, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshUI, self)
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.OnDecomposeEffectPlay, self.doDecompose, self)
end

Season123_1_8EquipBookView.defaultDescColor = "#cac8c5"

function Season123_1_8EquipBookView:_btncomposeOnClick()
	if self:isMainCardOverCount() then
		GameFacade.showToast(ToastEnum.SeasonMainCardOverCount)
	elseif self:canCompose() then
		self.isCompose = true

		gohelper.setActive(self._btnskipEffect.gameObject, true)
		self:showComposeEffect()
		TaskDispatcher.runDelay(self.sendComposeRequest, self, 2)
	else
		local coinConfig = CurrencyConfig.instance:getCurrencyCo(Season123Config.instance:getEquipItemCoin(self.actId, Activity123Enum.Const.EquipItemCoin))

		GameFacade.showToast(ToastEnum.DiamondBuy, coinConfig.name)
	end
end

function Season123_1_8EquipBookView:sendComposeRequest()
	Activity123Rpc.instance:sendComposeAct123EquipRequest(self.actId, self.itemId)
	Activity123Rpc.instance:sendGetUnlockAct123EquipIdsRequest(self.actId)

	self.isCompose = false

	gohelper.setActive(self._btnskipEffect.gameObject, false)
end

function Season123_1_8EquipBookView:_btndecomposeOnClick()
	local curSelectItemCount = self.itemId and Season123EquipBookModel.instance:getEquipBookItemCount(self.itemId) or 0

	if curSelectItemCount == 0 then
		return
	end

	local param = {}

	param.actId = self.actId
	param.itemId = self.itemId

	ViewMgr.instance:openView(ViewName.Season123_1_8DecomposeView, param)
end

function Season123_1_8EquipBookView:_btnbatchDecomposeOnClick()
	local equipItemCount = self:getItemCount()

	if equipItemCount == 0 then
		return
	end

	Season123EquipBookController.instance:openBatchDecomposeView(self.actId)
end

function Season123_1_8EquipBookView:_btnskipEffectOnClick()
	if self.isCompose then
		TaskDispatcher.cancelTask(self.sendComposeRequest, self)
		self:sendComposeRequest()
	end

	if self.isDecompose then
		TaskDispatcher.cancelTask(self.sendDecomposeEquipRequest, self)
		self:sendDecomposeEquipRequest()
	end

	gohelper.setActive(self._btnskipEffect.gameObject, false)
end

function Season123_1_8EquipBookView:_editableInitView()
	self._animatorCard = self._gotargetcardpos:GetComponent(typeof(UnityEngine.Animator))
	self._animCardEventWrap = self._animatorCard:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animCardEventWrap:AddEventListener("switch", self.onSwitchCardAnim, self)

	self.colorStr = Season123_1_8EquipBookView.defaultDescColor

	self:hideEffect()
	gohelper.setActive(self._btnskipEffect.gameObject, false)
end

function Season123_1_8EquipBookView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_unlock)

	self.actId = Season123Model.instance:getCurSeasonId()
	self.coinId = Season123Config.instance:getEquipItemCoin(self.actId, Activity123Enum.Const.EquipItemCoin)

	self:refreshUI()
end

function Season123_1_8EquipBookView:onSwitchCardAnim()
	self:refreshUI()
end

function Season123_1_8EquipBookView:refreshEquipBook()
	self._scrollcardlist.verticalNormalizedPosition = 1

	self:refreshUI()
end

function Season123_1_8EquipBookView:refreshUI()
	self.itemId = Season123EquipBookModel.instance.curSelectItemId

	self:refreshCardDesc()
	self:refreshIcon()
	self:refreshBtn()
end

function Season123_1_8EquipBookView:refreshCardDesc()
	if not self.itemId then
		self._txtcardname.text = ""

		gohelper.setActive(self._scrolldesc.gameObject, false)
	else
		local itemConfig = Season123Config.instance:getSeasonEquipCo(self.itemId)

		self._txtcardname.text = itemConfig ~= nil and string.format("[%s]", itemConfig.name) or ""

		gohelper.setActive(self._scrolldesc.gameObject, itemConfig ~= nil)
		self:refreshCardItem(itemConfig)
	end
end

function Season123_1_8EquipBookView:refreshCardItem(itemConfig)
	self._cardDescInfos = self:getUserDataTb_()

	if itemConfig then
		local skillList = Season123EquipMetaUtils.getSkillEffectStrList(itemConfig)

		self.colorStr = Season123EquipMetaUtils.getCareerColorDarkBg(itemConfig.equipId)

		if itemConfig.attrId ~= 0 then
			local propsList = Season123EquipMetaUtils.getEquipPropsStrList(itemConfig.attrId)

			if GameUtil.getTabLen(propsList) > 0 then
				tabletool.addValues(self._cardDescInfos, propsList)
			end
		end

		tabletool.addValues(self._cardDescInfos, skillList)
		gohelper.CreateObjList(self, self.cardDescItemShow, self._cardDescInfos, self._godescContent, self._godescitem)
	end
end

function Season123_1_8EquipBookView:cardDescItemShow(obj, data, index)
	obj.name = "desc" .. index

	local txtDesc = gohelper.findChildText(obj, "txt_desc")
	local fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(txtDesc.gameObject, FixTmpBreakLine)

	txtDesc.text = data

	fixTmpBreakLine:refreshTmpContent(txtDesc)
	SLFramework.UGUI.GuiHelper.SetColor(txtDesc, self.colorStr)
end

function Season123_1_8EquipBookView:refreshIcon()
	if not self._icon then
		local go = self._gocarditem

		self._icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season123_1_8CelebrityCardEquip)
	end

	if self.itemId then
		self._icon:updateData(self.itemId)
	end
end

function Season123_1_8EquipBookView:refreshBtn()
	local equipItemCount = self:getItemCount()

	ZProj.UGUIHelper.SetGrayscale(self._btnbatchDecompose.gameObject, equipItemCount == 0)

	local itemConfig

	if self.itemId then
		itemConfig = Season123Config.instance:getSeasonEquipCo(self.itemId)

		local coinConfig = CurrencyConfig.instance:getCurrencyCo(self.coinId)

		self._txtdecomposeNum.text = string.format("+%s", itemConfig.decomposeGet)
		self._txtcomposeNum.text = string.format("-%s", itemConfig.composeCost)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecomposeCoin, coinConfig.icon .. "_1")
		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagedecomposeCoin, coinConfig.icon .. "_1")
	end

	gohelper.setActive(self._txtdecomposeNum.gameObject, self.itemId)
	gohelper.setActive(self._txtcomposeNum.gameObject, self.itemId)
	gohelper.setActive(self._imagecomposeCoin.gameObject, self.itemId)
	gohelper.setActive(self._imagedecomposeCoin.gameObject, self.itemId)

	local curSelectItemCount = self.itemId and Season123EquipBookModel.instance:getEquipBookItemCount(self.itemId) or 0

	SLFramework.UGUI.GuiHelper.SetColor(self._txtcomposeNum, self:canCompose() and "#070706" or "#800015")
	gohelper.setActive(self._gonormaldecomposebg, curSelectItemCount > 0)
	gohelper.setActive(self._golockdecomposebg, curSelectItemCount == 0)
	gohelper.setActive(self._gonormalcomposebg, not self:isMainCardOverCount())
	gohelper.setActive(self._golockcomposebg, self:isMainCardOverCount())
end

function Season123_1_8EquipBookView:isMainCardOverCount()
	if self.itemId then
		local itemCount = Season123EquipBookModel.instance:getEquipBookItemCount(self.itemId)
		local itemConfig = Season123Config.instance:getSeasonEquipCo(self.itemId)

		if itemConfig.isMain == 1 and itemCount >= 1 then
			return true
		end
	end

	return false
end

function Season123_1_8EquipBookView:canCompose()
	if not self.itemId then
		return false
	end

	local itemConfig = Season123Config.instance:getSeasonEquipCo(self.itemId)
	local currencyMO = CurrencyModel.instance:getCurrency(self.coinId)

	if currencyMO then
		if not currencyMO.quantity then
			local curCoinCount = 0

			return itemConfig and curCoinCount >= itemConfig.composeCost
		end
	end
end

function Season123_1_8EquipBookView:getItemCount()
	local itemMap = Season123Model.instance:getAllItemMo(self.actId)

	return GameUtil.getTabLen(itemMap)
end

function Season123_1_8EquipBookView:onChangeSelectCard()
	self._animatorCard:Play("switch", 0, 0)
	self:hideEffect()
end

function Season123_1_8EquipBookView:doDecompose(decomposeList)
	self.decomposeList = decomposeList

	gohelper.setActive(self._btnskipEffect.gameObject, true)
	self:showDecomposeEffect()

	self.isDecompose = true

	TaskDispatcher.runDelay(self.sendDecomposeEquipRequest, self, 1.5)
end

function Season123_1_8EquipBookView:sendDecomposeEquipRequest()
	Activity123Rpc.instance:sendDecomposeAct123EquipRequest(self.actId, self.decomposeList)

	self.isDecompose = false

	gohelper.setActive(self._btnskipEffect.gameObject, false)
end

function Season123_1_8EquipBookView:showDecomposeEffect()
	gohelper.setActive(self._godecomposeEffect, false)
	gohelper.setActive(self._godecomposeEffect, true)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_qiutu_list_maintain)
end

function Season123_1_8EquipBookView:showComposeEffect()
	gohelper.setActive(self._gocomposeEffect, false)
	gohelper.setActive(self._gocomposeEffect, true)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_celebrity_synthesis)
end

function Season123_1_8EquipBookView:hideEffect()
	gohelper.setActive(self._godecomposeEffect, false)
	gohelper.setActive(self._gocomposeEffect, false)
end

function Season123_1_8EquipBookView:onClose()
	TaskDispatcher.cancelTask(self.sendComposeRequest, self)
	TaskDispatcher.cancelTask(self.sendDecomposeEquipRequest, self)

	Season123EquipBookModel.instance._itemStartAnimTime = nil
end

function Season123_1_8EquipBookView:onDestroyView()
	if self._animCardEventWrap then
		self._animCardEventWrap:RemoveAllEventListener()

		self._animCardEventWrap = nil
	end

	if self._icon ~= nil then
		self._icon:disposeUI()

		self._icon = nil
	end

	Season123EquipBookController.instance:onCloseView()
end

return Season123_1_8EquipBookView
