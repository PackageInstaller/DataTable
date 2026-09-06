-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/view/DivineKingOrderResultView.lua

module("logic.extensions.divinekingorderclg.view.DivineKingOrderResultView", package.seeall)

local DivineKingOrderResultView = class("DivineKingOrderResultView", ViewComponent)

function DivineKingOrderResultView:ctor()
	DivineKingOrderResultView.super.ctor(self)
end

function DivineKingOrderResultView:unbindEvents()
	DivineKingOrderResultView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnSave:RemoveClickListener()
end

function DivineKingOrderResultView:bindEvents()
	DivineKingOrderResultView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
end

function DivineKingOrderResultView:buildUI()
	DivineKingOrderResultView.super.buildUI(self)

	self._btnCancel = self:getBtn("btnCancel")
	self._btnSave = self:getBtn("btnSave")

	local cell = self:getGo("cell")
	local tab = self:getGo("tableview")

	self._tableview = ScrollerList.create(tab, cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineKingOrderResultView:onExit()
	DivineKingOrderResultView.super.onExit(self)
end

function DivineKingOrderResultView:onEnter()
	DivineKingOrderResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivineKingOrderClgController.instance:getActivityId()
	end

	local infos = DivineKingOrderClgModel.instance:getCurFightSoulInfos()
	local dataList = {}

	for _, info in pairs(infos) do
		table.insert(dataList, info)
	end

	self._tableview:reloadData(dataList)
	self.addGEvent(self, GlobalNotify.DivineKingOrderClgConfirmSave, self._handleConfirmResult, self)
end

function DivineKingOrderResultView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	MaterialMgr.setCell(MatType.Pet, data.raceId, cell.icon)

	local info = DivineKingOrderClgModel.instance:getCurSoulInfoByRaceId(data.raceId)

	cell.txtNumWater.text = "x" .. data.waterSoulCount
	cell.txtNumWater.text = data.waterSoulCount <= 0 and string.format("x%s", (info or nil) and (info.waterSoulCount or 0)) or string.format("x%s<color=#41FF1DFF>(+%s)</color>", (info or nil) and (info.waterSoulCount or 0), data.waterSoulCount)
	cell.txtNumKong.text = data.kongSoulCount <= 0 and string.format("x%s", (info or nil) and (info.kongSoulCount or 0)) or string.format("x%s<color=#41FF1DFF>(+%s)</color>", (info or nil) and (info.kongSoulCount or 0), data.kongSoulCount)
end

function DivineKingOrderResultView:_clearCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.icon = goutil.findChild(cell.go, "icon")

	MaterialMgr.resetAll(cell.icon)

	cell.txtNumWater = goutil.findChildTextComponent(cell.go, "waterBuff/txtNum")
	cell.txtDescWater = goutil.findChildTextComponent(cell.go, "waterBuff/txtDesc")
	cell.txtNumKong = goutil.findChildTextComponent(cell.go, "kongBuff/txtNum")
	cell.txtDescKong = goutil.findChildTextComponent(cell.go, "kongBuff/txtDesc")

	return cell
end

function DivineKingOrderResultView:_onClickSave()
	DivineKingOrderClgController.instance:confirmSave(true)
end

function DivineKingOrderResultView:_onClickCancel()
	DivineKingOrderClgController.instance:confirmSave(false)
end

function DivineKingOrderResultView:_handleConfirmResult(status)
	if status == 0 then
		local activityType = DivineKingOrderClgController.instance:getActivityType()
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

		if isAoqiGodProcessType then
			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, self._activityId)
		end
	end

	self:close()
	BattleController.instance:endBattle()
end

return DivineKingOrderResultView
