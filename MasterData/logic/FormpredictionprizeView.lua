-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/view/FormpredictionprizeView.lua

module("logic.extensions.formprediction.view.FormpredictionprizeView", package.seeall)

local FormpredictionprizeView = class("FormpredictionprizeView", ViewComponent)

function FormpredictionprizeView:ctor()
	FormpredictionprizeView.super.ctor(self)
end

function FormpredictionprizeView:unbindEvents()
	FormpredictionprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FormpredictionprizeView:bindEvents()
	FormpredictionprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FormpredictionprizeView:buildUI()
	FormpredictionprizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._itemcell = self:getGo("itemcell")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function FormpredictionprizeView:onExit()
	FormpredictionprizeView.super.onExit(self)
	self._scrollList:dispose()
end

function FormpredictionprizeView:onEnter()
	FormpredictionprizeView.super.onEnter(self)

	self._activityId = 385001
	self._curFormId = 0
	self._itemScrollListDic = {}

	local param = self:getOpenParam() or {}
	local actId = checknumber(param[1])

	if actId > 0 then
		self._activityId = actId
	end

	local formId = checknumber(param[2])

	if formId > 0 then
		self._curFormId = formId
	end

	local tabCfg = FormPredictionConfig.instance:getFormationCfgById(self._activityId, self._curFormId) or {}

	self._prizePlanId = tabCfg.prizePlanId

	local list = FormPredictionConfig.instance:getPrizeCfgById(self._prizePlanId) or {}

	self._scrollList:reloadData(list)
end

function FormpredictionprizeView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local rewardView = goutil.findChild(cell, "rewardView")
	local scrollList = self._itemScrollListDic[cell]

	if scrollList == nil then
		scrollList = ScrollerList.create(rewardView, self._itemcell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		self._itemScrollListDic[cell] = scrollList
	end

	txtDesc.text = langPara("分数达到%s以上", data.needScore)

	local arr = string.split(data.prize, "#")

	scrollList:reloadData(arr)
end

function FormpredictionprizeView:_clearCell(cell)
	return
end

function FormpredictionprizeView:_updateItemCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell)
end

function FormpredictionprizeView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell)
end

return FormpredictionprizeView
