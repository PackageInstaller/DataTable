-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wandererpass/view/WandererpassprizeView.lua

module("logic.extensions.wandererpass.view.WandererpassprizeView", package.seeall)

local WandererpassprizeView = class("WandererpassprizeView", ViewComponent)

function WandererpassprizeView:ctor()
	WandererpassprizeView.super.ctor(self)
end

function WandererpassprizeView:unbindEvents()
	WandererpassprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuy)
end

function WandererpassprizeView:bindEvents()
	WandererpassprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
end

function WandererpassprizeView:buildUI()
	WandererpassprizeView.super.buildUI(self)

	self._pass = self:getGo("pass")
	self._btnBuy = self:getGo("btnBuy")
	self._txtDesc = self:getTxt("imgDesc/txtDesc")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setOnlyCircleOffsetPos(true)
	self._scrollList:extendCircleWithOffset(-200, "node")
end

function WandererpassprizeView:onExit()
	WandererpassprizeView.super.onExit(self)
	self._scrollList:dispose()
end

function WandererpassprizeView:onEnter()
	WandererpassprizeView.super.onEnter(self)

	local activityId = checknumber(self:getFirstParam())

	if activityId == 0 then
		activityId = 582001
	end

	self._activityId = activityId

	self.addGEvent(self, GlobalNotify.ON_WANDERER_PASS_GET_INFO, self._refreshUI, self)
	WandererPassAgent.instance:sendPM_WandererPassGetInfoReq(activityId)
	self:_refreshUI()
end

function WandererpassprizeView:_refreshUI()
	local info = WandererpassModel.instance:getInfo(self._activityId) or {}

	self._hasBuy = checkbool(info.hasBuy)

	GameUtil.SetActive(self._pass, checkbool(info.hasBuy))

	local cfg = WandererpassConfig.instance:getActivityCfgById(self._activityId) or {}

	self._txtDesc.text = cfg.desc

	if not cfg.prize then
		local prize = ""
		local list = string.split(prize, "#")

		self._scrollList:reloadData(list)
	end
end

function WandererpassprizeView:_updateCell(view, cell, data, tag)
	local pass = goutil.findChild(cell, "node/pass")
	local item = goutil.findChild(cell, "node/item")
	local txtDesc = goutil.findChildTextComponent(cell, "node/txtDesc")

	GameUtil.SetActive(pass, self._hasBuy)
	MaterialMgr.setCellByCfg(data, item)

	local cfg = WandererpassConfig.instance:getActivityCfgById(self._activityId) or {}

	txtDesc.text = cfg["prizeDesc_" .. cell.data] or ""
end

function WandererpassprizeView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function WandererpassprizeView:_onClickBuy()
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

return WandererpassprizeView
