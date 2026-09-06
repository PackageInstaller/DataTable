-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/view/MirrortrialbuyView.lua

module("logic.extensions.mirrortrial.view.MirrortrialbuyView", package.seeall)

local MirrortrialbuyView = class("MirrortrialbuyView", ViewComponent)

function MirrortrialbuyView:ctor()
	MirrortrialbuyView.super.ctor(self)
end

function MirrortrialbuyView:buildUI()
	MirrortrialbuyView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._goCell = self:getGo("cell")
	self._btnFree = self:getBtn("freePrize/btn")
	self._btnPay = self:getBtn("payPrize/btn")
	self._tableFree = self:getGo("freePrize/tableView")
	self._free = self:getGo("freePrize")
	self._pay = self:getGo("payPrize")
	self._tablePay = self:getGo("payPrize/tableView")
	self._txtPrice = self:getTxt("payPrize/btn/Text")
	self._tableTotal = self:getGo("payPrize/tableViewTotal")
	self._tableViewFree = ScrollerList.create(self._tableFree, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableViewPay = ScrollerList.create(self._tablePay, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableViewTotal = ScrollerList.create(self._tableTotal, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function MirrortrialbuyView:bindEvents()
	MirrortrialbuyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnFree:AddClickListener(self._onClickBtnFree, self)
	self._btnPay:AddClickListener(self._onClickBtnPay, self)
end

function MirrortrialbuyView:unbindEvents()
	MirrortrialbuyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnFree:RemoveClickListener()
	self._btnPay:RemoveClickListener()
end

function MirrortrialbuyView:destroyUI()
	MirrortrialbuyView.super.destroyUI(self)
end

function MirrortrialbuyView:onEnter()
	MirrortrialbuyView.super.onEnter(self)

	self._params = self:getOpenParam()
	self._curActBaseCfg = self._params[1]
	self._freePrize = self._params[2]
	self._payPrize = self._params[3]
	self._totalPrize = self._params[4]

	if self._curActBaseCfg then
		self:updateUI()
	end
end

function MirrortrialbuyView:onEnterFinished()
	MirrortrialbuyView.super.onEnterFinished(self)
end

function MirrortrialbuyView:onExit()
	MirrortrialbuyView.super.onExit(self)
	self._tableViewFree:dispose()
	self._tableViewPay:dispose()
end

function MirrortrialbuyView:onExitFinished()
	MirrortrialbuyView.super.onExitFinished(self)
end

function MirrortrialbuyView:updateUI()
	self._txtPrice.text = langPara("￥%s", PayConfig.instance:getPayMoneyYuan(self._curActBaseCfg.payGoodsId))

	if not self._freePrize or #self._freePrize == 0 then
		goutil.setActive(self._free, false)
		Framework.TransformUtil.SetLocalPos(self._pay.transform, 0, 0, 0)
	else
		Framework.TransformUtil.SetLocalPos(self._pay.transform, 300, 0, 0)
		goutil.setActive(self._free, true)
		self._tableViewFree:reloadData(self._freePrize)
	end

	self._tableViewPay:reloadData(self._payPrize)
	self._tableViewTotal:reloadData(self._totalPrize)
end

function MirrortrialbuyView:_clearCell(cellGo)
	local cell = {}

	cell.item = goutil.findChild(cellGo, "item")

	MaterialMgr.resetAll(cell.item)

	return cell
end

function MirrortrialbuyView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	MaterialMgr.setCellByCfg(data, cell.item)
end

function MirrortrialbuyView:_onClickBtnFree()
	self:close()
	MirrorTrialAgent.instance:sendPM_MirrorTrialGainPrizeReq(self._curActBaseCfg.activityId)
end

function MirrortrialbuyView:_onClickBtnPay()
	self:close()
	PayController.instance:pay(self._curActBaseCfg.payGoodsId, GameEnum.PaySubGoodsType.MIRRORTRIAL, self._curActBaseCfg.activityId)
end

return MirrortrialbuyView
