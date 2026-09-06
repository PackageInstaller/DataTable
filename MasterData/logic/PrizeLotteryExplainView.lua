-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/view/PrizeLotteryExplainView.lua

module("logic.extensions.summerlottery.view.PrizeLotteryExplainView", package.seeall)

local PrizeLotteryExplainView = class("PrizeLotteryExplainView", TableViewComponent)

function PrizeLotteryExplainView:_getPath()
	return {
		cellPath = "viewBgIma/prizeCell",
		viewPath = "viewBgIma/callItemSR"
	}
end

function PrizeLotteryExplainView:ctor()
	PrizeLotteryExplainView.super.ctor(self)
end

function PrizeLotteryExplainView:unbindEvents()
	PrizeLotteryExplainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function PrizeLotteryExplainView:bindEvents()
	PrizeLotteryExplainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function PrizeLotteryExplainView:buildUI()
	PrizeLotteryExplainView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._ruleTitleNameTxt = self:getTxt("viewBgIma/left/titleNameTxt")
	self._ruleTitleDesTxt = self:getTxt("viewBgIma/left/tableview/Viewport/Content")
	self._itemCell = self:getGo("viewBgIma/itemCell")
	self._groupMap = {}

	goutil.setActive(self._itemCell, false)
end

function PrizeLotteryExplainView:onExit()
	PrizeLotteryExplainView.super.onExit(self)
end

function PrizeLotteryExplainView:onEnter()
	PrizeLotteryExplainView.super.onEnter(self)

	self._poolId = self:getFirstParam()
	self._ruleConf = SummerLotteryConfig.instance:getCommonLotteryRuleConf(self._poolId)
	self._showConfs = SummerLotteryConfig.instance:getCommonLotteryShowConfs(self._poolId)

	if not self._ruleConf or not self._showConfs then
		FloatWordMgr.instance:show(lang("奖励展示配置不存在"))
		self:close()

		return
	end

	self:_initRule()
	self:_initPrizes()
end

function PrizeLotteryExplainView:_initRule()
	self._ruleTitleNameTxt.text = self._ruleConf.title
	self._ruleTitleDesTxt.text = self._ruleConf.rule
end

function PrizeLotteryExplainView:_initPrizes()
	self:updateListData(self._showConfs)
end

function PrizeLotteryExplainView:initCell(cell)
	return
end

function PrizeLotteryExplainView:_cellSize(sv, index)
	local prizes = self._curViewDatas[index + 1]

	if string.nilorempty(prizes[1].itemTitle) then
		return 640, math.ceil(#prizes / 5) * 110 + 40
	else
		return 640, math.ceil(#prizes / 5) * 147 + 40
	end
end

function PrizeLotteryExplainView:_updateCell(view, cell, data)
	local tagTxt = goutil.findChildTextComponent(cell, "rateTitle/tagTxt")
	local rateTxt = goutil.findChildTextComponent(cell, "rateTitle/rateTxt")
	local itemList = goutil.findChild(cell, "itemList")
	local prizes = data
	local firstPrize = data[1]

	tagTxt.text = firstPrize.tagTxt or ""
	rateTxt.text = firstPrize.title or ""
	self._groupMap[cell] = self._groupMap[cell] or {}

	local itemArray = self._groupMap[cell]
	local totalLen = #prizes

	for i, item in ipairs(itemArray) do
		if totalLen < i then
			goutil.setActive(item, false)
		end
	end

	local layoutGroup = itemList:GetComponent("GridLayoutGroup")
	local cellSize = {
		x = layoutGroup.cellSize.x,
		y = layoutGroup.cellSize.y
	}
	local spacing = {
		x = layoutGroup.spacing.x,
		y = layoutGroup.spacing.y
	}

	if string.nilorempty(firstPrize.itemTitle) then
		cellSize.y = 100
		spacing.y = 10
	else
		cellSize.y = 137
		spacing.y = 0
	end

	layoutGroup.cellSize = cellSize
	layoutGroup.spacing = spacing

	for i, prize in ipairs(prizes) do
		if not itemArray[i] then
			local item = goutil.cloneAndSetParent(self._itemCell, itemList.transform)
			local itemCell = goutil.findChild(item, "cell")
			local curPrizeRateTxt = goutil.findChildTextComponent(item, "curPrizeRateTxt")

			GameUtil.SetActive(curPrizeRateTxt, not string.nilorempty(prize.itemTitle))

			curPrizeRateTxt.text = prize.itemTitle or ""
			itemArray[i] = item

			goutil.setActive(item, true)
			MaterialMgr.resetAll(itemCell)
			MaterialMgr.setCellByCfg(prize.item, itemCell)
		end
	end
end

function PrizeLotteryExplainView:_clearTableview(cell)
	local itemArray = self._groupMap[cell]

	for _, item in ipairs(itemArray) do
		local itemCell = goutil.findChild(item, "cell")

		MaterialMgr.resetAll(itemCell)
		goutil.setActive(item, false)
	end
end

return PrizeLotteryExplainView
