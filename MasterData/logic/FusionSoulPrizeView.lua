-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulPrizeView.lua

module("logic.extensions.fusionsoul.view.FusionSoulPrizeView", package.seeall)

local FusionSoulPrizeView = class("FusionSoulPrizeView", ViewComponent)

function FusionSoulPrizeView:ctor()
	FusionSoulPrizeView.super.ctor(self)
end

function FusionSoulPrizeView:unbindEvents()
	FusionSoulPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FusionSoulPrizeView:bindEvents()
	FusionSoulPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FusionSoulPrizeView:buildUI()
	FusionSoulPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemTablecell = self:getGo("itemTablecell")
	self._txtTotalCount = self:getTxt("totalCount/txt")
end

function FusionSoulPrizeView:onExit()
	FusionSoulPrizeView.super.onExit(self)
	self._tableList:dispose()

	for k, v in pairs(self._itemTableListDir) do
		v:dispose()

		self._itemTableListDir[k] = nil
	end
end

function FusionSoulPrizeView:onEnter()
	FusionSoulPrizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FusionSoulGetInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._itemTableListDir = {}

	self:_refreshView()
end

function FusionSoulPrizeView:_refreshView()
	local cfgs = FusionSoulConfig.instance:getProgressPrizeCfgs(self._activityId)
	local list = {}

	for i, v in ipairs(cfgs) do
		table.insert(list, v)
	end

	self._curScore = FusionSoulModel.instance:getTotalClueCount(self._activityId)

	self._tableList:reloadData(list)

	local clueCfgs = FusionSoulConfig.instance:getClueCfgs(self._activityId)

	self._txtTotalCount.text = langPara("当前已收集线索：%d/%d", self._curScore, #clueCfgs)
end

function FusionSoulPrizeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btnGet")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local gainPrize = goutil.findChild(go, "gain")
	local notReach = goutil.findChild(go, "notReach")
	local itemTableView = goutil.findChild(go, "itemTableview")

	txtName.text = langPara("累计收集%d个线索", data.progress)

	local isGainPrize = FusionSoulModel.instance:isGainPrize(self._activityId, data.prizeId)

	GameUtil.SetActive(gainPrize, isGainPrize)
	GameUtil.SetActive(notReach, self._curScore < data.progress)
	GameUtil.SetActive(btn, not isGainPrize and self._curScore >= data.progress)

	local prizeArray = string.split(data.prize, "#")

	if itemTableView and self._itemTablecell then
		if not self._itemTableListDir[itemTableView] then
			local itemTableList = ScrollerList.create(itemTableView, self._itemTablecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemTableListDir[itemTableView] = self._itemTableListDir[itemTableView]

			self._itemTableListDir[itemTableView]:reloadData(prizeArray)
			self._itemTableListDir[itemTableView]:dragNotifyParent()
		end
	end

	GameUtil.addClickHandler(btn, function()
		self:_onClickGetPrize(data.prizeId)
	end)
end

function FusionSoulPrizeView:_clearCell(cell)
	local go = cell.gameObject
	local itemTableView = goutil.findChild(go, "itemTableview")

	if self._itemTableListDir[itemTableView] then
		self._itemTableListDir[itemTableView]:dispose()

		self._itemTableListDir[itemTableView] = nil
	end
end

function FusionSoulPrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function FusionSoulPrizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function FusionSoulPrizeView:_onClickGetPrize(prizeId)
	FusionSoulAgent.instance:sendPM_FusionSoulGainProgressPrizeReq(self._activityId, prizeId)
end

return FusionSoulPrizeView
