-- chunkname: @modules/logic/currency/view/CurrencyExchangeView.lua

module("modules.logic.currency.view.CurrencyExchangeView", package.seeall)

local CurrencyExchangeView = class("CurrencyExchangeView", BaseView)

function CurrencyExchangeView:onInitView()
	self._simagehuawen1 = gohelper.findChildSingleImage(self.viewGO, "tipbg/#simage_huawen1")
	self._simagehuawen2 = gohelper.findChildSingleImage(self.viewGO, "tipbg/#simage_huawen2")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_yes")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_no")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._toggleoption = gohelper.findChildToggle(self.viewGO, "#toggle_option")
	self._txtoption = gohelper.findChildText(self.viewGO, "#toggle_option/#txt_option")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CurrencyExchangeView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
	self._toggleoption:AddOnValueChanged(self._toggleOptionOnClick, self)
end

function CurrencyExchangeView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
	self._toggleoption:RemoveOnValueChanged()
end

local closeType = MsgBoxEnum.CloseType

function CurrencyExchangeView:_btnyesOnClick()
	self:_closeInvokeCallback(closeType.Yes)
end

function CurrencyExchangeView:_btnnoOnClick()
	self:_closeInvokeCallback(closeType.No)
end

function CurrencyExchangeView:_closeInvokeCallback(result)
	local needShowNext = false

	if result == closeType.Yes then
		if self._toggleoption.isOn then
			self:saveOptionData()
		end

		needShowNext = CurrencyController.instance:checkCurrencyExchange(self.viewParam)
	elseif self.viewParam.noCallback then
		self.viewParam.noCallback(self.viewParam.noCallbackObj)
	end

	if not needShowNext then
		self:closeThis()
	end
end

function CurrencyExchangeView:_editableInitView()
	self._simagehuawen1:LoadImage(ResUrl.getMessageIcon("huawen1_002"))
	self._simagehuawen2:LoadImage(ResUrl.getMessageIcon("huawen2_003"))

	self._goNo = self._btnno.gameObject
	self._goYes = self._btnyes.gameObject

	gohelper.addUIClickAudio(self._btnyes.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.addUIClickAudio(self._btnno.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function CurrencyExchangeView:onUpdateParam()
	self:onOpen()
end

function CurrencyExchangeView:onDestroyView()
	self._simagehuawen1:UnLoadImage()
	self._simagehuawen2:UnLoadImage()
end

function CurrencyExchangeView:onOpen()
	if not string.nilorempty(self.viewParam.msg) and self.viewParam.extra and #self.viewParam.extra > 0 then
		local tip = self.viewParam.msg

		tip = GameUtil.getSubPlaceholderLuaLang(tip, self.viewParam.extra)
		self._txtdesc.text = tip
	elseif not self.viewParam.msg then
		self._txtdesc.text = ""
	end

	if self.viewParam.openCallback then
		self.viewParam.openCallback(self)
	end

	gohelper.setActive(self._goNo, true)
	recthelper.setAnchorX(self._goYes.transform, 248)
	recthelper.setAnchorX(self._goNo.transform, -248)
	NavigateMgr.instance:addEscape(ViewName.CurrencyExchangeView, self._onEscapeBtnClick, self)

	self._toggleoption.isOn = false

	gohelper.setActive(self._toggleoption.gameObject, false)

	if self.viewParam.isShowDailySure and self.viewParam.isExchangeStep then
		self:refreshOptionUI()
	end
end

function CurrencyExchangeView:_onEscapeBtnClick()
	if self._goNo.gameObject.activeInHierarchy then
		self:_closeInvokeCallback(closeType.No)
	end
end

function CurrencyExchangeView:refreshOptionUI()
	gohelper.setActive(self._toggleoption.gameObject, true)

	self.optionType = MsgBoxEnum.optionType.Daily
	self._txtoption.text = luaLang("messageoptionbox_daily")
end

function CurrencyExchangeView:saveOptionData()
	if not self.viewParam.isShowDailySure or not self.viewParam.isExchangeStep then
		return
	end

	if self.optionType == nil or self.optionType <= 0 or not self._toggleoption.isOn then
		return
	end

	local key = CurrencyController.instance:getOptionLocalKey(self.viewParam.srcType)

	if self.optionType == MsgBoxEnum.optionType.Daily then
		TimeUtil.setDayFirstLoginRed(key)
	end
end

function CurrencyExchangeView:_toggleOptionOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	self:saveOptionData()
end

function CurrencyExchangeView:onClose()
	return
end

return CurrencyExchangeView
