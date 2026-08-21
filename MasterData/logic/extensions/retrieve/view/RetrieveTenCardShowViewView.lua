-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveTenCardShowViewView.lua

module("logic.extensions.retrieve.view.RetrieveTenCardShowViewView", package.seeall)

local M = class("RetrieveTenCardShowViewView", ViewComponent)
local AnimState = {
	SHOW_IMMEDIATE = 2,
	CONVERSION_ANIM = 3,
	CLOSE = 4,
	SHOW_ANIM = 1
}

function M:buildUI()
	self._txtSLinGanValue = self:getUIComponent("retrieve_ten_card_show_view_-1109512837", UIComponentType.TMPText)
	self._txtALinGanValue = self:getUIComponent("retrieve_ten_card_show_view_-834977197", UIComponentType.TMPText)
	self._btnShare = self:getBtn("retrieve_ten_card_show_view_-1665399867")

	goutil.setActive(self._btnShare.gameObject, false)

	self._btnContinue = self:getBtn("retrieve_ten_card_show_view_64972784")
	self._btnTen = self:getBtn("retrieve_ten_card_show_view_250063414")
	self._tenIcon = self:getImage("retrieve_ten_card_show_view_1750829242")
	self._tenNum = self:getText("retrieve_ten_card_show_view_427436554")
	self._itemRoot = self:getUIComponent("retrieve_ten_card_show_view_-2017621738", UIComponentType.RectTransform)
	self._item = self:getGo("retrieve_ten_card_show_view_159711101")
end

function M:_bindTopCurrencyInfo()
	if self._lotteryData then
		self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, CommEnum.MoneyShowType.LotteryHeroShowType)
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnShare:AddClickListener(self._onClickShare, self)
	self._btnContinue:AddClickListener(self._onClickContinue, self)
	self._btnTen:AddClickListener(self._onClickTenAgain, self)
end

function M:unbindEvents()
	self._btnShare:RemoveClickListener()
	self._btnContinue:RemoveClickListener()
	self._btnTen:RemoveClickListener()
end

function M:onEnter()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_chouka_result_display)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)

	local lotteryId = RetrieveModel.instance:getLotteryId()
	local lotteryData = ActivityController.instance:getActivityById(lotteryId)

	if not lotteryData then
		printError("抽卡数据为空")

		return
	end

	self._lotteryType = lotteryData:getLotterySimpleType()
	self._lotteryData = lotteryData
	self._lotteryConversion = {}

	self:_bindTopCurrencyInfo()
	self:_buildCardItem()
	self:_buildPointData()
	self:_refreshCostView()
	self:_refreshButton()
end

function M:_refreshButton()
	local lotteryId = RetrieveModel.instance:getLotteryId()

	if not lotteryId then
		goutil.setActive(self._btnTen.gameObject, false)

		return
	end

	local lotteryData = ActivityController.instance:getActivityById(lotteryId)

	if not lotteryData then
		goutil.setActive(self._btnTen.gameObject, false)

		return
	end

	goutil.setActive(self._btnTen.gameObject, lotteryData:getIsOpen())
end

function M:_buildCardItem()
	local cardSceneRoot = false
	local scene = SceneMgr.instance:getScene(SceneType.Retrieve)

	if scene then
		cardSceneRoot = scene.stage:getSceneCardRoot()
	end

	local itemList = {}

	if cardSceneRoot and not goutil.isNil(cardSceneRoot) then
		for i = 1, 10 do
			local itemNode = goutil.findChild(cardSceneRoot, string.format("item%s", i))

			if not goutil.isNil(itemNode) then
				table.insert(itemList, itemNode)
			end
		end
	end

	self._lotteryViewList = {}

	local lotteryResultList = RetrieveController.instance:getCacheLotteryResult()

	for i, lotteryResult in ipairs(lotteryResultList) do
		local itemView = false
		local obj = goutil.findChild(itemList[i], "item_" .. i)

		if obj then
			itemView = Astral.SimpleLuaComponentContainer.Get(obj, RetrieveTenItemView)
		else
			obj = self:getResInstance(ResName.RetrieveCardSceneItem)

			goutil.addChildToParent(obj, itemList[i])

			obj.transform.name = "item_" .. i
			itemView = Astral.SimpleLuaComponentContainer.Add(obj, RetrieveTenItemView)
		end

		local xinMaoGo = false

		if self:_checkXinMaoData(lotteryResult.conversion) then
			xinMaoGo = goutil.cloneAndSetParent(self._item, self._itemRoot)
		end

		goutil.setActive(obj, true)
		itemView:setViewPresentor(self._viewPresentor)
		itemView:onEnter()
		itemView:setIndex(i)
		itemView:updateData(lotteryResult, xinMaoGo)
		table.insert(self._lotteryViewList, itemView)
	end

	self._state = AnimState.SHOW_ANIM
end

function M:_buildPointData()
	self._txtSLinGanValue.text = 0
	self._txtALinGanValue.text = 0

	local lotteryItemList = RetrieveController.instance:getCacheItemMOList()

	if lotteryItemList then
		for i = 1, #lotteryItemList do
			local item = lotteryItemList[i]

			if item:getItemId() == GameEnum.CurrencyCodeEnum.InspirationS then
				self._txtSLinGanValue.text = item:getCount()
			elseif item:getItemId() == GameEnum.CurrencyCodeEnum.InspirationA then
				self._txtALinGanValue.text = item:getCount()
			end
		end
	end
end

function M:_refreshCostView()
	local tenCost = self._lotteryData:getLotteryCost(RetrieveEnum.LotteryNum.Ten)
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(tenCost.item)
	local iconName = tostring(itemCo.icon) .. "0"

	self._tenNum.text = tenCost.num

	IconLoader.setSprite(self._tenIcon, IconType.Skinlib, iconName)
end

function M:_checkXinMaoData(conversion)
	for _, v in pairs(conversion) do
		local converData = v

		if converData.code ~= GameEnum.CurrencyCodeEnum.InspirationS and converData.code ~= GameEnum.CurrencyCodeEnum.InspirationA then
			return true
		end
	end

	return false
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)

	for i = 1, #self._lotteryViewList do
		local itemView = self._lotteryViewList[i]

		if itemView and itemView:getGo() and not goutil.isNil(itemView:getGo()) then
			goutil.destroy(itemView:getGo())
		end
	end

	table.clear(self._lotteryViewList)
end

function M:_onClickContinue()
	self:close()
	ViewMgr.instance:clearSomeViewFromBackStack(ViewName.RetrieveTenCardShowViewViewPresentor)

	if RetrieveModel.instance:getIsTest() then
		RetrieveModel.instance:onReset()
		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)

		return
	end

	RetrieveController.instance:jumpToMainRetrieve()
	RetrieveController.instance:clearCacheItemMOList()
end

function M:_onClickTenAgain()
	local lotteryId = RetrieveModel.instance:getLotteryId()

	if RetrieveController.instance:checkCanLottery(lotteryId, RetrieveEnum.LotteryNum.Ten) then
		self:close()
		ViewMgr.instance:clearSomeViewFromBackStack(ViewName.RetrieveTenCardShowViewViewPresentor)
	end

	RetrieveController.instance:clearCacheItemMOList()

	if RetrieveModel.instance:getIsTest() then
		RetrieveModel.instance:onReset()
		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)

		return
	end

	RetrieveController.instance:doRetrieveTen()
end

function M:_onClickShare()
	local shareType = ShareEnum.Two
	local fileName = string.format("CG_%s", self._lotteryData:getLotteryId())
	local showToast = true
	local shareOpen = ShareFacade.instance:openShare(shareType, fileName, showToast, self._onShareViewExist, self)
end

function M:_onShareViewExist()
	return
end

return M
