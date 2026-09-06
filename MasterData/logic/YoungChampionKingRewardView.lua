-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingRewardView.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingRewardView", package.seeall)

local YoungChampionKingRewardView = class("YoungChampionKingRewardView", ViewComponent)

function YoungChampionKingRewardView:ctor()
	YoungChampionKingRewardView.super.ctor(self)
end

function YoungChampionKingRewardView:unbindEvents()
	YoungChampionKingRewardView.super.unbindEvents(self)

	for i = 1, #self._switchBtns do
		GameUtil.rmClickHandler(self._switchBtns[i].go)
	end

	self._btnClose:RemoveClickListener()
end

function YoungChampionKingRewardView:bindEvents()
	YoungChampionKingRewardView.super.bindEvents(self)

	for i = 1, #self._switchBtns do
		GameUtil.addClickHandler(self._switchBtns[i].go, GameUtil.handler(self._onSwitchList, self, i))
	end

	self._btnClose:AddClickListener(self.close, self)
end

function YoungChampionKingRewardView:buildUI()
	YoungChampionKingRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")

	local cellGo = self:getGo("cell")
	local tableviewGo = self:getGo("tableview")

	self._scrollrect = tableviewGo:GetComponent("ScrollRect")
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

function YoungChampionKingRewardView:onExit()
	YoungChampionKingRewardView.super.onExit(self)
	self._tableview:dispose()
end

function YoungChampionKingRewardView:onEnter()
	YoungChampionKingRewardView.super.onEnter(self)

	self._cellPool = {}
	self._activityId = YoungChampionKingModel.instance:getCurActId()
	self._curSwitchId = nil

	self:_onSwitchList(1)
end

function YoungChampionKingRewardView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	cell.txtRank.text = data.title

	if not data.showPrize then
		local prize = data.prize
		local itemList = string.split(prize, "#")

		cell.tableview:reloadData(itemList)

		local imgRank = goutil.findChild(cellGo.gameObject, "imgRank")
		local imgChangeImgRank = imgRank:GetComponent(ComponentType.UIImageSpriteChange)
		local rankId = checknumber(data._rankId)

		if rankId >= 1 and rankId <= 3 then
			goutil.setActive(imgRank, true)
			imgChangeImgRank:SetState(rankId - 1)

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

function YoungChampionKingRewardView:_clearCell(cellGo)
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

function YoungChampionKingRewardView:_onDrag(eventData)
	self._scrollrect:OnDrag(eventData)
end

function YoungChampionKingRewardView:_onBeginDrag(eventData)
	self._scrollrect:OnBeginDrag(eventData)
end

function YoungChampionKingRewardView:_onEndDrag(eventData)
	self._scrollrect:OnEndDrag(eventData)
end

function YoungChampionKingRewardView:_updateItemCell(view, cellGo, data)
	local proxy = MaterialMgr.setCellByCfg(data, cellGo)

	if proxy then
		proxy.binder:setEffStatus(false)
	end
end

function YoungChampionKingRewardView:_clearItemCell(cellGo)
	MaterialMgr.resetAll(cellGo)
end

function YoungChampionKingRewardView:_onSwitchList(id)
	if self._curSwitchId ~= id then
		self._curSwitchId = id

		for i = 1, #self._switchBtns do
			local cell = self._switchBtns[i]

			cell.change:SetState(self._curSwitchId == i and 1 or 0)
		end

		local prizeCfgs = YoungChampionKingConfig.instance:getKnockoutRankPrizeCfgs(self._activityId)

		if self._curSwitchId == 2 then
			prizeCfgs = YoungChampionKingConfig.instance:getKnockoutRankPrizeCfgs(self._activityId)
		elseif self._curSwitchId == 1 then
			prizeCfgs = YoungChampionKingConfig.instance:getQualifyRankPrizeCfgs(self._activityId)
		end

		self._txt.text = "奖励将在活动结束时通过邮件发放"

		local dataList = {}
		local rankId = 1

		for id, cfg in ipairs(prizeCfgs) do
			cfg._rankId = rankId
			rankId = rankId + 1

			table.insert(dataList, cfg)
		end

		self._tableview:reloadData(dataList)
	end
end

return YoungChampionKingRewardView
