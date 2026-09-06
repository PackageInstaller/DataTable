-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/StarGodPlusExchange/view/StarGodPlusExchangView.lua

module("logic.extensions.StarGodPlusExchange.view.StarGodPlusExchangView", package.seeall)

local StarGodPlusExchangView = class("StarGodPlusExchangView", TableViewComponent)
local STAR_NUM = 4

function StarGodPlusExchangView:ctor()
	StarGodPlusExchangView.super.ctor(self)
end

function StarGodPlusExchangView:unbindEvents()
	StarGodPlusExchangView.super.unbindEvents(self)

	for i = 1, STAR_NUM do
		self._items[i].close:RemoveClickListener()
	end

	self._btnExchange:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function StarGodPlusExchangView:bindEvents()
	StarGodPlusExchangView.super.bindEvents(self)

	for i = 1, STAR_NUM do
		self._items[i].close:AddClickListener(function()
			self:_closeItem(i)
		end)
	end

	self._btnClose:AddClickListener(self.close, self)
	self._btnExchange:AddClickListener(self._exchange, self)
end

function StarGodPlusExchangView:buildUI()
	StarGodPlusExchangView.super.buildUI(self)

	self._btnExchange = self:getBtn("btnExchange")
	self._btnClose = self:getBtn("btnClose")
	self._viewBg = self:getGo("viewbg")
	self._txtTimes = self:getTxt("txtTimes")
	self._empty = self:getGo("empty")
	self._txtTips = self:getTxt("empty/txtTips")
	self._txtTip = self:getTxt("txtTip")
	self._txtCD = self:getTxt("txtCD")
	self._items = {}

	for i = 1, STAR_NUM do
		local obj = {}

		obj.icon = self:getGo("item/item" .. i .. "/icon")
		obj.close = self:getBtn("item/item" .. i .. "/close")
		obj.data = nil

		table.insert(self._items, obj)
	end
end

function StarGodPlusExchangView:onExit()
	StarGodPlusExchangView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.StarGodPlusExchangeInfo, self._refreshAll, self)
	GlobalDispatcher:removeListener(GlobalNotify.StarGodPlusExchangeBuy, self._handleExchange, self)
	self._tableview:Travel(self._clearCell, self)

	for k, v in pairs(self._items) do
		v.data = nil
	end
end

function StarGodPlusExchangView:onEnter()
	StarGodPlusExchangView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.StarGodPlusExchangeInfo, self._refreshAll, self)
	GlobalDispatcher:addListener(GlobalNotify.StarGodPlusExchangeBuy, self._handleExchange, self)
	StarGodPlusExchangController.instance:getInfo()

	local moList = StargodplusModel.instance:getFillerMoList()
	local list = {}

	for k, v in pairs(moList) do
		if checknumber(v._info.equippedPetId) < 0 and checknumber(v._cfg.quality) == GameEnum.StarGodPlusQuality.TYPE_CHENG then
			table.insert(list, v)
		end
	end

	self._curViewDatas = list

	self:reloadData()

	self._txtTip.text = lang("stargodplusexchange3")
	self._txtTips.text = lang("stargodplusexchange4")
end

function StarGodPlusExchangView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function StarGodPlusExchangView:_handleExchange()
	for k, v in pairs(self._items) do
		v.data = nil
	end

	self:_refreshAll()
end

function StarGodPlusExchangView:_refreshAll()
	self:_refresh()
	self:_refreshStar()
end

function StarGodPlusExchangView:_refresh()
	local maxTimes = checknumber(StarGodPlusExchangeConfig.instance:getCommonCfg("TIMES"))
	local haveTimes = maxTimes - StarGodPlusExchangModel.instance:getTimes()

	self._txtTimes.text = "次数：" .. haveTimes .. "/" .. maxTimes

	local timeStamp = checknumber(StarGodPlusExchangModel.instance:getCD())
	local diff = timeStamp / 1000 - ServerTime.now()

	if diff > 0 then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(diff)

		self._txtCD.text = langPara("text_countdown_min", day, hour, min)

		GameUtil.SetActive(self._txtCD, true)
		GameUtil.SetGray(self._btnExchange, true)
	else
		GameUtil.SetActive(self._txtCD, false)
		GameUtil.SetGray(self._btnExchange, false)
	end
end

function StarGodPlusExchangView:_refreshStar()
	for i = 1, STAR_NUM do
		if self._items[i].data ~= nil then
			local data = self._items[i].data
			local id = MatType.StarGodPlus .. ":" .. data._cfg.id .. ":1"
			local proxy = MaterialMgr.setCellByCfg(id, self._items[i].icon)

			if proxy then
				proxy.binder:setBgActive(false)
				proxy.binder:setNumStr("")
				proxy.binder:setNumBg(false)
				proxy.binder:setEffStatus(false)
			end

			GameUtil.SetActive(self._items[i].close, true)
		else
			MaterialMgr.resetAll(self._items[i].icon)
			GameUtil.SetActive(self._items[i].close, false)
		end
	end

	GameUtil.SetActive(self._viewBg, #self._curViewDatas == 0)
	GameUtil.SetActive(self._empty, #self._curViewDatas == 0)
end

function StarGodPlusExchangView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "info/item")
	local txtStarPower = goutil.findChildTextComponent(cell.gameObject, "info/txtPower")
	local txtLevel = goutil.findChildTextComponent(cell.gameObject, "info/txtLevel")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "info/txtName")

	GameUtil.addClickHandler(cell.gameObject, function()
		self:_onClickCell(data)
	end)

	local id = MatType.StarGodPlus .. ":" .. data._cfg.id .. ":1"

	MaterialMgr.setCellByCfg(id, item)

	local slotId = 1
	local maxLevel = StargodplusModel.instance:getMaxSlotLevel(slotId)
	local list = StargodplusModel.instance:getAttrList(data._cfg.id, maxLevel)
	local tempList = {}

	for i, v in ipairs(list or {}) do
		tempList[v.id] = v.value
	end

	txtStarPower.text = AttrMo.calcFightPowerByAttrs(tempList)
	txtName.text = data._cfg.name
end

function StarGodPlusExchangView:_clearCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)

	local item = goutil.findChild(cell.gameObject, "info/item")

	MaterialMgr.resetAll(item)
end

function StarGodPlusExchangView:_onClickCell(data)
	local success = false

	for k, v in pairs(self._items) do
		if v.data == nil then
			v.data = data
			success = true

			break
		end
	end

	if success then
		table.removebyvalue(self._curViewDatas, data)
		self:reloadData()
		self:_refreshStar()
	end
end

function StarGodPlusExchangView:_closeItem(i)
	table.insert(self._curViewDatas, self._items[i].data)

	self._items[i].data = nil

	self:reloadData()
	self:_refreshStar()
end

function StarGodPlusExchangView:_exchange()
	local list = {}

	for k, v in pairs(self._items) do
		if v.data then
			table.insert(list, checknumber(v.data._serverId))
		end
	end

	local timeStamp = checknumber(StarGodPlusExchangModel.instance:getCD())
	local diff = timeStamp - ServerTime.now()

	if diff > 0 then
		FloatWordMgr.instance:show(lang("stargodplusexchange1"))
	elseif checknumber(StarGodPlusExchangeConfig.instance:getCommonCfg("COST_NUM")) > #list then
		FloatWordMgr.instance:show(lang("stargodplusexchange2"))
	else
		StarGodPlusExchangController.instance:exchange(list)
	end
end

return StarGodPlusExchangView
