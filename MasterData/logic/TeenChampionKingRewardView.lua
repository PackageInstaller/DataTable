-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TeenChampionKingRewardView.lua

module("logic.extensions.teenchampionking.view.TeenChampionKingRewardView", package.seeall)

local TeenChampionKingRewardView = class("TeenChampionKingRewardView", ViewComponent)

function TeenChampionKingRewardView:ctor()
	TeenChampionKingRewardView.super.ctor(self)
end

function TeenChampionKingRewardView:unbindEvents()
	TeenChampionKingRewardView.super.unbindEvents(self)

	for i = 1, #self._switchBtns do
		GameUtil.rmClickHandler(self._switchBtns[i].go)
	end

	GameUtil.rmClickHandler(self._btnClose)
end

function TeenChampionKingRewardView:bindEvents()
	TeenChampionKingRewardView.super.bindEvents(self)

	for i = 1, #self._switchBtns do
		GameUtil.addClickHandler(self._switchBtns[i].go, GameUtil.handler(self._onSwitchList, self, i))
	end

	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TeenChampionKingRewardView:buildUI()
	TeenChampionKingRewardView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local cellGo = self:getGo("cell")
	local tableviewGo = self:getGo("tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._switchBtns = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("switchBtns/btn_" .. i)
		cell.change = cell.go:GetComponent("UIChangeGroup")
		self._switchBtns[i] = cell
	end

	self._txt = self:getTxt("txt")
end

function TeenChampionKingRewardView:onExit()
	TeenChampionKingRewardView.super.onExit(self)
	table.clear(self._subTabs)
	self._tableview:dispose()
end

function TeenChampionKingRewardView:onEnter()
	TeenChampionKingRewardView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 501001
	end

	self._subTabs = {}
	self._curSwitchId = nil

	self:_onSwitchList(1)
end

function TeenChampionKingRewardView:_updateCell(view, cell, data)
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")

	txtRank.text = data.title

	if not data.showPrize then
		local prize = data.prize
		local imgRank = goutil.findChild(cell.gameObject, "imgRank")
		local imgChangeImgRank = imgRank:GetComponent(ComponentType.UIImageSpriteChange)
		local rankId = 0

		if self._curSwitchId == 2 then
			rankId = checknumber(data.rankPrizeId)
		end

		if rankId >= 1 and rankId <= 3 then
			goutil.setActive(imgRank, true)
			imgChangeImgRank:SetState(rankId - 1)

			txtRank.text = ""
		else
			goutil.setActive(imgRank, false)
		end

		local itemList = string.split(prize, "#")
		local subTab = self._subTabs[cell.gameObject]

		if not subTab then
			local itemCom = goutil.findChild(cell.gameObject, "prizeCom")
			local itemCell = goutil.findChild(cell.gameObject, "itempos")

			subTab = ScrollerList.create(itemCom, itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
			self._subTabs[cell.gameObject] = subTab

			subTab:dragNotifyParent()
		end

		subTab:reloadData(itemList)
		subTab:MoveCellToBegin(0)
	end
end

function TeenChampionKingRewardView:_clearCell(cell)
	local subTab = self._subTabs[cell.gameObject]

	if subTab then
		subTab:removeDragNotifyParent()
		subTab:dispose()
	end
end

function TeenChampionKingRewardView:_updateItemCell(view, cellGo, data)
	local proxy = MaterialMgr.setCellByCfg(data, cellGo)

	if proxy then
		proxy.binder:setEffStatus(false)
	end
end

function TeenChampionKingRewardView:_clearItemCell(cellGo)
	MaterialMgr.resetAll(cellGo)
end

function TeenChampionKingRewardView:_onSwitchList(id)
	if self._curSwitchId ~= id then
		self._curSwitchId = id

		for i = 1, #self._switchBtns do
			local cell = self._switchBtns[i]

			cell.change:SetState(self._curSwitchId == i and 1 or 0)
		end

		local prizeCfgs = TeenChampionKingConfig.instance:getKnockoutRankPrizeCfgs(self._activityId)

		if self._curSwitchId == 2 then
			prizeCfgs = TeenChampionKingConfig.instance:getKnockoutRankPrizeCfgs(self._activityId)
		elseif self._curSwitchId == 1 then
			prizeCfgs = TeenChampionKingConfig.instance:getQualifyRankPrizeCfgs(self._activityId)
		end

		self._txt.text = "奖励将在活动结束时通过邮件发放"

		self._tableview:reloadData(prizeCfgs)
	end
end

return TeenChampionKingRewardView
