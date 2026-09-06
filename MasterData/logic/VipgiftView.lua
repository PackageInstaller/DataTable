-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/view/VipgiftView.lua

module("logic.extensions.vip.view.VipgiftView", package.seeall)

local VipgiftView = class("VipgiftView", TableViewComponent)

function VipgiftView:ctor()
	VipgiftView.super.ctor(self)
end

function VipgiftView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableView"
	}
end

function VipgiftView:buildUI()
	VipgiftView.super.buildUI(self)

	self._scrollrect = self:getGo("tableView"):GetComponent("ScrollRect")
end

function VipgiftView:bindEvents()
	VipgiftView.super.bindEvents(self)
end

function VipgiftView:unbindEvents()
	VipgiftView.super.unbindEvents(self)
end

function VipgiftView:destroyUI()
	VipgiftView.super.destroyUI(self)
end

function VipgiftView:onEnter()
	VipgiftView.super.onEnter(self)
	self:updateView()
end

function VipgiftView:onEnterFinished()
	VipgiftView.super.onEnterFinished(self)
end

function VipgiftView:onExit()
	VipgiftView.super.onExit(self)
end

function VipgiftView:onExitFinished()
	VipgiftView.super.onExitFinished(self)
end

function VipgiftView:updateView()
	local curDatas = VipConfig.instance:getBaseCfgs()

	self._curViewDatas = {}

	for _, data in pairs(curDatas) do
		table.insert(self._curViewDatas, data)
	end

	self:reloadData()
end

function VipgiftView:_updateCell(view, cell, data)
	local com = GameUtil.AddLuaOnce(cell.gameObject, VipGiftItem)

	com:setData(self, data, self._scrollrect)
end

function VipgiftView:_clearTableview(cell)
	return
end

function VipgiftView:dragCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnDrag(eventData)
	end
end

function VipgiftView:dragBegingCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnBeginDrag(eventData)
	end
end

function VipgiftView:dragEndCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnEndDrag(eventData)
	end
end

function VipgiftView:_onReloadFinish()
	if self._curViewDatas then
		self._tableview:MoveCellInView(VipModel.instance:getCurVipLv(), false)
	end
end

return VipgiftView
