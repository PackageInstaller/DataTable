-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldStageScoreView.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldStageScoreView", package.seeall)

local HolyDragonFieldStageScoreView = class("HolyDragonFieldStageScoreView", ViewComponent)
local _ScoreTypeDescName = {
	CircleCount = "回合数",
	Alive = "存活",
	ActiveCount = "存活数",
	BossDamage = "伤害区间",
	ComboCount = "连击数",
	UltimateCount = "超杀数",
	KillCount = "击杀数"
}
local _SettleTypeAlive = "Alive"

function HolyDragonFieldStageScoreView:buildUI()
	HolyDragonFieldStageScoreView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtDescTitle = self:getTxt("descCol/txt1")

	local tabScrView = self:getGo("tabCol/scrView")
	local tabScrCell = self:getGo("tabCol/scrCell")

	self._tabScrollerList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	local scoreScrView = self:getGo("descCol/scrView")
	local scoreScrCell = self:getGo("descCol/scrCell")

	self._scoreScrollerList = ScrollerList.create(scoreScrView, scoreScrCell, GameUtil.handler(self._updateScoreCell, self))
end

function HolyDragonFieldStageScoreView:bindEvents()
	HolyDragonFieldStageScoreView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function HolyDragonFieldStageScoreView:unbindEvents()
	HolyDragonFieldStageScoreView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function HolyDragonFieldStageScoreView:onEnter()
	HolyDragonFieldStageScoreView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._fieldId = checknumber(params[2])
	self._stageId = checknumber(params[3])
	self._subMo = self._activityId > 0 and HolyDragonFieldController.instance:getSubMo(self._activityId) or nil

	self:_onUpdate()
end

function HolyDragonFieldStageScoreView:onExit()
	HolyDragonFieldStageScoreView.super.onExit(self)

	if self._tabScrollerList then
		self._tabScrollerList:dispose()
	end

	if self._scoreScrollerList then
		self._scoreScrollerList:dispose()
	end
end

function HolyDragonFieldStageScoreView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function HolyDragonFieldStageScoreView:_onUpdateData()
	self._stageData = HolyDragonFieldConfig.instance:getStageData(self._activityId, self._fieldId, self._stageId)
	self._tabDataList = {}

	if self._stageData == nil then
		self._curTabIdx = 0

		return
	end

	if HolyDragonFieldConfig.instance:isBossStage(self._stageData) then
		self:_buildBossTabDataList()
	else
		self:_buildNormalTabDataList()
	end

	self._curTabIdx = #self._tabDataList > 0 and Mathf.Clamp(checknumber(self._curTabIdx), 1, #self._tabDataList) or 0
end

function HolyDragonFieldStageScoreView:_onUpdateUI()
	self._tabScrollerList:reloadData(self._tabDataList)
	self:_onUpdateScoreColUI()
end

function HolyDragonFieldStageScoreView:_onUpdateScoreColUI()
	local tabData = self._tabDataList[self._curTabIdx]

	if tabData == nil then
		self._txtDescTitle.text = "条件"

		self._scoreScrollerList:reloadData({})

		return
	end

	self._txtDescTitle.text = tabData.descName

	self._scoreScrollerList:reloadData(tabData.scoreList)
end

function HolyDragonFieldStageScoreView:_updateTabCell(view, cell, data)
	local go = cell.gameObject
	local tabIdx = cell.index + 1
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local tagSelect = goutil.findChild(go, "tagSelect")
	local isSelected = self._curTabIdx == tabIdx
	local stateIdx = isSelected and 0 or 1

	txtName.text = data.tabName

	GameUtil.setUITextColorIdx(txtName, stateIdx)
	GameUtil.SetActive(tagSelect, isSelected)
	GameUtil.addClickHandler(go, GameUtil.handler(self._onClickTab, self, tabIdx))
end

function HolyDragonFieldStageScoreView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function HolyDragonFieldStageScoreView:_onClickTab(tabIdx)
	self._curTabIdx = tabIdx

	self:_onUpdateUI()
end

function HolyDragonFieldStageScoreView:_updateScoreCell(view, cell, data)
	local go = cell.gameObject
	local bg = goutil.findChild(go, "bg")
	local txtValue = goutil.findChildTextComponent(go, "txtValue")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local tagFinish = goutil.findChild(go, "tagFinish")

	GameUtil.SetActive(bg, cell.index % 2 == 1)

	txtValue.text = data.valueText
	txtScore.text = data.score

	GameUtil.SetActive(tagFinish, data.isFinished)
end

function HolyDragonFieldStageScoreView:_buildNormalTabDataList()
	local tabMap = {}

	for _, settlePlan in ipairs(HolyDragonFieldConfig.instance:getStageNormalSettlePlans(self._stageData)) do
		local settlePlanDatas = HolyDragonFieldConfig.instance:getSettlePlanDatas(self._activityId, settlePlan)

		for _, settleData in pairs(settlePlanDatas or {}) do
			local settleType = settleData.settleType
			local tabData = tabMap[settleType]

			if tabData == nil then
				tabData = self:_createTabData(settleType)
				tabMap[settleType] = tabData

				table.insert(self._tabDataList, tabData)
			end

			table.insert(tabData.scoreList, {
				isFinished = false,
				valueText = self:_getSettleRangeText(settleType, settleData.num),
				score = settleData.score,
				sortValue = self:_getRangeSortValue(settleData.num)
			})
		end
	end

	self:_sortTabScoreList()
end

function HolyDragonFieldStageScoreView:_buildBossTabDataList()
	local tabMap = {}
	local bossSettlePlan = HolyDragonFieldConfig.instance:getStageBossSettlePlan(self._stageData)
	local bossSettleGroups = HolyDragonFieldConfig.instance:getBossSettleTypeGroups(self._activityId, bossSettlePlan)

	for _, group in ipairs(bossSettleGroups) do
		for _, settleData in ipairs(group.dataList or {}) do
			local settleType = settleData.settleType
			local tabData = tabMap[settleType]

			if tabData == nil then
				tabData = self:_createTabData(settleType)
				tabMap[settleType] = tabData

				table.insert(self._tabDataList, tabData)
			end

			local var_15_1 = tabData.scoreList
			local var_15_2 = {
				valueText = self:_getSettleRangeText(settleType, settleData.leftRange, settleData.rightRange),
				score = settleData.score,
				sortValue = checknumber(settleData.settleId)
			}

			var_15_2.isFinished = self._subMo and self._subMo:isBossSettleUsed(self._fieldId, self._stageId, settleData.settleId) or false

			table.insert(var_15_1, var_15_2)
		end
	end

	self:_sortTabScoreList()
end

function HolyDragonFieldStageScoreView:_createTabData(settleType)
	local settleTypeParam = HolyDragonFieldConfig.instance:getSettleTypeParam(self._activityId, settleType)
	local settleTypeName = HolyDragonFieldConfig.instance:getSettleTypeName(self._activityId, settleType)
	local var_16_0 = {
		settleType = settleType,
		tabName = settleTypeName
	}

	var_16_0.descName = _ScoreTypeDescName[settleTypeParam] or settleTypeName
	var_16_0.scoreList = {}

	return var_16_0
end

function HolyDragonFieldStageScoreView:_sortTabScoreList()
	for _, tabData in ipairs(self._tabDataList) do
		table.sort(tabData.scoreList, function(a, b)
			return a.sortValue < b.sortValue
		end)
	end
end

function HolyDragonFieldStageScoreView:_getSettleRangeText(settleType, leftRange, rightRange)
	local settleTypeParam = HolyDragonFieldConfig.instance:getSettleTypeParam(self._activityId, settleType)

	if settleTypeParam == _SettleTypeAlive then
		return self:_getAliveRangeText(leftRange, rightRange)
	end

	return self:_getRangeText(leftRange, rightRange)
end

function HolyDragonFieldStageScoreView:_getAliveRangeText(leftRange, rightRange)
	leftRange, rightRange = self:_normalizeRange(leftRange, rightRange)

	if rightRange == nil or rightRange == "" or checknumber(leftRange) == checknumber(rightRange) then
		return self:_getAliveValueText(leftRange)
	end

	return string.format("%s~%s", tostring(leftRange or ""), tostring(rightRange or ""))
end

function HolyDragonFieldStageScoreView:_getAliveValueText(value)
	return checknumber(value) > 0 and lang("存活") or lang("阵亡")
end

function HolyDragonFieldStageScoreView:_getRangeText(leftRange, rightRange)
	leftRange, rightRange = self:_normalizeRange(leftRange, rightRange)
	leftRange = self:_getRangeValueText(leftRange)
	rightRange = self:_getRangeValueText(rightRange)

	if rightRange == "" or leftRange == rightRange then
		return leftRange
	end

	return string.format("%s~%s", leftRange, rightRange)
end

function HolyDragonFieldStageScoreView:_getRangeValueText(value)
	value = self:_getRangeValue(value)

	if value == nil or value == "" then
		return ""
	end

	return MmUtil.formatNumber(checknumber(value), MmUtil.Units_CN, 1)
end

function HolyDragonFieldStageScoreView:_getRangeValue(value)
	if type(value) == "table" then
		value = value[1]
	end

	return value
end

function HolyDragonFieldStageScoreView:_normalizeRange(leftRange, rightRange)
	if type(leftRange) == "table" then
		rightRange = leftRange[2]
		leftRange = leftRange[1]
	end

	return leftRange, rightRange
end

function HolyDragonFieldStageScoreView:_getRangeSortValue(value)
	if type(value) == "table" then
		return checknumber(value[1])
	end

	return checknumber(value)
end

return HolyDragonFieldStageScoreView
