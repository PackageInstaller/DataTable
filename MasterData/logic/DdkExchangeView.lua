-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DdkExchangeView.lua

module("logic.extensions.darkdragonknife.view.DdkExchangeView", package.seeall)

local DdkExchangeView = class("DdkExchangeView", TableViewComponent)

function DdkExchangeView:ctor()
	DdkExchangeView.super.ctor(self)
end

function DdkExchangeView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function DdkExchangeView:buildUI()
	DdkExchangeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtName = self:getTxt("info/name/txtName")
	self._txtRange = self:getTxt("info/txtArea")
	self._txtRate = self:getTxt("info/txtRate")
	self._txtHurt = self:getTxt("info/txtHurt")
	self._txtScore = self:getTxt("txtScore")
	self._btnExchange = self:getBtn("btnExchange")
	self._btnUse = self:getBtn("btnUse")
	self._item = self:getGo("info/item")
end

function DdkExchangeView:bindEvents()
	DdkExchangeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnExchange:AddClickListener(self._exchange, self)
	self._btnUse:AddClickListener(self._use, self)
end

function DdkExchangeView:unbindEvents()
	DdkExchangeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnExchange:AddClickListener(self._exchange, self)
	self._btnUse:AddClickListener(self._use, self)
end

function DdkExchangeView:destroyUI()
	DdkExchangeView.super.destroyUI(self)
end

function DdkExchangeView:onEnter()
	DdkExchangeView.super.onEnter(self)

	self._propId = DDragonKModel.instance:getPropId()
	self._selectId = self._propId

	local propPlanId = DDragonKModel.instance:getPropPlanId()
	local cfg = DDragonKConfig.instance:getPropList(propPlanId)

	printInfo("test DdkExchangeView:onEnter", propPlanId, cfg)

	self._curViewDatas = {}

	for k, v in pairs(cfg) do
		table.insert(self._curViewDatas, v)
	end

	table.sort(self._curViewDatas, function(a, b)
		return a.id < b.id
	end)
	self:_refreshAll()
	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeRefreshExchange, self._refreshAll, self)
end

function DdkExchangeView:onEnterFinished()
	DdkExchangeView.super.onEnterFinished(self)
end

function DdkExchangeView:onExit()
	DdkExchangeView.super.onExit(self)

	local proxy = MaterialMgr.resetAll(self._item)

	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeRefreshExchange, self._refreshAll, self)
end

function DdkExchangeView:onExitFinished()
	DdkExchangeView.super.onExitFinished(self)
end

function DdkExchangeView:_refreshAll()
	self._propId = DDragonKModel.instance:getPropId()

	self:_selectCell(self._curViewDatas[self._selectId])
	self:reloadData()
end

function DdkExchangeView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local lock = goutil.findChild(cell, "lock")
	local use = goutil.findChild(cell, "use")
	local select = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")
	local proxy = MaterialMgr.setCellByCfg(data.actiId, item)
	local has = DDragonKModel.instance:getHasProp(data.id)

	goutil.setActive(lock, not has)
	goutil.setActive(use, data.id == self._propId)
	goutil.setActive(select, data.id == self._selectId)
	btnClick:AddClickListener(function()
		self:_selectCell(data)
	end)
end

function DdkExchangeView:_clearTableview(cell)
	local item = goutil.findChild(cell, "item")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")

	MaterialMgr.resetAll(item)
	btnClick:RemoveClickListener()
end

function DdkExchangeView:_selectCell(data)
	self._selectId = data.id
	self._txtName.text = data.name
	self._txtRange.text = langPara("攻击范围：<color=#20b376>%s</color>", data.length)
	self._txtRate.text = langPara("攻击速度：<color=#20b376>%s</color>", data.attackSpeed)
	self._txtHurt.text = langPara("伤害：<color=#20b376>%s</color>", data.damage)

	local curScore = DDragonKModel.instance:getTotalScore()
	local color = curScore >= data.score and "20b376" or "FF0000FF"

	self._txtScore.text = langPara("消耗积分：<color=#%s>%s</color>/%s", color, curScore, data.score)

	local has = DDragonKModel.instance:getHasProp(data.id)

	self._txtScore.gameObject:SetActive(not has)
	self._btnExchange.gameObject:SetActive(not has)
	self._btnUse.gameObject:SetActive(has and self._propId ~= data.id)

	local proxy = MaterialMgr.setCellByCfg(data.actiId, self._item)

	self._tableview:Refresh()
end

function DdkExchangeView:_exchange()
	local curScore = DDragonKModel.instance:getTotalScore()

	if curScore >= self._curViewDatas[self._selectId].score then
		local actId = DDragonKModel.instance:getActId()

		DarkDragonKnifeAgent.instance:sendPM_DarkDragonKnifeExchangeReq(actId, self._selectId)
	else
		FloatWordMgr.instance:show("当前积分不足")
	end
end

function DdkExchangeView:_use()
	local actId = DDragonKModel.instance:getActId()

	DarkDragonKnifeAgent.instance:sendPM_DarkDragonKnifeChangePropReq(actId, self._selectId)
end

return DdkExchangeView
