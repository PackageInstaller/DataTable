-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/view/TunTianChallengeExtremeView.lua

module("logic.extensions.tuntianchallenge.view.TunTianChallengeExtremeView", package.seeall)

local TunTianChallengeExtremeView = class("TunTianChallengeExtremeView", ViewComponent)

function TunTianChallengeExtremeView:buildUI()
	TunTianChallengeExtremeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._partCol = goutil.findChild(self.mainGO, "partCol")
	self._partView = goutil.findChild(self.mainGO, "partCol/partView")
	self._partCell = goutil.findChild(self.mainGO, "partCol/partCell")

	GameUtil.SetActive(self._partCell, false)

	self._prizeCell = {}

	local mainGo = goutil.findChild(self.mainGO, "prizecell")

	self._prizeCell._mainGo = mainGo
	self._prizeCell._item = goutil.findChild(mainGo, "item")
	self._prizeCell._effParent = goutil.findChild(mainGo, "effParent")
	self._prizeCell._received = goutil.findChild(mainGo, "received")
	self._prizeCell._btnGet = goutil.findChild(mainGo, "btnGet")
end

function TunTianChallengeExtremeView:bindEvents()
	TunTianChallengeExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._prizeCell._btnGet, self._onClickBtnPrizeGet, self)
end

function TunTianChallengeExtremeView:unbindEvents()
	TunTianChallengeExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._prizeCell._btnGet)
end

function TunTianChallengeExtremeView:onEnter()
	TunTianChallengeExtremeView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityType = TunTianChallengeController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local isInTime = TunTianChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._baseData = TunTianChallengeConfig.instance:getTtBaseData(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.TunTianClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TunTianGainExtremeClgPrizeRes, self._onUpdate, self)
	self:_sendInfoReq()
end

function TunTianChallengeExtremeView:onExit()
	TunTianChallengeExtremeView.super.onExit(self)
	self:_onClearPartCol()
	self:_onClearPrizeCell()
end

function TunTianChallengeExtremeView:_sendInfoReq()
	TunTianChallengeController.instance:sendPM_TunTianClgGetInfoReq(self._activityId)
end

function TunTianChallengeExtremeView:_onSetUI()
	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end
end

function TunTianChallengeExtremeView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TunTianChallengeExtremeView:_onUpdateData()
	return
end

function TunTianChallengeExtremeView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePartColUI()
	self:_onUpdatePrizeCell()
end

function TunTianChallengeExtremeView:_onUpdatePlaneUI()
	return
end

function TunTianChallengeExtremeView:_onUpdatePartColUI()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)
	local dataList = TunTianChallengeConfig.instance:getTtExtStageTypeDataList(self._activityId)

	for idx, data in ipairs(dataList) do
		local mainGo = children[idx]

		if mainGo == nil then
			printError("缺失预制,请检查预制体")
		else
			self:_updatePartCell(mainGo, data)
		end
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= #dataList)
	end
end

function TunTianChallengeExtremeView:_onClearPartCol()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		GameUtil.rmClickHandler(mainGo)
	end
end

function TunTianChallengeExtremeView:_updatePartCell(mainGo, data)
	local score = TunTianChallengeController.instance:getStageTypeScoreOfExtClg(self._activityId, data.stageType)
	local status = TunTianChallengeController.instance:getStageTypeStatusOfExtClg(self._activityId, data.stageType)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtStatus = goutil.findChildTextComponent(mainGo, "txtStatus")

	txtName.text = string.format("%s：", data.typeName)
	txtScore.text = string.format("%s", score)

	local statusStr, changeIdx, isNeedStatus = "", 0, true

	if status == TunTianChallengeModel.StageTypeStatus.NotPass then
		statusStr = "未通关"
		changeIdx = 0
	elseif status == TunTianChallengeModel.StageTypeStatus.HasPass then
		statusStr = "已通关"
		changeIdx = 1
	else
		statusStr = ""
		isNeedStatus = false
	end

	txtStatus.text = statusStr

	GameUtil.setUITextColorIdx(txtStatus, changeIdx)
	GameUtil.SetActive(txtStatus.gameObject, isNeedStatus)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickPartCell, self, data.stageType))
end

function TunTianChallengeExtremeView:_onClickPartCell(stageType)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.TunTianChallengeExtremeStageView, self._activityId, stageType)
end

function TunTianChallengeExtremeView:_onUpdatePrizeCell()
	MaterialMgr.setCellByCfg(self._baseData.extremeClgPrize, self._prizeCell._item)
	GameUtil.SetActive(self._prizeCell._mainGo, not self._isAoqiGodProcessType)

	local isHasGain = TunTianChallengeController.instance:isHasGainPrizeOfExtClg()
	local isCanGain = TunTianChallengeController.instance:isCanGainPrizeOfExtClg(self._activityId)

	GameUtil.SetActive(self._prizeCell._received, isHasGain)
	GameUtil.SetActive(self._prizeCell._btnGet, isCanGain)

	if isCanGain then
		local effGo = self._prizeCell._effParent

		UIEffectManager.instance:stopEffect(self._prizeEff)

		if effGo then
			local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

			local function func(_, eff)
				eff:setClipping(effGo:GetComponent(goutil.Type_RectTransform))
				eff:setParent(effGo.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1, 1, 1)

				eff.hideEffWhileNotOnTop = true
			end

			self._prizeEff = UIEffectManager.instance:playEffect(self, effPath, effGo, 0, 0, true, false, nil, func, nil)
		end
	else
		UIEffectManager.instance:stopEffect(self._prizeEff)
	end
end

function TunTianChallengeExtremeView:_onClearPrizeCell()
	MaterialMgr.resetAll(self._prizeCell._item)
	UIEffectManager.instance:stopEffect(self._prizeEff)
end

function TunTianChallengeExtremeView:_onClickBtnPrizeGet()
	if self._isAoqiGodProcessType then
		return
	end

	local result, tips = TunTianChallengeController.instance:getTryGetPrizeOfExtClgResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	TunTianChallengeController.instance:sendPM_TunTianGainExtremeClgPrizeReq(self._activityId)
end

function TunTianChallengeExtremeView:_onClickBtnTip()
	local key = TunTianChallengeConfig.instance:getTtClientCommonValue(self._activityId, "TUNTIAN_EXTREME_RULE_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

return TunTianChallengeExtremeView
