-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/view/PartyFoodPrizeView.lua

module("logic.extensions.partysummary.view.PartyFoodPrizeView", package.seeall)

local PartyFoodPrizeView = class("PartyFoodPrizeView", TableViewComponent)

function PartyFoodPrizeView:ctor()
	PartyFoodPrizeView.super.ctor(self)
end

function PartyFoodPrizeView:onExit()
	PartyFoodPrizeView.super.onExit(self)

	self._curViewDatas = nil
	self._dayIndex = nil
end

function PartyFoodPrizeView:destroyUI()
	PartyFoodPrizeView.super.destroyUI(self)
end

function PartyFoodPrizeView:bindEvents()
	PartyFoodPrizeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function PartyFoodPrizeView:unbindEvents()
	PartyFoodPrizeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function PartyFoodPrizeView:buildUI()
	PartyFoodPrizeView.super.buildUI(self)

	self._closeBtn = self:getBtn("viewBgGo/closeBtn")
end

function PartyFoodPrizeView:onEnter()
	PartyFoodPrizeView.super.onEnter(self)

	local actId = self:getFirstParam()

	if checknumber(actId) <= 0 then
		actId = PartySummaryConfig.instance:getPartyFoodActivityId()
	end

	self._curViewDatas, self._dayIndex = PartySummaryModel.instance:getPartyFoodBigPrizes(actId)

	self._tableview:ReloadData()
end

function PartyFoodPrizeView:_onReloadFinish(view)
	if self._curViewDatas and #self._curViewDatas > 3 and self._dayIndex > 2 then
		self._tableview:MoveCellInView(self._dayIndex, false)

		self._onReloadFinish = nil
	end
end

function PartyFoodPrizeView:_getPath()
	return {
		cellPath = "viewBgGo/prizeItem",
		viewPath = "viewBgGo/prizeItemSR"
	}
end

function PartyFoodPrizeView:_cellSize()
	return 845, 90
end

function PartyFoodPrizeView:_updateCell(view, cell, data)
	local itemBgIcc = goutil.findChild(cell, "itemBgIcc"):GetComponent("UIImageColorChange")
	local dateTxt = goutil.findChildTextComponent(cell, "dateTxt")
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local viewContent = goutil.findChild(cell, "goodsSR/Viewport/Content").transform
	local viewLayout = goutil.findChild(cell, "goodsSR/Viewport/Content/items"):GetComponent(ComponentType.UILayoutSingleLine)

	GameUtil.SetActive(goodsGo, false)

	dateTxt.text = string.format("%s月%s日", data.month, data.day)

	local num = cell.data - math.floor(cell.data / 2) * 2

	itemBgIcc:SetState(num)

	local childCount = viewLayout.transform.childCount

	if data.prizeList then
		if not #data.prizeList then
			local goodsCount = 0

			while childCount < goodsCount do
				local go = UGUIToolHelper.AddChild(viewLayout.gameObject, goodsGo)

				childCount = childCount + 1
			end

			for i = 1, goodsCount do
				local go = viewLayout.transform:GetChild(i - 1).gameObject

				GameUtil.SetActive(go, true)

				local posGo = goutil.findChild(go, "posGo")

				MaterialMgr.resetAll(posGo)
				MaterialMgr.setCellByCfg(data.prizeList[i].prize, posGo)

				local proTxt = goutil.findChildTextComponent(go, "proTxt")

				proTxt.text = PartySummaryModel.instance:getPartyFoodProbability(data.prizeList[i])
			end

			for i = goodsCount + 1, childCount do
				GameUtil.SetActive(viewLayout.transform:GetChild(i - 1), false)
			end

			viewLayout:Layout()

			local sizeDelta = viewContent.sizeDelta

			sizeDelta.x = goodsCount * 100
			viewContent.sizeDelta = sizeDelta
		end
	end
end

return PartyFoodPrizeView
