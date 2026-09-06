-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldScoreFmtExView.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldScoreFmtExView", package.seeall)

local HolyDragonFieldScoreFmtExView = class("HolyDragonFieldScoreFmtExView", ViewComponent)
local _SettleTypeAlive = "Alive"

function HolyDragonFieldScoreFmtExView:buildUI()
	HolyDragonFieldScoreFmtExView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._defaultShowPos = GameUtil.getAnchoredPos(self._moveNode) or Vector2.New(-110, 80)
	self._txtTarget1Name = self:getTxt("moveNode/target1/txtName")

	local target1ScrView = self:getGo("moveNode/target1/scrView")
	local target1ScrCell = self:getGo("moveNode/target1/scrCell")

	self._target1ScrollerList = ScrollerList.create(target1ScrView, target1ScrCell, GameUtil.handler(self._updateTarget1Cell, self), GameUtil.handler(self._clearScoreCell, self))
	self._txtTarget2Name = self:getTxt("moveNode/target2/txtName")

	local target2ScrView = self:getGo("moveNode/target2/scrView")
	local target2ScrCell = self:getGo("moveNode/target2/scrCell")

	self._target2ScrollerList = ScrollerList.create(target2ScrView, target2ScrCell, GameUtil.handler(self._updateTarget2Cell, self), GameUtil.handler(self._clearScoreCell, self))
end

function HolyDragonFieldScoreFmtExView:bindEvents()
	HolyDragonFieldScoreFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnArrow, self._onClickArrow, self)
end

function HolyDragonFieldScoreFmtExView:unbindEvents()
	HolyDragonFieldScoreFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnArrow)
end

function HolyDragonFieldScoreFmtExView:onEnter()
	HolyDragonFieldScoreFmtExView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	if self._fmtMo == nil then
		self:_reloadEmpty()

		return
	end

	self._activityId = self._fmtMo:getActivityId()
	self._fieldId = self._fmtMo:getFieldId()
	self._stageId = self._fmtMo:getStageId()
	self._subMo = HolyDragonFieldController.instance:getSubMo(self._activityId)
	self._isPopupState = true

	self:_initMoveNodePos()
	goutil.setActive(self._btnHide.gameObject, true)
	self:_onUpdate()
end

function HolyDragonFieldScoreFmtExView:onExit()
	HolyDragonFieldScoreFmtExView.super.onExit(self)
	self:_stopTween()
	self:_resetMoveNode()

	if self._target1ScrollerList then
		self._target1ScrollerList:dispose()
	end

	if self._target2ScrollerList then
		self._target2ScrollerList:dispose()
	end
end

function HolyDragonFieldScoreFmtExView:_onUpdate()
	self._target1DataList = {}
	self._target2DataList = {}

	local stageData = HolyDragonFieldConfig.instance:getStageData(self._activityId, self._fieldId, self._stageId)
	local bossSettlePlan = HolyDragonFieldConfig.instance:getStageBossSettlePlan(stageData)
	local bossSettleGroups = HolyDragonFieldConfig.instance:getBossSettleTypeGroups(self._activityId, bossSettlePlan)

	self._target1DataList = self:_buildSettleDataList(bossSettleGroups[1])
	self._target2DataList = self:_buildSettleDataList(bossSettleGroups[2])

	self:_updateTargetNames()
	self._target1ScrollerList:reloadData(self._target1DataList)
	self._target2ScrollerList:reloadData(self._target2DataList)
end

function HolyDragonFieldScoreFmtExView:_reloadEmpty()
	self._target1DataList = {}
	self._target2DataList = {}
	self._txtTarget1Name.text = ""
	self._txtTarget2Name.text = ""

	if self._target1ScrollerList then
		self._target1ScrollerList:reloadData(self._target1DataList)
	end

	if self._target2ScrollerList then
		self._target2ScrollerList:reloadData(self._target2DataList)
	end
end

function HolyDragonFieldScoreFmtExView:_buildSettleDataList(group)
	local dataList = {}

	if group == nil then
		return dataList
	end

	for _, settleData in ipairs(group.dataList or {}) do
		local var_8_0 = dataList
		local var_8_1 = {
			settlePlan = checknumber(group.settlePlan),
			settleType = checknumber(group.settleType),
			settleId = checknumber(settleData.settleId),
			settleData = settleData
		}

		var_8_1.isFinished = self._subMo and self._subMo:isBossSettleUsed(self._fieldId, self._stageId, settleData.settleId) or false

		table.insert(var_8_0, var_8_1)
	end

	table.sort(dataList, self._sortBySettleId)

	return dataList
end

function HolyDragonFieldScoreFmtExView._sortBySettleId(a, b)
	return a.settleId < b.settleId
end

function HolyDragonFieldScoreFmtExView:_updateTargetNames()
	self._txtTarget1Name.text = self:_getTargetName(self._target1DataList)
	self._txtTarget2Name.text = self:_getTargetName(self._target2DataList)
end

function HolyDragonFieldScoreFmtExView:_getTargetName(dataList)
	local data = dataList and dataList[1]

	if data and data.settleData then
		if not data.settleData.settleType then
			local settleType = 0

			return HolyDragonFieldConfig.instance:getSettleTypeName(self._activityId, settleType)
		end
	end
end

function HolyDragonFieldScoreFmtExView:_updateTarget1Cell(view, cell, data)
	self:_updateScoreCell(cell.gameObject, data, self:_getRangeText(data.settleType, data.settleData), cell.index)
end

function HolyDragonFieldScoreFmtExView:_updateTarget2Cell(view, cell, data)
	self:_updateScoreCell(cell.gameObject, data, self:_getRangeText(data.settleType, data.settleData), cell.index)
end

function HolyDragonFieldScoreFmtExView:_updateScoreCell(go, data, valueText, index)
	local bgColorChange = goutil.findChildComponent(go, "bg", "UIImageColorChange")
	local txtValue = goutil.findChildTextComponent(go, "txtValue")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local tagSelect = goutil.findChild(go, "tagSelect")
	local tagSelectIcon = goutil.findChild(go, "tagSelect/icon")
	local tagFinish = goutil.findChild(go, "tagFinish")
	local isSelected = self._fmtMo:isBossSettleSelected(data.settleType, data.settleId)

	bgColorChange:SetState(checknumber(index) % 2)

	txtValue.text = valueText
	txtScore.text = tostring(data.settleData.score)

	GameUtil.SetActive(tagSelect, not data.isFinished)
	GameUtil.SetActive(tagSelectIcon, isSelected and not data.isFinished)
	GameUtil.SetActive(tagFinish, data.isFinished)
	GameUtil.rmClickHandler(go)

	if not data.isFinished then
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickCell, self, data))
	end
end

function HolyDragonFieldScoreFmtExView:_clearScoreCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function HolyDragonFieldScoreFmtExView:_getRangeText(settleType, settleData)
	local settleTypeParam = HolyDragonFieldConfig.instance:getSettleTypeParam(self._activityId, settleType)

	if settleTypeParam == _SettleTypeAlive then
		return self:_getAliveRangeText(settleData.leftRange, settleData.rightRange)
	end

	local leftRange = self:_getRangeValueText(settleData.leftRange)
	local rightRange = self:_getRangeValueText(settleData.rightRange)

	if leftRange == rightRange or rightRange == "" then
		return leftRange
	end

	return string.format("%s~%s", leftRange, rightRange)
end

function HolyDragonFieldScoreFmtExView:_getAliveRangeText(leftRange, rightRange)
	leftRange = self:_getRangeValue(leftRange)
	rightRange = self:_getRangeValue(rightRange)

	if rightRange == nil or rightRange == "" or checknumber(leftRange) == checknumber(rightRange) then
		return self:_getAliveValueText(leftRange)
	end

	return string.format("%s~%s", tostring(leftRange or ""), tostring(rightRange or ""))
end

function HolyDragonFieldScoreFmtExView:_getAliveValueText(value)
	return checknumber(value) > 0 and lang("存活") or lang("阵亡")
end

function HolyDragonFieldScoreFmtExView:_getRangeValueText(value)
	value = self:_getRangeValue(value)

	if value == nil or value == "" then
		return ""
	end

	return MmUtil.formatNumber(checknumber(value), MmUtil.Units_CN, 1)
end

function HolyDragonFieldScoreFmtExView:_getRangeValue(value)
	if type(value) == "table" then
		value = value[1]
	end

	return value
end

function HolyDragonFieldScoreFmtExView:_onClickCell(data)
	if self._fmtMo:isBossSettleSelected(data.settleType, data.settleId) then
		self._fmtMo:setBossSettleSelected(data.settleType, data.settleId, false)
	else
		self._fmtMo:setBossSettleSelected(data.settleType, data.settleId, true)
	end

	self._target1ScrollerList:refresh()
	self._target2ScrollerList:refresh()
end

function HolyDragonFieldScoreFmtExView:_stopTween()
	if self._moveNode then
		UnityTweens.TweenPosition.StopTween(self._moveNode)
	end

	if self._arrowRectTrans then
		UnityTweens.TweenRotate.StopTween(self._arrowRectTrans)
	end
end

function HolyDragonFieldScoreFmtExView:_initMoveNodePos()
	if self._defaultShowPos == nil then
		local pos = GameUtil.getAnchoredPos(self._moveNode) or Vector2.New(-110, 80)

		if pos.x >= 300 then
			pos = Vector2.New(-110, pos.y)
		end

		self._defaultShowPos = pos
	end

	self._showPos = Vector2.New(self._defaultShowPos.x, self._defaultShowPos.y)
	self._hidePos = Vector2.New(400, self._showPos.y)

	self:_resetMoveNode()
end

function HolyDragonFieldScoreFmtExView:_resetMoveNode()
	if self._moveNode and self._showPos then
		Framework.TransformUtil.SetAnchoredPos(self._moveNode.transform, self._showPos.x, self._showPos.y)
	end

	if self._arrowRectTrans then
		Framework.TransformUtil.SetLocalRotation(self._arrowRectTrans.transform, 0, 0, 0)
	end
end

function HolyDragonFieldScoreFmtExView:_getMoveNodePos()
	local pos = GameUtil.getAnchoredPos(self._moveNode)

	return Vector3.New(pos.x, pos.y, 0)
end

function HolyDragonFieldScoreFmtExView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, self:_getMoveNodePos(), Vector3.New(self._hidePos.x, self._hidePos.y, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	end
end

function HolyDragonFieldScoreFmtExView:_onClickArrow()
	if self._isPopupState then
		self:_onClickHide()
	else
		self._isPopupState = true

		goutil.setActive(self._btnHide.gameObject, true)
		UnityTweens.TweenPosition.StartTween(self._moveNode, self:_getMoveNodePos(), Vector3.New(self._showPos.x, self._showPos.y, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

return HolyDragonFieldScoreFmtExView
