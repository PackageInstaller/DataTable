-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/view/OriginKingOrderClgStageView.lua

module("logic.extensions.originkingorderclg.view.OriginKingOrderClgStageView", package.seeall)

local OriginKingOrderClgStageView = class("OriginKingOrderClgStageView", ViewComponent)

function OriginKingOrderClgStageView:buildUI()
	OriginKingOrderClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnReset = self:getGo("ruleTips/btnReset")

	local stageScrView = self:getGo("fmtCol/scrView")
	local stageScrCell = self:getGo("fmtCol/scrCell")

	self._stageScrollerList = ScrollerList.create(stageScrView, stageScrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._prizeItem = self:getGo("ruleTips/prizeItem")
	self._tagHasGain = self:getGo("ruleTips/tagHasGain")
end

function OriginKingOrderClgStageView:bindEvents()
	OriginKingOrderClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function OriginKingOrderClgStageView:unbindEvents()
	OriginKingOrderClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
end

function OriginKingOrderClgStageView:onEnter()
	OriginKingOrderClgStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = OriginKingOrderClgController.instance:getSubMo(self._activityId)
	self._actData = OriginKingOrderClgConfig.instance:getActivityData(self._activityId)

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_OriginKingOrderClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginKingOrderClgResetRes, self._onUpdate, self)
	OriginKingOrderClgController.instance:sendPM_OriginKingOrderClgGetInfoReq(self._activityId)

	local changeSetId = self._subMo:popChangeSetId()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function OriginKingOrderClgStageView:onExit()
	OriginKingOrderClgStageView.super.onExit(self)
	MaterialMgr.resetAll(self._prizeItem)
	self._stageScrollerList:dispose()
end

function OriginKingOrderClgStageView:_onUpdate()
	self:_onUpdateStageCol()
	self:_onUpdateResetBtn()

	local stageData
	local datas = OriginKingOrderClgConfig.instance:getStageDatas(self._activityId) or {}

	for idx, data in ipairs(datas) do
		stageData = data

		local result = self:_getTryEnterStageResultAndTips(false, data.stageId)

		if result == GameEnum.ResultCode.Success then
			break
		end
	end

	local prize = stageData and stageData.firstPassPrize

	if not string.nilorempty(prize) then
		local isPassStage = self._subMo:isHistoryStagePassed(stageData.stageId)

		GameUtil.SetActive(self._prizeItem, true)
		GameUtil.SetActive(self._tagHasGain, isPassStage)
		MaterialMgr.setCellByCfg(prize, self._prizeItem)
	else
		MaterialMgr.resetAll(self._prizeItem)
		GameUtil.SetActive(self._prizeItem, false)
		GameUtil.SetActive(self._tagHasGain, false)
	end
end

function OriginKingOrderClgStageView:_onUpdateStageCol()
	local datas = OriginKingOrderClgConfig.instance:getStageDatas(self._activityId) or {}

	self._stageScrollerList:reloadData(datas)

	local index = 0

	for idx, data in ipairs(datas) do
		index = idx - 1

		if not self._subMo:isStagePassed(data.stageId) then
			break
		end
	end

	self._stageScrollerList:MoveCellToCenter(index)
end

function OriginKingOrderClgStageView:_onUpdateResetBtn()
	local result = self:_getTryResetResultAndTips(false)

	GameUtil.SetGray(self._btnReset, result ~= GameEnum.ResultCode.Success)
end

function OriginKingOrderClgStageView:_updateStageCell(view, cell, data, tag)
	local index = cell.data
	local stageId = data.stageId
	local isPassed = self._subMo:isStagePassed(stageId)
	local isUnlocked = self._subMo:isStageUnlocked(stageId)
	local result = self:_getTryEnterStageResultAndTips(false, stageId)
	local mainGo = cell.gameObject
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local btnEnter = goutil.findChild(mainGo, "btnEnter")
	local tagLock = goutil.findChild(mainGo, "fmt/tagLock")
	local tagActive = goutil.findChild(mainGo, "fmt/tagActive")
	local xp1 = goutil.findChild(mainGo, "fmt/xp1")
	local xp2 = goutil.findChild(mainGo, "fmt/xp2")

	GameUtil.SetActive(xp1, index % 2 == 1)
	GameUtil.SetActive(xp2, index % 2 == 0)
	GameUtil.SetActive(tagLock, not isUnlocked)
	GameUtil.SetActive(btnEnter, isUnlocked and not isPassed)
	GameUtil.SetActive(tagActive, result == GameEnum.ResultCode.Success)
	GameUtil.SetGray(btnEnter, result ~= GameEnum.ResultCode.Success)
	GameUtil.addClickHandler(btnEnter, GameUtil.handler(self._onClickBtnEnter, self, stageId), self)

	local creepsMasterId = data.creepsMasterId
	local creepsCfg = OriginKingOrderClgConfig.instance:getCreepsDatas(creepsMasterId) or {}

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local mask = goutil.findChild(go, "mask")
		local icon = goutil.findChild(go, "mask/icon")
		local creepsData

		for _, cData in ipairs(creepsCfg) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		GameUtil.SetActive(mask, creepsData ~= nil)

		if creepsData then
			local petMo = FightingPowerPetMo.New()

			petMo:fromChallengeCreepCo(creepsData, creepsCfg)

			petMo.creepName = creepsData.creepName

			MaterialMgr.setIcon(icon, MatType.Pet, petMo.curFaceId)
			GameUtil.addClickHandler(go, function()
				CommonTipsMgr.instance:showPetTips(petMo)
			end)
		else
			MaterialMgr.clearIcon(icon)
			GameUtil.rmClickHandler(go)
		end
	end
end

function OriginKingOrderClgStageView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local btnEnter = goutil.findChild(mainGo, "btnEnter")

	GameUtil.rmClickHandler(btnEnter)
	GameUtil.SetGray(btnEnter, false)

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "mask/icon")

		MaterialMgr.clearIcon(icon)
		GameUtil.rmClickHandler(go)
	end
end

function OriginKingOrderClgStageView:_getTryEnterStageResultAndTips(isShowTips, stageId)
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
		local curPassedStageId = self._subMo:getCurPassedStageId()

		if self._subMo:isStagePassed(stageId) then
			result = GameEnum.ResultCode.Error
			tips = "已通关"
		end
	end

	if result == GameEnum.ResultCode.Success and not self._subMo:isStageUnlocked(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "未解锁"
	end

	if isShowTips and not string.nilorempty(tips) then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function OriginKingOrderClgStageView:_onClickBtnEnter(stageId)
	local result = self:_getTryEnterStageResultAndTips(true, stageId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	OriginKingOrderClgController.instance:enterStageBattle(self._activityId, stageId)
end

function OriginKingOrderClgStageView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginKingOrderClgStageView:_getTryResetResultAndTips(isShowTips)
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
		local curPassedStageId = self._subMo:getCurPassedStageId()

		if curPassedStageId <= 0 then
			result = GameEnum.ResultCode.Error
			tips = "当前没有可重置的关卡"
		end
	end

	if isShowTips and not string.nilorempty(tips) then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function OriginKingOrderClgStageView:_onClickBtnReset()
	local result = self:_getTryResetResultAndTips(true)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local function okFunc()
		OriginKingOrderClgController.instance:sendPM_OriginKingOrderClgResetReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", "将重置本层所有的通关情况及龙魂情况，是否确认此操作？", okFunc, nil, "确定", "取消")
end

return OriginKingOrderClgStageView
