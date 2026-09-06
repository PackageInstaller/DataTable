-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/view/SupplymergerewardView.lua

module("logic.extensions.strength.view.SupplymergerewardView", package.seeall)

local SupplymergerewardView = class("SupplymergerewardView", ViewComponent)

function SupplymergerewardView:ctor()
	SupplymergerewardView.super.ctor(self)
end

function SupplymergerewardView:unbindEvents()
	SupplymergerewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function SupplymergerewardView:bindEvents()
	SupplymergerewardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.onClickClose, self)
end

function SupplymergerewardView:buildUI()
	SupplymergerewardView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tableview = self:getGo("tableView")
	self._cell = self:getGo("itemCell")
	self.scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SupplymergerewardView:onExit()
	SupplymergerewardView.super.onExit(self)
	self.scrollList:dispose()

	for k, v in pairs(self._rewardList) do
		v:dispose()
	end
end

function SupplymergerewardView:onEnter()
	SupplymergerewardView.super.onEnter(self)

	self._index = self:getFirstParam()
	self._cfg = SupplyConfig.instance:getGiftByVipDetail(self._index)
	self._rewardList = {}

	self.scrollList:reloadData(self._cfg)
end

function SupplymergerewardView:onClickClose()
	self:close()
end

function SupplymergerewardView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local tableview = goutil.findChild(cell, "tableView")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	txtDesc.text = "VIP" .. data.vipLv

	local itemStr = data.prize

	if self._rewardList[cell] == nil then
		self._rewardList[cell] = ScrollerList.create(tableview, item, GameUtil.handler(self._updateRewardList, self), GameUtil.handler(self._clearRewardList, self))
	end

	self._rewardList[cell]:reloadData(string.split(itemStr, "#"))
end

function SupplymergerewardView:_clearCell()
	return
end

function SupplymergerewardView:_updateRewardList(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function SupplymergerewardView:_clearRewardList(cell)
	MaterialMgr.resetAll()
end

return SupplymergerewardView
