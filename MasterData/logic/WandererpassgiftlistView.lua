-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wandererpass/view/WandererpassgiftlistView.lua

module("logic.extensions.wandererpass.view.WandererpassgiftlistView", package.seeall)

local WandererpassgiftlistView = class("WandererpassgiftlistView", ViewComponent)

function WandererpassgiftlistView:ctor()
	WandererpassgiftlistView.super.ctor(self)
end

function WandererpassgiftlistView:unbindEvents()
	WandererpassgiftlistView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuy)
end

function WandererpassgiftlistView:bindEvents()
	WandererpassgiftlistView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
end

function WandererpassgiftlistView:buildUI()
	WandererpassgiftlistView.super.buildUI(self)

	self._pass = self:getGo("pass")
	self._btnBuy = self:getGo("btnBuy")
	self._txtDesc = self:getTxt("imgDesc/txtDesc")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function WandererpassgiftlistView:onExit()
	WandererpassgiftlistView.super.onExit(self)
	self._scrollList:dispose()
end

function WandererpassgiftlistView:onEnter()
	WandererpassgiftlistView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 582001
	end

	local giftCfgList = WandererpassConfig.instance:getGiftListCfgById(self._activityId) or {}
	local cfg = WandererpassConfig.instance:getActivityCfgById(self._activityId) or {}

	self._txtDesc.text = cfg.desc

	local list = {}

	for k, v in pairs(giftCfgList) do
		table.insert(list, v)
	end

	ArraySort.sortOn(list, "id")
	self._scrollList:reloadData(list)
	self.addGEvent(self, GlobalNotify.ON_WANDERER_PASS_GET_INFO, self._refreshUI, self)
	WandererPassAgent.instance:sendPM_WandererPassGetInfoReq(self._activityId)
	self:_refreshUI()
end

function WandererpassgiftlistView:_refreshUI()
	local info = WandererpassModel.instance:getInfo(self._activityId) or {}

	GameUtil.SetActive(self._pass, checkbool(info.hasBuy))
end

function WandererpassgiftlistView:_updateCell(view, cell, data, tag)
	local img = goutil.findChild(cell, "img")
	local item = goutil.findChild(cell, "item")
	local txt = goutil.findChildTextComponent(cell, "txt")

	GameUtil.setUIImageSpriteIdx(img, cell.index)

	txt.text = data.desc

	MaterialMgr.setCellByCfg(data.prize, item)
end

function WandererpassgiftlistView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function WandererpassgiftlistView:_onClickBuy()
	local info = WandererpassModel.instance:getInfo(self._activityId) or {}

	if not checkbool(info.hasBuy) then
		local cfg = WandererpassConfig.instance:getActivityCfgById(self._activityId)

		if cfg then
			local goodsId = cfg.payGoodsId

			PayController.instance:pay(goodsId, GameEnum.PaySubGoodsType.WANDERER_PASS, self._activityId)
		end
	else
		TipsFacade.instance:openCommonTips("已经购买")
	end
end

return WandererpassgiftlistView
