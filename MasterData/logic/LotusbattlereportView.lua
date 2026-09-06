-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlereportView.lua

module("logic.extensions.lotusbattle.view.LotusbattlereportView", package.seeall)

local LotusbattlereportView = class("LotusbattlereportView", TableViewComponent)

function LotusbattlereportView:ctor()
	LotusbattlereportView.super.ctor(self)
end

function LotusbattlereportView:unbindEvents()
	LotusbattlereportView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function LotusbattlereportView:bindEvents()
	LotusbattlereportView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function LotusbattlereportView:buildUI()
	LotusbattlereportView.super.buildUI(self)

	self._noReportGo = self:getGo("noReport")
	self._btnClose = self:getBtn("btnClose")
end

function LotusbattlereportView:onExit()
	LotusbattlereportView.super.onExit(self)
	GlobalDispatcher:removeListener(LotusBattleFieldAgent.LBFSimpleBattleRecordRes, self._updateUI, self)
end

function LotusbattlereportView:onEnter()
	LotusbattlereportView.super.onEnter(self)

	self._activityId = LotusbattleModel.instance:getActivityId()

	GlobalDispatcher:addListener(LotusBattleFieldAgent.LBFSimpleBattleRecordRes, self._updateUI, self)
	LotusBattleFieldAgent.instance:sendPM_LBFSimpleBattleRecordReq(self._activityId)
	self:_updateUI()
end

function LotusbattlereportView:_updateUI()
	self._curViewDatas = LotusbattleModel.instance:getRecordInfo()

	table.sort(self._curViewDatas, function(a, b)
		return checknumber(a.time) > checknumber(b.time)
	end)
	self:reloadData()
	goutil.setActive(self._noReportGo, not self._curViewDatas or #self._curViewDatas <= 0)
end

function LotusbattlereportView:_onClickbtnClose()
	self:close()
end

function LotusbattlereportView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function LotusbattlereportView:_updateCell(view, cell, data)
	local btnDetail = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnDetail")
	local txtKill = goutil.findChildTextComponent(cell.gameObject, "txtKill")
	local txtMode = goutil.findChildTextComponent(cell.gameObject, "txtMode")
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local modelCfg = LotusbattleConfig.instance:getModelCfg(self._activityId, data.modelId)

	txtRank.text = string.format("第<size=36>%s</size>名", data.rank)
	txtMode.text = modelCfg.name
	txtKill.text = string.format("淘汰人数：<color=#EB4642FF>%s</color>", data.killNum)

	btnDetail:AddClickListener(function()
		LotusBattleFieldAgent.instance:sendPM_LBFBattleRecordReq(self._activityId, data.fieldId)
	end)
end

function LotusbattlereportView:_clearTableview(cell)
	return
end

return LotusbattlereportView
