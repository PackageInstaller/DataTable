-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/recommend/StoreRecommendView.lua

module("logic.extensions.store.view.recommend.StoreRecommendView", package.seeall)

local M = class("StoreRecommendView", ViewComponent)
local bannerInterval = 3
local defualtRecommendId = 10000

function M:buildUI()
	self._panel1 = self:getGo("store_main_view_copy_-1379932124")
	self._imgBanner1 = UIComponentType.BigBGLocalizationLua(self:getGo("store_main_view_copy_1031121665"))
	self._imgBanner2 = UIComponentType.BigBGLocalizationLua(self:getGo("store_main_view_copy_-801413663"))
	self._imgBanner3 = UIComponentType.BigBGLocalizationLua(self:getGo("store_main_view_copy_735665264"))
	self._btnBanner1 = self:getBtn("store_main_view_copy_-785857228")
	self._btnBanner2 = self:getBtn("store_main_view_copy_-1471757368")
	self._btnBanner3 = self:getBtn("store_main_view_copy_826459513")
	self._panel2 = self:getGo("store_main_view_copy_1047370977")
	self._imgContent = UIComponentType.BigBGLocalizationLua(self:getGo("store_main_view_copy_-82092049"))
	self._btnContent = self:getBtn("store_main_view_copy_-2101274093")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnBanner1:AddClickListener(self._onClickBanner1, self)
	self._btnBanner2:AddClickListener(self._onClickBanner2, self)
	self._btnBanner3:AddClickListener(self._onClickBanner3, self)
	self._btnContent:AddClickListener(self._onClickFullBanner, self)
	GlobalDispatcher:addEventListener(EventType.PICK_RECOMMEND_STORE, self._onRefreshRecommendList, self)
end

function M:unbindEvents()
	self._btnBanner1:RemoveClickListener()
	self._btnBanner2:RemoveClickListener()
	self._btnBanner3:RemoveClickListener()
	self._btnContent:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.PICK_RECOMMEND_STORE, self._onRefreshRecommendList, self)
end

function M:_onRefreshRecommendList(evt, list, storeId, isClick)
	self._storeList = list
	self._selectStoreId = storeId

	local isDeaultTab = self._selectStoreId == defualtRecommendId

	goutil.setActive(self._panel1, isDeaultTab)
	goutil.setActive(self._panel2, not isDeaultTab)
	self:_initRecommond()
end

function M:onEnter()
	return
end

function M:onExit()
	self._selectShower = false

	self._imgBanner1:ClearImage()
	self._imgBanner2:ClearImage()
	self._imgBanner3:ClearImage()
	self._imgContent:ClearImage()
end

function M:_clickBannerCallBack(code)
	local recommendCo = StoreConfig.instance:getRecommendCo(code)

	if recommendCo then
		StoreAgent.instance:reqJumpTo(recommendCo.storeId, recommendCo.goodsId)
	end
end

function M:_updateLeftTabCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._leftTabScroll:NewListViewItem("store_left_tab")
	local storeList = self._storeList

	if storeList then
		local data = storeList[curIndex]
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, StoreLeftNavItem)

		shower.view = self

		shower:setCellData(data, curIndex, self._leftTabGroup, true)
		shower:setClickCallBack(self._clickStoreCallBack, self)
		shower:setSelectState(self._selectStoreId == data.code)
	end

	return item
end

function M:_clickStoreCallBack(tabId, storeId, isClick)
	if self._selectStoreId == storeId and isClick then
		return
	end

	self._selectStoreId = storeId

	local isDeaultTab = self._selectStoreId == defualtRecommendId

	goutil.setActive(self._panel1, isDeaultTab)
	goutil.setActive(self._panel2, not isDeaultTab)
	self:_initRecommond()
end

function M:_initRecommond()
	if not self._selectStoreId then
		return
	end

	local isDeaultTab = self._selectStoreId == defualtRecommendId
	local tabShower = false

	for i = 1, #self._storeList do
		if self._storeList[i].code == self._selectStoreId then
			tabShower = self._storeList[i]
		end
	end

	self._selectShower = tabShower

	if not tabShower then
		return
	end

	if isDeaultTab then
		local len = #tabShower.data

		if len >= 3 then
			local icon1 = tabShower.data[1]:getIcon()
			local icon2 = tabShower.data[2]:getIcon()
			local icon3 = tabShower.data[3]:getIcon()

			self._imgBanner1:SetImage(GameUrl.getStoreBigIcon(string.format("store_banner2/%s", icon1)), nil, self)
			self._imgBanner2:SetImage(GameUrl.getStoreBigIcon(string.format("store_banner2/%s", icon2)), nil, self)
			self._imgBanner3:SetImage(GameUrl.getStoreBigIcon(string.format("store_banner2/%s", icon3)), nil, self)
			GlobalDispatcher:dispatchEvent(EventType.STORE_SHOW_BUBBLE, StoreEnum.BubbleFactor.OpenRecommend, tabShower.data[1]:getTips())
		end
	else
		GlobalDispatcher:dispatchEvent(EventType.STORE_SHOW_BUBBLE, StoreEnum.BubbleFactor.OpenRecommend, tabShower.data:getTips())

		local icon = tabShower.data:getIcon()

		self._imgContent:SetImage(GameUrl.getStoreBigIcon(string.format("store_banner2/%s", icon)), nil, self)
	end
end

function M:_clickAdvertisingCallBack(code)
	local recommendCo = StoreConfig.instance:getRecommendCo(code)

	if recommendCo then
		StoreAgent.instance:reqJumpTo(recommendCo.storeId, recommendCo.goodsId)
	end
end

function M:_onClickBanner1()
	local isDeaultTab = self._selectStoreId == defualtRecommendId

	if not isDeaultTab then
		return
	end

	if not self._selectShower then
		return
	end

	local shower = self._selectShower.data[1]

	if shower then
		StoreAgent.instance:reqJumpTo(shower:getStoreId(), shower:getGoodsId())
	end
end

function M:_onClickBanner2()
	local isDeaultTab = self._selectStoreId == defualtRecommendId

	if not isDeaultTab then
		return
	end

	if not self._selectShower then
		return
	end

	local shower = self._selectShower.data[2]

	if shower then
		StoreAgent.instance:reqJumpTo(shower:getStoreId(), shower:getGoodsId())
	end
end

function M:_onClickBanner3()
	local isDeaultTab = self._selectStoreId == defualtRecommendId

	if not isDeaultTab then
		return
	end

	if not self._selectShower then
		return
	end

	local shower = self._selectShower.data[3]

	if shower then
		StoreAgent.instance:reqJumpTo(shower:getStoreId(), shower:getGoodsId())
	end
end

function M:_onClickFullBanner()
	local isDeaultTab = self._selectStoreId == defualtRecommendId

	if isDeaultTab then
		return
	end

	if not self._selectShower then
		return
	end

	local shower = self._selectShower.data

	if shower then
		StoreAgent.instance:reqJumpTo(shower:getStoreId(), shower:getGoodsId())
	end
end

function M:setVisible(visble)
	if not visble then
		goutil.setActive(self._panel1, visble)
		goutil.setActive(self._panel2, visble)
	end

	if visble then
		local temp = StoreModel.instance:getRecommendList()

		StoreAgent.instance:checkEnableShow(temp)

		self._storeList = {}

		self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, nil)
	end
end

return M
