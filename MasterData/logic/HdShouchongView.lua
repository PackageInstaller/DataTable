-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdShouchongView.lua

module("logic.extensions.activitypopup.view.HdShouchongView", package.seeall)

local HdShouchongView = class("HdShouchongView", ActivityPopupBase)

function HdShouchongView:buildUI()
	HdShouchongView.super.buildUI(self)

	self._tableview = self:getGo("rewardList"):GetComponent("UITableview")
	self._tableCell = self:getGo("rewardList/item")

	self._tableCell:SetActive(false)

	self._btnPay = self:getBtn("btnPay")
end

function HdShouchongView:bindEvents()
	HdShouchongView.super.bindEvents(self)
	self._btnPay:AddClickListener(self._onClickPay, self)
end

function HdShouchongView:unbindEvents()
	HdShouchongView.super.unbindEvents(self)
	self._btnPay:RemoveClickListener()
end

function HdShouchongView:onEnter()
	HdShouchongView.super.onEnter(self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}

	local cfg = self:getActivityPopupCfg()

	if not cfg then
		return
	end

	local rewardStrs = string.split(cfg.reward, "#")

	for i, v in ipairs(rewardStrs) do
		local element = {}

		element.rewardStr = v

		table.insert(self._curViewDatas, element)
	end

	self._tableview:ReloadData()
end

function HdShouchongView:onExit()
	HdShouchongView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()
end

function HdShouchongView:_numInView()
	return #self._curViewDatas
end

function HdShouchongView:_cellSize(view, idx)
	if idx + 1 == #self._curViewDatas then
		return 110, 90
	end

	return 90, 90
end

function HdShouchongView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function HdShouchongView:_updateCell(view, cell, data)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	Framework.TransformUtil.SetLocalScale(parentGo.transform, 0.9, 0.9, 0.9)
	MaterialMgr.setCellByCfg(data.rewardStr, parentGo)
end

function HdShouchongView:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

function HdShouchongView:_onClickPay()
	if not ActivityPopupModel.instance:isHaveNextActivityViewId() then
		UIStateManager.instance:clear()
	end

	FuncOpenController.instance:openFunc(95, GameEnum.PayShopEasyJump.Recharge)
end

return HdShouchongView
