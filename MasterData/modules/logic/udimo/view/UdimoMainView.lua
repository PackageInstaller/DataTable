-- chunkname: @modules/logic/udimo/view/UdimoMainView.lua

module("modules.logic.udimo.view.UdimoMainView", package.seeall)

local UdimoMainView = class("UdimoMainView", BaseView)

function UdimoMainView:onInitView()
	self._gomain = gohelper.findChild(self.viewGO, "#go_main")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/Left/#btn_Info")
	self._btnBG = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/Left/#btn_BG")
	self._btnChange = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#btn_Change")
	self._goslider = gohelper.findChild(self.viewGO, "#go_main/Slider")
	self._imagesliderValue = gohelper.findChildImage(self.viewGO, "#go_main/Slider/image_FG")
	self._goPress = gohelper.findChild(self.viewGO, "#go_main/#go_press")
	self._golockscreen = gohelper.findChild(self.viewGO, "#go_lockscreen")
	self._txtDate = gohelper.findChildText(self.viewGO, "#go_lockscreen/Layout/#txt_Date")
	self._txtDay = gohelper.findChildText(self.viewGO, "#go_lockscreen/Layout/#txt_Day")
	self._gotop = gohelper.findChild(self.viewGO, "#go_lockscreen/Top")
	self._goPoint = gohelper.findChild(self.viewGO, "#go_lockscreen/Top/Point")
	self._goWifi = gohelper.findChild(self.viewGO, "#go_lockscreen/Top/Wifi")
	self._goBattery = gohelper.findChild(self.viewGO, "#go_lockscreen/Top/Battery")
	self._imageBatteryValue = gohelper.findChildImage(self.viewGO, "#go_lockscreen/Top/Battery/image_Battery/image_Inner")
	self._goweathertitle = gohelper.findChild(self.viewGO, "#go_lockscreen/Left/image_SmallTitle")
	self._txtTemperature = gohelper.findChildText(self.viewGO, "#go_lockscreen/Left/#txt_Temperature")
	self._goweather = gohelper.findChild(self.viewGO, "#go_lockscreen/Left/#txt_Temperature/Weather")
	self._imageWeatherColor = gohelper.findChildImage(self.viewGO, "#go_lockscreen/Left/#txt_Temperature/Weather/image_BG")
	self._txtWeather = gohelper.findChildText(self.viewGO, "#go_lockscreen/Left/#txt_Temperature/Weather/image_BG/txt_Weather")
	self._imageWeatherIcon = gohelper.findChildImage(self.viewGO, "#go_lockscreen/Left/#txt_Temperature/Weather/image_BG/txt_Weather/#image_Icon")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_lockscreen/Left/#txt_Temperature/#txt_Tips")
	self._godrag = gohelper.findChild(self.viewGO, "#go_lockscreen/#go_drag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function UdimoMainView:addEvents()
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
	self._btnBG:AddClickListener(self._btnBGOnClick, self)
	self._btnChange:AddClickListener(self._btnChangeOnClick, self)
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._pressClick:AddClickDownListener(self._onPressClickDown, self)
	self._pressDrag:AddDragListener(self._onPressDrag, self)
	self._pressClick:AddClickUpListener(self._onPressClickUp, self)

	for i, timeComp in ipairs(self.timeCompList) do
		timeComp.animatorEvent:AddEventListener("updateOldTime", self["_onUpdateOldTime" .. i], self)
	end

	self.addEventCb(self, DeviceController.instance, DeviceEvent.OnBatteryStatusChange, self.refreshBattery, self)
	self.addEventCb(self, DeviceController.instance, DeviceEvent.OnBatteryValueChange, self.refreshBattery, self)
	self.addEventCb(self, DeviceController.instance, DeviceEvent.OnNetworkTypeChange, self.refreshNetworkType, self)
	self.addEventCb(self, UdimoController.instance, UdimoEvent.OnGetWeatherInfo, self.refreshWeather, self)
	self.addEventCb(self, UdimoController.instance, UdimoEvent.Switch2UdimoLockMode, self._switch2LockMode, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function UdimoMainView:removeEvents()
	self._btnInfo:RemoveClickListener()
	self._btnBG:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._drag:RemoveDragListener()
	self._pressClick:RemoveClickDownListener()
	self._pressDrag:RemoveDragListener()
	self._pressClick:RemoveClickUpListener()

	for i, timeComp in ipairs(self.timeCompList) do
		timeComp.animatorEvent:RemoveAllEventListener()
	end

	self.removeEventCb(self, DeviceController.instance, DeviceEvent.OnBatteryStatusChange, self.refreshBattery, self)
	self.removeEventCb(self, DeviceController.instance, DeviceEvent.OnBatteryValueChange, self.refreshBattery, self)
	self.removeEventCb(self, DeviceController.instance, DeviceEvent.OnNetworkTypeChange, self.refreshNetworkType, self)
	self.removeEventCb(self, UdimoController.instance, UdimoEvent.OnGetWeatherInfo, self.refreshWeather, self)
	self.removeEventCb(self, UdimoController.instance, UdimoEvent.Switch2UdimoLockMode, self._switch2LockMode, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function UdimoMainView:_btnInfoOnClick()
	UdimoController.instance:openInfoView()
end

function UdimoMainView:_btnBGOnClick()
	UdimoController.instance:openChangeBgView()
end

function UdimoMainView:_btnChangeOnClick()
	UdimoController.instance:openChangeDecorationView()
end

function UdimoMainView:_onDragBegin(param, pointerEventData)
	if not self._isLockMode then
		return
	end

	self._startPos = pointerEventData.position.x
end

function UdimoMainView:_onDrag(param, pointerEventData)
	if not self._startPos then
		return
	end
end

function UdimoMainView:_onPressClickDown(param, pos, delta)
	local pressUdimo = self._pressData.udimoId
	local pickedUpUdimo = UdimoModel.instance:getPickedUpUdimoId()

	if pressUdimo or pickedUpUdimo then
		return
	end

	local pressUdimoId, entity = UdimoHelper.getRaycastUdimo(pos)

	if pressUdimoId then
		AudioMgr.instance:trigger(AudioEnum.Udimo.play_ui_utim_dianan)
	end

	local isTranslating = entity and entity:getIsInTranslating()

	if pressUdimoId and not isTranslating then
		self._pressData.udimoId = pressUdimoId
		self._pressData.startTime = UnityEngine.Time.realtimeSinceStartup
		self._pressData.clickPos = pos

		local anchorX, anchorY = recthelper.screenPosToAnchorPos2(pos, self._transmain)

		self._pressData.sliderPos = {
			x = anchorX,
			y = anchorY
		}

		TaskDispatcher.cancelTask(self._onPressing, self)
		TaskDispatcher.runRepeat(self._onPressing, self, 0.01)
	end
end

function UdimoMainView:_onPressing()
	local pressProgress = 0
	local pressUdimoId = self._pressData.udimoId
	local pressStartTime = self._pressData.startTime
	local pickedUpUdimo = UdimoModel.instance:getPickedUpUdimoId()
	local isPressing = not pickedUpUdimo and pressUdimoId and pressStartTime

	if isPressing then
		local passTime = UnityEngine.Time.realtimeSinceStartup - pressStartTime

		pressProgress = GameUtil.clamp(passTime / UdimoEnum.Const.UdimoPickedUpTime, 0, 1)
	end

	self:refreshSlider(pressProgress, self._pressData.sliderPos)

	if pressProgress >= 1 then
		UdimoController.instance:pickUpUdimo(pressUdimoId, self._pressData.clickPos)
		TaskDispatcher.cancelTask(self._onPressing, self)
	end
end

function UdimoMainView:_onPressDrag(param, eventData)
	local pos = eventData.position
	local pressUdimoId = self._pressData.udimoId
	local pickedUpUdimo = UdimoModel.instance:getPickedUpUdimoId()

	if pickedUpUdimo and self._scene then
		self._scene.udimomgr:updateUdimoCurStateParam(pickedUpUdimo, UdimoEnum.UdimoState.PickedUp, {
			dragPos = pos
		})
	elseif pressUdimoId then
		local newPressUdimoId = UdimoHelper.getRaycastUdimo(pos)

		if newPressUdimoId ~= pressUdimoId then
			self._pressData.udimoId = nil
		else
			self._pressData.clickPos = pos
		end
	end
end

function UdimoMainView:_onPressClickUp(param, pos, delta)
	self._pressData = {}

	UdimoController.instance:pickUpUdimoOver(pos)
end

local DRAG_DISTANCE = 100

function UdimoMainView:_onDragEnd(param, pointerEventData)
	if not self._startPos then
		return
	end

	local endPos = pointerEventData.position.x

	if endPos > self._startPos and endPos - self._startPos >= DRAG_DISTANCE then
		self.playAnim(self, UIAnimationName.Close, self.switchMode, self)
		AudioMgr.instance:trigger(AudioEnum.Udimo.play_ui_utim_daiji3)
	end

	self._startPos = nil
end

function UdimoMainView:_switch2LockMode()
	self:switchMode(true)
end

function UdimoMainView:_onOpenView(viewName)
	if self._isLockMode then
		return
	end

	local isDecorationView = viewName == ViewName.UdimoChangeDecorationView
	local isInfoView = viewName == ViewName.UdimoInfoView

	if isDecorationView or isInfoView then
		if isDecorationView then
			self.playAnim(self, UIAnimationName.Close, self._hideMain, self)
		end

		self._scene.udimomgr:setUdimoNodeActive(false)
	end
end

function UdimoMainView:_hideMain()
	gohelper.setActive(self._gomain, false)
end

function UdimoMainView:_onCloseView(viewName)
	if self._isLockMode then
		return
	end

	local isDecorationView = viewName == ViewName.UdimoChangeDecorationView
	local isInfoView = viewName == ViewName.UdimoInfoView

	if isDecorationView or isInfoView then
		if isDecorationView then
			gohelper.setActive(self._gomain, true)
			self:playAnim(UIAnimationName.Open)
		end

		self._scene.udimomgr:setUdimoNodeActive(true)
	end
end

local TIME_NUM = 4

function UdimoMainView:_editableInitView()
	self._scene = UdimoController.instance:getUdimoScene()
	self._mianAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._gomain)
	self._lockAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._golockscreen)
	self._transmain = self._gomain.transform
	self._transslider = self._goslider.transform
	self._lastGetInfoTime = Time.realtimeSinceStartup
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag)
	self._pressClick = SLFramework.UGUI.UIClickListener.Get(self._goPress)
	self._pressDrag = SLFramework.UGUI.UIDragListener.Get(self._goPress)
	self._pressData = {}
	self.timeCompList = {}

	for i = 1, TIME_NUM do
		local timeComp = self:getUserDataTb_()

		timeComp.txtOldTime = gohelper.findChildText(self.viewGO, string.format("#go_lockscreen/#txt_Time/txt_item%s/#txt_old", i))
		timeComp.txtNewTime = gohelper.findChildText(self.viewGO, string.format("#go_lockscreen/#txt_Time/txt_item%s/#txt_new", i))

		local timeGO = gohelper.findChild(self.viewGO, string.format("#go_lockscreen/#txt_Time/txt_item%s", i))

		timeComp.animator = timeGO:GetComponent(typeof(UnityEngine.Animator))
		timeComp.animatorEvent = timeGO:GetComponent(typeof(ZProj.AnimationEventWrap))
		self.timeCompList[i] = timeComp
	end
end

function UdimoMainView:onUpdateParam()
	self:switchMode(self.viewParam and self.viewParam.isLock)
end

function UdimoMainView:onOpen()
	self._openTime = Time.time

	self:_stat(StatEnum.UdimoOperationType.UdimoEnter)
	self:onUpdateParam()

	if not self._isLockMode then
		AudioMgr.instance:trigger(AudioEnum.Udimo.play_ui_utim_open)
	end

	self:_everySecondCall(true)
	TaskDispatcher.cancelTask(self._everySecondCall, self)
	TaskDispatcher.runRepeat(self._everySecondCall, self, TimeUtil.OneSecond)
end

function UdimoMainView:switchMode(isLockMode)
	if self._isLockMode and self._isLockMode == isLockMode then
		return
	end

	self._isLockMode = not not isLockMode

	if self._isLockMode then
		self:_everySecondCall(true)
		AudioMgr.instance:trigger(AudioEnum.Udimo.play_ui_utim_daiji)
	end

	gohelper.setActive(self._golockscreen, self._isLockMode)
	gohelper.setActive(self._gomain, not self._isLockMode)
	self:refresh()

	if self._isLockMode then
		self._switchModeTime = Time.time

		self:_stat(StatEnum.UdimoOperationType.UdimoLock)
	else
		self:_stat(StatEnum.UdimoOperationType.UdimoUnlock, self._switchModeTime)
	end
end

function UdimoMainView:playAnim(animName, cb, cbObj)
	if self._isLockMode then
		self._lockAnimatorPlayer:Play(animName, cb, cbObj)
	else
		self._mianAnimatorPlayer:Play(animName, cb, cbObj)
	end
end

function UdimoMainView:refresh()
	self:refreshNetworkType()
	self:refreshBattery()
	self:refreshWeather()
	self:refreshSlider()
end

function UdimoMainView:refreshNetworkType()
	if not self._isLockMode then
		return
	end

	local networkType = DeviceModel.instance:getNetworkType()

	gohelper.setActive(self._goPoint, networkType == DeviceEnum.NetWorkType.Mobile)
	gohelper.setActive(self._goWifi, networkType == DeviceEnum.NetWorkType.Wifi)
end

function UdimoMainView:refreshBattery()
	if not self._isLockMode then
		return
	end

	local batteryValue = DeviceModel.instance:getBatteryValue()

	if batteryValue then
		local status = DeviceModel.instance:getBatteryStatus()

		SLFramework.UGUI.GuiHelper.SetColor(self._imageBatteryValue, (status == DeviceEnum.BatteryStatus.Charge or nil) and "#00FF00")

		self._imageBatteryValue.fillAmount = Mathf.Clamp(batteryValue / DeviceEnum.Const.MaxBatteryValue, 0, 1)
	end

	gohelper.setActive(self._goBattery, batteryValue)
end

function UdimoMainView:refreshWeather()
	if not self._isLockMode then
		return
	end

	local weatherId = UdimoWeatherModel.instance:getWeatherId()
	local winLevel = UdimoWeatherModel.instance:getWindLevel()
	local strTemperature = UdimoWeatherModel.instance:getTemperature()
	local numTemperature = not string.nilorempty(strTemperature) and tonumber(strTemperature)

	if numTemperature then
		numTemperature = math.floor(numTemperature + 0.5)
		self._txtTemperature.text = numTemperature

		local cfgWeatherId = UdimoConfig.instance:findCfgWeatherId(weatherId, winLevel)

		self._txtTips.text = UdimoConfig.instance:getTemperatureTip(cfgWeatherId, numTemperature)
	end

	local weatherInfo = UdimoConfig.instance:getWeatherInfo(weatherId, winLevel)

	if weatherInfo then
		self._txtWeather.text = weatherInfo.name

		UISpriteSetMgr.instance:setUdimoSprite(self._imageWeatherIcon, weatherInfo.icon)

		if string.nilorempty(weatherInfo.color) then
			ZProj.UGUIHelper.SetColorAlpha(self._imageWeatherColor, 0)
		else
			SLFramework.UGUI.GuiHelper.SetColor(self._imageWeatherColor, weatherInfo.color)
			ZProj.UGUIHelper.SetColorAlpha(self._imageWeatherColor, 1)
		end
	end

	local showWeather = numTemperature and weatherInfo

	gohelper.setActive(self._txtTips, showWeather)
	gohelper.setActive(self._txtTemperature, showWeather)
	gohelper.setActive(self._goweather, showWeather)
	gohelper.setActive(self._goweathertitle, (showWeather or nil) and SettingsModel.instance:isOverseas())
end

function UdimoMainView:refreshSlider(progress, pos)
	if self._isLockMode then
		gohelper.setActive(self._goslider, false)
	else
		progress = progress or 0

		local pickedUpUdimo = UdimoModel.instance:getPickedUpUdimoId()
		local isPressing = not pickedUpUdimo and self._pressData.udimoId

		if isPressing then
			self._imagesliderValue.fillAmount = progress

			if pos then
				recthelper.setAnchor(self._transslider, pos.x, pos.y)
			end
		end

		gohelper.setActive(self._goslider, isPressing and progress < 1)
	end
end

local GET_INFO_INTERVAL = TimeUtil.OneHourSecond

function UdimoMainView:_everySecondCall(onOpen)
	self:refreshTime(onOpen)

	local curTime = Time.realtimeSinceStartup

	if not self._lastGetInfoTime or curTime - self._lastGetInfoTime >= GET_INFO_INTERVAL then
		UdimoController.instance:getUdimoInfo()

		self._lastGetInfoTime = curTime
	end

	UdimoController.instance:onGetWeatherInfo()
end

function UdimoMainView:refreshTime(onOpen)
	if not self._isLockMode then
		return
	end

	self.digits = {}

	local dt = ServerTime.nowDateInLocal()
	local timeStr = string.format("%02d%02d", dt.hour, dt.min)

	for digit in string.gmatch(timeStr, "%d") do
		table.insert(self.digits, digit)
	end

	for i, timeNum in ipairs(self.digits) do
		local timeComp = self.timeCompList[i]

		if timeComp then
			if not onOpen and timeComp.txtOldTime.text ~= timeNum then
				timeComp.animator:Play("switch", 0, 0)

				timeComp.txtNewTime.text = timeNum
			else
				timeComp.txtOldTime.text = timeNum
				timeComp.txtNewTime.text = timeNum
			end
		end
	end

	self._txtDate.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("player_birthday"), dt.month, dt.day)

	local weekDay = TimeUtil.getTodayWeedDay(dt)

	self._txtDay.text = TimeUtil.weekDayToLangStr(weekDay)
end

function UdimoMainView:_onUpdateOldTime1()
	self:updateOldTimeTxt(1)
end

function UdimoMainView:_onUpdateOldTime2()
	self:updateOldTimeTxt(2)
end

function UdimoMainView:_onUpdateOldTime3()
	self:updateOldTimeTxt(3)
end

function UdimoMainView:_onUpdateOldTime4()
	self:updateOldTimeTxt(4)
end

function UdimoMainView:updateOldTimeTxt(index)
	local timeComp = self.timeCompList[index]

	if timeComp then
		timeComp.txtOldTime.text = timeComp.txtNewTime.text
	end
end

function UdimoMainView:onClose()
	TaskDispatcher.cancelTask(self._onPressing, self)
	TaskDispatcher.cancelTask(self._everySecondCall, self)
	self:_stat(StatEnum.UdimoOperationType.UdimoExit, self._openTime)
end

function UdimoMainView:_stat(opType, startTime)
	UdimoStatController.instance:udimoViewOperation(opType, (startTime or nil) and Time.time - tonumber(startTime))
end

function UdimoMainView:onDestroyView()
	return
end

return UdimoMainView
