-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/view/DivineKingDragonChallengeStageView.lua

module("logic.extensions.divinekingdragonchallenge.view.DivineKingDragonChallengeStageView", package.seeall)

local DivineKingDragonChallengeStageView = class("DivineKingDragonChallengeStageView", ViewComponent)

function DivineKingDragonChallengeStageView:buildUI()
	DivineKingDragonChallengeStageView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._stageCol = goutil.findChild(self.mainGO, "stageCol")
	self._stageView = goutil.findChild(self.mainGO, "stageCol/stageView")
	self._stageCell = goutil.findChild(self.mainGO, "stageCol/stageCell")

	GameUtil.SetActive(self._stageCell, false)

	self._prizeEffs = {}
end

function DivineKingDragonChallengeStageView:bindEvents()
	DivineKingDragonChallengeStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function DivineKingDragonChallengeStageView:unbindEvents()
	DivineKingDragonChallengeStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineKingDragonChallengeStageView:onEnter()
	DivineKingDragonChallengeStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = DivineKingDragonChallengeController.instance:getActivityId()
	end

	self._activityType = DivineKingDragonChallengeController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local isInTime = DivineKingDragonChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._divineKingDragonMo = DivineKingDragonChallengeController.instance:getDivineKingDragonMo(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.DivineKingDragonGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.DivineKingDragonGainPrizeRes, self._onUpdate, self)
end

function DivineKingDragonChallengeStageView:onExit()
	DivineKingDragonChallengeStageView.super.onExit(self)
	self:_onClearStageCol()
end

function DivineKingDragonChallengeStageView:_onSetUI()
	return
end

function DivineKingDragonChallengeStageView:_onUpdate()
	self:_onUpdateStageColUI()
end

function DivineKingDragonChallengeStageView:_onUpdateStageColUI()
	local parentTran = self._stageView.transform
	local childGo = self._stageCell
	local cfg = DivineKingDragonChallengeConfig.instance:getDkdStageDataList(self._activityId)
	local childCount = #cfg
	local children = GameUtil.getChildren(parentTran)

	for index, mainGo in ipairs(children) do
		GameUtil.SetActive(mainGo, index <= childCount)
	end

	for index, data in ipairs(cfg) do
		local mainGo = children[index]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, index))
		end

		GameUtil.SetActive(mainGo, true)
		self:_updateStageCell(mainGo, data.stageId, index)
	end
end

function DivineKingDragonChallengeStageView:_onClearStageCol()
	local children = GameUtil.getChildren(self._stageView.transform)

	for index, mainGo in ipairs(children) do
		self:_clearStageCell(mainGo)
	end
end

function DivineKingDragonChallengeStageView:_updateStageCell(mainGo, stageId, index)
	local stageData = DivineKingDragonChallengeConfig.instance:getDkdStageData(self._activityId, stageId)
	local isCanGain = self._divineKingDragonMo:isCanGainPrizeOfStage(stageId)
	local isHasGain = self._divineKingDragonMo:isHasGainPrizeOfStage(stageId)
	local imgBg = goutil.findChild(mainGo, "imgBg")
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local txtLevel_txt = goutil.findChildTextComponent(mainGo, "txtLevel/txt")
	local btnEnter = goutil.findChild(mainGo, "btnEnter")
	local btnEnter_redPoint = goutil.findChild(mainGo, "btnEnter/redPoint")
	local item = goutil.findChild(mainGo, "item")
	local btnGain = goutil.findChild(mainGo, "btnGain")
	local imgReceived = goutil.findChild(mainGo, "imgReceived")

	if not self._isAoqiGodProcessType then
		MaterialMgr.setCellByCfg(stageData.prize, item)
	end

	GameUtil.SetActive(btnGain, isCanGain and not self._isAoqiGodProcessType)
	GameUtil.SetActive(imgReceived, isHasGain and not self._isAoqiGodProcessType)

	local effParent = item
	local pathName = "fx_ui_juqingfuben/fx_ui_juqingfuben02"

	UIEffectManager.instance:stopEffect(self._prizeEffs[mainGo])

	if isCanGain and not goutil.isNil(effParent) and not string.nilorempty(pathName) and not self._isAoqiGodProcessType then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._prizeEffs[mainGo] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end

	GameUtil.addClickHandler(btnEnter, GameUtil.handler(self._onClickStageCell, self, stageId))
	GameUtil.addClickHandler(btnGain, GameUtil.handler(self._onClickStageCellBtnGain, self, stageId))
end

function DivineKingDragonChallengeStageView:_clearStageCell(mainGo)
	local imgBg = goutil.findChild(mainGo, "imgBg")
	local item = goutil.findChild(mainGo, "item")
	local btnEnter = goutil.findChild(mainGo, "btnEnter")
	local btnGain = goutil.findChild(mainGo, "btnGain")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnEnter)
	GameUtil.rmClickHandler(btnGain)
	UIEffectManager.instance:stopEffect(self._prizeEffs[mainGo])

	self._prizeEffs[mainGo] = nil
end

function DivineKingDragonChallengeStageView:_onClickStageCell(stageId)
	local result, tips = self._divineKingDragonMo:getTryEnterStageOfResultAndTips(self._activityId, stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if self._isAoqiGodProcessType then
		local pass = DivineKingDragonChallengeController.instance:hasPassChallenge(self._activityId)

		if pass then
			AoqiGodController.instance:doHandleChallengeFinishReady(self._activityType, self._activityId)
		end
	end

	UIStateManager.instance:push(ViewName.DivineKingDragonChallengeStageTeamView, self._activityId, stageId)
end

function DivineKingDragonChallengeStageView:_onClickStageCellBtnGain(stageId)
	local result, tips = self._divineKingDragonMo:getTryGainPrizeInStageOfResultAndTips(self._activityId, stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	DivineKingDragonChallengeController.instance:sendPM_DivineKingDragonGainPrizeReq(self._activityId, stageId)
end

function DivineKingDragonChallengeStageView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function DivineKingDragonChallengeStageView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function DivineKingDragonChallengeStageView:_onClickBtnTip()
	local key = DivineKingDragonChallengeConfig.instance:getDkdCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

return DivineKingDragonChallengeStageView
