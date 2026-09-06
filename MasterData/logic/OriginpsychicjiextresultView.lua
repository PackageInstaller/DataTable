-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpsychicji/view/OriginpsychicjiextresultView.lua

module("logic.extensions.originpsychicji.view.OriginpsychicjiextresultView", package.seeall)

local OriginpsychicjiextresultView = class("OriginpsychicjiextresultView", ViewComponent)

OriginpsychicjiextresultView.ItemType = {
	Cur = 2,
	Pre = 1
}

function OriginpsychicjiextresultView:ctor()
	OriginpsychicjiextresultView.super.ctor(self)
end

function OriginpsychicjiextresultView:unbindEvents()
	OriginpsychicjiextresultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnCover:RemoveClickListener()
end

function OriginpsychicjiextresultView:bindEvents()
	OriginpsychicjiextresultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnCover:AddClickListener(self._onClickbtnCover, self)
end

function OriginpsychicjiextresultView:buildUI()
	OriginpsychicjiextresultView.super.buildUI(self)

	self._btnSure = self:getBtn("btns/btnSure")
	self._btnCancel = self:getBtn("btns/btnCancel")
	self._btnCover = self:getBtn("btns/btnCover")
	self._singleLineBtnsLayout = self:getGo("btns"):GetComponent(ComponentType.UILayoutSingleLine)
	self._singleLineResLayout = self:getGo("rescon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._txtDesc = self:getTxt("txtDesc")
	self._txtBtnSure = self:getTxt("btns/btnSure/txt")
	self._txtTips = self:getTxt("txtTips")

	self:_buildResultItems()
end

function OriginpsychicjiextresultView:_buildResultItems()
	self._resultItemGos = {}
	self._resultItemGos[OriginpsychicjiextresultView.ItemType.Pre] = self:getGo("rescon/pre")
	self._resultItemGos[OriginpsychicjiextresultView.ItemType.Cur] = self:getGo("rescon/cur")
end

function OriginpsychicjiextresultView:onExit()
	OriginpsychicjiextresultView.super.onExit(self)
end

function OriginpsychicjiextresultView:onEnter()
	OriginpsychicjiextresultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._msg = params[1]
	self._clgType = params[2]
	self._activityId = self._msg.activityId
	self._stageId = self._msg.stageId

	if self._msg.isWin then
		self._energy = self._msg.energy or 0
	end

	self:_updateUI()
end

function OriginpsychicjiextresultView:_onClickbtnSure()
	if self._needSave then
		self:_sendSaveReq()
	end

	BattleFacade.instance:endBattle()
end

function OriginpsychicjiextresultView:_onClickbtnCancel()
	OriginPsychicJiAgent.instance:sendPM_OriginPsychicJiSaveReq(self._activityId, false)
	BattleFacade.instance:endBattle()
end

function OriginpsychicjiextresultView:_onClickbtnCover()
	self:_sendSaveReq()
	BattleFacade.instance:endBattle()
end

function OriginpsychicjiextresultView:_sendSaveReq()
	OriginpsychicjiController.instance:saveExtResultMsg(self._msg)
	OriginPsychicJiAgent.instance:sendPM_OriginPsychicJiSaveReq(self._activityId, true)
end

function OriginpsychicjiextresultView:_updateUI()
	self._needSave = false

	goutil.setActive(self._resultItemGos[OriginpsychicjiextresultView.ItemType.Cur], true)
	goutil.setActive(self._resultItemGos[OriginpsychicjiextresultView.ItemType.Pre], true)

	if self._clgType == OriginpsychicjiController.ClgType.Normal then
		goutil.setActive(self._btnCancel.gameObject, false)
		goutil.setActive(self._btnSure.gameObject, true)
		goutil.setActive(self._btnCover.gameObject, false)
		goutil.setActive(self._resultItemGos[OriginpsychicjiextresultView.ItemType.Cur], true)
		goutil.setActive(self._resultItemGos[OriginpsychicjiextresultView.ItemType.Pre], false)

		self._txtBtnSure.text = "确认"
		self._txtTips.text = ""

		self:_udpateItem(OriginpsychicjiextresultView.ItemType.Cur, self._msg.typeToEnergy)
	else
		self._txtBtnSure.text = "知道了"

		local energy = OriginpsychicjiController:getEnergyValue(self._activityId, self._msg.typeToEnergy)
		local lastEnergy = OriginpsychicjiModel.instance:getStageEnergyValue(self._activityId, self._clgType, self._stageId)
		local actCfg = OriginpsychicjiConfig.instance:getActCfg(self._activityId)

		if lastEnergy <= 0 then
			goutil.setActive(self._btnCancel.gameObject, false)
			goutil.setActive(self._btnSure.gameObject, true)
			goutil.setActive(self._btnCover.gameObject, false)
			goutil.setActive(self._resultItemGos[OriginpsychicjiextresultView.ItemType.Cur], true)
			goutil.setActive(self._resultItemGos[OriginpsychicjiextresultView.ItemType.Pre], false)
			self:_udpateItem(OriginpsychicjiextresultView.ItemType.Cur, self._msg.typeToEnergy)

			self._needSave = energy <= actCfg.extStageMaxEnergy
		else
			goutil.setActive(self._btnCancel.gameObject, energy <= actCfg.extStageMaxEnergy and energy ~= lastEnergy)
			goutil.setActive(self._btnSure.gameObject, energy > actCfg.extStageMaxEnergy or energy == lastEnergy)
			goutil.setActive(self._btnCover.gameObject, energy <= actCfg.extStageMaxEnergy and energy ~= lastEnergy)

			local typeToEnergy = OriginpsychicjiModel.instance:getExtStageTypeToEnergy(self._activityId, self._stageId)

			self:_udpateItem(OriginpsychicjiextresultView.ItemType.Pre, typeToEnergy)
			self:_udpateItem(OriginpsychicjiextresultView.ItemType.Cur, self._msg.typeToEnergy)
		end

		self._txtTips.text = energy > actCfg.extStageMaxEnergy and string.format("总能量超过<color=#ffed98>%s</color>无法保存", actCfg.extStageMaxEnergy) or ""
	end

	self._txtDesc.text = OriginpsychicjiController.instance:getEnergySettleRuleDesc(self._activityId, self._clgType, self._stageId)

	self._singleLineBtnsLayout:Layout()
	self._singleLineResLayout:Layout()
end

function OriginpsychicjiextresultView:_udpateItem(itemType, typeToEnergy)
	local cell = self._resultItemGos[itemType]
	local goCell = goutil.findChild(cell.gameObject, "cell")
	local goCon = goutil.findChild(cell.gameObject, "con")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")
	local layout = goCon:GetComponent(ComponentType.UILayoutSingleLine)

	goutil.setActive(goCell, false)

	typeToEnergy = typeToEnergy or {}

	local cnt = #typeToEnergy
	local itemGo
	local vlaue = 0
	local childCount = goCon.transform.childCount

	for i = 0, childCount - 1 do
		local go = goCon.transform:GetChild(i).gameObject

		goutil.setActive(go, false)
	end

	for i, v in ipairs(typeToEnergy) do
		local curValue = OriginpsychicjiConfig.instance:getSettleEnergyByNum(self._activityId, v.left, v.right)

		vlaue = vlaue + curValue

		local childIndex = i - 1

		itemGo = childIndex < childCount and goCon.transform:GetChild(childIndex).gameObject or goutil.cloneAndSetParent(goCell, goCon.transform)

		goutil.setActive(itemGo, true)
		self:_udpateScoreItem(itemGo, v, i == cnt)
	end

	if self._clgType == OriginpsychicjiController.ClgType.Normal then
		local stageCfg = OriginpsychicjiConfig.instance:getNormalStageCfg(self._activityId, self._stageId)
		local pass = vlaue >= stageCfg.passNeedEnergy

		txtScore.text = pass and string.format("总：<color=#ffed98>%s</color>能量", vlaue) or string.format("总：<color=#ffed98>%s</color>能量,但未达通关条件", vlaue)
	else
		txtScore.text = string.format("总：<color=#ffed98>%s</color>能量", vlaue)
	end

	layout:Layout()
end

function OriginpsychicjiextresultView:_udpateScoreItem(cell, pair, hideLine)
	local txtEnergy = goutil.findChildTextComponent(cell.gameObject, "txtEnergy")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")
	local goLine = goutil.findChild(cell.gameObject, "line")

	goutil.setActive(goLine, not hideLine)

	local value = OriginpsychicjiConfig.instance:getSettleEnergyByNum(self._activityId, pair.left, pair.right)

	txtEnergy.text = string.format("<color=#ffed98>+%s</color>能量", value)
	txtScore.text = pair.right
	txtName.text = OriginpsychicjiController.instance:getEnergySettleNameDesc(self._activityId, pair.left)
end

return OriginpsychicjiextresultView
