-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattlereportView.lua

module("logic.extensions.glorybattle.view.GlorybattlereportView", package.seeall)

local GlorybattlereportView = class("GlorybattlereportView", ViewComponent)

function GlorybattlereportView:ctor()
	GlorybattlereportView.super.ctor(self)
end

function GlorybattlereportView:unbindEvents()
	GlorybattlereportView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function GlorybattlereportView:bindEvents()
	GlorybattlereportView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function GlorybattlereportView:buildUI()
	GlorybattlereportView.super.buildUI(self)

	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getBtn("btnClose")
	self._emptyGo = self:getGo("empty")
	self._scrollList = {}
end

function GlorybattlereportView:onExit()
	GlorybattlereportView.super.onExit(self)
	self._scrollerList:dispose()
end

function GlorybattlereportView:onEnter()
	GlorybattlereportView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GloryBattleViewBtlReportRes, self._onGloryBattleViewBtlReportRes, self)

	self._activityId = GlorybattleModel.instance:getCurrActivityId()

	GloryBattleAgent.instance:sendPM_GloryBattleViewBtlReportReq(self._activityId)
end

function GlorybattlereportView:_onGloryBattleViewBtlReportRes(viewBtlReports)
	local newList = {}

	table.insertto(newList, viewBtlReports)
	table.sort(newList, function(a, b)
		return checknumber(a.endTimeStamp) > checknumber(b.endTimeStamp)
	end)
	self._scrollerList:reloadData(newList)
	goutil.setActive(self._emptyGo, #newList <= 0)
end

function GlorybattlereportView:_updateCell(view, cell, data, tag)
	local btnDetail = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnDetail")
	local goCon = goutil.findChild(cell.gameObject, "cutepet/con")
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")
	local txtTotal = goutil.findChildTextComponent(cell.gameObject, "txtTotal")
	local txtWin = goutil.findChildTextComponent(cell.gameObject, "txtWin")
	local genreCfg = GlorybattleConfig.instance:getGenreCfg(self._activityId, data.genreId)
	local raceId = GlorybattleConfig.instance:getCutePetRaceId(genreCfg.cutePetId)
	local date = GameUtil.time2date(checknumber(data.endTimeStamp) / 1000)
	local scroll = self:_getScroll(goTableview, goTablecell)
	local proxy = MaterialMgr.setCell(MatType.CutePet, raceId, goCon)

	proxy.binder:setAutoTips(false)
	proxy.binder:setCallBack(function()
		UIStateManager.instance:push(ViewName.GlorycutepetsimpletipView, genreCfg.cutePetId, data.cutePetLevel)
	end)

	txtWin.text = data.winNum
	txtTotal.text = data.totalCurrency
	txtTime.text = string.format("%s-%s-%s %s:%s", date.year, date.month, date.day, date.hour, date.min)

	scroll:reloadData(data.creepsId)
	btnDetail:AddClickListener(function()
		UIStateManager.instance:push(ViewName.GlorybattleresultView, self._activityId, GlorybattleController.ResultType.Report, data)
	end)
end

function GlorybattlereportView:_clearCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "cutepet/con")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")

	MaterialMgr.resetAll(goCon)

	if self._scrollList[goTableview] then
		self._scrollList[goTableview]:dispose()
	end
end

function GlorybattlereportView:_onClickbtnClose()
	self:close()
end

function GlorybattlereportView:_getScroll(goTableview, goTablecell)
	local scrollList = self._scrollList[goTableview]

	if not scrollList then
		scrollList = ScrollerList.create(goTableview, goTablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
		self._scrollList[goTableview] = scrollList
	end

	return scrollList
end

function GlorybattlereportView:_updatePetCell(view, cell, creepsId, tag)
	local cfg = GlorybattleConfig.instance:getBattlePetCfg(self._activityId, creepsId)

	MaterialMgr.setCell(MatType.Pet, cfg.raceId, cell.gameObject)
end

function GlorybattlereportView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return GlorybattlereportView
