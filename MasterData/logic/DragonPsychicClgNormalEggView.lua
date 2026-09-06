-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgNormalEggView.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgNormalEggView", package.seeall)

local DragonPsychicClgNormalEggView = class("DragonPsychicClgNormalEggView", ViewComponent)

function DragonPsychicClgNormalEggView:ctor()
	DragonPsychicClgNormalEggView.super.ctor(self)

	self._effPool = {}
end

function DragonPsychicClgNormalEggView:buildUI()
	DragonPsychicClgNormalEggView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._imgEgg = goutil.findChild(self.mainGO, "imgEgg")
	self._btnShop = goutil.findChild(self.mainGO, "btnShop")
	self._btnTask = goutil.findChild(self.mainGO, "btnTask")
	self._btnGet = goutil.findChild(self.mainGO, "btnGet")
	self._redBtnGet = goutil.findChild(self.mainGO, "btnGet/red")
	self._btnSpeedUp = goutil.findChild(self.mainGO, "btnSpeedUp")
	self._imgBtnSpeedUp = goutil.findChild(self.mainGO, "btnSpeedUp/img")
	self._txtBtnSpeedUp = goutil.findChildTextComponent(self.mainGO, "btnSpeedUp/txt")
	self._leftTime = goutil.findChild(self.mainGO, "leftTime")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "leftTime/txt")
	self._speedEffRoot = goutil.findChild(self.mainGO, "speedEffRoot")
	self._eggEffRoot = goutil.findChild(self.mainGO, "eggEffRoot")
end

function DragonPsychicClgNormalEggView:bindEvents()
	DragonPsychicClgNormalEggView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickBtnGet, self)
	GameUtil.addClickHandler(self._btnSpeedUp, self._onClickBtnSpeedUp, self)
end

function DragonPsychicClgNormalEggView:unbindEvents()
	DragonPsychicClgNormalEggView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnSpeedUp)
end

function DragonPsychicClgNormalEggView:onEnter()
	DragonPsychicClgNormalEggView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = DragonPsychicClgController.instance:getActivityType()

	local isInTime = DragonPsychicClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = DragonPsychicClgConfig.instance:getDpcData(self._activityId)
	self._finishTime = 0

	self.addGEvent(self, GlobalNotify.handlePM_DPClgGetUniversalInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DPClgHatchRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DPClgDecHatchTimeRes, self._handlePM_DPClgDecHatchTimeRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_DPClgGainHatchPetRes, self._handlePM_DPClgGainHatchPetRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_DPClgSelectPetRes, self._onUpdate, self)

	local matStr = self._actData.decHatchTimeCost

	if not string.nilorempty(matStr) then
		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

		MaterialMgr.setIcon(self._imgBtnSpeedUp, matType, matId, nil, nil)
	else
		MaterialMgr.clearIcon(self._imgBtnSpeedUp)
	end

	self:_onUpdate()
	RedPointController.instance:regRedPoint(self._redBtnGet, RedPointModel.ID_DRAGONPSYCHICCLG_EGG)
end

function DragonPsychicClgNormalEggView:onExit()
	DragonPsychicClgNormalEggView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnGet)
	MaterialMgr.resetAll(self._imgBtnSpeedUp)
	self:_clearEffPool()
	self:_onClear()
end

function DragonPsychicClgNormalEggView:_handlePM_DPClgDecHatchTimeRes(msg)
	self:_playSpeedAnim()
end

function DragonPsychicClgNormalEggView:_handlePM_DPClgGainHatchPetRes(msg)
	self:_onUpdate()
	UIStateManager.instance:push(ViewName.DragonPsychicClgNormalEggSuccessView, msg.activityId, msg.creepsId)
end

function DragonPsychicClgNormalEggView:_onUpdate()
	local hatchState = DragonPsychicClgController.instance:getHatchStateOfNor(self._activityId)

	if hatchState == DragonPsychicClgEnum.HatchState_Doing then
		self:_showEggTimer()
	else
		self:_stopEggTimer()
	end

	if hatchState == DragonPsychicClgEnum.HatchState_Finish then
		self:_playEggFinishAnim()
	else
		self:_stopEggFinishAnim()
	end

	GameUtil.SetActive(self._btnShop, hatchState == DragonPsychicClgEnum.HatchState_Null)
	GameUtil.SetActive(self._btnTask, hatchState == DragonPsychicClgEnum.HatchState_Doing)
	GameUtil.SetActive(self._btnGet, hatchState == DragonPsychicClgEnum.HatchState_Finish)

	local leftSpeedTimes = DragonPsychicClgController.instance:getLeftSpeedTimesOfNor(self._activityId)

	if hatchState == DragonPsychicClgEnum.HatchState_Doing and leftSpeedTimes > 0 then
		self._txtBtnSpeedUp.text = string.format("x%s", leftSpeedTimes)

		GameUtil.SetActive(self._btnSpeedUp, true)
	else
		GameUtil.SetActive(self._btnSpeedUp, false)
	end
end

function DragonPsychicClgNormalEggView:_onClear()
	self:_stopEggTimer()
end

function DragonPsychicClgNormalEggView:_showEggTimer()
	self._deltaTime = 1
	self._finishTime = DragonPsychicClgController.instance:getFinishTimeInHatchOfNor(self._activityId)
	self._finishTime = Mathf.Round(self._finishTime / 1000)
	self._hatchTime = self._actData.hatchTime
	self._curLeftFinishRate = 1
	self._eggEggStates = DragonPsychicClgConfig.instance:getCommonValue(self._activityId, "eggEggStates") or {}
	self._curEggState = self._curEggState or 0

	self:_ticking()
	settimer(self._deltaTime, self._ticking, self)
	GameUtil.SetActive(self._leftTime, true)
end

function DragonPsychicClgNormalEggView:_stopEggTimer()
	GameUtil.SetActive(self._leftTime, false)
	removetimer(self._ticking, self)

	self._curEggState = 0

	self:_stopEggingEff()
end

function DragonPsychicClgNormalEggView:_ticking()
	self._inTime = Mathf.Max(self._finishTime - ServerTime.now(), 0)
	self._curLeftFinishRate = self._inTime / self._hatchTime
	self._stateTemp = 0

	for state, rate in ipairs(self._eggEggStates) do
		if rate >= self._curLeftFinishRate then
			self._stateTemp = state
		else
			break
		end
	end

	if self._stateTemp ~= self._curEggState then
		self._curEggState = self._stateTemp

		self:_playEggingEff(self._curEggState)
	end

	if self._inTime <= 0 then
		self:_stopEggTimer()
		self:_onUpdate()

		return
	end

	local hour, min, sec = GameUtil.getTimeHHMMSS(self._inTime)

	self._txtLeftTime.text = hour > 0 and string.format("%02d:%02d:%02d", hour, min, sec) or string.format("%02d:%02d", min, sec)
end

function DragonPsychicClgNormalEggView:_playSpeedAnim()
	local mainGo = self._speedEffRoot
	local pathName = "20240403/28_longdan/fx_ui_dianji"
	local key = pathName

	self:_playEff(key, mainGo, pathName, false, function()
		FloatWordMgr.instance:show(string.format("已加速%s秒", self._actData.decHatchTime))
		self:_onUpdate()
	end)
end

function DragonPsychicClgNormalEggView:_playEggingEff(state)
	local mainGo = self._eggEffRoot
	local names = DragonPsychicClgConfig.instance:getCommonValue(self._activityId, "eggEggEffPathNames")
	local pathName

	self:_playEff("eggEff", mainGo, (names or nil) and names[state], true)
end

function DragonPsychicClgNormalEggView:_stopEggingEff()
	self:_stopEff("eggEff")
end

function DragonPsychicClgNormalEggView:_playEggFinishAnim()
	local mainGo = self._eggEffRoot
	local pathName = DragonPsychicClgConfig.instance:getCommonValue(self._activityId, "eggFinishEff")

	self:_playEff("eggFinish", mainGo, pathName, true)
end

function DragonPsychicClgNormalEggView:_stopEggFinishAnim()
	self:_stopEff("eggFinish")
end

function DragonPsychicClgNormalEggView:_playEff(key, mainGo, pathName, isLoop, finishHandler)
	local effParent = mainGo

	UIEffectManager.instance:stopEffect(self._effPool[key])

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._effPool[key] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, isLoop, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function DragonPsychicClgNormalEggView:_stopEff(key)
	UIEffectManager.instance:stopEffect(self._effPool[key])
end

function DragonPsychicClgNormalEggView:_clearEffPool()
	for key, eff in pairs(self._effPool) do
		self:_stopEff(key)
	end
end

function DragonPsychicClgNormalEggView:_onClickBtnShop()
	local hatchState = DragonPsychicClgController.instance:getHatchStateOfNor(self._activityId)

	if hatchState ~= DragonPsychicClgEnum.HatchState_Null then
		return
	end

	UIStateManager.instance:push(ViewName.DragonPsychicClgNormalEggShopView, self._activityId)
end

function DragonPsychicClgNormalEggView:_onClickBtnTask()
	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		self:close()
	end

	UIStateManager.instance:push(ViewName.DragonPsychicClgNorTaskFrameView, self._actData.taskActivityId)
end

function DragonPsychicClgNormalEggView:_onClickBtnGet()
	local hatchState = DragonPsychicClgController.instance:getHatchStateOfNor(self._activityId)

	if hatchState ~= DragonPsychicClgEnum.HatchState_Finish then
		return
	end

	DragonPsychicClgController.instance:sendPM_DPClgGainHatchPetReq(self._activityId)
end

function DragonPsychicClgNormalEggView:_onClickBtnSpeedUp()
	local hatchState = DragonPsychicClgController.instance:getHatchStateOfNor(self._activityId)

	if hatchState ~= DragonPsychicClgEnum.HatchState_Doing then
		FloatWordMgr.instance:show("没有可加速的对象")

		return
	end

	local leftSpeedTimes = DragonPsychicClgController.instance:getLeftSpeedTimesOfNor(self._activityId)

	if leftSpeedTimes <= 0 then
		FloatWordMgr.instance:show("剩余加速次数不足")

		return
	end

	local function okFunc()
		self:_onUpdate()
		DragonPsychicClgController.instance:sendPM_DPClgDecHatchTimeReq(self._activityId, 1)
	end

	local decHatchTime = self._actData.decHatchTime
	local leftTime = Mathf.Max(self._finishTime - ServerTime.now(), 0)

	if leftTime - decHatchTime <= 0 then
		local hour, min, sec = GameUtil.getTimeHHMMSS(decHatchTime)
		local tipsContent = string.format("当前剩余时间少于道具加速（加速%smin)的时间 是否确认使用？", min)

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
	else
		okFunc()
	end
end

return DragonPsychicClgNormalEggView
