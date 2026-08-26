-- chunkname: @modules/logic/summon/view/SummonConfirmView.lua

module("modules.logic.summon.view.SummonConfirmView", package.seeall)

local SummonConfirmView = class("SummonConfirmView", BaseView)

function SummonConfirmView:onInitView()
	self._simagehuawen1 = gohelper.findChildSingleImage(self.viewGO, "bg/tipbg/#simage_huawen1")
	self._simagehuawen2 = gohelper.findChildSingleImage(self.viewGO, "bg/tipbg/#simage_huawen2")
	self._simagebeforeicon = gohelper.findChildSingleImage(self.viewGO, "cost/before/#simage_beforeicon")
	self._txtbeforequantity = gohelper.findChildText(self.viewGO, "cost/before/numbg/#txt_beforequantity")
	self._simageaftericon = gohelper.findChildSingleImage(self.viewGO, "cost/after/#simage_aftericon")
	self._txtafterquantity = gohelper.findChildText(self.viewGO, "cost/after/numbg/#txt_afterquantity")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_yes")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_no")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._toggleoption = gohelper.findChildToggle(self.viewGO, "#toggle_option")
	self._txtoption = gohelper.findChildText(self.viewGO, "#toggle_option/#txt_option")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonConfirmView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
	self._toggleoption:AddOnValueChanged(self._toggleOptionOnClick, self)
end

function SummonConfirmView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
	self._toggleoption:RemoveOnValueChanged()
end

function SummonConfirmView:_btnyesOnClick()
	self._yes = true

	SummonMainController.instance:checkFreeDiamondEnough(self.viewParam)

	if self._toggleoption.isOn then
		self:saveOptionData()
	end

	self:closeThis()
end

function SummonConfirmView:_btnnoOnClick()
	self:closeThis()

	if self.viewParam.noCallback then
		callWithCatch(self.viewParam.noCallback, self.viewParam.noCallbackObj)
	end
end

function SummonConfirmView:_callCheckWithParam()
	self._callback(self._callbackObj, self.viewParam)
end

function SummonConfirmView:_editableInitView()
	self._simagehuawen1:LoadImage(ResUrl.getMessageIcon("huawen1_002"))
	self._simagehuawen2:LoadImage(ResUrl.getMessageIcon("huawen2_003"))
	gohelper.addUIClickAudio(self._btnyes.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnno.gameObject, AudioEnum.UI.UI_Common_Click)

	self._toggleoption.isOn = false
end

function SummonConfirmView:onUpdateParam()
	self:onOpen()
end

function SummonConfirmView:onOpen()
	self._type = self.viewParam.type
	self._id = self.viewParam.id
	self._quantity = self.viewParam.quantity
	self._callback = self.viewParam.callback
	self._callbackObj = self.viewParam.callbackObj
	self._yes = false
	self.needTransform = self.viewParam.needTransform

	local needItemCostStr = self.viewParam.needItemCostStr
	local isDiamond = self._type == MaterialEnum.MaterialType.Currency and (self._id == CurrencyEnum.CurrencyType.Diamond or self._id == CurrencyEnum.CurrencyType.FreeDiamondCoupon)
	local config, icon = ItemModel.instance:getItemConfigAndIcon(self._type, self._id)

	self._simageaftericon:LoadImage(icon)

	if self.needTransform then
		local afterConfig, afterIcon = ItemModel.instance:getItemConfigAndIcon(self.viewParam.cost_type, self.viewParam.cost_id)

		self._simagebeforeicon:LoadImage(afterIcon)

		self._txtbeforequantity.text = GameUtil.numberDisplay(self.viewParam.cost_quantity)
		self._txtafterquantity.text = GameUtil.numberDisplay(self.viewParam.miss_quantity)

		local var_9_0 = {
			self.viewParam.miss_quantity
		}

		var_9_0[2] = isDiamond and luaLang("summon_confirm_quantifier1") or luaLang("summon_confirm_quantifier2")
		var_9_0[3] = config.name
		var_9_0[4] = self.viewParam.cost_quantity
		var_9_0[5] = afterConfig.name
		var_9_0[6] = needItemCostStr

		local tag = var_9_0

		self._txtdesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang(string.nilorempty(needItemCostStr) and "summon_transform_desc" or "sp02_summon_itemnum_transform_desc"), tag)
	else
		self._simagebeforeicon:LoadImage(icon)

		local hasQuantity = ItemModel.instance:getItemQuantity(self._type, self._id)

		self._txtbeforequantity.text = GameUtil.numberDisplay(hasQuantity)
		self._txtafterquantity.text = GameUtil.numberDisplay(hasQuantity - self._quantity)

		local var_9_1 = {
			self._quantity
		}

		var_9_1[2] = isDiamond and luaLang("summon_confirm_quantifier1") or luaLang("summon_confirm_quantifier2")
		var_9_1[3] = config.name

		local tag = var_9_1

		self._txtdesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_confirm_desc"), tag)
	end

	self:refreshOptionUI()
end

function SummonConfirmView:refreshOptionUI()
	gohelper.setActive(self._toggleoption.gameObject, true)

	self.optionType = MsgBoxEnum.optionType.Daily
	self._txtoption.text = luaLang("p_summonConfirmView_auto_option")
end

function SummonConfirmView:saveOptionData()
	if self.optionType <= 0 or not self._toggleoption.isOn then
		return
	end

	local key = SummonMainController.instance:getOptionLocalKey()

	if self.optionType == MsgBoxEnum.optionType.Daily then
		TimeUtil.setDayFirstLoginRed(key)
	end
end

function SummonConfirmView:_toggleOptionOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function SummonConfirmView:onClose()
	return
end

function SummonConfirmView:onCloseFinish()
	return
end

function SummonConfirmView:onDestroyView()
	self._simagehuawen1:UnLoadImage()
	self._simagehuawen2:UnLoadImage()
	self._simagebeforeicon:UnLoadImage()
	self._simageaftericon:UnLoadImage()
end

return SummonConfirmView
