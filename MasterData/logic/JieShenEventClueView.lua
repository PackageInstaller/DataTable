-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventClueView.lua

module("logic.extensions.jieshenevent.view.JieShenEventClueView", package.seeall)

local JieShenEventClueView = class("JieShenEventClueView", ViewComponent)

function JieShenEventClueView:ctor()
	JieShenEventClueView.super.ctor(self)
end

function JieShenEventClueView:unbindEvents()
	JieShenEventClueView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCombine)
end

function JieShenEventClueView:bindEvents()
	JieShenEventClueView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnCombine, self._onClickCombine, self)
end

function JieShenEventClueView:buildUI()
	JieShenEventClueView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnCombine = self:getGo("btnCombine")
	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._itemCell = self:getGo("itemCell")
	self._itemTableMap = {}
	self._btnRule = self:getGo("btnRule")
end

function JieShenEventClueView:onExit()
	JieShenEventClueView.super.onExit(self)
	self._tableList:dispose()

	for i, v in pairs(self._cellEffs) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._cellEffs = {}
end

function JieShenEventClueView:onEnter()
	JieShenEventClueView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_JieShenEvnetGainCluePrizeRes, self._refreshView, self)

	self._activityId = self:getFirstParam()

	self:_refreshView()

	self._cellEffs = {}
end

function JieShenEventClueView:_refreshView()
	local cfgs = JieShenEventConfig.instance:getClueTabCfgs(self._activityId)

	self._tableList:reloadData(cfgs)
end

function JieShenEventClueView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtTitle = goutil.findChildTextComponent(go, "txtTitle")
	local descTableview = goutil.findChild(go, "descTableview")
	local txtDesc = goutil.findChildTextComponent(go, "descTableview/viewport/content/txtDesc")
	local imgRes = goutil.findChild(go, "imgRes")
	local itemTableView = goutil.findChild(go, "itemTableView")
	local isUnlock = JieShenEventModel.instance:isGainClueTab(self._activityId, data.tabId)
	local isCanUnlock = not isUnlock and JieShenEventController.instance:isTabCollectClueComplete(self._activityId, data.tabId)

	if itemTableView and self._itemCell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemTableMap[go] then
			local itemScrollList = ScrollerList.create(itemTableView, self._itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemTableMap[go] = self._itemTableMap[go]

			local prizeList = {}

			for i, v in ipairs(prizeStrArr) do
				table.insert(prizeList, {
					str = v,
					showEffect = isCanUnlock,
					tabId = data.tabId
				})
			end

			self._itemTableMap[go]:setCenterMode(true)
			self._itemTableMap[go]:reloadData(prizeList)
			self._itemTableMap[go]:dragNotifyParent()
		end
	end

	GameUtil.SetActive(itemTableView, not isUnlock)
	GameUtil.SetActive(descTableview, isUnlock)

	txtTitle.text = data.title
	txtDesc.text = not isUnlock and "" or data.desc

	uGuiUtil.setSpriteToImage(imgRes, nil, data.res)
	GameUtil.addClickHandler(go, function()
		self:_onClickTab(data.tabId)
	end, self)
end

function JieShenEventClueView:_clearTabCell(cell)
	local go = cell.gameObject
	local imgRes = goutil.findChild(go, "imgRes")
	local itemScrollList = self._itemTableMap[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemTableMap[go] = nil
	end

	uGuiUtil.clearImage(go)
end

function JieShenEventClueView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	UIEffectManager.instance:stopEffect(self._cellEffs[go])

	if data.showEffect then
		local effGo = go
		local path = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(target, eff)
			eff:setScrollRectClipping(self._tableView:GetComponent(ComponentType.ScrollRect))
			eff:setParent(effGo.transform)
			eff:setLocalPos(50, -50, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		self._cellEffs[go] = UIEffectManager.instance:playEffect(self, path, effGo, 0, 0, true, false, nil, func)
	end

	local proxy = MaterialMgr.setCellByCfg(data.str, go)

	if proxy then
		proxy.binder:setAutoTips(not data.showEffect)

		if data.showEffect then
			proxy.binder:setCallBack(GameUtil.handler(self._onClickTab, self, data.tabId))
		else
			proxy.binder:setCallBack(nil)
		end
	end
end

function JieShenEventClueView:_clearItemCell(cell)
	local go = cell.gameObject

	UIEffectManager.instance:stopEffect(self._cellEffs[go])
	MaterialMgr.resetAll(go)
end

function JieShenEventClueView:_onClickTab(tabId)
	local isUnlock = JieShenEventModel.instance:isGainClueTab(self._activityId, tabId)
	local isCanUnlock = not isUnlock and JieShenEventController.instance:isTabCollectClueComplete(self._activityId, tabId)

	if not isUnlock and not isCanUnlock then
		FloatWordMgr.instance:show(lang("点击右下角“情报梳理”，即可解锁相关情报哦~"))
	elseif not isUnlock then
		JieShenEventAgent.instance:sendPM_JieShenEvnetGainCluePrizeReq(self._activityId, tabId)
	end
end

function JieShenEventClueView:_onClickCombine()
	UIStateManager.instance:push(ViewName.JieShenEventClueCombineView, self._activityId)
end

function JieShenEventClueView:_onClickRule()
	TipsFacade.instance:openRulesView("jie_shen_event_rule")
end

return JieShenEventClueView
