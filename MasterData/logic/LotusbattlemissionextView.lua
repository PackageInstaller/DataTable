-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlemissionextView.lua

module("logic.extensions.lotusbattle.view.LotusbattlemissionextView", package.seeall)

local LotusbattlemissionextView = class("LotusbattlemissionextView", ViewComponent)

function LotusbattlemissionextView:ctor()
	LotusbattlemissionextView.super.ctor(self)
end

function LotusbattlemissionextView:unbindEvents()
	LotusbattlemissionextView.super.unbindEvents(self)
	self._btnStart:RemoveClickListener()
end

function LotusbattlemissionextView:bindEvents()
	LotusbattlemissionextView.super.bindEvents(self)
	self._btnStart:AddClickListener(self._onClickbtnStart, self)
end

function LotusbattlemissionextView:buildUI()
	LotusbattlemissionextView.super.buildUI(self)

	self._txtStage = self:getTxt("stageNum/txt")
	self._txtClockTime = self:getTxt("periodInfo/clock/txtClockTime")
	self._btnStart = self:getBtn("btnStart")
	self._petBagmaskGo = self:getGo("petBagmask")
	self._rbuffScrollercellGo = self:getGo("rightCpCol/rbuffScrollercell")
	self._lbuffScrollercellGo = self:getGo("leftCpCol/lbuffScrollercell")
	self._txtDesc = self:getTxt("topDesc/txtDesc")
	self._lbuffScrollercellGo = self:getGo("leftCpCol/lbuffScrollercell")
	self._rbuffScrollercellGo = self:getGo("rightCpCol/rbuffScrollercell")
	self._myBuff = self:_buildBuffIcon(self._lbuffScrollercellGo)
	self._opBuff = self:_buildBuffIcon(self._rbuffScrollercellGo)
	self._timeEffectGo = self:getGo("periodInfo/effect")
	self._effect2Go = self:getGo("effect2")
	self._effect1Go = self:getGo("effect1")
end

function LotusbattlemissionextView:_buildBuffIcon(cell)
	local temp = {
		mainGO = cell,
		goIcon = goutil.findChild(cell.gameObject, "icon"),
		txtBubble = goutil.findChildTextComponent(cell.gameObject, "bubble/txt"),
		txtName = goutil.findChildTextComponent(cell.gameObject, "name/txt")
	}

	goutil.setActive(cell, false)

	return temp
end

function LotusbattlemissionextView:onExit()
	LotusbattlemissionextView.super.onExit(self)
	removetimer(self._tick, self)
	GlobalDispatcher:removeListener(LotusBattleFieldAgent.LBFNotifyEnterNextSetFormationRes, self._LBFNotifyEnterNextSetFormationRes, self)
	GlobalDispatcher:removeListener(LotusBattleFieldAgent.SetFormError, self._SetFormError, self)
	GlobalDispatcher:removeListener(LotusBattleFieldAgent.LBFNotifyEnterSelectBuffRes, self._UpdateExtForm, self)
	GlobalDispatcher:removeListener(LotusBattleFieldAgent.SetFormSuccessed, self._setFormSuccessed, self)
	GlobalDispatcher:removeListener(LotusbattleController.EnterShowFormationTime, self._onEnterShowFormationTime, self)

	if self._timeeffectHandler then
		UIEffectManager.instance:stopEffect(self._timeeffectHandler)

		self._timeeffectHandler = nil
	end

	for k, v in pairs(self._uiEffectHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._uiEffectHandlers = {}
end

function LotusbattlemissionextView:onEnter()
	LotusbattlemissionextView.super.onEnter(self)
	GlobalDispatcher:addListener(LotusBattleFieldAgent.LBFNotifyEnterNextSetFormationRes, self._LBFNotifyEnterNextSetFormationRes, self)
	GlobalDispatcher:addListener(LotusBattleFieldAgent.SetFormError, self._SetFormError, self)
	GlobalDispatcher:addListener(LotusBattleFieldAgent.LBFNotifyEnterSelectBuffRes, self._UpdateExtForm, self)
	GlobalDispatcher:addListener(LotusBattleFieldAgent.SetFormSuccessed, self._setFormSuccessed, self)
	GlobalDispatcher:addListener(LotusbattleController.EnterShowFormationTime, self._onEnterShowFormationTime, self)

	self._activityId = LotusbattleModel.instance:getActivityId()
	self._modelId = LotusbattleModel.instance:getModelId()
	self._modelCfg = LotusbattleConfig.instance:getModelCfg(self._activityId, self._modelId)
	self._customFmtMo = self:getFirstParam()
	self._stepType = GameEnum.LotusBattleMissionStep.One
	self._isCanSetForm = true
	self._actCfg = LotusbattleConfig.instance:getActCfg(self._activityId)
	self._uiEffectHandlers = {}

	self:_setTargetTickTime()
	self:_updateUI()
	self:_updateFmt()
	self:_startTimer()
	self:_setTimeEffect()
	self:_loadBuffEffects()
end

function LotusbattlemissionextView:_onClickbtnStart()
	if not self._isCanSetForm then
		FloatWordMgr.instance:show("您已确认布阵 无法调整")

		return
	end

	if ServerTime.now() > self._targetTickTime then
		FloatWordMgr.instance:show("您已确认布阵 无法调整")

		return
	end

	local isEmpty = self._customFmtMo:getCurFormation():isEmpty()

	if isEmpty then
		FloatWordMgr.instance:show("布阵至少上阵一只精灵")

		return
	end

	if self:_isFirstStep() then
		LotusBattleFieldAgent.instance:sendPM_LBFSetFirstStepFormationReq(self._customFmtMo:getCurFormation():createFormPb())
	else
		LotusBattleFieldAgent.instance:sendPM_LBFSetSecondStepFormationReq(self._customFmtMo:getCurFormation():createFormPb())
	end

	self._isCanSetForm = false

	GameUtil.SetGray(self._btnStart.gameObject, not self._isCanSetForm)
end

function LotusbattlemissionextView:_updateBuffCell(view, cell, data, tag)
	return
end

function LotusbattlemissionextView:_clearBuffCell(cell)
	return
end

function LotusbattlemissionextView:_setTargetTickTime()
	if self:_isFirstStep() then
		local time = LotusbattleConfig.instance:getStageTime(self._activityId, "firstStepTime")

		self._targetTickTime = ServerTime.now() + time
	else
		local time = LotusbattleConfig.instance:getStageTime(self._activityId, "secondStepTime")

		self._targetTickTime = ServerTime.now() + time
	end

	self._targetTickTime = self._targetTickTime - 1
end

function LotusbattlemissionextView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	leftTime = math.max(leftTime, 0)
	self._txtClockTime.text = string.format("倒计时：%s", leftTime)

	if leftTime <= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.FormatForceEndDrag)

		if LotusbattleController.instance:getCanSetFormationFlag() then
			self:_onClickbtnStart()
		end

		LotusbattleController.instance:setCanSetFormationFlag(false)
		removetimer(self._tick, self)
		self:_setTickText()
	end
end

function LotusbattlemissionextView:_updateUI()
	self:_setFormationDesc()
	GameUtil.SetGray(self._btnStart.gameObject, not self._isCanSetForm)
end

function LotusbattlemissionextView:_setFormationDesc()
	if self:_isFirstStep() then
		self._txtStage.text = "阶段1/2"
		self._txtDesc.text = langPara("请上阵%d只精灵", self._actCfg.firstStepNum)

		self._customFmtMo:setNeedUpPetCount(self._actCfg.firstStepNum)
	else
		self._txtStage.text = "阶段2/2"
		self._txtDesc.text = langPara("请上阵%d只精灵", self._actCfg.secondStepNum)

		local num = LotusbattleModel.instance:getLastFormInTeamPetNum() + self._actCfg.secondStepNum

		self._customFmtMo:setNeedUpPetCount(num, LotusbattleModel.instance:getLastFormInTeamPetNum())
	end
end

function LotusbattlemissionextView:_isFirstStep()
	return self._stepType == GameEnum.LotusBattleMissionStep.One
end

function LotusbattlemissionextView:_LBFNotifyEnterNextSetFormationRes()
	GlobalDispatcher:dispatch(GlobalNotify.FormatForceEndDrag)

	self._stepType = GameEnum.LotusBattleMissionStep.Two
	self._isCanSetForm = true

	self:_updateFmt()
	self:_setTargetTickTime()
	self:_startTimer()
	self:_updateUI()
end

function LotusbattlemissionextView:_startTimer()
	settimer(1, self._tick, self, true)
	self:_tick()
end

function LotusbattlemissionextView:_updateFmt()
	local simpleForm = LotusbattleModel.instance:getMySimpleform()

	self._customFmtMo:updateLeftFormationMo(simpleForm)
	self._customFmtMo:_updateFmt()
end

function LotusbattlemissionextView:_LBFSetFirstStepFormationRes()
	self._isCanSetForm = true

	GameUtil.SetGray(self._btnStart.gameObject, not self._isCanSetForm)
end

function LotusbattlemissionextView:_SetFormError()
	self._isCanSetForm = true

	GameUtil.SetGray(self._btnStart.gameObject, not self._isCanSetForm)
end

function LotusbattlemissionextView:_UpdateExtForm()
	removetimer(self._tick, self)
	self:_setTickText()
	self:_updateFmt()
end

function LotusbattlemissionextView:_setFormSuccessed()
	self._customFmtMo:refreshMyFmts()
end

function LotusbattlemissionextView:_onEnterShowFormationTime()
	local myBuffId = LotusbattleModel.instance:getResultMyBuffId()
	local opBuffId = LotusbattleModel.instance:getResultOpBuffId()

	self:_showBuff(self._myBuff, myBuffId, self._effect1Go)
	self:_showBuff(self._opBuff, opBuffId, self._effect2Go)
end

function LotusbattlemissionextView:_showBuff(buffItem, buffId, effectGo)
	goutil.setActive(buffItem.mainGO, buffId > 0)
	Framework.TransformUtil.SetAnchoredPos(effectGo.transform, 0, 0)

	if buffId > 0 then
		local buffCfg = LotusbattleConfig.instance:getBuffCfg(self._modelCfg.buffPlanId, buffId)
		local spriteName = GameUrl.getExpEventUrl(buffCfg.iconPath)

		uGuiUtil.setSpriteToImage(buffItem.goIcon, nil, spriteName)

		buffItem.txtBubble.text = buffCfg.buffDesc
		buffItem.txtName.text = buffCfg.name

		goutil.setActive(effectGo, true)

		local tween = effectGo:GetComponent(UnityTweensType.TweenPosition)

		tween:AddListener(function()
			local handler = self._uiEffectHandlers[effectGo]

			if handler then
				UIEffectManager.instance:stopEffect(handler)

				self._uiEffectHandlers[effectGo] = nil
			end
		end)

		tween.from = Vector3.zero

		tween:Begin()
	end
end

function LotusbattlemissionextView:_setTickText()
	if self:_isFirstStep() then
		self._stepType = GameEnum.LotusBattleMissionStep.Two
		self._txtClockTime.text = "等待服务器返回数据"
	else
		self._txtClockTime.text = "等待进入战斗"
	end
end

function LotusbattlemissionextView:_setTimeEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_qiecuojiemian_daojishi.prefab"

	self._timeeffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._timeeffectHandler:setParent(self._timeEffectGo.transform)
	self._timeeffectHandler:setLocalPos(11, 68, 0)
	self._timeeffectHandler:setScale(1)
end

function LotusbattlemissionextView:_loadBuffEffect(effectGo)
	local tween = effectGo:GetComponent(UnityTweensType.TweenPosition)

	tween:Stop()
	goutil.setActive(effectGo, false)
	Framework.TransformUtil.SetAnchoredPos(effectGo.transform, 0, 0)

	tween.from = Vector3.zero

	local handler = self._uiEffectHandlers[effectGo]

	if not handler then
		local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_buzhengzhandoutuowei.prefab"

		handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

		handler:setParent(effectGo.transform)
		handler:setLocalPos(0, 0, 0)
		handler:setScale(1)
	end

	self._uiEffectHandlers[effectGo] = handler
end

function LotusbattlemissionextView:_loadBuffEffects()
	self:_loadBuffEffect(self._effect1Go)
	self:_loadBuffEffect(self._effect2Go)
end

return LotusbattlemissionextView
