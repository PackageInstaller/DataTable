-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulCombineView.lua

module("logic.extensions.fusionsoul.view.FusionSoulCombineView", package.seeall)

local FusionSoulCombineView = class("FusionSoulCombineView", ViewComponent)

function FusionSoulCombineView:ctor()
	FusionSoulCombineView.super.ctor(self)
end

function FusionSoulCombineView:unbindEvents()
	FusionSoulCombineView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnEnter)
end

function FusionSoulCombineView:bindEvents()
	FusionSoulCombineView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)

	for i, v in ipairs(self._downGoList) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickDown, self, i))
	end
end

function FusionSoulCombineView:buildUI()
	FusionSoulCombineView.super.buildUI(self)

	self._clueTableCell = self:getGo("clueTableCell")
	self._clueTableview = self:getGo("clueTableview")
	self._clueTableList = ScrollerList.create(self._clueTableview, self._clueTableCell, GameUtil.handler(self._updateClueCell, self), GameUtil.handler(self._clearClueCell, self))
	self._btnClose = self:getGo("btnClose")
	self._btnEnter = self:getGo("btnEnter")
	self._downGoList = {}

	for i = 1, 3 do
		local go = self:getGo("down_" .. i)

		table.insert(self._downGoList, go)
	end
end

function FusionSoulCombineView:onExit()
	FusionSoulCombineView.super.onExit(self)
	self._clueTableList:dispose()
end

function FusionSoulCombineView:onEnter()
	FusionSoulCombineView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FusionSoulAddTip, self._onAddClue, self)
	self.addGEvent(self, GlobalNotify.FusionSoulGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_FusionSoulCombineClueRes, self._PM_FusionSoulCombineClueRes, self)

	self._activityId = checknumber(self:getFirstParam())
	self._selectClueIds = {}

	self:_refreshView()
end

function FusionSoulCombineView:_refreshView()
	local cfgs = FusionSoulConfig.instance:getClueCfgs(self._activityId)

	self._clueTableList:reloadData(cfgs)
	self:_refreshDown()
end

function FusionSoulCombineView:_refreshDown()
	for i, v in ipairs(self._downGoList) do
		local txt = goutil.findChildTextComponent(v, "txt")
		local img = goutil.findChild(v, "img")
		local clueId = self._selectClueIds[i]

		if clueId then
			local cfg = FusionSoulConfig.instance:getClueCfg(self._activityId, clueId) or {}

			txt.text = cfg.name

			GameUtil.SetActive(img, true)
		else
			txt.text = ""

			GameUtil.SetActive(img, false)
		end
	end

	GameUtil.SetGray(self._btnEnter, #self._selectClueIds == 0 or FusionSoulController.instance:isCollectAllClue(self._activityId))
end

function FusionSoulCombineView:_updateClueCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txt")
	local btn = go
	local lock = goutil.findChild(go, "lock")
	local gainClue = FusionSoulModel.instance:isGainClue(self._activityId, data.clueId)

	txtName.text = gainClue == true and data.name or "?"

	GameUtil.SetActive(lock, not gainClue)
	GameUtil.SetActive(txtName, gainClue)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickClue(data.clueId)
	end)
end

function FusionSoulCombineView:_clearClueCell(cell)
	local btn = cell.gameObject

	GameUtil.rmClickHandler(btn)
end

function FusionSoulCombineView:_onAddClue(clueId)
	if #self._selectClueIds < #self._downGoList then
		if table.indexof(self._selectClueIds, clueId) == false then
			table.insert(self._selectClueIds, clueId)
			self:_refreshDown()
		end
	else
		FloatWordMgr.instance:show(lang("已达可选上限"))
	end
end

function FusionSoulCombineView:_onClickClue(clueId)
	if FusionSoulModel.instance:isGainClue(self._activityId, clueId) == true then
		UIStateManager.instance:push(ViewName.FusionSoulClueTipView, self._activityId, clueId)
	else
		FloatWordMgr.instance:show(lang("未获得该线索"))
	end
end

function FusionSoulCombineView:_onClickDown(idx)
	table.remove(self._selectClueIds, idx)
	self:_refreshDown()
end

function FusionSoulCombineView:_onClickEnter()
	if #self._selectClueIds <= 0 then
		FloatWordMgr.instance:show(lang("请填入线索"))
	elseif FusionSoulController.instance:isCollectAllClue(self._activityId) == true then
		FloatWordMgr.instance:show(lang("已完成所有委托，无法关联"))
	else
		FusionSoulController.instance:sendPM_FusionSoulCombineClueReq(self._activityId, self._selectClueIds)
	end
end

function FusionSoulCombineView:_PM_FusionSoulCombineClueRes(isCombineCorrect)
	if isCombineCorrect == true then
		self._selectClueIds = {}

		self:_refreshView()
	end
end

return FusionSoulCombineView
