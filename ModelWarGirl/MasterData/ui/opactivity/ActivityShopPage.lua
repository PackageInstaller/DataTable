-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityShopPage.lua

local ShopCellMixin = require("UI/MainState/Trade/ShopCellMixin")
local ResShopExchg = require("ClientData/ResShopExchg")
local ShopItem = require("UI/MainState/Trade/ShopItem")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local UIControls = UIControls
local ActivityShopRefreshPanel = Class("ActivityShopRefreshPanel", UIControls.Panel)

function ActivityShopRefreshPanel:ctor()
	self.btnRefresh = UIControls.Button(self, self.mPath .. "/BtnRefresh")

	self.btnRefresh:addEventClick(self.onBtnRefreshClick)

	self.btnRefreshDis = UIControls.Button(self, self.mPath .. "/BtnRefreshDis")

	self.btnRefreshDis:addEventClick(self.onBtnRefreshDisClick)
end

function ActivityShopRefreshPanel:setValid(buyOver)
	self.btnRefresh:setVisible(buyOver)
	self.btnRefreshDis:setVisible(not buyOver)
end

function ActivityShopRefreshPanel:onBtnRefreshClick()
	local actObj = self.mParent.actObj

	if actObj and actObj.actData and actObj.actData.nowRealRound then
		CurAvatar:activityRPC(Functor(RPC.opActShopRefresh, actObj.opId, actObj.actData.nowRealRound), actObj.opId)
	end
end

function ActivityShopRefreshPanel:onBtnRefreshDisClick()
	MsgManager.clientNotice(300)
end

local classNameStr = "ActivityShopPage"
local ActivityShopPage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityShopPage, ActivityPanelMixin)

function ActivityShopPage:initUI()
	self._slot4CellClick = Slot(self._onShopItemClick, self)
	self.scrollItems = UIControls.ScrollViewLoopV(self, "ContentList", 0, self._onCellChanged)
	self.cells = {}
	self.textHas = UIControls.Label(self, "HavePanel/TextNum")
	self.btnCost = UIControls.Button(self, "BtnIcon")

	self.btnCost:addEventClick(self.onClickCost)

	self.textRule = UIControls.Label(self, "BgDes/TextDes")
	self.textTime = UIControls.Label(self, "BgTime/TextTime")

	if UIControls.checkControlFunc(self, "RefreshPanel") then
		self.panelRefresh = ActivityShopRefreshPanel(self, "RefreshPanel")
	end
end

function ActivityShopPage:_setData()
	self:refreshShopItems()

	if self.actObj.actData.maxRound and self.actObj.actData.maxRound > 1 then
		if self.panelRefresh then
			self.panelRefresh:setVisible(true)
		end
	elseif self.panelRefresh then
		self.panelRefresh:setVisible(false)
	end
end

function ActivityShopPage:refreshShopItems(...)
	self._curItems = self.actObj.actData:getCurShopItem()
	self.chgCostId = nil

	if self.actObj.actData.maxRound and self.actObj.actData.maxRound > 1 then
		self.nowRealRound = self.actObj.actData.nowRealRound or 0
	end

	for index, shopItem in ipairs(self._curItems) do
		self.chgCostId = shopItem:getCostMoneyInfo()

		break
	end

	if self.chgCostId then
		local moneyPath = ClientUtils.getMoneyIcon(self.chgCostId)

		if moneyPath then
			self.btnCost:setImage(moneyPath[1], moneyPath[2])
		end
	end
end

function ActivityShopPage:onClickCost()
	local fakeItem = BaseObject.GetObject(self.chgCostId)

	UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem)
end

function ActivityShopPage:_onShow()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_ACT, self.clientTemplateData.template_id)

	if self.chgCostId then
		local num = ClientUtils.getMoney(self.chgCostId)

		self.textHas:setText(ClientUtils.getNumShortStr(num))
	end

	for _, shopItem in ipairs(self._curItems) do
		shopItem:setBoughtNum(self.actObj.actData:getHasBuyNum(shopItem.id))
	end

	for index, targetCell in pairs(self.cells) do
		local item = self._curItems[index]

		targetCell:setData(item)
	end

	self.scrollItems:setTotalCount(#self._curItems)

	if self.actObj.actData.maxRound and self.actObj.actData.maxRound > 1 and self.panelRefresh then
		self.panelRefresh:setValid(self.actObj.actData:isCurRoundBuyOver())
	end
end

function ActivityShopPage:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIConst.ActivityShopCellLoop(sender, "System/Common/Grid/GridTokenStoreItem", newIdx)
		targetCell.mEventClick = self._slot4CellClick
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	local item = self._curItems[newIdx]

	targetCell:setData(item)
end

function ActivityShopPage:_onShopItemClick(item)
	if not item:canBuy() then
		local hint = item:getClickHint()

		if hint ~= nil then
			MsgManager.notice(hint)
		end
	else
		local ui = UIManager.getUI("shopBuyBox")

		ui:showShopItem(item, self, Slot(self.onBuyCB, self), UIConst.ActivityShopCellChild, "System/Common/Grid/GridTokenStoreItem")
		ui:bindWindow(self)
	end
end

function ActivityShopPage:onBuyCB(exchgid, count)
	RPC.opActGetAward(self.actObj.opId, exchgid, count)
end

function ActivityShopPage:onActivityDataRefresh()
	if self.actObj.actData.maxRound and self.actObj.actData.maxRound > 1 and (self.actObj.actData.nowRealRound or 0) > self.nowRealRound then
		self:refreshShopItems()
		self:playAni("ShowStoreItem")
	end

	self:_onShow()
end

return ActivityShopPage
