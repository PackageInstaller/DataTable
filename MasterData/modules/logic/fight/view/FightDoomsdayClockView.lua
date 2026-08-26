-- chunkname: @modules/logic/fight/view/FightDoomsdayClockView.lua

module("modules.logic.fight.view.FightDoomsdayClockView", package.seeall)

local FightDoomsdayClockView = class("FightDoomsdayClockView", FightBaseView)

function FightDoomsdayClockView:onInitView()
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.goBroken = gohelper.findChild(self.viewGO, "root/clock/broken")
	self.goZhiZhen = gohelper.findChild(self.viewGO, "root/clock/unbroken/#image_zhizhen")
	self.trZhiZhen = self.goZhiZhen:GetComponent(gohelper.Type_Transform)
	self.areaTransform = gohelper.findChildComponent(self.viewGO, "root/clock/unbroken/#go_area", gohelper.Type_Transform)
	self.imageOrange = gohelper.findChildImage(self.viewGO, "root/clock/unbroken/#go_area/#image_orange")
	self.imageYellow = gohelper.findChildImage(self.viewGO, "root/clock/unbroken/#go_area/#image_yellow")
	self.imageRed = gohelper.findChildImage(self.viewGO, "root/clock/unbroken/#go_area/#image_red")
	self.imageGreen = gohelper.findChildImage(self.viewGO, "root/clock/unbroken/#go_area/#image_green")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_click")
	self.timeValueAnimator = gohelper.findChildComponent(self.viewGO, "root/timevalue", gohelper.Type_Animator)
	self.timeValueBg = gohelper.findChildComponent(self.viewGO, "root/timevalue/bg", gohelper.Type_Image)
	self.timeValueBgGlow = gohelper.findChildComponent(self.viewGO, "root/timevalue/bg_glow", gohelper.Type_Image)
	self.rectAnimRoot = gohelper.findChildComponent(self.viewGO, "root/timevalue/scroll/animroot", gohelper.Type_RectTransform)
	self.txtTimeList = {}
	self.goTimeList = self:getUserDataTb_()

	for i = 1, 5 do
		local goTime = gohelper.findChild(self.viewGO, "root/timevalue/scroll/animroot/#go_time_" .. i)

		table.insert(self.goTimeList, goTime)

		local txtDict = self:getUserDataTb_()

		self.txtTimeList[i] = txtDict
		txtDict[FightParamData.ParamKey.DoomsdayClock_Range1] = gohelper.findChildText(goTime, "#txt_time_orange")
		txtDict[FightParamData.ParamKey.DoomsdayClock_Range2] = gohelper.findChildText(goTime, "#txt_time_yellow")
		txtDict[FightParamData.ParamKey.DoomsdayClock_Range3] = gohelper.findChildText(goTime, "#txt_time_red")
		txtDict[FightParamData.ParamKey.DoomsdayClock_Range4] = gohelper.findChildText(goTime, "#txt_time_green")
	end

	self.key2Image = self:getUserDataTb_()
	self.key2Image[FightParamData.ParamKey.DoomsdayClock_Range1] = self.imageOrange
	self.key2Image[FightParamData.ParamKey.DoomsdayClock_Range2] = self.imageYellow
	self.key2Image[FightParamData.ParamKey.DoomsdayClock_Range3] = self.imageRed
	self.key2Image[FightParamData.ParamKey.DoomsdayClock_Range4] = self.imageGreen
	self.key2ImageLine = self:getUserDataTb_()
	self.key2ImageLine[FightParamData.ParamKey.DoomsdayClock_Range1] = gohelper.findChildComponent(self.viewGO, "root/clock/unbroken/#go_area/line1", gohelper.Type_RectTransform)
	self.key2ImageLine[FightParamData.ParamKey.DoomsdayClock_Range2] = gohelper.findChildComponent(self.viewGO, "root/clock/unbroken/#go_area/line2", gohelper.Type_RectTransform)
	self.key2ImageLine[FightParamData.ParamKey.DoomsdayClock_Range3] = gohelper.findChildComponent(self.viewGO, "root/clock/unbroken/#go_area/line3", gohelper.Type_RectTransform)
	self.key2ImageLine[FightParamData.ParamKey.DoomsdayClock_Range4] = gohelper.findChildComponent(self.viewGO, "root/clock/unbroken/#go_area/line4", gohelper.Type_RectTransform)
	self.key2Transform = self:getUserDataTb_()
	self.key2ImageEffect = self:getUserDataTb_()

	for key, image in pairs(self.key2Image) do
		self.key2Transform[key] = image:GetComponent(gohelper.Type_RectTransform)
		self.key2ImageEffect[key] = gohelper.findChild(image.gameObject, "#glow")
	end

	self.goAdd = gohelper.findChild(self.viewGO, "root/num/add")
	self.txtAdd = gohelper.findChildText(self.viewGO, "root/num/add/#txt_add")
	self.goReduce = gohelper.findChild(self.viewGO, "root/num/reduce")
	self.txtReduce = gohelper.findChildText(self.viewGO, "root/num/reduce/#txt_reduce")
	self.indicatorValue = FightDataHelper.fieldMgr:getIndicatorNum(FightEnum.IndicatorId.DoomsdayClock) or 0

	self:setTimeValueActive(false)
	gohelper.setActive(self.goBroken, false)

	self.keyList = {
		FightParamData.ParamKey.DoomsdayClock_Range1,
		FightParamData.ParamKey.DoomsdayClock_Range2,
		FightParamData.ParamKey.DoomsdayClock_Range3,
		FightParamData.ParamKey.DoomsdayClock_Range4
	}
end

FightDoomsdayClockView.AreaId2Color = {
	[FightParamData.ParamKey.DoomsdayClock_Range1] = "#e56745",
	[FightParamData.ParamKey.DoomsdayClock_Range2] = "#4c7bff",
	[FightParamData.ParamKey.DoomsdayClock_Range3] = "#e54550",
	[FightParamData.ParamKey.DoomsdayClock_Range4] = "#60cace"
}
FightDoomsdayClockView.ZhiZhenTweenDuration = 0.5

function FightDoomsdayClockView:addEvents()
	self:com_registFightEvent(FightEvent.DoomsdayClock_OnValueChange, self.onValueChange)
	self:com_registFightEvent(FightEvent.DoomsdayClock_OnAreaChange, self.onAreaChange)
	self:com_registFightEvent(FightEvent.DoomsdayClock_OnBroken, self.onBroken)
	self:com_registFightEvent(FightEvent.OnIndicatorChange, self.onIndicatorChange)
	self:com_registFightEvent(FightEvent.DoomsdayClock_OnClear, self.onClear)
	self.btnClick:AddClickListener(self.onClickClock, self)
end

function FightDoomsdayClockView:onClickClock()
	HelpController.instance:showHelp(HelpEnum.HelpId.V2A7_boss)
end

function FightDoomsdayClockView:onClear()
	self:refreshHighlightArea()
end

function FightDoomsdayClockView:refreshHighlightArea()
	local offset = self:getParamValue(FightParamData.ParamKey.DoomsdayClock_Offset)
	local curValue = self:getParamValue(FightParamData.ParamKey.DoomsdayClock_Value)

	curValue = self:formatValue(curValue + offset)

	local area = FightParamData.ParamKey.DoomsdayClock_Range1

	for _, key in ipairs(self.keyList) do
		local rangeValue = self:getParamValue(key)

		if curValue < rangeValue then
			area = key

			break
		end
	end

	if not self.AreaId2Color[area] then
		local color = "#ffd84c"

		for key, goEffect in pairs(self.key2ImageEffect) do
			gohelper.setActive(goEffect, false)

			if key == area then
				gohelper.setActive(goEffect, true)
			end
		end

		SLFramework.UGUI.GuiHelper.SetColor(self.timeValueBgGlow, color)
		self:refreshTxtColor(area)
		self.timeValueAnimator:Play("switch", 0, 0)
	end
end

function FightDoomsdayClockView:refreshTxtColor(curKey)
	for _, txtDict in ipairs(self.txtTimeList) do
		for key, txt in pairs(txtDict) do
			gohelper.setActive(txt.gameObject, key == curKey)
		end
	end
end

function FightDoomsdayClockView:formatValue(value)
	local maxValue = self:getParamValue(FightParamData.ParamKey.DoomsdayClock_Range4)

	while value < 0 do
		value = value + maxValue
	end

	while maxValue <= value do
		value = value - maxValue
	end

	return value
end

function FightDoomsdayClockView:onBroken()
	gohelper.setActive(self.goBroken, true)
	AudioMgr.instance:trigger(20270057)
end

FightDoomsdayClockView.ItemHeight = 25
FightDoomsdayClockView.ItemCount = 5
FightDoomsdayClockView.ScrollCenterCount = 3
FightDoomsdayClockView.ScrollDuration = 1

function FightDoomsdayClockView:onIndicatorChange(indicatorId, offsetNum)
	if indicatorId ~= FightEnum.IndicatorId.DoomsdayClock then
		return
	end

	if not offsetNum or offsetNum == 0 then
		return
	end

	FightModel.instance:setWaitIndicatorAnimation(true)

	self.startValue = self.indicatorValue
	self.endValue = self.indicatorValue + offsetNum
	self.indicatorValue = self.endValue
	self.totalOffset = math.abs(offsetNum)
	self.offsetSymbol = offsetNum / self.totalOffset
	self.scrollLen = offsetNum * FightDoomsdayClockView.ItemHeight

	local duration = FightDoomsdayClockView.ScrollDuration

	if math.abs(offsetNum) <= 2 then
		duration = duration / 2
	end

	self.speed = self.scrollLen / duration
	self.scrolledAnchorY = 0
	self.scrolledOffset = 0

	self:setTimeValueTxt(self.startValue)
	self:setTimeValueActive(true)
	recthelper.setAnchorY(self.rectAnimRoot, 0)

	self.startScrollAnim = true
end

function FightDoomsdayClockView:_onFrame()
	if not self.startScrollAnim then
		return
	end

	local deltaTime = Time.deltaTime
	local curAnchorY = recthelper.getAnchorY(self.rectAnimRoot)
	local scrollY = deltaTime * self.speed

	self.scrolledAnchorY = self.scrolledAnchorY + scrollY
	curAnchorY = curAnchorY + scrollY

	recthelper.setAnchorY(self.rectAnimRoot, curAnchorY)

	if math.abs(self.scrolledAnchorY) >= FightDoomsdayClockView.ItemHeight then
		self:onScrolledOneItemHeight()
	end
end

function FightDoomsdayClockView:onScrolledOneItemHeight()
	self.scrolledOffset = self.scrolledOffset + 1
	self.scrolledAnchorY = 0

	recthelper.setAnchorY(self.rectAnimRoot, 0)

	local curIndicatorValue = self.startValue + self.scrolledOffset * self.offsetSymbol

	self:setTimeValueTxt(curIndicatorValue)

	if self.scrolledOffset == self.totalOffset then
		self:onScrollAnimDone()
	end
end

function FightDoomsdayClockView:setTimeValueTxt(value)
	for i, txtDict in ipairs(self.txtTimeList) do
		for _, txt in pairs(txtDict) do
			txt.text = value - FightDoomsdayClockView.ScrollCenterCount + i
		end
	end
end

function FightDoomsdayClockView:setTimeValueActive(active)
	for i, goTime in ipairs(self.goTimeList) do
		gohelper.setActive(goTime, active or i == FightDoomsdayClockView.ScrollCenterCount)
	end
end

function FightDoomsdayClockView:onScrollAnimDone()
	self.startScrollAnim = false

	self:setTimeValueTxt(self.indicatorValue)
	self:setTimeValueActive(false)
	FightController.instance:dispatchEvent(FightEvent.OnIndicatorAnimationDone)
end

function FightDoomsdayClockView:onValueChange(oldValue, currValue, offset)
	self:tweenZhiZhen(offset)
	self:showFloat(offset)
	self.timeValueAnimator:Play("fit", 0, 0)
end

function FightDoomsdayClockView:onAreaChange()
	self:refreshArea()
	self:tweenZhiZhen()
end

function FightDoomsdayClockView:getParamValue(key)
	local param = FightDataHelper.fieldMgr.param
	local value = param and param:getKey(key)

	return value or 0
end

function FightDoomsdayClockView:onOpen()
	self.animator:Play("open")
	self:setTimeValueTxt(self.indicatorValue)
	self:refreshHighlightArea()
	self:refreshArea()
	self:directSetZhiZhenPos()
	self:initUpdateBeat()
end

function FightDoomsdayClockView:initUpdateBeat()
	self.updateHandle = UpdateBeat:CreateListener(self._onFrame, self)

	UpdateBeat:AddListener(self.updateHandle)
end

function FightDoomsdayClockView:tweenZhiZhen(offset)
	self:clearZhiZhenTween()

	if not offset then
		self:directSetZhiZhenPos()

		return
	end

	local curValue = self:getParamValue(FightParamData.ParamKey.DoomsdayClock_Value)
	local startValue = curValue - offset

	self.zhiZhenTweenId = ZProj.TweenHelper.DOTweenFloat(startValue, curValue, FightDoomsdayClockView.ZhiZhenTweenDuration, self.tweenFrame, self.directSetZhiZhenPos, self)

	AudioMgr.instance:trigger(20270055)
end

function FightDoomsdayClockView:tweenFrame(value)
	local maxValue = self:getParamValue(FightParamData.ParamKey.DoomsdayClock_Range4)
	local rate = value / maxValue
	local rotation = rate * 360

	transformhelper.setLocalRotation(self.trZhiZhen, 0, 0, -rotation)
end

function FightDoomsdayClockView:directSetZhiZhenPos()
	local rotation = self:getZhiZhenCurRotation()

	transformhelper.setLocalRotation(self.trZhiZhen, 0, 0, rotation)
end

function FightDoomsdayClockView:getZhiZhenCurRotation()
	local value = self:getParamValue(FightParamData.ParamKey.DoomsdayClock_Value)
	local maxValue = self:getParamValue(FightParamData.ParamKey.DoomsdayClock_Range4)
	local rate = value / maxValue
	local rotation = rate * 360

	return -rotation
end

FightDoomsdayClockView.RotateCircleAngle = 1800
FightDoomsdayClockView.RotateDuration = 1
FightDoomsdayClockView.RotateEaseType = EaseType.OutCirc

function FightDoomsdayClockView:refreshArea()
	local offsetValue = self:getParamValue(FightParamData.ParamKey.DoomsdayClock_Offset)
	local maxValue = self:getParamValue(FightParamData.ParamKey.DoomsdayClock_Range4)
	local offsetRate = offsetValue / maxValue
	local offsetAngle = offsetRate * 360
	local useArea = 0

	for key, image in pairs(self.key2Image) do
		local area = self:getParamValue(key)

		area = area - useArea
		image.fillAmount = area / maxValue

		local rotationZ = useArea / maxValue * 360

		transformhelper.setLocalRotation(self.key2Transform[key], 0, 0, -rotationZ + offsetAngle)
		transformhelper.setLocalRotation(self.key2ImageLine[key], 0, 0, -rotationZ + offsetAngle - 180)

		useArea = useArea + area
	end

	self:clearRotationTween()

	self.tweenRotationId = ZProj.TweenHelper.DOTweenFloat(0, FightDoomsdayClockView.RotateCircleAngle, FightDoomsdayClockView.RotateDuration, self.onRotateFrameCallback, self.onRotateDoneCallback, self, nil, FightDoomsdayClockView.RotateEaseType)

	AudioMgr.instance:trigger(20270056)
end

function FightDoomsdayClockView:onRotateFrameCallback(value)
	transformhelper.setLocalRotation(self.areaTransform, 0, 0, value)
end

function FightDoomsdayClockView:onRotateDoneCallback()
	transformhelper.setLocalRotation(self.areaTransform, 0, 0, 0)

	self.tweenRotationId = nil
end

function FightDoomsdayClockView:showFloat(offset)
	self:hideFloat()
	TaskDispatcher.cancelTask(self.hideFloat, self)

	if offset > 0 then
		gohelper.setActive(self.goAdd, true)

		self.txtAdd.text = string.format("%+d", offset)
	else
		gohelper.setActive(self.goReduce, true)

		self.txtReduce.text = string.format("%+d", offset)
	end

	TaskDispatcher.runDelay(self.hideFloat, self, 1)
end

function FightDoomsdayClockView:hideFloat()
	gohelper.setActive(self.goAdd, false)
	gohelper.setActive(self.goReduce, false)
end

function FightDoomsdayClockView:clearZhiZhenTween()
	if self.zhiZhenTweenId then
		ZProj.TweenHelper.KillById(self.zhiZhenTweenId)

		self.zhiZhenTweenId = nil
	end
end

function FightDoomsdayClockView:clearRotationTween()
	if self.tweenRotationId then
		ZProj.TweenHelper.KillById(self.tweenRotationId)

		self.tweenRotationId = nil
	end
end

function FightDoomsdayClockView:onDestroyView()
	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)
	end

	if self.btnClick then
		self.btnClick:RemoveClickListener()

		self.btnClick = nil
	end

	self:clearZhiZhenTween()
	self:clearRotationTween()
	TaskDispatcher.cancelTask(self.hideFloat, self)
end

return FightDoomsdayClockView
