-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestRewardView.lua

module("logic.extensions.martialcontest.view.MartialContestRewardView", package.seeall)

local MartialContestRewardView = class("MartialContestRewardView", ViewComponent)

function MartialContestRewardView:ctor()
	MartialContestRewardView.super.ctor(self)
end

function MartialContestRewardView:unbindEvents()
	MartialContestRewardView.super.unbindEvents(self)

	for i = 1, #self._switchBtns do
		GameUtil.rmClickHandler(self._switchBtns[i].go)
	end

	self._btnClose:RemoveClickListener()
end

function MartialContestRewardView:bindEvents()
	MartialContestRewardView.super.bindEvents(self)

	for i = 1, #self._switchBtns do
		GameUtil.addClickHandler(self._switchBtns[i].go, GameUtil.handler(self._onSwitchList, self, i))
	end

	self._btnClose:AddClickListener(self.close, self)
end

function MartialContestRewardView:buildUI()
	MartialContestRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")

	local cellGo = self:getGo("cell")
	local tableviewGo = self:getGo("tableview")

	self._scrollrect = tableviewGo:GetComponent("ScrollRect")
	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._switchBtns = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("switchBtns/btn_" .. i)
		cell.change = cell.go:GetComponent("UIChangeGroup")
		self._switchBtns[i] = cell
	end

	self._txt = self:getTxt("txt")
end

function MartialContestRewardView:onExit()
	MartialContestRewardView.super.onExit(self)
	self._tableview:dispose()
end

function MartialContestRewardView:onEnter()
	MartialContestRewardView.super.onEnter(self)

	self._cellPool = {}

	local params = self:getOpenParam()

	self._activityId = checknumber(self:getFirstParam())
	self._stepId = params[2]
	self._curSwitchId = nil

	if self._stepId then
		self:_onSwitchList(self._stepId)
	else
		self:_onSwitchList(MartialContestEnum.Qualify_Step_Id)
	end
end

function MartialContestRewardView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	cell.txtRank.text = data.title

	if not data.showPrize then
		local prize = data.prize
		local itemList = string.split(prize, "#")

		cell.tableview:reloadData(itemList)

		local imgRank = goutil.findChild(cellGo.gameObject, "imgRank")
		local imgChangeImgRank = imgRank:GetComponent(ComponentType.UIImageSpriteChange)
		local rank = data.rankRange[1]

		if rank >= 1 and rank <= 3 then
			goutil.setActive(imgRank, true)
			imgChangeImgRank:SetState(rank - 1)

			cell.txtRank.text = ""
		else
			goutil.setActive(imgRank, false)
		end

		cell.tableview:MoveCellToBegin(0)
		cell.drag:AddDragListener(self._onDrag, self)
		cell.drag:AddBeginDragListener(self._onBeginDrag, self)
		cell.drag:AddEndDragListener(self._onEndDrag, self)
	end
end

function MartialContestRewardView:_clearCell(cellGo)
	local cell = self._cellPool[cellGo]

	if cell == nil then
		cell = {
			go = cellGo
		}
		cell.txtRank = goutil.findChildTextComponent(cell.go, "txtRank")
		cell.prizeCom = goutil.findChild(cell.go, "prizeCom")
		cell.itempos = goutil.findChild(cell.go, "itempos")
		cell.tableview = ScrollerList.create(cell.prizeCom, cell.itempos, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		cell.drag = Framework.UIDragTrigger.Get(cell.prizeCom)
		self._cellPool[cellGo] = cell
	end

	cell.tableview:dispose()
	MaterialMgr.resetAll(cell.prizeCom)
	cell.drag:RemoveDragListener()
	cell.drag:RemoveBeginDragListener()
	cell.drag:RemoveEndDragListener()

	return cell
end

function MartialContestRewardView:_onDrag(eventData)
	self._scrollrect:OnDrag(eventData)
end

function MartialContestRewardView:_onBeginDrag(eventData)
	self._scrollrect:OnBeginDrag(eventData)
end

function MartialContestRewardView:_onEndDrag(eventData)
	self._scrollrect:OnEndDrag(eventData)
end

function MartialContestRewardView:_updateItemCell(view, cellGo, data)
	local proxy = MaterialMgr.setCellByCfg(data, cellGo)

	if proxy then
		proxy.binder:setEffStatus(false)
	end
end

function MartialContestRewardView:_clearItemCell(cellGo)
	MaterialMgr.resetAll(cellGo)
end

function MartialContestRewardView:_onSwitchList(id)
	if self._curSwitchId ~= id then
		self._curSwitchId = id

		for i = 1, #self._switchBtns do
			local cell = self._switchBtns[i]

			cell.change:SetState(self._curSwitchId == i and 1 or 0)
		end

		local prizeCfgs = MartialContestConfig.instance:getQualifierPrizeCfgs(self._activityId)

		if self._curSwitchId == MartialContestEnum.Score_Match_Step_Id then
			prizeCfgs = MartialContestConfig.instance:getScoreRankPrizeCfgs(self._activityId)
		elseif self._curSwitchId == MartialContestEnum.Qualify_Step_Id then
			prizeCfgs = MartialContestConfig.instance:getQualifierPrizeCfgs(self._activityId)
		elseif self._curSwitchId == 3 then
			prizeCfgs = MartialContestConfig.instance:getFinalsPrizeCfgs(self._activityId)
		end

		self._txt.text = "奖励将在活动结束时通过邮件发放"

		local dataList = {}

		for id, cfg in pairs(prizeCfgs) do
			table.insert(dataList, cfg)
		end

		table.sort(dataList, function(a, b)
			return a.rankRange[1] < b.rankRange[1]
		end)
		self._tableview:reloadData(dataList)
	end
end

return MartialContestRewardView
