-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlemainView.lua

module("logic.extensions.lotusbattle.view.LotusbattlemainView", package.seeall)

local LotusbattlemainView = class("LotusbattlemainView", TableViewComponent)

LotusbattlemainView.PlayModel = {
	Model16 = 16,
	Model100 = 100
}
LotusbattlemainView.NangLockStatus = {
	Unlock = 1,
	Pet = 4,
	Lock = 2,
	Empty = 3
}

function LotusbattlemainView:ctor()
	LotusbattlemainView.super.ctor(self)
end

function LotusbattlemainView:unbindEvents()
	LotusbattlemainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnReport:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnBag:RemoveClickListener()
	self._mode1:RemoveClickListener()
	self._mode2:RemoveClickListener()
end

function LotusbattlemainView:bindEvents()
	LotusbattlemainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnShop:AddClickListener(self._onClickbtnShop, self)
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
	self._btnReport:AddClickListener(self._onClickbtnReport, self)
	self._btnTask:AddClickListener(self._onClickbtnTask, self)
	self._btnBag:AddClickListener(self._onClickbtnBag, self)
	self._mode1:AddClickListener(self._onClickmode1, self)
	self._mode2:AddClickListener(self._onClickmode2, self)
end

function LotusbattlemainView:buildUI()
	LotusbattlemainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnShop = self:getBtn("leftbtns/btnShop")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnReport = self:getBtn("leftbtns/btnReport")
	self._btnTask = self:getBtn("leftbtns/btnTask")
	self._btnBag = self:getBtn("righttop/btnBag")
	self._mode16Go = self:getGo("mode/mode2")
	self._mode100Go = self:getGo("mode/mode1")

	self:_buildMode(1, self._mode100Go)
	self:_buildMode(2, self._mode16Go)

	self._txtLeftTime = self:getTxt("remain/txt")
	self._goldBarGo = self:getGo("goldBar")
	self._effectGo = self:getGo("effect")
	self._effect2Go = self:getGo("effect2")
	self._mode1 = self:getBtn("mode/mode1")
	self._mode2 = self:getBtn("mode/mode2")
	self._redPointBtnTaskGo = self:getGo("leftbtns/btnTask/redPoint")
end

function LotusbattlemainView:_buildMode(mode, root)
	self._modeObjs = self._modeObjs or {}
	self._modeObjs[mode] = {
		onGo = goutil.findChild(root, "on"),
		offGo = goutil.findChild(root, "off"),
		txtOn = goutil.findChildTextComponent(root, "on/Text"),
		txtOff = goutil.findChildTextComponent(root, "off/Text")
	}
end

function LotusbattlemainView:onExit()
	LotusbattlemainView.super.onExit(self)
	GlobalDispatcher:removeListener(LotusBattleFieldAgent.LBFInfoRes, self._updateUI, self)
	GlobalDispatcher:removeListener(LotusBattleFieldAgent.LBFAdjustPackageRes, self._updateUI, self)
	GlobalDispatcher:removeListener(LotusBattleFieldAgent.LBFUnlockPackagePosRes, self._updateNang, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	if self._effectHandler2 then
		UIEffectManager.instance:stopEffect(self._effectHandler2)

		self._effectHandler2 = nil
	end

	RedPointController.instance:unregRedPoint(self._redPointBtnTaskGo)
end

function LotusbattlemainView:onEnter()
	LotusbattlemainView.super.onEnter(self)
	GlobalDispatcher:addListener(LotusBattleFieldAgent.LBFInfoRes, self._updateUI, self)
	GlobalDispatcher:addListener(LotusBattleFieldAgent.LBFAdjustPackageRes, self._updateUI, self)
	GlobalDispatcher:addListener(LotusBattleFieldAgent.LBFUnlockPackagePosRes, self._updateNang, self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.LotusBattle)

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end

	self._currPlayModelId = 0

	self:_setModel()
	self:_updateUI()

	local goldBarStr = LotusbattleConfig.instance:getCommonValue("gold_mainview")

	self:_setTopGoldBar(self._goldBarGo, goldBarStr)
	LotusBattleFieldAgent.instance:sendPM_LBFInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._redPointBtnTaskGo, 487)
	self:_setEffect()
	self:_setEffect2()
end

function LotusbattlemainView:_onClickbtnClose()
	self:close()
end

function LotusbattlemainView:_onClickbtnTip()
	local key = LotusbattleConfig.instance:getCommonValue("rulekey_mainview")

	TipsFacade.instance:openRulesView(key)
end

function LotusbattlemainView:_onClickbtnShop()
	local jumpTo = LotusbattleConfig.instance:getCommonValue("shopJumpTo_mainview")

	GotoMgr.gotoByString(jumpTo)
end

function LotusbattlemainView:_onClickbtnChallenge()
	LotusbattleController.instance:clearDataOnMatch()

	local modelId = LotusbattleController.instance:getModelId(self._activityId)

	if modelId <= 0 then
		FloatWordMgr.instance:show("活动未开放")

		return
	end

	if modelId ~= self._currPlayModelId then
		self:_setModel(true)
	end

	local leftTime = LotusbattleController.instance:getModelDailyChallengeLeftTimes(self._activityId, self._currPlayModelId)

	if leftTime <= 0 then
		FloatWordMgr.instance:show("挑战次数不足")

		return
	end

	LotusbattleController.instance:sendPM_LBFStartMatchReq(self._activityId, self._currPlayModelId)
end

function LotusbattlemainView:_onClickbtnReport()
	UIStateManager.instance:push(ViewName.LotusbattlereportView)
end

function LotusbattlemainView:_onClickbtnTask()
	UIStateManager.instance:push(ViewName.LotusbattletaskView)
end

function LotusbattlemainView:_onClickbtnBag()
	UIStateManager.instance:push(ViewName.LotusbattlespoilsofwarView)
end

function LotusbattlemainView:_onClickmode1()
	local firstId, otherModelId = self:_getModeIds()

	self:_onclickMode(firstId)
end

function LotusbattlemainView:_onClickmode2()
	local firstId, otherModelId = self:_getModeIds()

	self:_onclickMode(otherModelId)
end

function LotusbattlemainView:_onclickMode(modelId)
	local isOpen = LotusbattleController.instance:isModelIdOpen(self._activityId, modelId)

	if not isOpen then
		local cfg = LotusbattleConfig.instance:getModelCfg(self._activityId, modelId)
		local txt = self:_getOpenTimeDesc(cfg.openTime)

		FloatWordMgr.instance:show(txt)

		return
	end

	self._currPlayModelId = modelId

	self:_updateModeUI()
end

function LotusbattlemainView:_getPath()
	return {
		cellPath = "righttop/tablecell",
		viewPath = "righttop/tableview"
	}
end

function LotusbattlemainView:_updateCell(view, cell, data)
	local btnAdd = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnAdd")
	local btnLock = Framework.ButtonAdapter.GetFrom(cell.gameObject, "lock")
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local goLock = goutil.findChild(cell.gameObject, "lock")
	local isEmpty = data.status == LotusbattlemainView.NangLockStatus.Empty
	local isLock = data.status == LotusbattlemainView.NangLockStatus.Lock
	local hasPet = data.status == LotusbattlemainView.NangLockStatus.Pet

	MaterialMgr.resetAll(goItemcon)
	goutil.setActive(goLock, isLock)
	goutil.setActive(goItemcon, not isEmpty)
	goutil.setActive(btnAdd.gameObject, isEmpty)

	if hasPet then
		local creepsCfg = LotusbattleConfig.instance:getCreepsCfg(data.creepId)
		local cfgStr = string.format("%s:%s", MatType.Pet, creepsCfg.raceId)

		MaterialMgr.setCellByCfg(cfgStr, goItemcon)
	end

	btnAdd:AddClickListener(function()
		UIStateManager.instance:push(ViewName.LotusbattlespoilsofwarView)
	end)
	btnLock:AddClickListener(function()
		LotusbattleController.instance:tryUnlockNangGrid()
	end)
end

function LotusbattlemainView:_clearTableview(cell)
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")

	MaterialMgr.resetAll(goItemcon)
end

function LotusbattlemainView:_updateUI()
	self:_updateNang()
	self:_updateChallengeTimes()
end

function LotusbattlemainView:_updateNang()
	self._curViewDatas = LotusbattleModel.instance:getNangSlotDatas()

	self:reloadData()
end

function LotusbattlemainView:_updateChallengeTimes()
	if not self._currPlayModelId or self._currPlayModelId <= 0 then
		self._txtLeftTime.text = "活动未开放"

		return
	end

	local useTime = LotusbattleModel.instance:getTodayChallengeTimes(self._currPlayModelId)
	local totalTime = LotusbattleConfig.instance:getModelDailyTimes(self._activityId, self._currPlayModelId)
	local leftTime = totalTime - useTime

	self._txtLeftTime.text = string.format("<color=#ffa251>%s</color>/%s", leftTime, totalTime)
end

function LotusbattlemainView:_setModel(force)
	if self._currPlayModelId > 0 and not force then
		return
	end

	self._currPlayModelId = LotusbattleController.instance:getModelId(self._activityId)

	printInfo("输出一下模式Id：", self._currPlayModelId)
	self:_updateModeUI()
end

function LotusbattlemainView:_updateModeUI()
	LotusbattleModel.instance:setModelId(self._currPlayModelId)

	local firstId, otherModelId = self:_getModeIds()

	self:_setModelDetail(self._modeObjs[1], firstId)
	self:_setModelDetail(self._modeObjs[2], otherModelId)
end

function LotusbattlemainView:_setModelDetail(modelObj, modelId)
	local modelCfg = LotusbattleConfig.instance:getModelCfg(self._activityId, modelId)
	local isOpen = LotusbattleController.instance:isModelIdOpen(self._activityId, modelId)

	modelObj.txtOff.text = string.format("%s人战斗模式", modelCfg.memberNum)
	modelObj.txtOn.text = string.format("%s人战斗模式", modelCfg.memberNum)

	goutil.setActive(modelObj.onGo, isOpen)
	goutil.setActive(modelObj.offGo, not isOpen)
end

function LotusbattlemainView:_setEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_zhuzhanchang.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function LotusbattlemainView:_setEffect2()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_zhuzhanchang_duizhan.prefab"

	self._effectHandler2 = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler2:setParent(self._effect2Go.transform)
	self._effectHandler2:setLocalPos(0, 0, 0)
	self._effectHandler2:setScale(1)
end

function LotusbattlemainView:_getOpenTimeDesc(openTime)
	local txt = string.gsub(openTime, "#", "至")

	return (string.format("%s开放玩法", txt))
end

function LotusbattlemainView:_getModeIds()
	if self._currPlayModelId == 0 then
		return 1, 2
	end

	return self._currPlayModelId, self._currPlayModelId % 2 + 1
end

return LotusbattlemainView
