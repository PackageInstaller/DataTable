-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/view/VipprivilegeView.lua

module("logic.extensions.vip.view.VipprivilegeView", package.seeall)

local VipprivilegeView = class("VipprivilegeView", TableViewComponent)

function VipprivilegeView:ctor()
	VipprivilegeView.super.ctor(self)
end

function VipprivilegeView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableView"
	}
end

function VipprivilegeView:buildUI()
	VipprivilegeView.super.buildUI(self)

	self._scrollrect = self:getGo("tableView"):GetComponent("ScrollRect")
end

function VipprivilegeView:bindEvents()
	VipprivilegeView.super.bindEvents(self)
end

function VipprivilegeView:unbindEvents()
	VipprivilegeView.super.unbindEvents(self)
end

function VipprivilegeView:destroyUI()
	VipprivilegeView.super.destroyUI(self)
end

function VipprivilegeView:onEnter()
	VipprivilegeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ChatEffectChange, self.updateView, self)
	self:updateView()
end

function VipprivilegeView:onEnterFinished()
	VipprivilegeView.super.onEnterFinished(self)
end

function VipprivilegeView:onExit()
	VipprivilegeView.super.onExit(self)
end

function VipprivilegeView:onExitFinished()
	VipprivilegeView.super.onExitFinished(self)
end

function VipprivilegeView:updateView()
	local curDatas = VipConfig.instance:getPrivilegeCfgs()

	self._curViewDatas = {}

	for _, data in pairs(curDatas) do
		table.insert(self._curViewDatas, data)
	end

	self:reloadData()
end

function VipprivilegeView:_updateCell(view, cell, data)
	local com = GameUtil.AddLuaOnce(cell.gameObject, VipprivilegeItem)

	com:setData(self, data)
end

function VipprivilegeView:_clearTableview(cell)
	return
end

function VipprivilegeView:dragCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnDrag(eventData)
	end
end

function VipprivilegeView:dragBegingCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnBeginDrag(eventData)
	end
end

function VipprivilegeView:dragEndCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnEndDrag(eventData)
	end
end

function VipprivilegeView:_onReloadFinish()
	if self._curViewDatas then
		self._tableview:MoveCellInView(VipModel.instance:getCurVipLv(), false)
	end
end

return VipprivilegeView
