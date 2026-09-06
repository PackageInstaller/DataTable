-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldStageBossResultView.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldStageBossResultView", package.seeall)

local HolyDragonFieldStageBossResultView = class("HolyDragonFieldStageBossResultView", ViewComponent)
local _SettleTypeAlive = "Alive"
local _FinishColor = "20B376FF"
local _UnfinishColor = "E7504FFF"

function HolyDragonFieldStageBossResultView:buildUI()
	HolyDragonFieldStageBossResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtCurScore = self:getTxt("txtCurScore")
	self._txtTotalScore = self:getTxt("txtTotalScore")
	self._target1Row = self:_buildRow("target1")
	self._target2Row = self:_buildRow("target2")
end

function HolyDragonFieldStageBossResultView:bindEvents()
	HolyDragonFieldStageBossResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._endBattle, self)
end

function HolyDragonFieldStageBossResultView:unbindEvents()
	HolyDragonFieldStageBossResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function HolyDragonFieldStageBossResultView:onEnter()
	HolyDragonFieldStageBossResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._fieldId = checknumber(params[2])
	self._stageId = checknumber(params[3])
	self._selectBossSettle = params[4] or {}
	self._subMo = HolyDragonFieldController.instance:getSubMo(self._activityId)

	self:_onUpdate()
end

function HolyDragonFieldStageBossResultView:_buildRow(rootPath)
	return {
		txtName = self:getTxt(string.format("%s/txtName", rootPath)),
		txtValue = self:getTxt(string.format("%s/txtValue", rootPath)),
		txtScore = self:getTxt(string.format("%s/txtScore", rootPath))
	}
end

function HolyDragonFieldStageBossResultView:_onUpdate()
	local challengeMsg = self._subMo and self._subMo:getLastChallengeMsg() or nil
	local gainScore = challengeMsg and checknumber(challengeMsg.gainScore) or 0
	local maxScore = self._subMo and checknumber(self._subMo:getStageScore(self._fieldId, self._stageId)) or 0

	self._txtCurScore.text = tostring(gainScore)
	self._txtTotalScore.text = tostring(maxScore + gainScore)
	self._selectedSettleMap = self:_buildSelectedSettleMap()

	local stageData = HolyDragonFieldConfig.instance:getStageData(self._activityId, self._fieldId, self._stageId)
	local bossSettlePlan = HolyDragonFieldConfig.instance:getStageBossSettlePlan(stageData)
	local bossSettleGroups = HolyDragonFieldConfig.instance:getBossSettleTypeGroups(self._activityId, bossSettlePlan)

	self:_updateResultRow(self._target1Row, bossSettleGroups[1])
	self:_updateResultRow(self._target2Row, bossSettleGroups[2])
end

function HolyDragonFieldStageBossResultView:_buildSelectedSettleMap()
	local map = {}
	local stageData = HolyDragonFieldConfig.instance:getStageData(self._activityId, self._fieldId, self._stageId)
	local bossSettlePlan = HolyDragonFieldConfig.instance:getStageBossSettlePlan(stageData)

	for _, settleId in ipairs(self._selectBossSettle or {}) do
		settleId = checknumber(settleId)

		if settleId > 0 then
			local settleData = HolyDragonFieldConfig.instance:getBossSettleData(self._activityId, bossSettlePlan, settleId)

			if settleData then
				map[checknumber(settleData.settleType)] = settleData
			end
		end
	end

	return map
end

function HolyDragonFieldStageBossResultView:_updateResultRow(row, group)
	if group == nil then
		row.txtName.text = ""
		row.txtValue.text = ""
		row.txtScore.text = ""

		return
	end

	local settleNum = self:_getSettleNumByType(group.settleType)
	local targetData = self._selectedSettleMap and self._selectedSettleMap[checknumber(group.settleType)] or nil
	local curValue = settleNum and checknumber(settleNum.num) or 0

	if not group.settleTypeName then
		row.txtName.text = ""
	end

	if targetData == nil then
		row.txtValue.text = string.format("<color=#%s>%s</color>", _UnfinishColor, "未选择目标")
		row.txtScore.text = "0积分"

		return
	end

	local isFinish = self:_isInRange(curValue, targetData.leftRange, targetData.rightRange)
	local score = checknumber(targetData.score)

	if isFinish then
		if not _FinishColor then
			local color = _UnfinishColor
			local curValueText = self:_formatSettleValue(group.settleTypeParam, curValue)
			local targetValueText = self:_getTargetRangeText(group.settleTypeParam, targetData)

			row.txtName.text = string.format("%s(%s)", tostring(group.settleTypeName or ""), targetValueText)
			row.txtValue.text = string.format("<color=#%s>%s</color>", color, curValueText)
			row.txtScore.text = string.format("%s积分", tostring(score))
		end
	end
end

function HolyDragonFieldStageBossResultView:_getTargetRangeText(settleTypeParam, settleData)
	if settleTypeParam == _SettleTypeAlive then
		return self:_getAliveRangeText(settleData.leftRange, settleData.rightRange)
	end

	return self:_getRangeText(settleData.leftRange, settleData.rightRange)
end

function HolyDragonFieldStageBossResultView:_formatSettleValue(settleTypeParam, value)
	if settleTypeParam == _SettleTypeAlive then
		return self:_getAliveValueText(value)
	end

	return MmUtil.formatNumber(checknumber(value), MmUtil.Units_CN, 1)
end

function HolyDragonFieldStageBossResultView:_getAliveRangeText(leftRange, rightRange)
	leftRange, rightRange = self:_normalizeRange(leftRange, rightRange)

	if rightRange == nil or rightRange == "" or checknumber(leftRange) == checknumber(rightRange) then
		return self:_getAliveValueText(leftRange)
	end

	return string.format("%s~%s", tostring(leftRange or ""), tostring(rightRange or ""))
end

function HolyDragonFieldStageBossResultView:_getAliveValueText(value)
	return checknumber(value) > 0 and lang("存活") or lang("阵亡")
end

function HolyDragonFieldStageBossResultView:_getRangeText(leftRange, rightRange)
	leftRange, rightRange = self:_normalizeRange(leftRange, rightRange)
	leftRange = self:_getRangeValueText(leftRange)
	rightRange = self:_getRangeValueText(rightRange)

	if rightRange == "" or leftRange == rightRange then
		return leftRange
	end

	return string.format("%s~%s", leftRange, rightRange)
end

function HolyDragonFieldStageBossResultView:_getRangeValueText(value)
	value = self:_getRangeValue(value)

	if value == nil or value == "" then
		return ""
	end

	return MmUtil.formatNumber(checknumber(value), MmUtil.Units_CN, 1)
end

function HolyDragonFieldStageBossResultView:_getRangeValue(value)
	if type(value) == "table" then
		value = value[1]
	end

	return value
end

function HolyDragonFieldStageBossResultView:_normalizeRange(leftRange, rightRange)
	if type(leftRange) == "table" then
		rightRange = leftRange[2]
		leftRange = leftRange[1]
	end

	return leftRange, rightRange
end

function HolyDragonFieldStageBossResultView:_getSettleNumByType(settleType)
	local challengeMsg = self._subMo and self._subMo:getLastChallengeMsg() or nil

	for _, settleNum in ipairs((challengeMsg or nil) and (challengeMsg.settleNum or {})) do
		if checknumber(settleNum.settleType) == checknumber(settleType) then
			return settleNum
		end
	end

	return nil
end

function HolyDragonFieldStageBossResultView:_isInRange(value, leftRange, rightRange)
	if type(leftRange) == "table" then
		rightRange = leftRange[2]
		leftRange = leftRange[1]
	end

	value = checknumber(value)
	leftRange = checknumber(leftRange)
	rightRange = checknumber(rightRange)

	return leftRange <= value and value <= rightRange
end

function HolyDragonFieldStageBossResultView:_endBattle()
	BattleController.instance:endBattle()
end

return HolyDragonFieldStageBossResultView
