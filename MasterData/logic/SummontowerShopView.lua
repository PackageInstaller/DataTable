-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerShopView.lua

module("logic.extensions.summontower.view.SummontowerShopView", package.seeall)

local SummontowerShopView = class("SummontowerShopView", ViewComponent)

function SummontowerShopView:buildUI()
	SummontowerShopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableview = self:getGo("tableview"):GetComponent(ComponentType.UITableview)
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	local txtTip = self:getTxt("txtTip")
	local bubbleTip = self:getTxt("bubble/txtTip")

	txtTip.text = lang("txt_summontower_shop_tips")
	bubbleTip.text = lang("txt_summontower_shop_bubbletips")
end

function SummontowerShopView:bindEvents()
	SummontowerShopView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._tableview:RegisterCallback(self._numItemsInView, nil, self._itemCellAtIndex, self)
end

function SummontowerShopView:unbindEvents()
	SummontowerShopView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function SummontowerShopView:onEnter()
	SummontowerShopView.super.onEnter(self)

	self._gridData = self:getFirstParam()
	self._curViewDatas = self._gridData:getShopItems()

	self._tableview:SetOffsetWithoutRefresh(0)
	self._tableview:ReloadData()
	GlobalDispatcher:addListener(GlobalNotify.OnSommonTowerDoGrid, self._onSommonTowerDoGrid, self)
end

function SummontowerShopView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnSommonTowerDoGrid, self._onSommonTowerDoGrid, self)
	SummontowerShopView.super.onExit(self)

	self._gridData = nil
	self._curViewDatas = nil

	self._tableview:Travel(self._clearCell, self)
end

function SummontowerShopView:_onClickClose()
	self:close()
end

function SummontowerShopView:_numItemsInView(view)
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function SummontowerShopView:_itemCellAtIndex(view, idx)
	local data = self._curViewDatas[idx + 1]
	local cell = self._tableview:DequeueCell()

	cell = cell or self._tableview:AddChild(self._tableCell)

	local gameObject = cell.gameObject
	local txtLimit = goutil.findChildTextComponent(gameObject, "txtLimit")
	local hasBuy = goutil.findChild(gameObject, "hasBuy")
	local count = data:getMaxBuyCount()
	local buyTimes = data.buyTimes

	hasBuy:SetActive(count <= buyTimes)

	txtLimit.text = string.format(lang("text_lottery_desc_22"), count - buyTimes, count)

	self:_fillPrice(data, gameObject)
	self:_fillItemIcon(data, gameObject)
	self:_handleCellEvent(data, gameObject)

	return cell
end

function SummontowerShopView:_handleCellEvent(data, gameObject)
	local btn = Framework.ButtonAdapter.Get(gameObject)

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		if data.buyTimes >= data:getMaxBuyCount() then
			FloatWordMgr.instance:show(lang("text_recall_desc_6"))

			return
		end

		local price = data:getPrice()
		local ownedNum = SummonTowerItemsModel.instance:getItemsNum(SummonTowerItemsModel.ItemType.Coin)
		local gameItemCo = SummontowerConfig.instance:getGameItemCo(SummonTowerItemsModel.ItemType.Coin)

		if ownedNum < price then
			FloatWordMgr.instance:show(string.format("%s数量不足", gameItemCo.name))

			return
		end

		local content = langPara("确定花费<color=#ebad32>%s</color>%s购买%s吗？", price, gameItemCo.name, data:getGoodsName())

		TipsFacade.instance:openPopupCostMatViewNew(MatType.Item_Fake, gameItemCo.itemId, price, content, function()
			SummontowerController.instance:buyGameItem(self._gridData.gridId, data.shopItemId)
		end)
	end)
end

function SummontowerShopView:_fillPrice(data, gameObject)
	local priceIcon = goutil.findChild(gameObject, "txtprice/icon")
	local txtprice = goutil.findChildTextComponent(gameObject, "txtprice")
	local price = data:getPrice()

	txtprice.text = tostring(price)

	local gameItemCo = SummontowerConfig.instance:getGameItemCo(SummonTowerItemsModel.ItemType.Coin)

	MaterialMgr.setIcon(priceIcon, MatType.Item_Fake, gameItemCo.itemId)
end

function SummontowerShopView:_fillItemIcon(data, gameObject)
	local item = goutil.findChild(gameObject, "item")
	local itemCo = SummontowerConfig.instance:getShopItemCo(data.shopId, data.shopItemId)

	MaterialMgr.resetAll(item)

	if itemCo.itemType == SummonTowerItemsModel.ItemType.Pet then
		local petCo = SummontowerConfig.instance:getPetCo(data.randomValue)
		local curFaceId = checknumber(petCo.faceId)

		if curFaceId == 0 then
			curFaceId = petCo.raceId
		end

		local proxy = MaterialMgr.setCellByCfg(MatType.Pet .. ":" .. curFaceId .. ":" .. petCo.lv, item)

		if proxy then
			proxy.binder:setStars(petCo.awakenLv)
			proxy.binder:setSkin(curFaceId)
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				local fightingPower = FightingPowerPetMo.New(petCo.raceId, level)

				fightingPower:fromChallengeCreepCo(petCo, cfgs)

				local petMo = {
					contractSkillId = 0,
					raceId = petCo.raceId,
					curFaceId = curFaceId,
					level = level,
					name = petCo.creepsName,
					_curZdl = fightingPower:getFightingPower(),
					awakenLv = petCo.awakenLv
				}

				CommonTipsMgr.instance:showPetTips(petMo)
			end)
		end
	else
		local gameItemCo = SummontowerConfig.instance:getGameItemCo(itemCo.itemType)

		MaterialMgr.setCellByCfg(MatType.Item_Fake .. ":" .. gameItemCo.itemId, item)
	end
end

function SummontowerShopView:_clearCell(cell)
	local gameObject = cell.gameObject
	local item = goutil.findChild(gameObject, "item")
	local priceIcon = goutil.findChild(gameObject, "txtprice/icon")
	local btn = Framework.ButtonAdapter.Get(gameObject)

	MaterialMgr.resetAll(item)
	MaterialMgr.clearIcon(priceIcon)
	btn:RemoveClickListener()
end

function SummontowerShopView:_onSommonTowerDoGrid(changeMos, getPets)
	self._curViewDatas = self._gridData:getShopItems()

	self._tableview:ReloadData()
end

return SummontowerShopView
