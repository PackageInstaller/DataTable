-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/view/TunTianChallengeExtremeStageView.lua

module("logic.extensions.tuntianchallenge.view.TunTianChallengeExtremeStageView", package.seeall)

local TunTianChallengeExtremeStageView = class("TunTianChallengeExtremeStageView", ViewComponent)

function TunTianChallengeExtremeStageView:buildUI()
	TunTianChallengeExtremeStageView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._tips = {}

	if self._tips then
		local mainGo = goutil.findChild(self.mainGO, "tips")

		self._tips._txt1 = goutil.findChildTextComponent(self.mainGO, "tips/txt1")
		self._tips._btnDetail = goutil.findChild(self.mainGO, "tips/btnDetail")
	end

	self._stageCol = goutil.findChild(self.mainGO, "stageCol")
	self._stageScrollerview = goutil.findChild(self.mainGO, "stageCol/stageScrollerview")
	self._stageScrollercell = goutil.findChild(self.mainGO, "stageCol/stageScrollercell")
	self._stageScrollList = ScrollerList.create(self._stageScrollerview, self._stageScrollercell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._ruleCol = goutil.findChild(self.mainGO, "ruleCol")
	self._txtRangeTitle = goutil.findChildTextComponent(self.mainGO, "ruleCol/txtRangeTitle")
	self._txtValueTitle = goutil.findChildTextComponent(self.mainGO, "ruleCol/txtValueTitle")
	self._ruleScrollerview = goutil.findChild(self.mainGO, "ruleCol/ruleScrollerview")
	self._ruleScrollercell = goutil.findChild(self.mainGO, "ruleCol/ruleScrollercell")
	self._ruleScrollList = ScrollerList.create(self._ruleScrollerview, self._ruleScrollercell, GameUtil.handler(self._updateRuleCell, self), GameUtil.handler(self._clearRuleCell, self))
end

function TunTianChallengeExtremeStageView:bindEvents()
	TunTianChallengeExtremeStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._tips._btnDetail, self._onClickBtnDetail, self)
end

function TunTianChallengeExtremeStageView:unbindEvents()
	TunTianChallengeExtremeStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._tips._btnDetail)
end

function TunTianChallengeExtremeStageView:onEnter()
	TunTianChallengeExtremeStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageType = checknumber(params[2])
	self._activityType = TunTianChallengeController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local isInTime = TunTianChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	if self._stageType <= 0 then
		local text = "缺失传入参数 stageType"

		local function func()
			self:close()
		end

		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)

		return
	end

	self._stageTypeData = TunTianChallengeConfig.instance:getTtExtStageTypeData(self._activityId, self._stageType)
	self._convertDataList = TunTianChallengeConfig.instance:getTtExtConvertDataList(self._stageTypeData.balancedConvertPlanId)

	self:_onSetUI()

	self._isNeedRuleColShow = false

	self:_updateRuleColVisuable()
	self.addGEvent(self, GlobalNotify.TunTianClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TunTianExtremeClgUseNewStageScoreRes, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function TunTianChallengeExtremeStageView:onExit()
	TunTianChallengeExtremeStageView.super.onExit(self)
	self:_onClearStageCol()
	self:_onClearRuleCol()
end

function TunTianChallengeExtremeStageView:_sendInfoReq()
	TunTianChallengeController.instance:sendPM_TunTianClgGetInfoReq(self._activityId)
end

function TunTianChallengeExtremeStageView:_onSetUI()
	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	self._tips._txt1.text = self._stageTypeData.tipsOne
end

function TunTianChallengeExtremeStageView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TunTianChallengeExtremeStageView:_onUpdateData()
	self:_onUpdateStageColData()
end

function TunTianChallengeExtremeStageView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateStageColUI()
	self:_onUpdateRuleColUI()
end

function TunTianChallengeExtremeStageView:_onUpdatePlaneUI()
	return
end

function TunTianChallengeExtremeStageView:_onUpdateStageColData()
	self._stageInfoList = {}

	local cfg = TunTianChallengeConfig.instance:getTtExtStageDataList(self._activityId, self._stageType)

	for idx, data in ipairs(cfg) do
		local info = {}

		info.data = data
		info.status = TunTianChallengeController.instance:getStageStatusOfExtClg(self._stageType, data.stageId)
		self._stageInfoList[idx] = info
	end
end

function TunTianChallengeExtremeStageView:_onUpdateStageColUI()
	self._stageScrollList:reloadData(self._stageInfoList)

	local notPassIdx = 0

	for idx, info in ipairs(self._stageInfoList) do
		if info.status == TunTianChallengeModel.StageTypeStatus.NotPass then
			notPassIdx = idx

			break
		end
	end

	self._stageScrollList:MoveCellInView(notPassIdx - 1, true)
end

function TunTianChallengeExtremeStageView:_onClearStageCol()
	self._stageScrollList:dispose()
end

function TunTianChallengeExtremeStageView:_updateStageCell(view, cell, info, tag)
	local data = info.data
	local status = info.status
	local index = cell.index + 1
	local mainGo = cell.gameObject
	local txtStageName = goutil.findChildTextComponent(mainGo, "txtStageName")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtStatus = goutil.findChildTextComponent(mainGo, "txtStatus")
	local path = data.picturePath
	local bgGo = goutil.findChild(mainGo, "mask/con")

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		uGuiUtil.clearImage(bgGo)
	end

	txtStageName.text = string.format("第<size=50>%s</size>关", index)

	local score = TunTianChallengeController.instance:getStageScoreOfExtClg(self._stageType, data.stageId)

	txtScore.text = string.format("%s：%s", self._stageTypeData.typeName, score)

	local statusStr, changeIdx, isNeedStatus = "", 1, true

	if status == TunTianChallengeModel.StageStatus.UnChallenged then
		statusStr = "未挑战"
		changeIdx = 0
	elseif status == TunTianChallengeModel.StageStatus.ChallengeFail then
		statusStr = "挑战失败"
		changeIdx = 0
	elseif status == TunTianChallengeModel.StageStatus.ChallengeSuc then
		statusStr = "挑战成功"
		changeIdx = 1
	else
		statusStr = ""
		isNeedStatus = false
	end

	txtStatus.text = statusStr

	GameUtil.setUITextColorIdx(txtStatus, changeIdx)
	GameUtil.SetActive(txtStatus.gameObject, isNeedStatus)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickStageCell, self, info))
end

function TunTianChallengeExtremeStageView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(mainGo)
end

function TunTianChallengeExtremeStageView:_onClickStageCell(info)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local data = info.data
	local result, tips = TunTianChallengeController.instance:getTryFightStageOfExtClgResultAndTips(self._activityId, self._stageType, data.stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	TunTianChallengeController.instance:enterBattleOfExtClg(self._activityId, self._stageType, data.stageId)
end

function TunTianChallengeExtremeStageView:_onUpdateRuleColUI()
	self._ruleScrollList:reloadData(self._convertDataList)
	self._ruleScrollList:MoveCellInView(0, true)

	self._txtRangeTitle.text = self._stageTypeData.realName
end

function TunTianChallengeExtremeStageView:_onClearRuleCol()
	self._ruleScrollList:dispose()
end

function TunTianChallengeExtremeStageView:_updateRuleCell(view, cell, data, tag)
	local index = cell.index + 1
	local mainGo = cell.gameObject
	local txtRange = goutil.findChildTextComponent(mainGo, "txtRange")
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")
	local range = data.originalValueRange
	local leftNum, rightNum = checknumber(range[1]), checknumber(range[2])

	txtRange.text = index >= #self._convertDataList and string.format(">=%s", leftNum) or string.format("%s~%s", leftNum, rightNum)
	txtValue.text = data.convertedValue
end

function TunTianChallengeExtremeStageView:_clearRuleCell(cell)
	return
end

function TunTianChallengeExtremeStageView:_onClickBtnDetail()
	self._isNeedRuleColShow = not self._isNeedRuleColShow

	self:_updateRuleColVisuable()
end

function TunTianChallengeExtremeStageView:_updateRuleColVisuable()
	GameUtil.SetActive(self._ruleCol, self._isNeedRuleColShow)
end

function TunTianChallengeExtremeStageView:_onClickBtnTip()
	local key = TunTianChallengeConfig.instance:getTtClientCommonValue(self._activityId, "TUNTIAN_EXTREME_RULE_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

return TunTianChallengeExtremeStageView
