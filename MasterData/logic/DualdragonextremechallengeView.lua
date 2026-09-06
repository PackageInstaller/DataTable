-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualdragonchallenge/view/DualdragonextremechallengeView.lua

module("logic.extensions.dualdragonchallenge.view.DualdragonextremechallengeView", package.seeall)

local DualdragonextremechallengeView = class("DualdragonextremechallengeView", ViewComponent)

function DualdragonextremechallengeView:ctor()
	DualdragonextremechallengeView.super.ctor(self)

	self._cellNums = 4
end

function DualdragonextremechallengeView:unbindEvents()
	DualdragonextremechallengeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function DualdragonextremechallengeView:bindEvents()
	DualdragonextremechallengeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function DualdragonextremechallengeView:buildUI()
	DualdragonextremechallengeView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._openTime = self:getGo("openTime")
	self._txtTime = self:getTxt("openTime/txtTime")
	self._btnSure = self:getBtn("btnSure")
	self._rightconGo = self:getGo("rightcon")
	self._leftconGo = self:getGo("leftcon")
	self._leftRecordPos = self:getGo("leftcon/leftTransform"):GetComponent(typeof(TestRecordPos))
	self._rightRecordPos = self:getGo("rightcon/rightTransform"):GetComponent(typeof(TestRecordPos))
	self._cell_1Go_right = self:getGo("rightcon/cell_1")
	self._cell_1Go_left = self:getGo("leftcon/cell_1")
	self._leftTransformGo = self:getGo("leftcon/leftTransform")
	self._rightTransformGo = self:getGo("rightcon/rightTransform")
	self._leftItemGroup = ItemGroup.New(self._leftTransformGo, self._cell_1Go_left, nil, nil, true, self._disposeItem, self)
	self._rightItemGroup = ItemGroup.New(self._rightTransformGo, self._cell_1Go_right, nil, nil, true, self._disposeItem, self)
	self._txtLevelLeft = self:getTxt("leftcon/level/txtLevel")
	self._txtLevelRight = self:getTxt("rightcon/level/txtLevel")
	self._txtBtnSure = self:getTxt("btnSure/txt")

	self:_recordGoDefaultActive(self._btnSure)
	self:_recordGoDefaultActive(self._openTime)
end

function DualdragonextremechallengeView:onExit()
	DualdragonextremechallengeView.super.onExit(self)
	GlobalDispatcher:removeListener(DualDragonChallengeAgent.DualDragonResetExtreme, self._updateUI, self)
	GlobalDispatcher:removeListener(DualDragonChallengeAgent.DualDragonChallengeGetInfoRes, self._updateUI, self)
	GlobalDispatcher:removeListener(DualDragonChallengeAgent.DualDragonGainPrizeExtreme, self._updateUI, self)
end

function DualdragonextremechallengeView:onEnter()
	DualdragonextremechallengeView.super.onEnter(self)
	GlobalDispatcher:addListener(DualDragonChallengeAgent.DualDragonResetExtreme, self._updateUI, self)
	GlobalDispatcher:addListener(DualDragonChallengeAgent.DualDragonChallengeGetInfoRes, self._updateUI, self)
	GlobalDispatcher:addListener(DualDragonChallengeAgent.DualDragonGainPrizeExtreme, self._updateUI, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	DualDragonChallengeAgent.instance:sendPM_DualDragonChallengeGetInfoReq(self._activityId)
	self:_setActTime()
	self:_updateUI()
end

function DualdragonextremechallengeView:_onClickbtnClose()
	self:close()
end

function DualdragonextremechallengeView:_onClickbtnTip()
	local actData = DualdragonchallengeConfig.instance:getActData(self._activityId)

	TipsFacade.instance:openRulesView(actData.ruleKeyExtreme)
end

function DualdragonextremechallengeView:_onClickbtnSure()
	local isAllPass = DualdragonchallengeModel.instance:isAllExtremePass()

	if not isAllPass then
		FloatWordMgr.instance:show("需要完成全部关卡才可以领取奖励")

		return
	end

	local isGain = DualdragonchallengeModel.instance:isGainExtremePrize()

	if isGain then
		FloatWordMgr.instance:show("奖励已领取")

		return
	end

	DualDragonChallengeAgent.instance:sendPM_DualDragonGainPrizeExtremeReq(self._activityId)
end

function DualdragonextremechallengeView:_setActTime()
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.DualDragon, self._activityId)
end

function DualdragonextremechallengeView:_updateUI()
	self._currExtremeIndex = DualdragonchallengeModel.instance:getCurrExtremeIndex()
	self._isExtremeChallenge = self._currExtremeIndex > 0

	local stageCfgs = DualdragonchallengeConfig.instance:getstageCfgs(self._activityId)

	self._leftItemGroup:updateWithMoArray(stageCfgs[1], function(item, stageCfg)
		self:_updateCell(item, stageCfg)
	end)
	self._rightItemGroup:updateWithMoArray(stageCfgs[2], function(item, stageCfg)
		self:_updateCell(item, stageCfg)
	end)
	self._leftRecordPos:LoadPlan(0)
	self._rightRecordPos:LoadPlan(0)
	self:_setPassNum()

	local isAllPass = DualdragonchallengeModel.instance:isAllExtremePass()
	local isGain = DualdragonchallengeModel.instance:isGainExtremePrize()

	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._btnSure, false)
		GameUtil.SetActive(self._openTime, false)
	else
		goutil.setActive(self._btnSure.gameObject, isAllPass)
		GameUtil.SetGray(self._btnSure.gameObject, isGain)
		self:_refreshDefaultActive(self._openTime)
	end

	self._txtBtnSure.text = isGain and "已领取" or "领取奖励"
end

function DualdragonextremechallengeView:_updateCell(item, stageCfg)
	local btnChallenge = Framework.ButtonAdapter.GetFrom(item.mainGO, "btnChallenge")
	local btnReset = Framework.ButtonAdapter.GetFrom(item.mainGO, "btnReset")
	local btnLock = Framework.ButtonAdapter.GetFrom(item.mainGO, "lock")
	local goLock = goutil.findChild(item.mainGO, "lock")
	local goPass = goutil.findChild(item.mainGO, "pass")
	local txtDesc_1 = goutil.findChildTextComponent(item.mainGO, "buff/txtDesc_1")
	local txtDesc_2 = goutil.findChildTextComponent(item.mainGO, "buff/txtDesc_2")
	local buffGo = goutil.findChild(item.mainGO, "buff")
	local txtName = goutil.findChildTextComponent(item.mainGO, "txtName")
	local txtLock = goutil.findChildTextComponent(item.mainGO, "txtLock")
	local isPass = DualdragonchallengeModel.instance:isStagePass(stageCfg.groupId, stageCfg.stageId)
	local isChallengeStage = self._currExtremeIndex == stageCfg.stageId

	txtName.text = stageCfg.name
	txtLock.text = "通过关联关卡后激活效果"

	goutil.setActive(btnReset.gameObject, isPass)
	goutil.setActive(btnChallenge.gameObject, isPass or isChallengeStage)
	goutil.setActive(goLock, not isPass and not isChallengeStage)
	goutil.setActive(txtLock.gameObject, not isPass and not isChallengeStage or isPass and isChallengeStage)
	goutil.setActive(buffGo, isPass and not isChallengeStage or not isPass and isChallengeStage)
	goutil.setActive(goPass, isPass)
	goutil.setActive(txtName.gameObject, isPass or isChallengeStage)

	local buff = DualdragonchallengeConfig.instance:getBuffCfg(stageCfg.buffId)
	local debuff = DualdragonchallengeConfig.instance:getBuffCfg(stageCfg.debuffId)

	txtDesc_1.text = buff.des
	txtDesc_2.text = debuff.des

	btnChallenge:AddClickListener(function()
		if not isUnLock and not isChallengeStage then
			FloatWordMgr.instance:show("当前不可挑战")

			return
		end

		if isPass then
			FloatWordMgr.instance:show("关卡已通过")

			return
		end

		DualdragonchallengeController.instance:enterExtremeMission(self._activityId, stageCfg.groupId, stageCfg.stageId)
	end)
	btnReset:AddClickListener(function()
		local isAllPass = DualdragonchallengeModel.instance:isAllExtremePass()

		if isAllPass then
			FloatWordMgr.instance:show("已完成全部关卡")

			return
		end

		local function okFunc()
			DualdragonchallengeController.instance:sendPM_DualDragonResetExtremeReq(self._activityId, stageCfg.groupId, stageCfg.stageId)
		end

		local text = "重置关卡的同时，会将关联关卡的效果一并重置为未激活状态，是否确认重置？"

		TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
	end)
	btnLock:AddClickListener(function()
		if not isUnLock and self._currExtremeIndex > 0 then
			FloatWordMgr.instance:show("当前不可挑战")

			return
		end

		DualdragonchallengeController.instance:enterExtremeMission(self._activityId, stageCfg.groupId, stageCfg.stageId)
	end)
end

function DualdragonextremechallengeView:_disposeItem(item)
	return
end

function DualdragonextremechallengeView:_setPassNum()
	local stageCfgs = DualdragonchallengeConfig.instance:getstageCfgs(self._activityId)
	local totalNum = #stageCfgs[1]
	local passNum = DualdragonchallengeModel.instance:getGroup1PassNum()
	local perStr = DualdragonchallengeConfig.instance:getClientValue("extremeLeftPre")

	self._txtLevelLeft.text = string.format("%s：%s/%s", perStr, passNum, totalNum)
	passNum = DualdragonchallengeModel.instance:getGroup2PassNum()
	perStr = DualdragonchallengeConfig.instance:getClientValue("extremeRightPre")
	self._txtLevelRight.text = string.format("%s：%s/%s", perStr, passNum, totalNum)
end

function DualdragonextremechallengeView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function DualdragonextremechallengeView:_refreshDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}

	GameUtil.SetActive(go, checkbool(self._goDefaultActives[go]))
end

return DualdragonextremechallengeView
