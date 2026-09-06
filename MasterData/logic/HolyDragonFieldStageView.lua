-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldStageView.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldStageView", package.seeall)

local HolyDragonFieldStageView = class("HolyDragonFieldStageView", ViewComponent)
local _StageCountPerGroup = 5
local _TargetCellCount = 3

function HolyDragonFieldStageView:buildUI()
	HolyDragonFieldStageView.super.buildUI(self)

	self._bgGo = self:getGo("bg")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/txtTitle/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._defaultTitle = self._txtTitle.text
	self._btnRank = self:getGo("jumpBtnCol/btnRank")
	self._btnShop = self:getGo("jumpBtnCol/btnShop")
	self._btnBuff = self:getGo("jumpBtnCol/btnBuff")
	self._btnPrize = self:getGo("jumpBtnCol/btnPrize")
	self._redPointBuff = self:getGo("jumpBtnCol/btnBuff/redPoint")
	self._redPointGos = {
		self:getGo("jumpBtnCol/btnRank/redPoint"),
		self:getGo("jumpBtnCol/btnShop/redPoint"),
		self._redPointBuff,
		self:getGo("jumpBtnCol/btnPrize/redPoint")
	}

	local stageScrView = self:getGo("stageCol/scrView")
	local stageScrCell = self:getGo("stageCol/scrCell")

	self._stageScrollerList = ScrollerList.create(stageScrView, stageScrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._fmtView = self:getGo("infoCol/fmt/fmtView")
	self._fmtTagLock = self:getGo("infoCol/fmt/tagLock")
	self._txtScore = self:getTxt("infoCol/txtScore")
	self._btnClg = self:getGo("infoCol/btnClg")
	self._btnRule = self:getGo("infoCol/btnRule")

	local prizeScrView = self:getGo("infoCol/prize/scrView")
	local prizeScrCell = self:getGo("infoCol/prize/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeScrollerList:setCenterMode(true)

	self._targetLayoutTrans = self:getGo("infoCol/target/layout"):GetComponent(goutil.Type_RectTransform)
	self._targetCells = {}
	self._targetLines = {}

	for i = 1, _TargetCellCount do
		self._targetCells[i] = self:_buildScoreTargetCell(i)

		if i < _TargetCellCount then
			self._targetLines[i] = self:getGo(string.format("infoCol/target/layout/line%d", i))
		end
	end

	self._fmtCells = {}

	for i = 1, self._fmtView.transform.childCount do
		local go = self._fmtView.transform:GetChild(i - 1).gameObject

		self._fmtCells[i] = {
			go = go,
			mask = goutil.findChild(go, "mask"),
			icon = goutil.findChild(go, "mask/icon")
		}
	end
end

function HolyDragonFieldStageView:bindEvents()
	HolyDragonFieldStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickBtnRule, self)
end

function HolyDragonFieldStageView:unbindEvents()
	HolyDragonFieldStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnRule)
end

function HolyDragonFieldStageView:onEnter()
	HolyDragonFieldStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._fieldId = checknumber(params[2])
	self._curStageId = nil
	self._locateStageOnNextInfoRefresh = true

	if self._activityId <= 0 then
		self._activityId = HolyDragonFieldController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = HolyDragonFieldController.instance:getSubMo(self._activityId)
	self._actData = HolyDragonFieldConfig.instance:getActivityData(self._activityId)

	self.addGEvent(self, GlobalNotify.HolyDragonField_InfoRefresh, self._onInfoRefresh, self)
	self.addGEvent(self, GlobalNotify.HolyDragonField_ChallengeResult, self._onChallengeResult, self)
	self.addGEvent(self, GlobalNotify.HolyDragonField_BuffUpgrade, self._onBuffUpgrade, self)
	self:_onSetStaticUI()
	RedPointController.instance:regRedPoint(self._redPointBuff, RedPointModel.ID_HOLY_DRAGON_FIELD_BUFF_UPDATE)
	self:_onUpdate()
	HolyDragonFieldController.instance:sendPM_HolyDragonFieldInfoReq(self._activityId)
end

function HolyDragonFieldStageView:onExit()
	HolyDragonFieldStageView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointBuff)

	self._locateStageOnNextInfoRefresh = false

	self:_clearBg()
	self:_clearPrize()
	self._stageScrollerList:dispose()
	self:_clearFmt()
end

function HolyDragonFieldStageView:_onInfoRefresh(activityId)
	if activityId ~= self._activityId then
		return
	end

	if self._locateStageOnNextInfoRefresh then
		self._curStageId = nil
		self._locateStageOnNextInfoRefresh = false
	end

	self:_onUpdate()
end

function HolyDragonFieldStageView:_onChallengeResult(activityId, fieldId)
	if activityId ~= self._activityId or fieldId ~= self._fieldId then
		return
	end

	self:_onUpdate()
end

function HolyDragonFieldStageView:_onBuffUpgrade(activityId)
	if activityId ~= self._activityId then
		return
	end

	self:_onUpdate()
end

function HolyDragonFieldStageView:_onSetStaticUI()
	for _, go in ipairs(self._redPointGos) do
		GameUtil.SetActive(go, false)
	end
end

function HolyDragonFieldStageView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function HolyDragonFieldStageView:_onUpdateData()
	self._fieldData = HolyDragonFieldConfig.instance:getFieldData(self._activityId, self._fieldId)
	self._isFieldOpen = self._fieldData and self:_isTimeOpen(self._fieldData.openTime) or false
	self._stageDataList = {}
	self._stageGroupDataList = {}

	local stageDatas = HolyDragonFieldConfig.instance:getStageDatas(self._activityId, self._fieldId)

	for stageId, stageData in pairs(stageDatas or {}) do
		local data = {}

		data.stageId = stageId
		data.stageData = stageData

		table.insert(self._stageDataList, data)
	end

	table.sort(self._stageDataList, function(a, b)
		return a.stageId < b.stageId
	end)

	for i, data in ipairs(self._stageDataList) do
		data.index = i
		data.score = self._subMo:getStageScore(self._fieldId, data.stageId)
		data.maxScore = self:_getStageMaxScore(data.stageData)
		data.isPassed = self._subMo:isStagePassed(self._fieldId, data.stageId)
		data.isTimeOpen = self:_isTimeOpen(data.stageData.openTime)
		data.isPrePassed = i == 1 or self._subMo:isStagePassed(self._fieldId, self._stageDataList[i - 1].stageId)
		data.isLocked = not self._isFieldOpen or not data.isTimeOpen or not data.isPrePassed
		data.isChallengeable = not data.isLocked
	end

	if not self:_hasStageData(self._curStageId) then
		local selectedStageId = self:_getSelectedStageId()

		self._curStageId = selectedStageId > 0 and selectedStageId or self:_getDefaultStageId()
	end

	self:_buildStageGroupDataList()
end

function HolyDragonFieldStageView:_onUpdateUI(moveStageToCenter)
	self:_setTitle()
	self:_loadBg()
	self:_onUpdateStageColUI(moveStageToCenter)
	self:_onUpdateInfoColUI()
end

function HolyDragonFieldStageView:_setTitle()
	if self._fieldData then
		local title = lang(self._fieldData.nameLangkey or "")

		if string.nilorempty(title) then
			self._txtTitle.text = self._defaultTitle or title
		end
	end
end

function HolyDragonFieldStageView:_loadBg()
	if self._fieldData then
		if string.nilorempty(self._fieldData) or self._curBgUrl == self._fieldData then
			return
		end

		self._curBgUrl = self._fieldData

		uGuiUtil.setSpriteToImage(self._bgGo, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl(self._fieldData))
	end
end

function HolyDragonFieldStageView:_clearBg()
	uGuiUtil.clearImage(self._bgGo)

	self._curBgUrl = nil
end

function HolyDragonFieldStageView:_onUpdateStageColUI(moveToCenter)
	self._stageScrollerList:reloadData(self._stageGroupDataList)

	if moveToCenter == false then
		return
	end

	local index = self:_getCurStageIndex()

	if index > 0 then
		self._stageScrollerList:MoveCellToCenter(math.floor((index - 1) / _StageCountPerGroup))
	end
end

function HolyDragonFieldStageView:_updateStageCell(view, cell, groupData, tag)
	local go = cell.gameObject

	for i = 1, _StageCountPerGroup do
		local line = goutil.findChild(go, string.format("lines/line%s", i))
		local stageCell = goutil.findChild(go, string.format("stageView/stageCell%s", i))
		local data = groupData.stageList[i]

		if i < _StageCountPerGroup then
			GameUtil.SetActive(line, groupData.stageList[i] ~= nil and groupData.stageList[i + 1] ~= nil)
		else
			GameUtil.SetActive(line, not groupData.isLastGroup)
		end

		self:_updateStageEntryCell(stageCell, data)
	end
end

function HolyDragonFieldStageView:_clearStageCell(cell)
	local go = cell.gameObject

	for i = 1, _StageCountPerGroup do
		GameUtil.rmClickHandler(goutil.findChild(go, string.format("stageView/stageCell%s", i)))
	end
end

function HolyDragonFieldStageView:_updateStageEntryCell(go, data)
	GameUtil.rmClickHandler(go)
	GameUtil.SetActive(go, data ~= nil)

	if data == nil then
		return
	end

	local txtName = goutil.findChildTextComponent(go, "txtName")
	local tagPass = goutil.findChild(go, "tagPass")
	local tagLock = goutil.findChild(go, "tagLock")
	local txtLock = goutil.findChildTextComponent(go, "tagLock/txt")
	local tagSelect = goutil.findChild(go, "tagSelect")
	local txtScore = goutil.findChildTextComponent(go, "score/txt")
	local isSelected = self._curStageId == data.stageId
	local isBossStage = HolyDragonFieldConfig.instance:isBossStage(data.stageData)

	txtName.text = isBossStage and lang("BOSS关") or langPara("第%s关", data.index)
	txtScore.text = langPara("积分：%s/%s", data.score, data.maxScore)

	GameUtil.SetActive(tagPass, data.isPassed)
	GameUtil.SetActive(tagLock, data.isLocked and not data.isPassed)
	GameUtil.SetActive(tagSelect, isSelected)

	txtLock.text = self:_getStageLockText(data)

	GameUtil.addClickHandler(go, GameUtil.handler(self._onClickStageEntry, self, data))
end

function HolyDragonFieldStageView:_onUpdateInfoColUI()
	local data = self:_getCurStageData()

	if data == nil then
		self._txtScore.text = "000000"

		self:_clearFmt()
		self:_clearPrize()
		self:_clearScoreTargets()
		GameUtil.setUIGroupIdx(self._btnClg, 0)
		GameUtil.SetGray(self._btnClg, true)

		return
	end

	self._txtScore.text = tostring(data.score)

	self:_setFmt(data.stageData.creepsMasterId)
	self:_setScoreTargets(data.stageData)
	self:_setPrize(data.stageData.prize)
	GameUtil.setUIGroupIdx(self._btnClg, data.isChallengeable and 1 or 0)
	GameUtil.SetGray(self._btnClg, not data.isChallengeable)
end

function HolyDragonFieldStageView:_setFmt(creepsMasterId)
	self:_clearFmt()

	local creepsDatas = HolyDragonFieldConfig.instance:getCreepsDatas(creepsMasterId)

	for _, creepsData in pairs(creepsDatas or {}) do
		local posId = checknumber(creepsData.posId)
		local cell = self._fmtCells[posId]

		if cell then
			local proxy = MaterialMgr.setCell(MatType.Pet, creepsData.raceId, cell.icon)

			if proxy then
				proxy.binder:setAutoTips(false)

				local tmpMo = FightingPowerPetMo.createPetByLevel(creepsData.raceId, 1, 1, 0)

				proxy.binder:setClickCallBack(function()
					CommonTipsMgr.instance:showPetTips(tmpMo, true)
				end)
			end

			GameUtil.SetActive(cell.go, true)
			GameUtil.SetActive(cell.mask, true)
		end
	end
end

function HolyDragonFieldStageView:_clearFmt()
	for _, cell in ipairs(self._fmtCells or {}) do
		MaterialMgr.resetAll(cell.icon)
		GameUtil.SetActive(cell.go, true)
		GameUtil.SetActive(cell.mask, false)
	end
end

function HolyDragonFieldStageView:_buildScoreTargetCell(index)
	local cellPath = string.format("infoCol/target/layout/cell%d", index)

	return {
		go = self:getGo(cellPath),
		txtTarget = self:getTxt(string.format("%s/txtCond", cellPath)),
		txtValue = self:getTxt(string.format("%s/txtValue", cellPath))
	}
end

function HolyDragonFieldStageView:_setScoreTargets(stageData)
	self:_clearScoreTargets(true)

	local targetList = self:_getScoreTargetList(stageData)
	local showCount = 0

	for i, targetData in ipairs(targetList) do
		local cell = self._targetCells[i]

		if cell then
			local score = self:_getScoreTargetScore(stageData, targetData)

			showCount = i
			cell.txtTarget.text = targetData.name
			cell.txtValue.text = tostring(score)

			GameUtil.SetActive(cell.go, true)
		else
			break
		end
	end

	self:_setScoreTargetLines(showCount)
	self:_rebuildTargetLayout()
end

function HolyDragonFieldStageView:_getScoreTargetScore(stageData, targetData)
	if targetData == nil then
		return 0
	end

	if HolyDragonFieldConfig.instance:isBossStage(stageData) then
		return self:_getBossScoreTargetScore(stageData, targetData)
	end

	return self:_getNormalScoreTargetScore(targetData)
end

function HolyDragonFieldStageView:_getNormalScoreTargetScore(targetData)
	if self._subMo == nil then
		return 0
	end

	local hasSettleValue = self._subMo:hasStageSettleTypeNum(self._fieldId, self._curStageId, targetData.settleType)

	if not hasSettleValue then
		return 0
	end

	local settleValue = self._subMo:getStageSettleTypeNum(self._fieldId, self._curStageId, targetData.settleType)

	return HolyDragonFieldConfig.instance:getStageSettleScore(self._activityId, self._fieldId, self._curStageId, targetData.settleType, settleValue)
end

function HolyDragonFieldStageView:_getBossScoreTargetScore(stageData, targetData)
	if self._subMo == nil then
		return 0
	end

	local score = 0
	local targetSettleType = checknumber(targetData.settleType)
	local bossSettlePlan = HolyDragonFieldConfig.instance:getStageBossSettlePlan(stageData)

	for _, settleId in ipairs(self._subMo:getBossSettleIds(self._fieldId, self._curStageId) or {}) do
		settleId = checknumber(settleId)

		if settleId > 0 then
			local settleData = HolyDragonFieldConfig.instance:getBossSettleData(self._activityId, bossSettlePlan, settleId)

			if settleData and checknumber(settleData.settleType) == targetSettleType then
				score = score + checknumber(settleData.score)
			end
		end
	end

	return score
end

function HolyDragonFieldStageView:_clearScoreTargets(skipRebuild)
	for _, cell in ipairs(self._targetCells or {}) do
		cell.txtTarget.text = ""
		cell.txtValue.text = ""

		GameUtil.SetActive(cell.go, false)
	end

	self:_setScoreTargetLines(0)

	if not skipRebuild then
		self:_rebuildTargetLayout()
	end
end

function HolyDragonFieldStageView:_setScoreTargetLines(showCount)
	for i, lineGo in ipairs(self._targetLines or {}) do
		GameUtil.SetActive(lineGo, i < showCount)
	end
end

function HolyDragonFieldStageView:_rebuildTargetLayout()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._targetLayoutTrans)
end

function HolyDragonFieldStageView:_setPrize(prize)
	self._prizeScrollerList:reloadData((not string.nilorempty(prize) or nil) and string.split(prize, "#"))
end

function HolyDragonFieldStageView:_clearPrize()
	self._prizeScrollerList:dispose()
end

function HolyDragonFieldStageView:_updatePrizeCell(view, cell, prizeStr)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local tagHasGain = goutil.findChild(go, "tagHasGain")
	local data = self:_getCurStageData()

	MaterialMgr.setCellByCfg(prizeStr, item)
	GameUtil.SetActive(tagHasGain, (data or nil) and (data.isPassed or false))
end

function HolyDragonFieldStageView:_clearPrizeCell(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(item)
end

function HolyDragonFieldStageView:_buildStageGroupDataList()
	for i, data in ipairs(self._stageDataList or {}) do
		local groupIdx = math.floor((i - 1) / _StageCountPerGroup) + 1
		local groupData = self._stageGroupDataList[groupIdx]

		if groupData == nil then
			groupData = {
				stageList = {}
			}

			table.insert(self._stageGroupDataList, groupData)
		end

		table.insert(groupData.stageList, data)
	end

	for i, groupData in ipairs(self._stageGroupDataList) do
		local nextGroupData = self._stageGroupDataList[i + 1]

		groupData.isLastGroup = nextGroupData == nil
	end
end

function HolyDragonFieldStageView:_hasStageData(stageId)
	for _, data in ipairs(self._stageDataList or {}) do
		if data.stageId == stageId then
			return true
		end
	end

	return false
end

function HolyDragonFieldStageView:_getDefaultStageId()
	for _, data in ipairs(self._stageDataList or {}) do
		if data.isChallengeable and not data.isPassed then
			return data.stageId
		end
	end

	for i = #self._stageDataList, 1, -1 do
		local data = self._stageDataList[i]

		if data.isPassed then
			return data.stageId
		end
	end

	if self._stageDataList then
		return (self._stageDataList or nil) and (self._stageDataList.stageId or 0)
	end
end

function HolyDragonFieldStageView:_getSelectedStageId()
	local selectedStageId = self._subMo and self._subMo:getSelectedStageId(self._fieldId) or 0

	return self:_hasStageData(selectedStageId) and selectedStageId or 0
end

function HolyDragonFieldStageView:_getCurStageData()
	for _, data in ipairs(self._stageDataList or {}) do
		if data.stageId == self._curStageId then
			return data
		end
	end

	return nil
end

function HolyDragonFieldStageView:_getCurStageIndex()
	for i, data in ipairs(self._stageDataList or {}) do
		if data.stageId == self._curStageId then
			return i
		end
	end

	return 0
end

function HolyDragonFieldStageView:_isTimeOpen(openTime)
	return GameUtil.getTimePeriod(openTime, nil) == GameUtil.inTimePeriod
end

function HolyDragonFieldStageView:_getStageLockText(data)
	if not self._isFieldOpen then
		return lang("未开启")
	end

	if not data.isTimeOpen then
		return GameUtil.formatTimeString("%Y.%m.%d %H:%M解锁", data.stageData.openTime)
	end

	if not data.isPrePassed then
		return lang("通过上一关开启")
	end

	return lang("未开启")
end

function HolyDragonFieldStageView:_getScoreTargetList(stageData)
	local targetList = {}

	if HolyDragonFieldConfig.instance:isBossStage(stageData) then
		local bossSettlePlan = HolyDragonFieldConfig.instance:getStageBossSettlePlan(stageData)
		local bossSettleGroups = HolyDragonFieldConfig.instance:getBossSettleTypeGroups(self._activityId, bossSettlePlan)

		for _, group in ipairs(bossSettleGroups) do
			for _, settleData in ipairs(group.dataList or {}) do
				self:_appendScoreTargetByType(targetList, settleData)
			end
		end
	else
		for _, settlePlan in ipairs(HolyDragonFieldConfig.instance:getStageNormalSettlePlans(stageData)) do
			local settlePlanDatas = HolyDragonFieldConfig.instance:getSettlePlanDatas(self._activityId, settlePlan)
			local settleType, name, score = self:_getSettlePlanBrief(settlePlanDatas)

			if name ~= "" then
				table.insert(targetList, {
					settleType = settleType,
					name = name,
					score = score
				})
			end
		end
	end

	return targetList
end

function HolyDragonFieldStageView:_getStageMaxScore(stageData)
	if stageData == nil then
		return 0
	end

	if HolyDragonFieldConfig.instance:isBossStage(stageData) then
		return self:_getBossStageMaxScore(stageData)
	end

	return self:_getNormalStageMaxScore(stageData)
end

function HolyDragonFieldStageView:_getNormalStageMaxScore(stageData)
	local maxScore = 0

	for _, settlePlan in ipairs(HolyDragonFieldConfig.instance:getStageNormalSettlePlans(stageData)) do
		local settlePlanDatas = HolyDragonFieldConfig.instance:getSettlePlanDatas(self._activityId, settlePlan)
		local _, _, settlePlanMaxScore = self:_getSettlePlanBrief(settlePlanDatas)

		maxScore = maxScore + checknumber(settlePlanMaxScore)
	end

	return maxScore
end

function HolyDragonFieldStageView:_getBossStageMaxScore(stageData)
	local maxScore = 0
	local bossSettlePlan = HolyDragonFieldConfig.instance:getStageBossSettlePlan(stageData)
	local bossSettleDatas = HolyDragonFieldConfig.instance:getBossSettleDatas(self._activityId, bossSettlePlan)

	for _, settleData in pairs(bossSettleDatas or {}) do
		maxScore = maxScore + checknumber(settleData.score)
	end

	return maxScore
end

function HolyDragonFieldStageView:_appendScoreTargetByType(targetList, settleData)
	if settleData == nil then
		return
	end

	for _, targetData in ipairs(targetList) do
		if targetData.settleType == settleData.settleType then
			targetData.score = Mathf.Max(checknumber(targetData.score), checknumber(settleData.score))

			return
		end
	end

	table.insert(targetList, {
		settleType = settleData.settleType,
		name = self:_getBossSettleName(settleData),
		score = settleData.score
	})
end

function HolyDragonFieldStageView:_getSettlePlanBrief(settlePlanDatas)
	local settleType = 0
	local name = ""
	local maxScore = 0

	for _, settleData in pairs(settlePlanDatas or {}) do
		if name == "" then
			settleType = settleData.settleType
			name = self:_getSettlePlanName(settleData)
		end

		maxScore = Mathf.Max(maxScore, checknumber(settleData.score))
	end

	return settleType, name, maxScore
end

function HolyDragonFieldStageView:_getSettlePlanName(settleData)
	return self:_getSettleTypeName(settleData.settleType)
end

function HolyDragonFieldStageView:_getBossSettleName(settleData)
	return self:_getSettleTypeName(settleData.settleType)
end

function HolyDragonFieldStageView:_getSettleTypeName(settleType)
	return HolyDragonFieldConfig.instance:getSettleTypeName(self._activityId, settleType)
end

function HolyDragonFieldStageView:_getSelectedBossSettle()
	local data = self:_getCurStageData()

	if data == nil or data.stageData == nil or not HolyDragonFieldConfig.instance:isBossStage(data.stageData) then
		return nil
	end

	local selectedBossSettle = {}

	if self._subMo == nil then
		return selectedBossSettle
	end

	local bossSettlePlan = HolyDragonFieldConfig.instance:getStageBossSettlePlan(data.stageData)
	local bossSettleGroups = HolyDragonFieldConfig.instance:getBossSettleTypeGroups(self._activityId, bossSettlePlan)

	for _, group in ipairs(bossSettleGroups or {}) do
		local settleId = self:_getMinUnfinishedBossSettleId(group)

		if settleId > 0 then
			table.insert(selectedBossSettle, settleId)
		end
	end

	return selectedBossSettle
end

function HolyDragonFieldStageView:_getMinUnfinishedBossSettleId(group)
	local minSettleId = 0

	for _, settleData in ipairs((group or nil) and (group.dataList or {})) do
		local settleId = checknumber(settleData and settleData.settleId)

		if settleId > 0 and not self._subMo:isBossSettleUsed(self._fieldId, self._curStageId, settleId) and (minSettleId <= 0 or settleId < minSettleId) then
			minSettleId = settleId
		end
	end

	return minSettleId
end

function HolyDragonFieldStageView:_onClickBtnClg()
	local data = self:_getCurStageData()

	if data == nil then
		return
	end

	if not self._isFieldOpen then
		FloatWordMgr.instance:show(lang("未开启"))

		return
	end

	if not data.isTimeOpen then
		FloatWordMgr.instance:show(self:_getStageLockText(data))

		return
	end

	if not data.isPrePassed then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	HolyDragonFieldController.instance:showMissionView(self._activityId, self._fieldId, self._curStageId, self:_getSelectedBossSettle())
end

function HolyDragonFieldStageView:_onClickStageEntry(data)
	self._locateStageOnNextInfoRefresh = false
	self._curStageId = data.stageId

	if self._subMo then
		self._subMo:setSelectedStageId(self._fieldId, self._curStageId)
	end

	self:_onUpdateUI(false)
end

function HolyDragonFieldStageView:_onClickBtnTip()
	if self._actData and self._actData.mainRuleKey then
		TipsFacade.instance:openRulesView(self._actData.mainRuleKey)
	end
end

function HolyDragonFieldStageView:_onClickBtnRule()
	local data = self:_getCurStageData()

	if data == nil then
		return
	end

	UIStateManager.instance:push(ViewName.HolyDragonFieldStageScoreView, self._activityId, self._fieldId, self._curStageId)
end

function HolyDragonFieldStageView:_onClickBtnRank()
	HolyDragonFieldController.instance:openRankView(self._activityId, self._fieldId)
end

function HolyDragonFieldStageView:_onClickBtnShop()
	GotoMgr.gotoByString(self._actData.jumpToShop)
end

function HolyDragonFieldStageView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.HolyDragonFieldBuffView, self._activityId, self._fieldId)
end

function HolyDragonFieldStageView:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.HolyDragonFieldPrizeView, self._activityId)
end

return HolyDragonFieldStageView
