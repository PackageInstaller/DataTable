-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pindaodao/view/PinDaoDaoSelectView.lua

module("logic.extensions.pindaodao.view.PinDaoDaoSelectView", package.seeall)

local PinDaoDaoSelectView = class("PinDaoDaoSelectView", ViewComponent)

function PinDaoDaoSelectView:ctor()
	PinDaoDaoSelectView.super.ctor(self)
end

function PinDaoDaoSelectView:unbindEvents()
	PinDaoDaoSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PinDaoDaoSelectView:bindEvents()
	PinDaoDaoSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PinDaoDaoSelectView:buildUI()
	PinDaoDaoSelectView.super.buildUI(self)

	self._btnClose = self:getGo("viewInfoGo/btnClose")

	local goTab = self:getGo("viewInfoGo/tableview")
	local goCell = self:getGo("viewInfoGo/tablecell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCellGoods, self), GameUtil.handler(self._clearCellGoods, self))
	self._txtCurProgress = self:getTxt("viewInfoGo/txtCurProgress")
end

function PinDaoDaoSelectView:onExit()
	PinDaoDaoSelectView.super.onExit(self)
	self._tableView:dispose()
end

function PinDaoDaoSelectView:onEnter()
	PinDaoDaoSelectView.super.onEnter(self)

	local param = self:getOpenParam() or {}

	self._activityId = checknumber(param[1])
	self._selectGoodsId = checknumber(param[2])
	self._curProgress = checknumber(param[3])

	if self._activityId <= 0 then
		self._activityId = 565001
	end

	if self._selectGoodsId <= 0 then
		self._selectGoodsId = 1
	end

	self._goodsCfgs = PinDaoDaoConfig.instance:getGoodsCfgs(self._activityId) or {}

	self._tableView:reloadData(self._goodsCfgs)
	self._tableView:MoveCellToCenter(self._selectGoodsId - 1)

	self._txtCurProgress.text = string.format("当前已砍神钻：<color=#20b376>%s</color>", self._curProgress)
end

function PinDaoDaoSelectView:_updateCellGoods(view, cell, data)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local goItem = goutil.findChild(go, "item")
	local select = goutil.findChild(go, "select")

	goutil.setActive(select, data.goodsId == self._selectGoodsId)
	MaterialMgr.resetAll(goItem)
	MaterialMgr.setCellByCfg(data.goods, goItem)
	GameUtil.addClickHandler(btn, function()
		TipsFacade.instance:openPopupWindow("提示", "是否将该物品设为当前折扣对象？", function()
			GlobalDispatcher:dispatch(GlobalNotify.PinDaoDaoSelectGoodsId, data.goodsId)
			self:close()
		end, nil, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
	end)

	local txtPrize = goutil.findChildTextComponent(go, "txtPrize")

	txtPrize.text = string.format("原价：<color=#20b376>%s</color>", data.originCostNum)
end

function PinDaoDaoSelectView:_clearCellGoods(cell)
	local go = cell.gameObject
	local goItem = goutil.findChild(go, "item")

	MaterialMgr.resetAll(goItem)

	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

return PinDaoDaoSelectView
