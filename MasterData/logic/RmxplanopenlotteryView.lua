-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanopenlotteryView.lua

module("logic.extensions.richmanxplan.view.RmxplanopenlotteryView", package.seeall)

local RmxplanopenlotteryView = class("RmxplanopenlotteryView", ViewComponent)

function RmxplanopenlotteryView:ctor()
	RmxplanopenlotteryView.super.ctor(self)
end

function RmxplanopenlotteryView:unbindEvents()
	RmxplanopenlotteryView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function RmxplanopenlotteryView:bindEvents()
	RmxplanopenlotteryView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function RmxplanopenlotteryView:buildUI()
	RmxplanopenlotteryView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._gridGo = self:getGo("grid")
	self._gridsGo = self:getGo("grids")
	self._itemGroup = ItemGroup.New(self._gridsGo, self._gridGo, nil, nil, true, self._clearGroupItem, self)
	self._notHitGo = self:getGo("notHit")
	self._hitGo = self:getGo("hit")
	self._txtGain = self:getTxt("hit/txtGain")
	self._txtDesc = self:getTxt("hit/txtDesc")
end

function RmxplanopenlotteryView:onExit()
	RmxplanopenlotteryView.super.onExit(self)
	self._itemGroup:dispose()
end

function RmxplanopenlotteryView:onEnter()
	RmxplanopenlotteryView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._lotteryResults = params[2]
	self._totalResults = #self._lotteryResults
	self._curResultIndex = 1

	self:_updateUI()
end

function RmxplanopenlotteryView:_onClickbtnSure()
	if self._curResultIndex >= self._totalResults then
		self:close()
		GlobalDispatcher:dispatch(GlobalNotify.RichManXPlanCloseOpenLottery)
	else
		self._curResultIndex = self._curResultIndex + 1

		self:_updateUI()
	end
end

function RmxplanopenlotteryView:_updateUI()
	self:_updateData()
	self:_updateGrids()
	self:_updateDesc()
end

function RmxplanopenlotteryView:_updateData()
	self._lotteryResult = self._lotteryResults[self._curResultIndex]
	self._eventCfg = RichmanxplanConfig.instance:getCaipiaoEventCfg(self._activityId, self._lotteryResult.eventId)
	self._selectNumbers = {}
	self._isHit = false
	self._hitNum = 0
	self._prizeNumber = checknumber(self._lotteryResult.prizeNumber)

	for i, v in ipairs(self._lotteryResult.selectNumber) do
		self._selectNumbers[v] = v
		self._isHit = self._isHit or v == self._prizeNumber
		self._hitNum = self._hitNum + 1
	end
end

function RmxplanopenlotteryView:_updateDesc()
	goutil.setActive(self._hitGo, self._isHit)
	goutil.setActive(self._notHitGo, not self._isHit)

	if self._isHit then
		self._txtGain.text = self._eventCfg.prize
	end
end

function RmxplanopenlotteryView:_updateGrids()
	local numIds = {}

	for i = 1, self._eventCfg.numberMax do
		table.insert(numIds, i)
	end

	self._itemGroup:updateWithMoArray(numIds, function(item, num)
		local xIdx = item.index % 5

		if xIdx == 0 then
			xIdx = 5
		end

		local yIdex = math.ceil(item.index / 5)
		local x = (xIdx - 1) * 180 - 50
		local y = -(yIdex - 1) * 135 + 50

		Framework.TransformUtil.SetLocalPos(item.mainGO.transform, x, y, 0)

		local goSelect = goutil.findChild(item.mainGO, "select")
		local goTrueNum = goutil.findChild(item.mainGO, "trueNum")
		local imgNum = goutil.findChild(item.mainGO, "txtNum"):GetComponent(ComponentType.UIImgNumeralText)

		imgNum:SetNum(checknumber(num))
		goutil.setActive(goSelect, self._selectNumbers[num])
		goutil.setActive(goTrueNum, num == self._prizeNumber)
	end)
end

function RmxplanopenlotteryView:_clearGroupItem(item)
	return
end

return RmxplanopenlotteryView
