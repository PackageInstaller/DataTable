-- chunkname: @modules/logic/versionactivity2_5/challenge/view/store/Act183CurrencyReplaceTipsView.lua

module("modules.logic.versionactivity2_5.challenge.view.store.Act183CurrencyReplaceTipsView", package.seeall)

local Act183CurrencyReplaceTipsView = class("Act183CurrencyReplaceTipsView", BaseView)

function Act183CurrencyReplaceTipsView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#txt_desc")
	self._simageold = gohelper.findChildSingleImage(self.viewGO, "root/#go_old/#simage_old")
	self._simagenew = gohelper.findChildSingleImage(self.viewGO, "root/#go_new/#simage_new")
	self._txtoldcount = gohelper.findChildText(self.viewGO, "root/#go_old/#txt_oldcount")
	self._txtnewcount = gohelper.findChildText(self.viewGO, "root/#go_new/#txt_newcount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183CurrencyReplaceTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Act183CurrencyReplaceTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Act183CurrencyReplaceTipsView:_btncloseOnClick()
	self:closeThis()
end

function Act183CurrencyReplaceTipsView:_editableInitView()
	return
end

function Act183CurrencyReplaceTipsView:onOpen()
	self:refresh()
	Act183Helper.saveOpenCurrencyReplaceTipsViewInLocal()
end

function Act183CurrencyReplaceTipsView:refresh()
	self._oldCurrencyId, self._oldCurrencyCo, self._oldCurrencyIconUrl = self:initSingleInfo("oldCurrencyId", "oldCurrencyIconUrl")
	self._newCurrencyId, self._newCurrencyCo, self._newCurrencyIconUrl = self:initSingleInfo("newCurrencyId", "newCurrencyIconUrl")

	self._simageold:LoadImage(self._oldCurrencyIconUrl)
	self._simagenew:LoadImage(self._newCurrencyIconUrl)

	self._replaceRate = self.viewParam and self.viewParam.replaceRate

	if not self._replaceRate then
		logError(string.format("缺少货币替换比例参数replaceRate"))

		self._replaceRate = 1
	end

	self._oldCurrencyNum = self.viewParam and self.viewParam.oldCurrencyNum

	if not self._oldCurrencyNum then
		logError(string.format("缺少原始货币数量参数oldCurrencyNum"))

		self._oldCurrencyNum = 0
	end

	self._newCurrencyNum = self._oldCurrencyNum * self._replaceRate
	self._txtoldcount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), self._oldCurrencyNum)
	self._txtnewcount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), self._newCurrencyNum)

	if self.viewParam then
		self._txtdesc.text = self.viewParam.desc or ""
	end
end

function Act183CurrencyReplaceTipsView:initSingleInfo(currencyIdName, currencyIconUrlName)
	if self.viewParam then
		local currencyId = self.viewParam[currencyIdName]
		local currencyCo = CurrencyConfig.instance:getCurrencyCo(currencyId)

		if not currencyCo then
			logError(string.format("货币配置不存在  currencyIdParamName = %s, currencyId = %s", currencyIdName, currencyId))
		end

		if self.viewParam then
			local currencyIconUrl = self.viewParam[currencyIconUrlName]

			if not currencyIconUrl then
				local iconName = currencyCo and currencyCo.icon

				currencyIconUrl = ResUrl.getCurrencyItemIcon(iconName)
			end

			return currencyId, currencyCo, currencyIconUrl
		end
	end
end

function Act183CurrencyReplaceTipsView:getCurrencyCount(currencyId)
	local currencyMo = CurrencyModel.instance:getCurrency(currencyId)

	if not currencyMo then
		logError(string.format("货币数据不存在 currencyId = %s", currencyId))

		return 0
	end

	return currencyMo.quantity
end

function Act183CurrencyReplaceTipsView:onDestroy()
	self._simageold:UnLoadImage()
	self._simagenew:UnloadImage()
end

return Act183CurrencyReplaceTipsView
