-- chunkname: @modules/logic/college/view/common/CollegeCurrencyView.lua

module("modules.logic.college.view.common.CollegeCurrencyView", package.seeall)

local CollegeCurrencyView = class("CollegeCurrencyView", BaseView)

function CollegeCurrencyView:ctor(rootPath, types)
	self:__onInit()

	self._rootPath = rootPath
	self._types = types or CollegeEnum.CurrencyItemTypeList
end

function CollegeCurrencyView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, self._rootPath)

	if gohelper.isNil(self._goRoot) then
		logError(string.format("指挥所货币栏挂点不存在 viewName = %s, rootPath = %s", self.viewName, self._rootPath))

		return
	end

	if not self._types or #self._types <= 0 then
		logError(string.format("指挥所货币栏显示道具类型不可为空 viewName = %s", self.viewName))

		return
	end

	self._loader = PrefabInstantiate.Create(self._goRoot)

	self._loader:startLoad(CollegeEnum.PrefabPath.Currency, self._onLoadPrefabDone, self)
end

function CollegeCurrencyView:_onLoadPrefabDone(loader)
	self._goCurrencyRoot = loader:getInstGO()

	self:initPrefab()
	self:refreshUI()
end

function CollegeCurrencyView:initPrefab()
	self._goCurrency = gohelper.findChild(self._goCurrencyRoot, "#go_Container/#go_Currency")
	self._goCurrencyItem = gohelper.findChild(self._goCurrencyRoot, "#go_Container/#go_Currency/#go_CurrencyItem")

	self:initData()
end

function CollegeCurrencyView:initData()
	self:buildItemList()

	self._clientDataMo = CollegeModel.instance:getSceneMo().prop.clientDataMo
	self._coinId = CollegeConfig.instance:getConstNum(CollegeEnum.ConstId.CoinId)
	self._toolItemList = self:getUserDataTb_()
	self._isInitDone = true
end

function CollegeCurrencyView:buildItemList()
	self._itemList = {}

	if not self._types then
		return
	end

	for _, type in ipairs(self._types) do
		local typeItemList = CollegeConfig.instance:getItemListByType(type)

		tabletool.addValues(self._itemList, typeItemList)
	end
end

function CollegeCurrencyView:refreshUI()
	if not self._isInitDone then
		return
	end

	gohelper.CreateObjList(self, self._refreshCurrencyItem, self._itemList, self._goCurrency, self._goCurrencyItem, CollegeCurrencyToolItem)
end

function CollegeCurrencyView:_refreshCurrencyItem(currencyItem, currencyCo, index)
	local currencyId = currencyCo.id
	local isCoin = currencyId == self._coinId

	self._toolItemList[index] = currencyItem

	currencyItem:onUpdateMO(currencyCo, self._clientDataMo, isCoin, index, self)
end

function CollegeCurrencyView:getCurrencyItemList()
	return self._toolItemList
end

return CollegeCurrencyView
