-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgPrizeView.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgPrizeView", package.seeall)

local NuoYaSisterClgPrizeView = class("NuoYaSisterClgPrizeView", ViewComponent)

function NuoYaSisterClgPrizeView:ctor()
	NuoYaSisterClgPrizeView.super.ctor(self)
end

function NuoYaSisterClgPrizeView:unbindEvents()
	NuoYaSisterClgPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NuoYaSisterClgPrizeView:bindEvents()
	NuoYaSisterClgPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NuoYaSisterClgPrizeView:buildUI()
	NuoYaSisterClgPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemTableCell = self:getGo("itemTableCell")
	self._txtCurStage = self:getTxt("txtCurStage")
end

function NuoYaSisterClgPrizeView:onExit()
	NuoYaSisterClgPrizeView.super.onExit(self)

	for i, v in pairs(self._itemTableListMap) do
		v:dispose()
	end

	self._itemTableListMap = {}

	self._tableList:dispose()
end

function NuoYaSisterClgPrizeView:onEnter()
	NuoYaSisterClgPrizeView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._itemTableListMap = {}

	local prizeCfg = NuoYaSisterClgConfig.instance:getPrizeCfg(self._activityId)

	self._tableList:reloadData(prizeCfg)

	self._txtCurStage.text = langPara("当前关卡：%d/%d", NuoYaSisterClgModel.instance:getMaxStageId(self._activityId), #prizeCfg)
end

function NuoYaSisterClgPrizeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local gainGo = goutil.findChild(go, "gain")
	local itemTableView = goutil.findChild(go, "itemTableView")
	local itemTableList = self._itemTableListMap[go]

	if not itemTableList and self._itemTableCell and itemTableView then
		self._itemTableListMap[go] = ScrollerList.create(itemTableView, self._itemTableCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		itemTableList = self._itemTableListMap[go]

		self._itemTableListMap[go]:dragNotifyParent()
	end

	txtLevel.text = langPara("第%d关", data.stageId)

	local prizeArr = string.split(data.prize, "#")

	itemTableList:reloadData(prizeArr)
	GameUtil.SetActive(gainGo, data.stageId <= NuoYaSisterClgModel.instance:getMaxStageId(self._activityId))
end

function NuoYaSisterClgPrizeView:_clearCell(cell)
	local go = cell.gameObject
	local itemTableList = self._itemTableListMap[go]

	if itemTableList then
		itemTableList:dispose()

		self._itemTableListMap[go] = nil
	end
end

function NuoYaSisterClgPrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function NuoYaSisterClgPrizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return NuoYaSisterClgPrizeView
