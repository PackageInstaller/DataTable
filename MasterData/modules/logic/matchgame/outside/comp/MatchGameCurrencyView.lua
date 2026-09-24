-- chunkname: @modules/logic/matchgame/outside/comp/MatchGameCurrencyView.lua

module("modules.logic.matchgame.outside.comp.MatchGameCurrencyView", package.seeall)

local MatchGameCurrencyView = class("MatchGameCurrencyView", BaseView)

function MatchGameCurrencyView:ctor(rootPath, itemConstId)
	self:__onInit()

	self._rootPath = rootPath

	self:updateInfo(itemConstId)
end

function MatchGameCurrencyView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, self._rootPath)

	if gohelper.isNil(self._goRoot) then
		logError(string.format("三消货币栏挂点不存在 viewName = %s, rootPath = %s", self.viewName, self._rootPath))

		return
	end

	if not self._itemIdList or #self._itemIdList <= 0 then
		logError(string.format("三消货币栏显示道具类型不可为空 viewName = %s", self.viewName))

		return
	end

	self._loader = PrefabInstantiate.Create(self._goRoot)

	self._loader:startLoad(MatchGameEnum.CurrencyPrefabPath, self._onLoadPrefabDone, self)
end

function MatchGameCurrencyView:addEvents()
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnUpdateItemInfo, self._onUpdateItemInfo, self)
end

function MatchGameCurrencyView:_onLoadPrefabDone(loader)
	self._goCurrencyRoot = loader:getInstGO()

	self:initPrefab()
	self:refreshUI()
end

function MatchGameCurrencyView:initPrefab()
	self._goItemList = gohelper.findChild(self._goCurrencyRoot, "#go_Container/#go_ItemList")
	self._goItem = gohelper.findChild(self._goCurrencyRoot, "#go_Container/#go_ItemList/#go_Item")
	self._isInitDone = true
end

function MatchGameCurrencyView:updateInfo(itemConstId)
	local defaultConstId = MatchGameEnum.ConstId.Currency

	itemConstId = itemConstId or defaultConstId

	local actId = MatchGameModel.instance:getCurActId()
	local actConstMap = lua_activity244_const.configDict[actId]
	local constIdCo = actConstMap and actConstMap[itemConstId]

	if not constIdCo then
		logError(string.format("三消货币栏常量配置不存在 actId = %s, constId = %s", actId, itemConstId))

		return
	end

	self._itemIdList = string.splitToNumber(constIdCo.value, "#")
	self._itemIdMap = GameUtil.listToDict(self._itemIdList)

	self:refreshUI()
end

function MatchGameCurrencyView:refreshUI()
	if not self._isInitDone then
		return
	end

	gohelper.CreateObjList(self, self._refreshItem, self._itemIdList, self._goItemList, self._goItem, MatchGameCurrencyItem)
end

function MatchGameCurrencyView:_refreshItem(currencyItem, itemId, index)
	currencyItem:onUpdateMO(itemId)
end

function MatchGameCurrencyView:_onUpdateItemInfo(updateItemIdMap)
	if not updateItemIdMap then
		return
	end

	local needUpdate = false

	for _, itemId in ipairs(self._itemIdList) do
		if updateItemIdMap[itemId] then
			needUpdate = true

			break
		end
	end

	if not needUpdate then
		return
	end

	self:refreshUI()
end

return MatchGameCurrencyView
