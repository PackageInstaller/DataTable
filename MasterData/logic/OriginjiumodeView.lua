-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/view/OriginjiumodeView.lua

module("logic.extensions.originjiu.view.OriginjiumodeView", package.seeall)

local OriginjiumodeView = class("OriginjiumodeView", ViewComponent)
local STAGE_FIELDS = {
	[OriginJiuModel.StageRoad_A] = {
		creepsMasterId = "creepsMasterIdA",
		name = "nameA"
	},
	[OriginJiuModel.StageRoad_B] = {
		creepsMasterId = "creepsMasterIdB",
		name = "nameB"
	}
}

function OriginjiumodeView:ctor()
	OriginjiumodeView.super.ctor(self)
end

function OriginjiumodeView:unbindEvents()
	OriginjiumodeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
end

function OriginjiumodeView:bindEvents()
	OriginjiumodeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onResetClick, self)
end

function OriginjiumodeView:buildUI()
	OriginjiumodeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")

	local scrView = self:getGo("scrView")
	local scrCellA = self:getGo("scrCellA")
	local scrCellB = self:getGo("scrCellB")
	local scrCellList = {
		scrCellA,
		scrCellB
	}

	self._sizeList = {}

	for branchId, go in ipairs(scrCellList) do
		local width, height = GameUtil.getWidth(go), GameUtil.getHeight(go)

		self._sizeList[branchId] = {
			width,
			height
		}
	end

	self._scrollerList = ScrollerList.create(scrView, scrCellList, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._scrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
	self._scrollerList:setCenterMode(true)

	self._btnReset = self:getGo("rule/btnReset")
	self._buffGo = self:getGo("rule/buff")
	self._iconBuff = self:getGo("rule/buff/icon")
	self._txtBuff = self:getTxt("rule/buff/txt")
	self._txtRuleDesc = self:getTxt("rule/txtDesc/Viewport/Content")
	self._prizeItem = self:getGo("rule/prizeItem")
	self._tagHasGain = self:getGo("rule/tagHasGain")
end

function OriginjiumodeView:onExit()
	OriginjiumodeView.super.onExit(self)
	self._scrollerList:dispose()
	MaterialMgr.resetAll(self._prizeItem)
end

function OriginjiumodeView:onEnter()
	OriginjiumodeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._modelId = checknumber(params[2])
	self._phaseId = checknumber(params[3])

	self.addGEvent(self, GlobalNotify.ORIGIN_JIU_INFO_UPDATE, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.ORIGIN_JIU_RESET, self._getInfo, self)
	self:_getInfo()
	self:_refreshUI()

	local changeSetId = OriginJiuModel.instance:popChangeSetId()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function OriginjiumodeView:_getInfo()
	OriginJiuController.instance:sendGetInfo(self._activityId)
end

function OriginjiumodeView:_refreshUI()
	local modelInfo = OriginJiuModel.instance:getInfoByModelId(self._activityId, self._modelId) or {}

	self._phaseStageMap = {}
	self._maxStageId = 0

	for i, phase in ipairs(modelInfo.phases or {}) do
		if phase.phaseId == self._phaseId then
			for j, stage in ipairs(phase.stages or {}) do
				self._phaseStageMap[stage.stageId] = stage.stageRoad
				self._maxStageId = math.max(self._maxStageId, stage.stageId)
			end

			break
		end
	end

	local list = OriginJiuConfig.instance:getStageListCfgById(self._activityId, self._modelId, self._phaseId) or {}

	self._scrollerList:reloadData(list)

	self._endStageIdx = #list

	if self._endStageIdx ~= self._maxStageId and self._maxStageId > 0 then
		self._scrollerList:MoveCellToCenter(self._maxStageId - 1)
	end

	GameUtil.SetActive(self._buffGo, self._modelId == OriginJiuModel.ModelId_Ext)

	local buffId = self._phaseId
	local buffData = OriginJiuConfig.instance:getBuffData(self._activityId, buffId)

	GameUtil.setUIImageSpriteIdx(self._iconBuff, buffId - 1)

	self._txtBuff.text = buffData.name

	local phaseData = OriginJiuConfig.instance:getPhaseData(self._activityId, self._modelId, self._phaseId)

	self._txtRuleDesc.text = phaseData.ruleDesc

	local isPhaseGainedPrize = OriginJiuModel.instance:isPhaseGainedPrize(self._activityId, self._modelId, self._phaseId)

	MaterialMgr.setCellByCfg(phaseData.prize, self._prizeItem)
	GameUtil.SetActive(self._tagHasGain, isPhaseGainedPrize)

	local resetResult = self:_getTryResetResultAndTips(false)

	GameUtil.SetGray(self._btnReset, resetResult ~= GameEnum.ResultCode.Success)
end

function OriginjiumodeView:_updateCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local stageId = data.stageId
	local stageDatas = OriginJiuConfig.instance:getStageDatas(self._activityId, self._modelId, self._phaseId)

	if stageDatas then
		if not #stageDatas then
			local maxStageId = 0

			if tag == OriginJiuModel.StageRoad_A then
				local arrowLeft = goutil.findChild(mainGo, "arrowLeft")
				local arrowRight = goutil.findChild(mainGo, "arrowRight")
				local btnA = goutil.findChild(mainGo, "btnA")

				GameUtil.SetActive(arrowLeft, stageId > 1)
				GameUtil.SetActive(arrowRight, stageId < maxStageId)
				self:_updateStageCell(btnA, data, OriginJiuModel.StageRoad_A)
			else
				local arrowLeft = goutil.findChild(mainGo, "arrowLeft1")
				local arrowLeft2 = goutil.findChild(mainGo, "arrowLeft2")
				local arrowRight = goutil.findChild(mainGo, "arrowRight1")
				local arrowRight2 = goutil.findChild(mainGo, "arrowRight2")
				local btnA = goutil.findChild(mainGo, "btnA")
				local btnB = goutil.findChild(mainGo, "btnB")

				GameUtil.SetActive(arrowLeft, stageId > 1)
				GameUtil.SetActive(arrowLeft2, stageId > 1)
				GameUtil.SetActive(arrowRight, stageId < maxStageId)
				GameUtil.SetActive(arrowRight2, stageId < maxStageId)
				self:_updateStageCell(btnA, data, OriginJiuModel.StageRoad_A)
				self:_updateStageCell(btnB, data, OriginJiuModel.StageRoad_B)
			end
		end
	end
end

function OriginjiumodeView:_clearCell(cell)
	local mainGo = cell.gameObject
	local btnA = goutil.findChild(mainGo, "btnA")
	local btnB = goutil.findChild(mainGo, "btnB")

	self:_clearStageCell(btnA)
	self:_clearStageCell(btnB)
end

function OriginjiumodeView:_updateStageCell(mainGo, data, stageRoad)
	local nameField = STAGE_FIELDS[stageRoad].name
	local name = data[nameField]
	local stageId = data.stageId
	local idx = self._phaseStageMap[stageId]
	local isPass = OriginJiuModel.instance:isPassStage(self._activityId, self._modelId, self._phaseId, stageId)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local tagPass = goutil.findChild(mainGo, "tagPass")
	local colorChange = txtName.gameObject:GetComponent(ComponentType.UITextColorChange)
	local uIGradient = txtName.gameObject:GetComponent(ComponentType.UIGradient)

	txtName.text = name

	GameUtil.SetActive(tagLock, false)
	GameUtil.SetActive(tagPass, isPass)

	if idx and idx ~= stageRoad then
		GameUtil.SetActive(tagLock, true)
		GameUtil.SetActive(tagPass, false)
	end

	GameUtil.setUIGroupIdx(mainGo, self._phaseId - 1)

	if uIGradient then
		local color = txtName.color

		uIGradient.TopColor = UnityEngine.Color32.New(color.r * 255, color.g * 255, color.b * 255, color.a * 255)
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onCellClick, self, data, stageRoad))
end

function OriginjiumodeView:_clearStageCell(mainGo)
	GameUtil.rmClickHandler(mainGo)
end

function OriginjiumodeView:_getTagByIdx(data, idx)
	return (data.creepsMasterIdB > 0 or nil) and 2
end

function OriginjiumodeView:_getCellSize(view, idx)
	local list = self._scrollerList:getData()
	local data = list[idx + 1]
	local tag = self:_getTagByIdx(data, idx)

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

function OriginjiumodeView:_onCellClick(data, selectIdx)
	if data.stageId == self._maxStageId + 1 then
		local stageType = OriginJiuModel.instance:getStageClgType(self._activityId, self._modelId, self._phaseId)

		if stageType == OriginJiuModel.ClgType_Wheel then
			OriginJiuController.instance:enterStageBattleWithTab(self._activityId, self._modelId, self._phaseId, data.stageId, selectIdx)
		else
			OriginJiuController.instance:enterStageBattleWithCommon(self._activityId, self._modelId, self._phaseId, data.stageId, selectIdx)
		end
	elseif self._maxStageId >= data.stageId then
		TipsFacade.instance:openCommonTips("当前节点已经通关")
	else
		TipsFacade.instance:openCommonTips("请先完成前置关卡")
	end
end

function OriginjiumodeView:_onResetClick()
	local result = self:_getTryResetResultAndTips(true)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tipsContent = "是否确认重置当前所有关卡？"

	local function okFunc()
		OriginJiuController.instance:sendPM_OriginJiuClgPhaseResetReq(self._activityId, self._modelId, self._phaseId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function OriginjiumodeView:_getTryResetResultAndTips(isShowTips)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

		if not isInTime then
			result = GameEnum.ResultCode.Error
			tips = "不在活动时间范围内"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isPass = OriginJiuModel.instance:isPassPhase(self._activityId, self._modelId, self._phaseId)

		if isPass then
			result = GameEnum.ResultCode.Error
			tips = "本层已通关，无法小重置"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isHavePassStage = false
		local stageDatas = OriginJiuConfig.instance:getStageDatas(self._activityId, self._modelId, self._phaseId)

		for stageId, data in ipairs(stageDatas or {}) do
			local isPass = OriginJiuModel.instance:isPassStage(self._activityId, self._modelId, self._phaseId, stageId)

			if isPass then
				isHavePassStage = true

				break
			end
		end

		if not isHavePassStage then
			result = GameEnum.ResultCode.Error
			tips = "无需重置"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return OriginjiumodeView
