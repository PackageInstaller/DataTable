-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/DressbatchsellView.lua

module("logic.extensions.dress.view.DressbatchsellView", package.seeall)

local DressbatchsellView = class("DressbatchsellView", ViewComponent)
local Payway = {
	"rmb_",
	"8:14:",
	"8:1:",
	"105:1:"
}

function DressbatchsellView:ctor()
	DressbatchsellView.super.ctor(self)
end

function DressbatchsellView:buildUI()
	DressbatchsellView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._costs = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("cost/cost" .. i)
		cell.txt = goutil.findChildTextComponent(cell.go, "txtCost")
		self._costs[i] = cell
	end

	self._goCell = self:getGo("cell")
	self._goTable = self:getGo("tableview")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._deduceGo = self:getGo("deduce")
	self._costDeduceGo = self:getGo("deduce/cost")
	self._txtDeduceCost = self:getTxt("deduce/cost/txtCost")
end

function DressbatchsellView:bindEvents()
	DressbatchsellView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
end

function DressbatchsellView:unbindEvents()
	DressbatchsellView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function DressbatchsellView:destroyUI()
	DressbatchsellView.super.destroyUI(self)
end

function DressbatchsellView:onEnter()
	DressbatchsellView.super.onEnter(self)

	local dataList = self:getFirstParam() or {}

	self.showDataList = {}
	self.totalDataList = {}

	for k, v in pairs(dataList) do
		table.insert(self.showDataList, v)

		self.totalDataList[v.goodsCfg.id] = v
	end

	self._tableView:reloadData(self.showDataList)
	self:_onClickBtn()
end

function DressbatchsellView:onEnterFinished()
	DressbatchsellView.super.onEnterFinished(self)
end

function DressbatchsellView:onExit()
	DressbatchsellView.super.onExit(self)
	MaterialMgr.resetAll(self._costDeduceGo)
end

function DressbatchsellView:onExitFinished()
	DressbatchsellView.super.onExitFinished(self)
end

function DressbatchsellView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtName.text = data.goodsCfg.name

	goutil.setActive(cell.markTime, data:getIsTrialCard())

	if data:getUseTime() == 15 then
		cell.showTime:SetState(2)
	elseif data:getUseTime() == 7 then
		cell.showTime:SetState(1)
	else
		cell.showTime:SetState(0)
	end

	cell.txtCost.text = data.costNum

	cell.coinCost:SetState(data.costType - 2)
	uGuiUtil.setSpriteToImage(cell.item, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.goodsCfg.icon))
	goutil.setActive(cell.mark, table.keyof(self.totalDataList, data))
	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickBtn, self, data))
end

function DressbatchsellView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.item = goutil.findChild(cell.go, "item")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.mark = goutil.findChild(cell.go, "imgSelect")
	cell.markTime = goutil.findChild(cell.go, "markTime")
	cell.showTime = goutil.findChild(cell.markTime, "card"):GetComponent(ComponentType.UIImageSpriteChange)
	cell.txtCost = goutil.findChildTextComponent(cell.go, "txtCost")
	cell.coinCost = goutil.findChild(cell.txtCost.gameObject, "icon"):GetComponent(ComponentType.UIImageSpriteChange)

	GameUtil.rmClickHandler(cell.go)
	uGuiUtil.clearImage(cell.item)

	return cell
end

function DressbatchsellView:_onClickBtn(data)
	if data then
		if table.keyof(self.totalDataList, data) then
			self.totalDataList[data.goodsCfg.id] = nil
		else
			self.totalDataList[data.goodsCfg.id] = data
		end

		self._tableView:reloadData(self.showDataList)
	end

	local nums = {
		0,
		0,
		0
	}

	for k, v in pairs(self.totalDataList) do
		local index = v.costType - 1

		if nums[index] then
			nums[index] = nums[index] + v.costNum
		end
	end

	self._isAbleToBuy = true

	for i = 1, 3 do
		local temNum = nums[i]

		if temNum ~= 0 then
			goutil.setActive(self._costs[i].go, true)

			local matStr = Payway[i + 1] .. temNum

			if not MaterialMgr.getMatEnough(matStr) then
				temNum = langPara("<color=red>%s</color>", temNum)
				self._isAbleToBuy = false
			end

			self._costs[i].txt.text = temNum
		else
			goutil.setActive(self._costs[i].go, false)
		end
	end

	self:_updateDeduce()
	GameUtil.SetGray(self._btnBuy.gameObject, not self._isAbleToBuy)
end

function DressbatchsellView:_updateDeduce()
	local currHasNum = MaterialFacade.instance:getMatNumber(MatType.Coin, 14)
	local oriCostNum = 0
	local duduceCostNum = 0
	local deduceMatType = 0
	local deduceMatId = 0

	for k, shopData in pairs(self.totalDataList) do
		shopData.deduceItemCount = 0

		local matType, matId = MaterialMgr.getMatParams(shopData.goodsCfg.originalGoodsId)
		local costNum = shopData.costNum

		if currHasNum < costNum then
			oriCostNum = oriCostNum + currHasNum

			local deduceItemCount = DressController.instance:getDeduceCostNum(shopData, costNum, currHasNum)

			duduceCostNum = duduceCostNum + deduceItemCount
			shopData.deduceItemCount = deduceItemCount

			if duduceCostNum > 0 and deduceMatType <= 0 then
				local deduceCfg = shopData:getDeduceCfg()

				if deduceCfg then
					local mt, mid = MaterialMgr.getMatParams(deduceCfg.deduction)

					deduceMatType = mt
					deduceMatId = mid
				end
			end
		else
			oriCostNum = oriCostNum + costNum
		end

		currHasNum = currHasNum - costNum

		if currHasNum <= 0 then
			currHasNum = 0
		end
	end

	if deduceMatType > 0 then
		local duduceHasNum = MaterialFacade.instance:getMatNumber(deduceMatType, deduceMatId)

		self._costs[1].txt.text = oriCostNum
		self._isAbleToBuy = self._isAbleToBuy or duduceCostNum <= duduceHasNum

		MaterialMgr.setIcon(self._costDeduceGo, deduceMatType, deduceMatId)

		self._txtDeduceCost.text = string.format("%s可补足", duduceCostNum)
	end

	goutil.setActive(self._deduceGo, duduceCostNum > 0)
end

function DressbatchsellView:_onClickBuy()
	if self._isAbleToBuy then
		if table.nums(self.totalDataList) == 0 then
			FloatWordMgr.instance:show(langPara("没有选中商品"))
		else
			local reqdata = {}

			for k, v in pairs(self.totalDataList) do
				local item = {}

				item.id = v.goodsCfg.id
				item.buyTimes = 1
				item.deduceItemCount = v.deduceItemCount

				table.insert(reqdata, item)
			end

			PayShopAgent.instance:sendBatchBuyItemReq(reqdata)
			self:close()
		end
	else
		FloatWordMgr.instance:show(langPara("货币不足，无法购买"))
	end
end

return DressbatchsellView
