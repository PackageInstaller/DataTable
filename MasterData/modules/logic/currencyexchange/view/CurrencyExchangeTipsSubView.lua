-- chunkname: @modules/logic/currencyexchange/view/CurrencyExchangeTipsSubView.lua

module("modules.logic.currencyexchange.view.CurrencyExchangeTipsSubView", package.seeall)

local CurrencyExchangeTipsSubView = class("CurrencyExchangeTipsSubView", LuaCompBase)

function CurrencyExchangeTipsSubView:init(go)
	self.viewGO = go
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "decorate/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "decorate/#simage_leftbg")
	self._txtleftproductname = gohelper.findChildText(self.viewGO, "left/#txt_leftproductname")
	self._simageleftproduct = gohelper.findChildSingleImage(self.viewGO, "left/#simage_leftproduct")
	self._txtrightproductname = gohelper.findChildText(self.viewGO, "right/#txt_rightproductname")
	self._simagerightproduct = gohelper.findChildSingleImage(self.viewGO, "right/#simage_rightproduct")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#txt_desc")
	self._goold = gohelper.findChild(self.viewGO, "root/#go_old")
	self._simageold = gohelper.findChildSingleImage(self.viewGO, "root/#go_old/#simage_old")
	self._txtoldcount = gohelper.findChildText(self.viewGO, "root/#go_old/#txt_oldcount")
	self._gonew = gohelper.findChild(self.viewGO, "root/#go_new")
	self._simagenew = gohelper.findChildSingleImage(self.viewGO, "root/#go_new/#simage_new")
	self._txtnewcount = gohelper.findChildText(self.viewGO, "root/#go_new/#txt_newcount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CurrencyExchangeTipsSubView:addEventListeners()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function CurrencyExchangeTipsSubView:removeEventListeners()
	self._btnclose:RemoveClickListener()
end

function CurrencyExchangeTipsSubView:_btncloseOnClick()
	CurrencyExchangeController.instance:dispatchEvent(CurrencyExchangeEvent.onSubViewClickClose)
end

function CurrencyExchangeTipsSubView:_editableInitView()
	return
end

function CurrencyExchangeTipsSubView:setInfo(currencyId)
	self.currencyId = currencyId
	self.exchangeCurrencyConfig = CurrencyExchangeConfig.instance:getExchangeConfig(self.currencyId)

	self:refreshUI()
end

function CurrencyExchangeTipsSubView:refreshUI()
	local infoMo = CurrencyExchangeModel.instance:getInfoMo(self.currencyId)

	if not infoMo.quantity then
		local exchangeCount = 0
		local currencyConfig = CurrencyConfig.instance:getCurrencyCo(self.currencyId)
		local currencyname = currencyConfig.icon

		self._simageold:LoadImage(self.exchangeCurrencyConfig.image)
		self._simagenew:LoadImage(ResUrl.getCurrencyItemIcon(currencyname))

		local countDesc = "x" .. tostring(exchangeCount)

		self._txtnewcount.text = countDesc
		self._txtoldcount.text = countDesc
		self._txtdesc.text = self.exchangeCurrencyConfig.desc
	end
end

function CurrencyExchangeTipsSubView:onDestroy()
	self._simageold:UnLoadImage()
end

return CurrencyExchangeTipsSubView
