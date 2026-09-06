-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/paladinlottery/PaladinLotteryView.lua

module("logic.extensions.lottery.view.paladinlottery.PaladinLotteryView", package.seeall)

local PaladinLotteryView = class("PaladinLotteryView", ViewComponent)

function PaladinLotteryView:ctor()
	PaladinLotteryView.super.ctor(self)

	self._chooisePool = 1
	self._lotteryPool = {
		{
			actId = 112010,
			viewName = "skyflashview"
		},
		{
			actId = 112011,
			viewName = "haloview"
		},
		{
			actId = 112012,
			viewName = "mizongview"
		},
		{
			actId = 112013,
			viewName = "firegodview"
		},
		{
			actId = 112014,
			viewName = "yanluoview"
		}
	}
end

function PaladinLotteryView:unbindEvents()
	PaladinLotteryView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function PaladinLotteryView:bindEvents()
	PaladinLotteryView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end)
end

function PaladinLotteryView:onExit()
	PaladinLotteryView.super.onExit(self)
end

function PaladinLotteryView:buildUI()
	PaladinLotteryView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._itemGo = self:getGo("itemGo")
	self._container = self:getGo("container")
	self._itemListSR = self:getGo("itemListSR")
	self._itemList = ScrollerList.create(self._itemListSR, self._itemGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearItemCell, self))
end

function PaladinLotteryView:onEnter()
	PaladinLotteryView.super.onEnter(self)
	self:_setPoolData()
	self:_openLastLottery()
	self._itemList:reloadData(self._poolData)
end

function PaladinLotteryView:_updateCell(view, cell, data)
	local lockGo = goutil.findChild(cell, "lockGo")
	local choiseGo = goutil.findChild(cell, "choiseGo")
	local redpointGo = goutil.findChild(cell, "redpointGo")
	local bgImg = cell.gameObject:GetComponent("UIImageSpriteChange")
	local lockTxt = goutil.findChildTextComponent(lockGo, "lockTxt")
	local index = cell.data
	local lock = DragonConfig.instance:getOpenDragonActivity(data.actId)

	goutil.setActive(lockGo, lock)
	goutil.setActive(choiseGo, index == self._chooisePool)
	goutil.setActive(redpointGo, self:_getRedPointState(data.actId) and not lock)

	local params = string.split(data.startTime, "T")

	if lock then
		lockTxt.text = string.format("%s %s 开启", params[1], params[2])
	end

	GameUtil.asBtn(cell):RemoveClickListener()
	GameUtil.asBtn(cell):AddClickListener(function()
		if lock then
			FloatWordMgr.instance:show("没有到活动时间~")

			return
		end

		self:showTabAt(self._container, data.viewName)

		self._chooisePool = cell.data

		self._itemList:refresh(self._poolData)
	end)

	if not string.nilorempty(data.lotteryImg) then
		bgImg:ChangeSprite(data.lotteryImg)
	end
end

function PaladinLotteryView:_clearItemCell(cell)
	return
end

function PaladinLotteryView:_setPoolData()
	self._poolData = {}

	for i, v in ipairs(self._lotteryPool) do
		local cfg = DragonConfig.instance:getActivityCfg(v.actId)
		local data = DragonConfig.instance:getDragonPoolCfg(cfg.poolGroupId)

		data.actId = v.actId
		data.viewName = v.viewName

		table.insert(self._poolData, data)
	end

	if #self._poolData > 1 then
		table.sort(self._poolData, function(a, b)
			return a.poolRank < b.poolRank
		end)
	end
end

function PaladinLotteryView:_openLastLottery()
	local params = self:getOpenParam()

	if params and params[1] then
		self._chooisePool = params[1]
	end

	local data = self._poolData[checknumber(self._chooisePool)]
	local name = data.viewName

	if DragonConfig.instance:getOpenDragonActivity(data.actId) then
		self:_openNextLottery()

		return
	end

	self:showTabAt(self._container, name)
end

function PaladinLotteryView:_openNextLottery()
	self._chooisePool = self._chooisePool + 1

	if self._chooisePool > #self._poolData then
		FloatWordMgr.instance:show("没有到活动时间~")

		self._chooisePool = 1

		self:close()

		return
	end

	local data = self._poolData[checknumber(self._chooisePool)]
	local name = data.viewName

	if DragonConfig.instance:getOpenDragonActivity(data.actId) then
		self:_openNextLottery()
	else
		self:showTabAt(self._container, name)
	end
end

function PaladinLotteryView:_getRedPointState(actId)
	if GameUtil.getUserDayData("PaladinLotteryView" .. actId) == nil then
		return true
	end

	return false
end

return PaladinLotteryView
