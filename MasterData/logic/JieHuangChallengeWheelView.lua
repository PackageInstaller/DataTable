-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiehuangchallenge/view/JieHuangChallengeWheelView.lua

module("logic.extensions.jiehuangchallenge.view.JieHuangChallengeWheelView", package.seeall)

local JieHuangChallengeWheelView = class("JieHuangChallengeWheelView", ViewComponent)

function JieHuangChallengeWheelView:ctor()
	JieHuangChallengeWheelView.super.ctor(self)

	self._wheelType = {
		Buff = 1,
		Condition = 3,
		Limit = 2
	}
	self._lastColor = GameUtil.getColorByHexColor(ColorConst.Green)
end

function JieHuangChallengeWheelView:buildUI()
	JieHuangChallengeWheelView.super.buildUI(self)

	self._effectGo = self:getGo("effectGo")
	self._btnClose = GameUtil.asBtn(self:getGo("btnClose"))
	self._btnStart = GameUtil.asBtn(self:getGo("btnStart"))
	self._blurBg = self:getGo("blurBg"):GetComponent(typeof(StaticBluredScreen))
	self._wheelGo = self:getGo("pan")
	self._btnRule = self:getBtn("btnRule")
	self._tipGo = self:getGo("tip")
	self._txtTip = self:getTxt("tip/txtTip")
	self._wheelData = {
		long = {
			chipCount = 6,
			startRotation = 0
		},
		mid = {
			chipCount = 6,
			startRotation = 0
		},
		short = {
			chipCount = 6,
			startRotation = 0
		}
	}
	self._longArrowGo = self:getGo("pan/arrowLong")
	self._longPoints = {}

	for i = 1, self._wheelData.long.chipCount do
		local pointGo = goutil.findChild(self._wheelGo, "longPan/long" .. i .. "Go")
		local endPos = Vector3(GameUtil.getAnchoredPos(pointGo).x, GameUtil.getAnchoredPos(pointGo).y, 0)
		local angle = Vector3.Angle(Vector3.up, endPos)

		if GameUtil.getAnchoredPos(pointGo).x > 0 then
			angle = -angle
		end

		table.insert(self._longPoints, {
			go = pointGo,
			angle = angle,
			txtNum = goutil.findChildTextComponent(pointGo, "txt"),
			imgActivate = goutil.findChild(pointGo, "imgActivate"),
			lastRes = goutil.findChild(pointGo, "lastRes")
		})
	end

	self._midArrowGo = self:getGo("pan/arrowMid")
	self._midPoints = {}

	for i = 1, self._wheelData.mid.chipCount do
		local pointGo = goutil.findChild(self._wheelGo, "midPan/mid" .. i .. "Go")
		local endPos = Vector3(GameUtil.getAnchoredPos(pointGo).x, GameUtil.getAnchoredPos(pointGo).y, 0)
		local angle = Vector3.Angle(Vector3.up, endPos)

		if GameUtil.getAnchoredPos(pointGo).x > 0 then
			angle = -angle
		end

		local var_2_0 = {
			go = pointGo,
			angle = angle
		}

		var_2_0.txtNum = goutil.findChildTextComponent(self._wheelGo, "midtxtPan/mid" .. i .. "Txt") or goutil.findChildTextComponent(pointGo, "txt")
		var_2_0.imgActivate = goutil.findChild(pointGo, "imgActivate")
		var_2_0.lastRes = goutil.findChild(pointGo, "lastRes")

		table.insert(self._midPoints, var_2_0)
	end

	self._shortArrowGo = self:getGo("pan/arrowShort")
	self._shortPoints = {}

	for i = 1, self._wheelData.short.chipCount do
		local pointGo = goutil.findChild(self._wheelGo, "shortPan/short" .. i .. "Go")
		local endPos = Vector3(GameUtil.getAnchoredPos(pointGo).x, GameUtil.getAnchoredPos(pointGo).y, 0)
		local angle = Vector3.Angle(Vector3.up, endPos)

		if GameUtil.getAnchoredPos(pointGo).x > 0 then
			angle = -angle
		end

		table.insert(self._shortPoints, {
			go = pointGo,
			angle = angle,
			txtNum = goutil.findChildTextComponent(pointGo, "txt"),
			imgActivate = goutil.findChild(pointGo, "imgActivate")
		})
	end

	self.rotationList = {}

	for i, v in pairs(self._wheelData) do
		if not self.rotationList[v.chipCount] then
			self.rotationList[v.chipCount] = {}

			local preRotation = 360 / v.chipCount
			local totalRotation = 0

			while totalRotation < 360 do
				table.insert(self.rotationList[v.chipCount], totalRotation)

				totalRotation = totalRotation + preRotation
			end
		end

		v.rotationList = self.rotationList[v.chipCount]
	end

	if self._wheelData.long.chipCount > 1 then
		local endAngle = self._longPoints[self._wheelData.long.chipCount].angle
		local startAngle = self._longPoints[1].angle

		if endAngle > 180 then
			endAngle = endAngle % 360 - 360
		end

		if startAngle > 180 then
			startAngle = startAngle % 360 - 360
		end

		self._wheelData.long.startRotation = (endAngle + startAngle) / 2
	end

	if self._wheelData.mid.chipCount > 1 then
		local endAngle = self._midPoints[self._wheelData.mid.chipCount].angle
		local startAngle = self._midPoints[1].angle

		if endAngle > 180 then
			endAngle = endAngle % 360 - 360
		end

		if startAngle > 180 then
			startAngle = startAngle % 360 - 360
		end

		self._wheelData.mid.startRotation = (endAngle + startAngle) / 2
	end

	if self._wheelData.short.chipCount > 1 then
		local endAngle = self._shortPoints[self._wheelData.short.chipCount].angle
		local startAngle = self._shortPoints[1].angle

		if endAngle > 180 then
			endAngle = endAngle % 360 - 360
		end

		if startAngle > 180 then
			startAngle = startAngle % 360 - 360
		end

		self._wheelData.short.startRotation = (endAngle + startAngle) / 2
	end

	self._ruleArrowMid = self:getGo("arrowTip/arrow_1")
	self._ruleArrowShort = self:getGo("arrowTip/arrow_2")
	self._ruleArrowLong = self:getGo("arrowTip/arrow_3")
end

function JieHuangChallengeWheelView:bindEvents()
	JieHuangChallengeWheelView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function JieHuangChallengeWheelView:unbindEvents()
	JieHuangChallengeWheelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnClose)
end

function JieHuangChallengeWheelView:onEnter()
	JieHuangChallengeWheelView.super.onEnter(self)

	self._tempLongRotationZ = 0
	self._tempMidRotationZ = 0
	self._tempShortRotationZ = 0

	GlobalDispatcher:addListener(GlobalNotify.MiyaChallengeBuyAndRandom, self._PM_MiyaChallengeBuyAndRandomRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MiyaChallengeChoice, self._PM_MiyaChallengeChoiceRes, self)

	self._mainEff = UIEffectManager.instance:playEffect(self, "20230825/jiehuangtiaozhan/fx_ui_jiehuangtiaozhan_lunpan2.prefab", nil, 0, 0, true)

	self._mainEff:setParent(self._effectGo.transform)
	self._mainEff:setLocalPos(0, 0, 0)
	self._mainEff:setScale(1)
	GameUtil.SetActive(self._btnClose, true)
	GameUtil.SetActive(self._btnStart, true)
	GameUtil.SetActive(self._tipGo, true)

	self._txtTip.text = lang("轻触轮盘开始转动")
	self._activityCfg = MiyaChallengeConfig.instance:getActivityCfg(MiyaChallengeModel.instance:getActivityId())
	self._tierCfg = MiyaChallengeConfig.instance:getTierStageCfg(self._activityCfg.tierPlanId, MiyaChallengeModel.instance:getTierId())
	self._randomCfg = nil

	if MiyaChallengeModel.instance:getBigStageId() == 1 then
		self._randomCfg = MiyaChallengeConfig.instance:getRandomCfg(self._tierCfg.firstRandomPlanId)
	elseif MiyaChallengeModel.instance:getBigStageId() == 2 then
		self._randomCfg = MiyaChallengeConfig.instance:getRandomCfg(self._tierCfg.secondRandomPlanId)
	elseif MiyaChallengeModel.instance:getBigStageId() == 3 then
		self._randomCfg = MiyaChallengeConfig.instance:getRandomCfg(self._tierCfg.thirdRandomPlanId)
	end

	self._readyEnter = nil
	self._enter = nil

	self:_refreshView()

	if MiyaChallengeModel.instance:getExchangeBuff() then
		UIStateManager.instance:push(ViewName.JieHuangChallengeSelectView)
	end

	self:_setBlurBg()
end

function JieHuangChallengeWheelView:onExit()
	JieHuangChallengeWheelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MiyaChallengeBuyAndRandom, self._PM_MiyaChallengeBuyAndRandomRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MiyaChallengeChoice, self._PM_MiyaChallengeChoiceRes, self)
	removetimer(self._checkShortRotation, self)
	removetimer(self._checkMidRotation, self)
	removetimer(self._checkLongRotation, self)
	MiyaChallengeController.instance:sendPM_MiyaChallengeGetStageInfoReq(MiyaChallengeModel.instance:getActivityId(), MiyaChallengeModel.instance:getTierId(), MiyaChallengeModel.instance:getBigStageId(), MiyaChallengeModel.instance:getStageSelect(MiyaChallengeModel.instance:getBigStageId()))
	self:_removeBlurBg()
	UIEffectManager.instance:stopEffect(self._mainEff)
	GameUtil.SetActive(self._btnStart, false)
end

function JieHuangChallengeWheelView:_refreshView()
	self._ignoreArrow = {}

	for i = 1, self._wheelData.long.chipCount do
		local id = self._randomCfg[self._wheelType.Condition][0].ids[i]
		local num = -1

		if id then
			num = checknumber(MiyaChallengeConfig.instance:getNum(self._wheelType.Condition, id))
		end

		self._longPoints[i].txtNum.text = num > 0 and num or lang("未定义")
		self._longPoints[i].txtNum.color = Color.white

		GameUtil.SetActive(self._longPoints[i].lastRes, false)
		GameUtil.SetActive(self._longPoints[i].imgActivate, false)

		if MiyaChallengeModel.instance:getBuff() and MiyaChallengeModel.instance:getBuff().conditionId == id then
			self._longPoints[i].txtNum.color = self._lastColor

			GameUtil.SetActive(self._longPoints[i].lastRes, true)
		end

		if not id or id == 0 then
			GameUtil.SetActive(self._longPoints[i].go, false)
			GameUtil.SetActive(self._longPoints[i].lastRes, false)
			GameUtil.SetActive(self._longArrowGo, false)
			GameUtil.SetActive(self._ruleArrowLong, false)

			self._ignoreArrow.long = true
		else
			GameUtil.SetActive(self._longPoints[i].go, true)
			GameUtil.SetActive(self._longArrowGo, true)
			GameUtil.SetActive(self._ruleArrowLong, true)

			self._ignoreArrow.long = false
		end
	end

	for i = 1, self._wheelData.mid.chipCount do
		local id = self._randomCfg[self._wheelType.Buff][0].ids[i]
		local num = -1

		if id then
			num = checknumber(MiyaChallengeConfig.instance:getNum(self._wheelType.Buff, id))
		end

		self._midPoints[i].txtNum.text = num > 0 and num or lang("未定义")
		self._midPoints[i].txtNum.color = Color.white

		GameUtil.SetActive(self._midPoints[i].lastRes, false)
		GameUtil.SetActive(self._midPoints[i].imgActivate, false)

		if MiyaChallengeModel.instance:getBuff() and MiyaChallengeModel.instance:getBuff().buffId == id then
			self._midPoints[i].txtNum.color = self._lastColor

			GameUtil.SetActive(self._midPoints[i].lastRes, true)
		end

		if not id or id == 0 then
			GameUtil.SetActive(self._midPoints[i].txtNum, false)
			GameUtil.SetActive(self._midPoints[i].lastRes, false)
			GameUtil.SetActive(self._ruleArrowMid, false)
			GameUtil.SetActive(self._midArrowGo, false)

			self._ignoreArrow.mid = true
		else
			GameUtil.SetActive(self._midPoints[i].txtNum, true)
			GameUtil.SetActive(self._ruleArrowMid, true)
			GameUtil.SetActive(self._midArrowGo, true)

			self._ignoreArrow.mid = false
		end
	end

	for i = 1, self._wheelData.short.chipCount do
		local id = self._randomCfg[self._wheelType.Limit][0].ids[i]
		local num = -1

		if id then
			num = checknumber(MiyaChallengeConfig.instance:getNum(self._wheelType.Limit, id))
		end

		self._shortPoints[i].txtNum.text = num > 0 and num or lang("未定义")
		self._shortPoints[i].txtNum.color = GameUtil.getColorByHexColor("#9D7F82FF")

		GameUtil.SetActive(self._shortPoints[i].imgActivate, false)

		if MiyaChallengeModel.instance:getBuff() and MiyaChallengeModel.instance:getBuff().limitId == id then
			self._shortPoints[i].txtNum.color = self._lastColor
		end

		if not id or id == 0 then
			GameUtil.SetActive(self._shortPoints[i].txtNum, false)
			GameUtil.SetActive(self._ruleArrowShort, false)
			GameUtil.SetActive(self._shortArrowGo, false)

			self._ignoreArrow.short = true
		else
			GameUtil.SetActive(self._shortPoints[i].txtNum, true)
			GameUtil.SetActive(self._ruleArrowShort, true)
			GameUtil.SetActive(self._shortArrowGo, true)

			self._ignoreArrow.short = false
		end
	end

	GameUtil.setLocalRotation(self._midArrowGo, 0, 0, 0)
	GameUtil.setLocalRotation(self._shortArrowGo, 0, 0, 0)
	GameUtil.setLocalRotation(self._longArrowGo, 0, 0, 0)
end

function JieHuangChallengeWheelView:_onClickStart()
	if MiyaChallengeModel.instance:getBuff() then
		if MiyaChallengeModel.instance:getBuyTime() >= self._activityCfg.buyTimeLimit then
			FloatWordMgr.instance:show("今日购买次数已耗尽")
			self:_onClickClose()

			return
		end

		local costNum = 0

		_, _, costNum = MaterialMgr.getMatParams(self._activityCfg.decrease)

		if MaterialMgr.getMatEnough(self._activityCfg.decrease) then
			local desc = langPara("今日没有免费次数了，确定要花费%d钻石购买转盘次数吗？每天最多购买%d次，还能购买%d次", costNum, self._activityCfg.buyTimeLimit, self._activityCfg.buyTimeLimit - MiyaChallengeModel.instance:getBuyTime())

			TipsFacade.instance:openPopupCostDiamondView(costNum, desc, function()
				self._longEnd = false
				self._minEnd = false
				self._shortEnd = false

				GameUtil.SetActive(self._btnClose, false)
				GameUtil.SetActive(self._btnStart, false)
				MiyaChallengeAgent.instance:sendPM_MiyaChallengeBuyAndRandomReq(MiyaChallengeModel.instance:getActivityId(), MiyaChallengeModel.instance:getBigStageId(), MiyaChallengeModel.instance:getShowStageId())
			end, nil, nil, nil, GameUtil.handler(function(status)
				if status == TipsFacade.STATE_CANCEL then
					self:_onClickClose()
				end
			end), self)
		else
			FloatWordMgr.instance:show("当前转动需要消耗%d钻石 您的钻石数量不足", costNum)
		end
	else
		MiyaChallengeAgent.instance:sendPM_MiyaChallengeBuyAndRandomReq(MiyaChallengeModel.instance:getActivityId(), MiyaChallengeModel.instance:getBigStageId(), MiyaChallengeModel.instance:getShowStageId())
		GameUtil.SetActive(self._btnClose, false)
		GameUtil.SetActive(self._btnStart, false)
	end
end

function JieHuangChallengeWheelView:_onClickClose()
	if self._enter == true then
		local customFmtMo = MiyaChallengeModel.instance:getCustomFmtMo()

		customFmtMo:initParams(ViewName.JieHuangChallengeMainView, ViewName.JieHuangChallengeLevelView)
		CustomFmtController.instance:showMissionView(customFmtMo)
		self:close()
	else
		self:close()
	end
end

function JieHuangChallengeWheelView:_onClickRule()
	UIStateManager.instance:push(ViewName.JieHuangChallengeRuleView)
end

function JieHuangChallengeWheelView:_checkLongRotation()
	_, _, self._tempLongRotationZ = GameUtil.getLocalRotation(self._longArrowGo)
	self._tempLongRotationZ = self._tempLongRotationZ % 360
	self._tempLongRotationZ = (self._tempLongRotationZ + self._wheelData.long.startRotation) % 360

	for i, v in ipairs(self._wheelData.long.rotationList) do
		if v < self._tempLongRotationZ then
			if i > 1 then
				GameUtil.SetActive(self._longPoints[i - 1].imgActivate, false)
			end

			GameUtil.SetActive(self._longPoints[i].imgActivate, true)
		else
			GameUtil.SetActive(self._longPoints[i].imgActivate, false)
		end
	end
end

function JieHuangChallengeWheelView:_checkMidRotation()
	_, _, self._tempMidRotationZ = GameUtil.getLocalRotation(self._midArrowGo)
	self._tempMidRotationZ = self._tempMidRotationZ % 360
	self._tempMidRotationZ = (self._tempMidRotationZ + self._wheelData.mid.startRotation) % 360

	for i, v in ipairs(self._wheelData.mid.rotationList) do
		if v < self._tempMidRotationZ then
			if i > 1 then
				GameUtil.SetActive(self._midPoints[i - 1].imgActivate, false)
			end

			GameUtil.SetActive(self._midPoints[i].imgActivate, true)
		else
			GameUtil.SetActive(self._midPoints[i].imgActivate, false)
		end
	end
end

function JieHuangChallengeWheelView:_checkShortRotation()
	_, _, self._tempShortRotationZ = GameUtil.getLocalRotation(self._shortArrowGo)
	self._tempShortRotationZ = self._tempShortRotationZ % 360
	self._tempShortRotationZ = (self._tempShortRotationZ + self._wheelData.short.startRotation) % 360

	for i, v in ipairs(self._wheelData.short.rotationList) do
		if v < self._tempShortRotationZ then
			if i > 1 then
				GameUtil.SetActive(self._shortPoints[i - 1].imgActivate, false)
			end

			GameUtil.SetActive(self._shortPoints[i].imgActivate, true)
		else
			GameUtil.SetActive(self._shortPoints[i].imgActivate, false)
		end
	end
end

function JieHuangChallengeWheelView:_checkWheelEnd()
	if self._longEnd == true and self._minEnd == true and self._shortEnd == true then
		return true
	else
		return false
	end

	return false
end

function JieHuangChallengeWheelView:_wheelEnd()
	GameUtil.SetActive(self._tipGo, true)

	self._txtTip.text = lang("点击空白处关闭弹窗")

	UIStateManager.instance:push(ViewName.JieHuangChallengeSelectView)
	GameUtil.SetActive(self._btnClose, true)
	GameUtil.SetActive(self._btnStart, true)
end

function JieHuangChallengeWheelView:_PM_MiyaChallengeBuyAndRandomRes()
	for i = 1, self._wheelData.long.chipCount do
		GameUtil.SetActive(self._longPoints[i].imgActivate, false)
		GameUtil.SetActive(self._longPoints[i].lastRes, false)

		self._longPoints[i].txtNum.color = Color.white
	end

	for i = 1, self._wheelData.mid.chipCount do
		GameUtil.SetActive(self._midPoints[i].imgActivate, false)
		GameUtil.SetActive(self._midPoints[i].lastRes, false)

		self._midPoints[i].txtNum.color = Color.white
	end

	for i = 1, self._wheelData.short.chipCount do
		GameUtil.SetActive(self._shortPoints[i].imgActivate, false)

		self._shortPoints[i].txtNum.color = GameUtil.getColorByHexColor("#9D7F82FF")
	end

	GameUtil.SetActive(self._tipGo, false)

	self._txtTip.text = lang("")

	local longRotation = 1800 + self._longPoints[1].angle

	for i = 1, self._wheelData.long.chipCount do
		if not MiyaChallengeModel.instance:getExchangeBuff() then
			break
		end

		if self._randomCfg[self._wheelType.Condition][0].ids[i] == MiyaChallengeModel.instance:getExchangeBuff().conditionId then
			longRotation = 1800 + self._longPoints[i].angle

			break
		end
	end

	local midRotation = 1800 + self._midPoints[1].angle

	for i = 1, self._wheelData.mid.chipCount do
		if not MiyaChallengeModel.instance:getExchangeBuff() then
			break
		end

		if self._randomCfg[self._wheelType.Buff][0].ids[i] == MiyaChallengeModel.instance:getExchangeBuff().buffId then
			midRotation = 1800 + self._midPoints[i].angle

			break
		end
	end

	local shortRotation = 1800 + self._shortPoints[1].angle

	for i = 1, self._wheelData.short.chipCount do
		if not MiyaChallengeModel.instance:getExchangeBuff() then
			break
		end

		if self._randomCfg[self._wheelType.Limit][0].ids[i] == MiyaChallengeModel.instance:getExchangeBuff().limitId then
			shortRotation = 1800 + self._shortPoints[i].angle

			break
		end
	end

	self._longEnd = false
	self._minEnd = false
	self._shortEnd = false

	if self._ignoreArrow.long == true then
		self._longEnd = true
	else
		local tweenLong = UnityTweens.TweenRotate.StartTween(self._longArrowGo, Vector3.New(0, 0, 0), Vector3.New(0, 0, longRotation), 10, UnityTweens.EaseType.easeOutQuart)

		settimer(0, self._checkLongRotation, self)
		tweenLong:RemoveListener()
		tweenLong:AddListener(function()
			removetimer(self._checkLongRotation, self)

			self._longEnd = true

			if self:_checkWheelEnd() then
				self:_wheelEnd()
			end
		end)
	end

	if self._ignoreArrow.mid == true then
		self._midEnd = true
	else
		local tweenMid = UnityTweens.TweenRotate.StartTween(self._midArrowGo, Vector3.New(0, 0, 0), Vector3.New(0, 0, midRotation), 7, UnityTweens.EaseType.easeOutQuart)

		settimer(0, self._checkMidRotation, self)
		tweenMid:RemoveListener()
		tweenMid:AddListener(function()
			removetimer(self._checkMidRotation, self)

			self._minEnd = true

			if self:_checkWheelEnd() then
				self:_wheelEnd()
			end
		end)
	end

	if self._ignoreArrow.short == true then
		self._shortEnd = true
	else
		local tweenShort = UnityTweens.TweenRotate.StartTween(self._shortArrowGo, Vector3.New(0, 0, 0), Vector3.New(0, 0, shortRotation), 5, UnityTweens.EaseType.easeOutQuart)

		settimer(0, self._checkShortRotation, self)
		tweenShort:RemoveListener()
		tweenShort:AddListener(function()
			removetimer(self._checkShortRotation, self)

			self._shortEnd = true

			if self:_checkWheelEnd() then
				self:_wheelEnd()
			end
		end)
	end

	self._readyEnter = true
end

function JieHuangChallengeWheelView:_PM_MiyaChallengeChoiceRes()
	if self._readyEnter == true then
		self._enter = true
	end

	self:_onClickClose()
end

function JieHuangChallengeWheelView:_setBlurBg()
	self._blurBg:Release()
	self._blurBg:Capture()
	StaticBluredHook.instance:start(self.mainGO)
	self._blurBg:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
end

function JieHuangChallengeWheelView:_removeBlurBg()
	StaticBluredHook.instance:stop()
	self._blurBg:Release()
end

function JieHuangChallengeWheelView:_onCaptureScreenFinish()
	StaticBluredHook.instance:stop()
end

return JieHuangChallengeWheelView
