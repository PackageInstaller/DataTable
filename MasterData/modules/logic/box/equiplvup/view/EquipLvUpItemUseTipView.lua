-- chunkname: @modules/logic/box/equiplvup/view/EquipLvUpItemUseTipView.lua

module("modules.logic.box.equiplvup.view.EquipLvUpItemUseTipView", package.seeall)

local EquipLvUpItemUseTipView = class("EquipLvUpItemUseTipView", BaseView)

function EquipLvUpItemUseTipView:onInitView()
	self._btntouchClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_touchClose")
	self._simagetipbg = gohelper.findChildSingleImage(self.viewGO, "#simage_tipbg")
	self._txtbuytip = gohelper.findChildText(self.viewGO, "centerTip/#txt_buytip")
	self._txtremaincount = gohelper.findChildText(self.viewGO, "centerTip/#txt_remaincount")
	self._toggletip = gohelper.findChildToggle(self.viewGO, "centerTip/#toggle_tip")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_buy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipLvUpItemUseTipView:addEvents()
	self._btntouchClose:AddClickListener(self._btntouchCloseOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._toggletip:AddOnValueChanged(self._toggleTipOnClick, self)
end

function EquipLvUpItemUseTipView:removeEvents()
	self._btntouchClose:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._toggletip:RemoveOnValueChanged()
end

function EquipLvUpItemUseTipView:_btntouchCloseOnClick()
	self:_onClose()
end

function EquipLvUpItemUseTipView:_btncloseOnClick()
	self:_onClose()
end

function EquipLvUpItemUseTipView:_onClose()
	if self._closeFunc then
		self._closeFunc(self._closeFuncObj)
	end

	self:closeThis()
end

function EquipLvUpItemUseTipView:_btnbuyOnClick()
	BackpackModel.instance:setCurCategoryId(ItemEnum.CategoryType.UseType)
	BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.UseType)
	BackpackController.instance:dispatchEvent(BackpackEvent.SelectCategory)

	if self._yesFunc then
		self._yesFunc(self._yesFuncObj)
	end

	self:closeThis()
end

function EquipLvUpItemUseTipView:_toggleTipOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function EquipLvUpItemUseTipView:_editableInitView()
	self._toggletip.isOn = false

	self._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
	gohelper.setActive(self._txtremaincount.gameObject, false)
	gohelper.setActive(self._toggletip.gameObject, true)
end

function EquipLvUpItemUseTipView:onUpdateParam()
	return
end

function EquipLvUpItemUseTipView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	self._equipMO = self.viewParam.equipMo
	self._yesFunc = self.viewParam.yesFunc
	self._yesFuncObj = self.viewParam.yesFuncObj
	self._closeFunc = self.viewParam.closeFunc
	self._closeFuncObj = self.viewParam.closeFuncObj
	self._itemId = self.viewParam.itemId

	local msg = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.EquipLvUpUseItemTip)
	local itemCo = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, self._itemId)

	self._txtbuytip.text = GameUtil.getSubPlaceholderLuaLangOneParam(msg, itemCo.name)

	NavigateMgr.instance:addEscape(self.viewName, self._onClose, self)
end

function EquipLvUpItemUseTipView:refreshCenterTip()
	return
end

function EquipLvUpItemUseTipView:onClose()
	if self._toggletip.isOn then
		local today = ServerTime.getServerTimeToday(true)
		local key = PlayerModel.instance:getPlayerPrefsKey(EquipLvUpEnum.ShowUseTipKey)

		PlayerPrefsHelper.setNumber(key, today)
	end
end

function EquipLvUpItemUseTipView:onDestroyView()
	self._simagetipbg:UnLoadImage()
end

return EquipLvUpItemUseTipView
