-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/publiccardpool/PublicDragonTabView.lua

module("logic.extensions.lottery.view.publiccardpool.PublicDragonTabView", package.seeall)

local PublicDragonTabView = class("PublicDragonTabView", ViewComponent)

function PublicDragonTabView:ctor()
	PublicDragonTabView.super.ctor(self)

	self._chooisePool = 1
end

function PublicDragonTabView:unbindEvents()
	PublicDragonTabView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function PublicDragonTabView:bindEvents()
	PublicDragonTabView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end)
end

function PublicDragonTabView:buildUI()
	PublicDragonTabView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._itemGo = self:getGo("itemGo")
	self._container = self:getGo("container")
	self._itemListSR = self:getGo("itemListSR")
	self._itemList = ScrollerList.create(self._itemListSR, self._itemGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearItemCell, self))
end

function PublicDragonTabView:onEnter()
	PublicDragonTabView.super.onEnter(self)
	self:_setPoolData()
	self:_openLastLottery()

	local num = 0

	for i, v in ipairs(self._poolData) do
		if v.id then
			num = num + 1
		end
	end

	print("tab num = ", num)

	local isShowlist = num > 1

	goutil.setActive(self._itemListSR, isShowlist)

	if isShowlist then
		self._itemList:reloadData(self._poolData)
	end
end

function PublicDragonTabView:onExit()
	PublicDragonTabView.super.onExit(self)
	self._itemList:dispose()
end

function PublicDragonTabView:_updateCell(view, cell, data)
	local lockGo = goutil.findChild(cell, "lockGo")
	local choiseGo = goutil.findChild(cell, "choiseGo")
	local redpointGo = goutil.findChild(cell, "redpointGo")
	local itemTxt = goutil.findChildTextComponent(cell, "itemTxt")
	local tagImgGo = goutil.findChild(cell, "tagImaGo")
	local lockTxt = goutil.findChildTextComponent(lockGo, "lockTxt")
	local lock = DragonConfig.instance:getOpenDragonActivity(data.activityId)
	local poolCfg = DragonConfig.instance:getDragonPoolCfg(data.poolGroupId)

	goutil.setActive(lockGo, lock)
	goutil.setActive(choiseGo, data.id == self._chooisePool)
	goutil.setActive(redpointGo, self:_getRedPointState(data.activityId) and not lock)

	local params = string.split(poolCfg.startTime, "T")

	if lock then
		lockTxt.text = string.format("%s %s 开启", params[1], params[2])
	end

	GameUtil.asBtn(cell):RemoveClickListener()
	GameUtil.asBtn(cell):AddClickListener(function()
		if lock then
			FloatWordMgr.instance:show("没有到活动时间~")

			return
		end

		self:_showView(data.id)

		self._chooisePool = data.id

		self._itemList:refresh(self._poolData)
	end)

	itemTxt.text = poolCfg.title

	if string.nilorempty(poolCfg.tagLabel) then
		goutil.setActive(tagImgGo, false)
	else
		goutil.setActive(tagImgGo, true)

		local tagTxt = goutil.findChildTextComponent(tagImgGo, "tagTxt")

		tagTxt.text = poolCfg.tagLabel
	end
end

function PublicDragonTabView:_clearItemCell(cell)
	GameUtil.asBtn(cell):RemoveClickListener()
end

function PublicDragonTabView:_setPoolData()
	self._planId = checknumber(self:getFirstParam())

	if self._planId == 0 then
		self:close()

		return
	end

	self._poolData = {}

	local list = DragonConfig.instance:getPlanCfg(self._planId)

	for k, v in pairs(list) do
		if ActivityDefineController.instance:isTimeGateProcessType(v.activityId) then
			local isOpen = TimeGateController.instance:isOpenByActivityId(v.activityId)

			if isOpen then
				table.insert(self._poolData, v)
			end
		elseif ActivityDefineController.instance:checkIsInActivityTimeByActivityId(v.activityId) then
			table.insert(self._poolData, v)
		end
	end

	table.sort(self._poolData, function(a, b)
		return a.id < b.id
	end)
end

function PublicDragonTabView:_openLastLottery()
	local params = self:getOpenParam()

	if params and params[2] then
		self._chooisePool = checknumber(params[2])
	end

	local data = self:getPoolDataByIndex()

	if not data then
		self._chooisePool = 1
	end

	if not data or DragonConfig.instance:getOpenDragonActivity(data.activityId) then
		self:_openNextLottery()

		return
	end

	self:_showView(data.id)
end

function PublicDragonTabView:_openNextLottery()
	self._chooisePool = self._chooisePool + 1

	local data = self:getPoolDataByIndex()

	if not data then
		FloatWordMgr.instance:show("没有到活动时间~")

		self._chooisePool = 1

		self:close()

		return
	end

	if DragonConfig.instance:getOpenDragonActivity(data.activityId) then
		self:_openNextLottery()
	else
		self:_showView(data.id)
	end
end

function PublicDragonTabView:_showView(id)
	ViewMgr.instance:close(ViewName.PublicDragonLottery)
	self:showTabAt(self._container, ViewName.PublicDragonLottery, self._planId, id)
end

function PublicDragonTabView:_getRedPointState(actId)
	if GameUtil.getUserDayData("PublicDragonLotteryView" .. actId) == nil then
		return true
	end

	return false
end

function PublicDragonTabView:getPoolDataByIndex()
	for k, v in pairs(self._poolData) do
		if v.id == self._chooisePool then
			return v
		end
	end

	return nil
end

return PublicDragonTabView
