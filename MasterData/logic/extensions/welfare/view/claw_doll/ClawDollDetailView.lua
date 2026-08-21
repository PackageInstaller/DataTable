-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/claw_doll/ClawDollDetailView.lua

module("logic.extensions.welfare.view.claw_doll.ClawDollDetailView", package.seeall)

local M = class("ClawDollDetailView", ViewComponent)
local coinId = CommEnum.CurrencyCodeEnum.ClawDollCoin

function M:buildUI()
	self._btnReturn = self:getBtn("6&title_view_-878360263")
	self._btnCoin = self:getBtn("3&btn_middle_-31477526")
	self._empty = self:getGo("2&empty_unit_-1401348703")
	self.go_com_price = self:getGo("9&com_price_1317146225")
	self._loopHasDollList = LoopGridViewHelper.New(self:getGo("prize_claw_main_view_886107758"))

	self._loopHasDollList:InitGridView(0, self._onCellHasUpdate, self)

	self._loopAllList = LoopGridViewHelper.New(self:getGo("prize_claw_main_view_503383005"))

	self._loopAllList:InitGridView(0, self._onCellAllUpdate, self)

	self._costCell = PrefabReferenceUtil.createCurrencyCostLuaCell(self.go_com_price)
end

function M:destroyUI()
	self._btnReturn = nil

	self._loopHasDollList:Dispose()

	self._loopHasDollList = nil

	self._loopAllList:Dispose()

	self._loopAllList = nil
	self._hasDollDataLst = nil
	self._allDollList = nil
	self._isEnterScene = nil
end

function M:bindEvents()
	self._btnCoin:AddClickListener(self._onClickCoin, self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnCoin:RemoveClickListener()
	self._btnReturn:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local cfgId = ClawDollActivityView.CONFIGID

	ClawDollAgent.instance:sendGetClipDollInfoRequest(cfgId)
	self:refreshHasDollLoopList()
	self:_refreshCoinText()
	self._costCell:updateData(coinId)
end

function M:onExit()
	self._isEnterScene = nil

	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CLAW_DOLL_REFRESHDETAIL, self._refreshAllDollLoopList, self)
		GlobalDispatcher:addEventListener(EventType.TOP_MONEY_ITEM_ADD_CLICK, self._handleToCoinItemAddClick, self)
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._refreshCoinText, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CLAW_DOLL_REFRESHDETAIL, self._refreshAllDollLoopList, self)
		GlobalDispatcher:removeEventListener(EventType.TOP_MONEY_ITEM_ADD_CLICK, self._handleToCoinItemAddClick, self)
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._refreshCoinText, self)
	end
end

function M:_onClickReturn()
	self:back()
end

function M:_onClickCoin()
	local cfgId = ClawDollActivityView.CONFIGID
	local bool = self:_canEnterActivity()

	if not bool then
		FloatWordMgr.instance:show(lang("tip_activity_over"))

		return
	end

	local bollList = ClawDollController.instance:getDollInMachineList(cfgId)

	if bollList ~= nil and #bollList ~= 0 then
		if self._isEnterScene then
			SceneFace.instance:enterClawDollScene()
		else
			local isFinishAllTask = ClawDollController.instance:isFinishAllTask(cfgId)

			if isFinishAllTask then
				FloatWordMgr.instance:show(lang("tip_claw_doll_nocoin"))
			else
				local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_clawdoll_coin"))

				dialog:setConfirmListener(function()
					self:back()
					ViewMgr.instance:open(ViewName.ClawDollTaskView)
				end, self)
			end
		end
	else
		FloatWordMgr.instance:show(lang("claw_doll_boll_empty"))
	end
end

function M:_canEnterActivity()
	local cfgId = ClawDollActivityView.CONFIGID
	local actId = ClawDollController.instance:getActivityId(cfgId)
	local actMo = ActivityModel.instance:getActivityById(actId)
	local bool = actMo:getIsActivityOpen()

	return bool
end

function M:_handleToCoinItemAddClick()
	if #self._allDollList > 0 then
		local minMulti = 1
		local targetId = 1104
		local alwaysShowTips = true
		local forceShowWhenJumpOpen
		local titleStr = lang("tip_exchange_title_clawdoll")

		CurrencyExchangeController.instance:showTipsNormal(targetId, minMulti, alwaysShowTips, forceShowWhenJumpOpen, titleStr)
	else
		FloatWordMgr.instance:show(lang("claw_doll_boll_empty"))
	end
end

function M:_refreshCoinText(e, list)
	local f = list
	local num = ClawDollController.instance:getCurCoinNumber(ClawDollActivityView.CONFIGID)

	self._isEnterScene = num >= 1

	local color = self._isEnterScene and "FFFFFF" or "c93b3b"

	self._costCell:setCostCount(1, color)
end

function M:refreshHasDollLoopList()
	local tempList = ItemModel.instance:getItemsByTS(GameEnum.ItemTypeEnum.PropItemType, 12)

	self._hasDollDataLst = {}

	for k, v in pairs(tempList) do
		if v:getCount() > 0 then
			table.insert(self._hasDollDataLst, v)
		end
	end

	local count = self._hasDollDataLst and #self._hasDollDataLst or 0

	goutil.setActive(self._empty, count == 0)
	self._loopHasDollList:SetListItemCount(count, false)
	self._loopHasDollList:RefreshAllShownItem()
end

function M:_onCellHasUpdate(curIndex)
	curIndex = curIndex + 1

	local class = ItemCell
	local item = self._loopHasDollList:NewListViewItem("backpack_item")
	local dollitemData = self._hasDollDataLst[curIndex]
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, class)

	shower = shower or Astral.LuaComponentContainer.Add(item.gameObject, class)

	shower:updateData(dollitemData)
	shower:Awake()
	shower:setShowSelectedEffect(false)

	return item
end

function M:_refreshAllDollLoopList(e, cfgId)
	self._loopAllList:ClearCells()

	self._allDollList = ClawDollController.instance:getDollInMachineList(cfgId)

	local count = self._allDollList and #self._allDollList or 0

	self._loopAllList:SetListItemCount(count, false)
	self._loopAllList:RefreshAllShownItem()
end

function M:_onCellAllUpdate(curIndex)
	curIndex = curIndex + 1

	local class = ItemCell
	local item = self._loopAllList:NewListViewItem("backpack_item")
	local dollNo = self._allDollList[curIndex]
	local dollData = ItemUtil.createItemData({
		itemId = dollNo.id
	})

	dollData:setCount(dollNo.count)

	local shower = Astral.LuaComponentContainer.Get(item.gameObject, class)

	shower = shower or Astral.LuaComponentContainer.Add(item.gameObject, class)

	shower:updateData(dollData)
	shower:Awake()
	shower:setShowSelectedEffect(false)

	return item
end

return M
