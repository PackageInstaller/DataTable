-- chunkname: @modules/logic/currencyexchange/view/CurrencyExchangeTipsView.lua

module("modules.logic.currencyexchange.view.CurrencyExchangeTipsView", package.seeall)

local CurrencyExchangeTipsView = class("CurrencyExchangeTipsView", BaseView)

function CurrencyExchangeTipsView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CurrencyExchangeTipsView:addEvents()
	self.addEventCb(self, CurrencyExchangeController.instance, CurrencyExchangeEvent.onSubViewClickClose, self.closeThis, self)
end

function CurrencyExchangeTipsView:removeEvents()
	self.removeEventCb(self, CurrencyExchangeController.instance, CurrencyExchangeEvent.onSubViewClickClose, self.closeThis, self)
end

function CurrencyExchangeTipsView:_editableInitView()
	self._subViewContainer = gohelper.findChild(self.viewGO, "subViewContainer")
	self._loader = MultiAbLoader.New()
	self._subViewDic = self:getUserDataTb_()
end

function CurrencyExchangeTipsView:onUpdateParam()
	return
end

function CurrencyExchangeTipsView:onOpen()
	if not self.viewParam or not self.viewParam.currencyId then
		logError("货币转换弹窗,没有数据")

		return
	end

	local exchangeCurrencyConfig = CurrencyExchangeConfig.instance:getExchangeConfig(self.viewParam.currencyId)

	if not exchangeCurrencyConfig then
		logError("货币转换弹窗,需要转化的id不存在 id:" .. tostring(self.viewParam.currencyId))

		return
	end

	self.currencyId = self.viewParam.currencyId
	self.exchangeCurrencyConfig = exchangeCurrencyConfig

	self:refreshUI()
end

function CurrencyExchangeTipsView:refreshUI()
	self:loadTipView()
end

function CurrencyExchangeTipsView:loadTipView()
	local prefabName = self.exchangeCurrencyConfig.boxPath

	if string.nilorempty(prefabName) then
		self:closeThis()

		return
	end

	local path = "" .. prefabName

	self._loader:addPath(path)
	self._loader:startLoad(self.onViewLoadFinish, self)
end

function CurrencyExchangeTipsView:onViewLoadFinish()
	if not self._subViewDic[self.currencyId] then
		local prefab = self._loader:getFirstAssetItem():GetResource()
		local viewGo = gohelper.clone(prefab, self._subViewContainer)

		self._subViewDic[self.currencyId] = MonoHelper.addNoUpdateLuaComOnceToGo(viewGo, CurrencyExchangeTipsSubView)
	end

	self:refreshSubView()
end

function CurrencyExchangeTipsView:refreshSubView()
	for currencyId, subView in pairs(self._subViewDic) do
		local isActive = self.currencyId == currencyId

		gohelper.setActive(subView.viewGO, isActive)

		if isActive then
			subView:setInfo(self.currencyId)
		end
	end
end

function CurrencyExchangeTipsView:onClose()
	return
end

function CurrencyExchangeTipsView:onDestroyView()
	for _, subView in pairs(self._subViewDic) do
		subView:onDestroy()
	end

	tabletool.clear(self._subViewDic)

	self._subViewDic = nil
end

return CurrencyExchangeTipsView
