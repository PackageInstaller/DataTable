-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/clearstargame/view/ClearStarGameResultView.lua

module("logic.extensions.clearstargame.view.ClearStarGameResultView", package.seeall)

local ClearStarGameResultView = class("ClearStarGameResultView", ViewComponent)

function ClearStarGameResultView:ctor()
	ClearStarGameResultView.super.ctor(self)
end

function ClearStarGameResultView:unbindEvents()
	ClearStarGameResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function ClearStarGameResultView:bindEvents()
	ClearStarGameResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, GameUtil.handler(self._onClickEnd, self, true))
	GameUtil.addClickHandler(self._btnCancel, GameUtil.handler(self._onClickEnd, self, false))
end

function ClearStarGameResultView:buildUI()
	ClearStarGameResultView.super.buildUI(self)

	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")

	local tableviewGo = self:getGo("Scrollerview")
	local cellGo = self:getGo("item")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("empty")

	self._tableview:setCenterMode(true)
end

function ClearStarGameResultView:onExit()
	ClearStarGameResultView.super.onExit(self)
	self._tableview:dispose()
end

function ClearStarGameResultView:onEnter()
	ClearStarGameResultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 479001
	end

	self._convertCfgs = ClearStarGameConfig.instance:getConvertCfgsById(self._activityId) or {}
	self._useItemMap = params[2] or {}
	self._starScoreMap = params[3] or {}

	local datalist = {}
	local matCollectMap = {}

	for i, cfg in ipairs(self._convertCfgs) do
		if checknumber(self._starScoreMap[i]) > 0 then
			local num = Mathf.Min(Mathf.Ceil(self._starScoreMap[i] / cfg.ratio), cfg.limit)

			if num > 0 then
				matCollectMap[cfg.itemId] = matCollectMap[cfg.itemId] or 0
				matCollectMap[cfg.itemId] = matCollectMap[cfg.itemId] + num
			end
		end
	end

	for k, v in pairs(matCollectMap) do
		table.insert(datalist, {
			itemId = k,
			num = v
		})
	end

	self._tableview:reloadData(datalist)
	goutil.setActive(self._empty, #datalist == 0)
end

function ClearStarGameResultView:_onClickEnd(isSaveData)
	self:close()

	local scores_pb_Ary = {}

	for i, score in pairs(self._starScoreMap) do
		table.insert(scores_pb_Ary, {
			scoreType = i,
			num = score
		})
	end

	local useItems_pb_Ary = {}

	for i, num in pairs(self._useItemMap) do
		table.insert(useItems_pb_Ary, {
			id = i,
			num = num
		})
	end

	ClearStarGameController.instance:endGame(self._activityId, isSaveData, scores_pb_Ary, useItems_pb_Ary)
end

function ClearStarGameResultView:_updateCell(view, cell, data)
	local proxy = MaterialMgr.setCell(MatType.ACTIVITY_ITEM, data.itemId, cell.gameObject)

	if proxy then
		proxy.binder:setNum(data.num)
	end
end

function ClearStarGameResultView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return ClearStarGameResultView
