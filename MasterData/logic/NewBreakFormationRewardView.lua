-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/view/NewBreakFormationRewardView.lua

module("logic.extensions.newbreakformation.view.NewBreakFormationRewardView", package.seeall)

local NewBreakFormationRewardView = class("NewBreakFormationRewardView", ViewComponent)

function NewBreakFormationRewardView:ctor()
	NewBreakFormationRewardView.super.ctor(self)
end

function NewBreakFormationRewardView:unbindEvents()
	NewBreakFormationRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NewBreakFormationRewardView:bindEvents()
	NewBreakFormationRewardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NewBreakFormationRewardView:buildUI()
	NewBreakFormationRewardView.super.buildUI(self)

	self._btnClose = self:getGo("viewInfoTran/viewCloseBtn")
	self._tabTableView = self:getGo("viewInfoTran/tabTableView")
	self._tabTableCell = self:getGo("viewInfoTran/tabTableCell")
	self._rewardGo = self:getGo("viewInfoTran/rewardListBgGo")
	self._rewardTableView = self:getGo("viewInfoTran/rewardListBgGo/rewardListSR")
	self._rewardTableCell = self:getGo("viewInfoTran/rewardListBgGo/rewardItemGo")
	self._rewardEmptyGo = self:getGo("viewInfoTran/rewardListBgGo/goEmpty")
	self._rankRewardGo = self:getGo("viewInfoTran/rankRewardListBgGo")
	self._rankRewardTableView = self:getGo("viewInfoTran/rankRewardListBgGo/rewardListSR")
	self._rankRewardTableCell = self:getGo("viewInfoTran/rankRewardListBgGo/rewardItemGo")
	self._itemScrollercell = self:getGo("viewInfoTran/rewardListBgGo/itemScrollercell")
end

function NewBreakFormationRewardView:onExit()
	NewBreakFormationRewardView.super.onExit(self)
	self._rewardTableList:dispose()
	self._tabTableList:dispose()
end

function NewBreakFormationRewardView:onEnter()
	NewBreakFormationRewardView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_NewBreachFormationGainScorePrizeRes, self._refreshView, self)

	self._tabTableList = ScrollerList.create(self._tabTableView, self._tabTableCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._rewardTableList = ScrollerList.create(self._rewardTableView, self._rewardTableCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._rankTableList = ScrollerList.create(self._rankRewardTableView, self._rankRewardTableCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._seasonId = self:getFirstParam()
	self._tabId = 1
	self._itemScrollListDic = {}

	self:_refreshView()
end

function NewBreakFormationRewardView:_refreshView()
	local tableData = {}
	local tabCfgs = NewBreakFormationConfig.instance:getTabCfgs(self._seasonId)

	for i, v in ipairs(tabCfgs) do
		table.insert(tableData, {
			isRankData = false,
			cfg = v
		})
	end

	table.insert(tableData, {
		isRankData = true
	})
	self._tabTableList:reloadData(tableData)
	GameUtil.SetActive(self._rewardGo, self._tabId > 0)
	GameUtil.SetActive(self._rankRewardGo, self._tabId <= 0)
	GameUtil.SetActive(self._rewardEmptyGo, false)

	if self._tabId > 0 then
		self:_refreshScoreRewardView()
	else
		self:_refreshRankRewardView()
	end
end

function NewBreakFormationRewardView:_refreshScoreRewardView()
	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, self._tabId)

	self._periodId = NewBreakFormationController.instance:getPeriodId(tabCfg.periodPlanId)

	local list = {}

	if self._periodId > 0 then
		local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, self._periodId)
		local scorePlanCfgs = NewBreakFormationConfig.instance:getScorePlanCfgs(periodCfg.scorePlanId)

		self._score = NewBreakFormationModel.instance:getTotalScoreByPeriod(self._seasonId, self._tabId, self._periodId)

		for i, v in ipairs(scorePlanCfgs) do
			table.insert(list, v)
		end

		table.sort(list, function(a, b)
			local isGainA = NewBreakFormationModel.instance:isPerioPrizeGain(self._seasonId, self._tabId, self._periodId, a.prizeId) and 1 or 0
			local isGainB = NewBreakFormationModel.instance:isPerioPrizeGain(self._seasonId, self._tabId, self._periodId, b.prizeId) and 1 or 0
			local isCanGainA = a.needScore >= self._score and not isGainA and 1 or 0
			local isCanGainB = b.needScore >= self._score and not isGainB and 1 or 0

			if isCanGainA ~= isCanGainB then
				return isCanGainB < isCanGainA
			end

			if isGainA ~= isGainB then
				return isGainA < isGainB
			end

			return a.prizeId < b.prizeId
		end)
	end

	self._rewardTableList:reloadData(list)
	GameUtil.SetActive(self._rewardEmptyGo, #list <= 0)
end

function NewBreakFormationRewardView:_refreshRankRewardView()
	self._rankTableList:reloadData(NewBreakFormationConfig.instance:getRankCfgs(self._seasonId))
end

function NewBreakFormationRewardView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local changeGroup = go:GetComponent(ComponentType.UIChangeGroup)
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local redPoint = goutil.findChild(go, "redPoint")

	if data.isRankData == false then
		local cfg = data.cfg
		local periodId = NewBreakFormationController.instance:getPeriodId(cfg.periodPlanId)
		local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(cfg.periodPlanId, periodId)
		local score = 0
		local scorePrizeCfgs = {}
		local hasReward = false

		if periodCfg then
			score = NewBreakFormationModel.instance:getTotalScoreByPeriod(self._seasonId, cfg.tabId, periodId)
			scorePrizeCfgs = NewBreakFormationConfig.instance:getScorePlanCfgs(periodCfg.scorePlanId)
			hasReward = false
		end

		for i, v in ipairs(scorePrizeCfgs) do
			if score >= v.needScore and not NewBreakFormationModel.instance:isPerioPrizeGain(self._seasonId, cfg.tabId, periodId, v.prizeId) then
				hasReward = true

				break
			end
		end

		GameUtil.SetActive(redPoint, hasReward)

		txtName.text = cfg.desc

		if cfg.tabId == self._tabId then
			changeGroup:SetState(1)
		else
			changeGroup:SetState(0)
		end

		GameUtil.rmClickHandler(go)
		GameUtil.addClickHandler(go, function()
			self:_onClickTab(cfg.tabId)
		end)
	else
		GameUtil.SetActive(redPoint, false)

		txtName.text = lang("排行榜")

		if self._tabId == 0 then
			changeGroup:SetState(1)
		else
			changeGroup:SetState(0)
		end

		GameUtil.rmClickHandler(go)
		GameUtil.addClickHandler(go, function()
			self:_onClickTab(0)
		end)
	end
end

function NewBreakFormationRewardView:_clearTabCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function NewBreakFormationRewardView:_updateRankCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local itemScrollerview = goutil.findChild(go, "itemScrollerview")

	txtScore.text = data.rank[1] == data.rank[2] and langPara("第%d名", data.rank[1]) or langPara("第%d-%d名", data.rank[1], data.rank[2])

	local prizeStr = data.prize

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = not string.nilorempty(prizeStr) and string.split(prizeStr, "#") or {}

		if not self._itemScrollListDic[go] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		end
	end
end

function NewBreakFormationRewardView:_clearRankCell(cell)
	local go = cell.gameObject
	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function NewBreakFormationRewardView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtProg = goutil.findChildTextComponent(go, "receiveInfo/txtProg")
	local btnReceive = goutil.findChild(go, "receiveInfo/receiveClickBtn")
	local gainGo = goutil.findChild(go, "gainGo")
	local itemScrollerview = goutil.findChild(go, "itemScrollerview")
	local isGain = NewBreakFormationModel.instance:isPerioPrizeGain(self._seasonId, self._tabId, self._periodId, data.prizeId)

	GameUtil.SetActive(gainGo, isGain)
	GameUtil.SetActive(btnReceive, not isGain and self._score >= data.needScore)

	txtScore.text = data.needScore
	txtProg.text = langPara("(%d/%d)", math.min(self._score, data.needScore), data.needScore)

	GameUtil.rmClickHandler(btnReceive)
	GameUtil.addClickHandler(btnReceive, function()
		self:_onClickReceive(data.prizeId)
	end)

	local prizeStr = data.prize

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = not string.nilorempty(prizeStr) and string.split(prizeStr, "#") or {}

		if not self._itemScrollListDic[go] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		end
	end
end

function NewBreakFormationRewardView:_clearRewardCell(cell)
	local go = cell.gameObject
	local btnReceive = goutil.findChild(go, "receiveInfo/receiveClickBtn")

	GameUtil.rmClickHandler(btnReceive)

	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function NewBreakFormationRewardView:_updateItemCell(view, cell, prizeStr, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, go)
end

function NewBreakFormationRewardView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function NewBreakFormationRewardView:_onClickTab(tabId)
	self._tabId = tabId

	self:_refreshView()
end

function NewBreakFormationRewardView:_onClickReceive(prizeId)
	NewBreachFormationAgent.instance:sendPM_NewBreachFormationGainScorePrizeReq(self._seasonId, self._tabId, self._periodId, prizeId)
end

return NewBreakFormationRewardView
