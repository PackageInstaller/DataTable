-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redstargodsell/view/RedstargodsellView.lua

module("logic.extensions.redstargodsell.view.RedstargodsellView", package.seeall)

local RedstargodsellView = class("RedstargodsellView", TableViewComponent)
local STAR_SHOW_LEVEL = 50

function RedstargodsellView:ctor()
	RedstargodsellView.super.ctor(self)
end

function RedstargodsellView:unbindEvents()
	RedstargodsellView.super.unbindEvents(self)
	self._close:RemoveClickListener()
	self._btnBuy:RemoveClickListener()

	for i = 1, 4 do
		GameUtil.rmClickHandler(self._cell[i].btn)
	end
end

function RedstargodsellView:bindEvents()
	RedstargodsellView.super.bindEvents(self)
	self._close:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self.onClickBuy, self)

	for i = 1, 4 do
		GameUtil.addClickHandler(self._cell[i].btn, function()
			self._selectId = i

			self:refresh()
		end)
	end
end

function RedstargodsellView:buildUI()
	RedstargodsellView.super.buildUI(self)

	self._close = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._txtLeftTime = self:getTxt("time/txtTime")
	self._txtLimit = self:getTxt("txtLimit")
	self._txtStarPower = self:getTxt("info/txtStarPower")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._txtPrice = self:getTxt("btnBuy/txtPrice")
	self._soldout = self:getGo("soldout")
	self._cell = {}

	for i = 1, 4 do
		local obj = {}

		obj.btn = self:getBtn("btn" .. i)
		obj.select = self:getGo("btn" .. i .. "/select")
		obj.name1 = self:getTxt("btn" .. i .. "/select/txt")
		obj.name2 = self:getTxt("btn" .. i .. "/Text")
		obj.noSelect = self:getGo("btn" .. i .. "/Text")
		obj.time = self:getTxt("btn" .. i .. "/txtOpenTime")
		obj.item = self:getGo("info/item" .. i .. "/icon")
		obj.txtNum = self:getTxt("info/item" .. i .. "/txtNum")

		table.insert(self._cell, obj)
	end
end

function RedstargodsellView:onExit()
	RedstargodsellView.super.onExit(self)
	removetimer(self._timer, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedstargodsellGetInfo, self.refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedstargodsellBuyGift, self.refresh, self)

	for i = 1, 4 do
		MaterialMgr.resetAll(self._cell[i].item)
	end
end

function RedstargodsellView:onEnter()
	RedstargodsellView.super.onEnter(self)

	self._actId = 84001
	self._selectId = 1

	GlobalDispatcher:addListener(GlobalNotify.RedstargodsellGetInfo, self.refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.RedstargodsellBuyGift, self.refresh, self)
	RedstargodsellController.instance:getInfo(self._actId)

	for i = 1, 4 do
		local cfg = RedstargodsellConfig.instance:getSaleCfg(self._actId, i)

		self._cell[i].name1.text = cfg.tabName
		self._cell[i].name2.text = cfg.tabName

		local openTime = GameUtil.string2time(cfg.startTime)

		if openTime > ServerTime.now() then
			local obj = GameUtil.parseToTimeTable(cfg.startTime)

			self._cell[i].time.text = string.format("%s.%s 5点开启", obj.month, checknumber(obj.day))
		else
			self._cell[i].time.text = ""
		end
	end
end

function RedstargodsellView:_getPath()
	return {
		cellPath = "info/cell",
		viewPath = "info/tableview"
	}
end

function RedstargodsellView:refresh()
	for i = 1, 4 do
		goutil.setActive(self._cell[i].select, i == self._selectId)
		goutil.setActive(self._cell[i].noSelect, i ~= self._selectId)
	end

	local cfg = RedstargodsellConfig.instance:getSaleCfg(self._actId, self._selectId)

	self:_setCellNoBg(cfg.starPrize, self._cell[4], false)

	local rightNowPrize = cfg.giftContent
	local strList = string.split(rightNowPrize, "#")

	for i, v in ipairs(strList) do
		self:_setCellNoBg(v, self._cell[i])
	end

	if checknumber(cfg.mailDay) > 0 then
		self:_setCellNoBg(cfg.mailContent, self._cell[3])
		goutil.setActive(self._tag7, true)
	else
		goutil.setActive(self._tag7, false)
	end

	self.openTime = GameUtil.string2time(cfg.startTime)
	self.endTime = GameUtil.string2time(cfg.endTime)

	self:_timer()

	local cfg = RedstargodsellConfig.instance:getSaleCfg(self._actId, self._selectId)
	local info = RedstargodsellModel.instance:getGift(self._actId, cfg.giftId)
	local isCanBuy = checkbool(info.isCanBuy)

	GameUtil.SetActive(self._btnBuy, isCanBuy)
	GameUtil.SetActive(self._soldout, not isCanBuy)

	local info = RedstargodsellModel.instance:getGift(self._actId, cfg.giftId)

	if info ~= nil then
		self._txtLimit.text = string.format("活动限购：%s/%s", checknumber(info.buyTimes), cfg.maxBuyTimes)
	end

	local type, id, num = MaterialMgr.getMatParams(cfg.starPrize)
	local list = StargodplusModel.instance:getAttrList(id, STAR_SHOW_LEVEL)
	local tempList = {}

	for i, v in ipairs(list or {}) do
		tempList[v.id] = v.value
	end

	local power = AttrMo.calcFightPowerByAttrs(tempList)
	local str = string.format("Lv.%d 星神战力：%s", STAR_SHOW_LEVEL, power)
	local attr = "\n"

	for k, v in pairs(tempList) do
		local attrStr = GameEnum.AttrTypeName[k]

		attr = attr .. attrStr .. "+" .. v .. "  "
	end

	self._txtStarPower.text = str

	local starCfg = StargodplusConfig.instance:getFillerCfg(id)

	self._txtDesc.text = starCfg.desc .. attr
end

function RedstargodsellView:_updateCell(view, cell, data)
	return
end

function RedstargodsellView:onClickBuy()
	local cfg = RedstargodsellConfig.instance:getSaleCfg(self._actId, self._selectId)

	if ServerTime.now() < self.openTime then
		FloatWordMgr.instance:show(lang("redstargodsellview_1"))

		return
	end

	if ServerTime.now() > self.endTime then
		FloatWordMgr.instance:show(lang("redstargodsellview_2"))

		return
	end

	local info = RedstargodsellModel.instance:getGift(self._actId, cfg.giftId)

	if checkbool(info.isCanBuy) == false then
		FloatWordMgr.instance:show("购买次数不足")

		return
	end

	local function okFunc()
		local paramStr = "{\"actId\":" .. self._actId .. "}"

		PayController.instance:pay(cfg.payGoodsId, GameEnum.PaySubGoodsType.RED_STAR_GOD_SELL, cfg.giftId, paramStr)
	end

	okFunc()
end

function RedstargodsellView:_timer()
	local leftTime = self.endTime - ServerTime.now()

	self._txtLeftTime.text = leftTime > 0 and string.format("剩余时间:%s", GameUtil.FormatTimeWordsNoSec(leftTime)) or "活动已结束，无法购买"
end

function RedstargodsellView:_setCellNoBg(cfg, cell, eff)
	local type, id, num = MaterialMgr.getMatParams(cfg)

	cell.txtNum.text = num

	local proxy = MaterialMgr.setCellByCfg(cfg, cell.item)

	if proxy then
		proxy.binder:setBgActive(false)
		proxy.binder:setNumStr("")
		proxy.binder:setNumBg(false)
		proxy.binder:setEffStatus(eff == nil and true or false)
	end
end

return RedstargodsellView
