-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonsoulvote/view/DragonsoulvoteprizeView.lua

module("logic.extensions.dragonsoulvote.view.DragonsoulvoteprizeView", package.seeall)

local DragonsoulvoteprizeView = class("DragonsoulvoteprizeView", ViewComponent)

function DragonsoulvoteprizeView:ctor()
	DragonsoulvoteprizeView.super.ctor(self)
end

function DragonsoulvoteprizeView:unbindEvents()
	DragonsoulvoteprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DragonsoulvoteprizeView:bindEvents()
	DragonsoulvoteprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DragonsoulvoteprizeView:buildUI()
	DragonsoulvoteprizeView.super.buildUI(self)

	self._itemCell = self:getGo("itemcell")
	self._cell = self:getGo("cell")
	self._tableviewGo = self:getGo("tableview")
	self._txtNum = self:getTxt("num/txt")
	self._btnClose = self:getBtn("btnClose")
	self._tableview = ScrollerList.create(self._tableviewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DragonsoulvoteprizeView:onExit()
	DragonsoulvoteprizeView.super.onExit(self)
	self._tableview:dispose()
end

function DragonsoulvoteprizeView:onEnter()
	DragonsoulvoteprizeView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = DragonSoulVoteController.instance:getActivityId()
	end

	self._cellPool = {}
	self._gamePrizeCfgList = {}

	local list = DragonSoulVoteConfig.instance:getProgressCfgListById(self._activityId) or {}

	for i, v in ipairs(list) do
		table.insert(self._gamePrizeCfgList, v)
	end

	self.addGEvent(self, GlobalNotify.DRAGON_SOUL_VOTE_UPDATE, self._onRefreshUI, self)
	DragonSoulVoteController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
end

function DragonsoulvoteprizeView:_updateCell(view, cell, data)
	local cellGo = self:_clearCell(cell)
	local info = DragonSoulVoteModel.instance:getInfo(self._activityId) or {}

	if not info.gainPrizeIds then
		local gainPrizeIds = {}
		local finishNum = checknumber(info.myProgress)
		local prizeCfg = string.split(data.prize, "#")

		cellGo.rewardView:dragNotifyParent()
		cellGo.rewardView:reloadData(prizeCfg)
		GameUtil.SetActive(cellGo.receive, table.indexof(gainPrizeIds, data.prizeId) ~= false)
		GameUtil.SetActive(cellGo.noPass, finishNum < data.progress)
		GameUtil.SetActive(cellGo.btnSure.gameObject, finishNum >= data.progress and table.indexof(gainPrizeIds, data.prizeId) == false)

		cellGo.txtDesc.text = string.format("为喜欢的龙脉合体投票%d次", data.progress)

		GameUtil.addClickHandler(cellGo.btnSure, GameUtil.handler(self._onClickGainPrize, self, data.prizeId))
	end
end

function DragonsoulvoteprizeView:_clearCell(cell)
	local cellGo = self._cellPool[cell]

	if cellGo == nil then
		cellGo = {
			txtDesc = goutil.findChildTextComponent(cell, "txtDesc"),
			receive = goutil.findChild(cell, "receive"),
			noPass = goutil.findChild(cell, "noPass"),
			btnSure = goutil.findChildButtonComponent(cell, "btnSure"),
			rewardViewGo = goutil.findChild(cell, "rewardView")
		}
		cellGo.rewardView = ScrollerList.create(cellGo.rewardViewGo, self._itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		cellGo.rewardView:setCenterMode(true)

		self._cellPool[cell] = cellGo
	end

	cellGo.rewardView:dispose()
	GameUtil.rmClickHandler(cellGo.btnSure)

	return cellGo
end

function DragonsoulvoteprizeView:_updateItemCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function DragonsoulvoteprizeView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell)
end

function DragonsoulvoteprizeView:_onClickGainPrize(prizeId)
	DragonSoulVoteController.instance:sendGetPrize(self._activityId, prizeId)
end

function DragonsoulvoteprizeView:_onRefreshUI()
	local info = DragonSoulVoteModel.instance:getInfo(self._activityId) or {}
	local finishNum = checknumber(info.myProgress)

	self._txtNum.text = string.format("为喜欢的龙脉合体增加人气值：<color=#eb4642>%d</color>", finishNum)

	if not info.gainPrizeIds then
		local gainPrizeIds = {}

		ArraySort.sortOn(self._gamePrizeCfgList, {
			function(a)
				if table.indexof(gainPrizeIds, a.prizeId) ~= false then
					return 1
				else
					return 0
				end
			end,
			"prizeId"
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})
		self._tableview:reloadData(self._gamePrizeCfgList)
	end
end

return DragonsoulvoteprizeView
