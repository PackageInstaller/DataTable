-- chunkname: @modules/logic/bgmswitch/view/BGMSwitchEggView.lua

module("modules.logic.bgmswitch.view.BGMSwitchEggView", package.seeall)

local BGMSwitchEggView = class("BGMSwitchEggView", BaseView)

function BGMSwitchEggView:onInitView()
	self._gointerface = gohelper.findChild(self.viewGO, "#go_mechine/#go_interference")
	self._btnbeatmechine = gohelper.findChildButton(self.viewGO, "#go_mechine/#btn_beatmechine")
	self._slidercontrol = gohelper.findChildSlider(self.viewGO, "#go_mechine/#slider_control")
	self._txtNum1 = gohelper.findChildText(self.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num1")
	self._txtNum2 = gohelper.findChildText(self.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num2")
	self._txtNum3 = gohelper.findChildText(self.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num3")
	self._txtNum4 = gohelper.findChildText(self.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num4")
	self._txtNum5 = gohelper.findChildText(self.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num5")
	self._txtNum6 = gohelper.findChildText(self.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num6")
	self._txtNum7 = gohelper.findChildText(self.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num7")
	self._goppt = gohelper.findChild(self.viewGO, "#go_mechine/#go_ppt")
	self._controlHandleAni = gohelper.findChild(self._slidercontrol.gameObject, "Handle"):GetComponent(typeof(UnityEngine.Animator))
	self._pptAni = self._goppt:GetComponent(typeof(UnityEngine.Animator))
	self._viewAni = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._simagepptpic1 = gohelper.findChildSingleImage(self._goppt, "#simage_pic1")
	self._simagepptpic2 = gohelper.findChildSingleImage(self._goppt, "#simage_pic2")
	self._imagepptpic1 = gohelper.findChildImage(self._goppt, "#simage_pic1")
	self._imagepptpic2 = gohelper.findChildImage(self._goppt, "#simage_pic2")
	self._egg2Items = {}

	for i = 1, 4 do
		self._egg2Items[i] = self._egg2Items[i] or {}
		self._egg2Items[i].go = gohelper.findChild(self.viewGO, "#go_mechine/#btn_control/btn0" .. tostring(i))
		self._egg2Items[i].btn = gohelper.findChildButton(self.viewGO, "#go_mechine/#btn_control/btn0" .. tostring(i))

		self._egg2Items[i].btn:AddClickListener(self._egg2itemBtnOnclick, self, i)

		self._egg2Items[i].goup = gohelper.findChild(self._egg2Items[i].go, "up")
		self._egg2Items[i].godown = gohelper.findChild(self._egg2Items[i].go, "down")
	end
end

function BGMSwitchEggView:addEvents()
	self._btnbeatmechine:AddClickListener(self._btnbeatmechineOnClick, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, self._onSelectPlayGear, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.RandomFinished, self._refreshBottomEggBtns, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.ItemSelected, self._onBgmItemSelected, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, self._onBgmSwitched, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, self._onBgmSwitched, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.PlayShakingAni, self._playShakingAniByGuide, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.SlideValueUpdate, self._sliderValueUpdate, self)
end

function BGMSwitchEggView:removeEvents()
	self._btnbeatmechine:RemoveClickListener()
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, self._onSelectPlayGear, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.RandomFinished, self._refreshBottomEggBtns, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.ItemSelected, self._onBgmItemSelected, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, self._onBgmSwitched, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, self._onBgmSwitched, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.PlayShakingAni, self._playShakingAniByGuide, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.SlideValueUpdate, self._sliderValueUpdate, self)
	TaskDispatcher.cancelTask(self._refreshBottomEggBtns, self)
end

function BGMSwitchEggView:_onSliderValueChanged(sliderValue)
	self.selectIndex = sliderValue
end

function BGMSwitchEggView:onOpen()
	gohelper.setActive(self._gointerface, false)
	self:checkTrigger()

	if not BGMSwitchModel.instance:getEggHideState() then
		self:_startCheckEasterEgg()
	end

	BGMSwitchModel.instance:setEggHideState(false)
	self:_updateEggBtnsAndShowPpt()
end

function BGMSwitchEggView:_onBgmSwitched()
	self:_onBgmItemSelected(BGMSwitchModel.instance:getCurBgm())
end

function BGMSwitchEggView:_sliderValueUpdate()
	if not BGMSwitchModel.instance:getEggIsTrigger() then
		return
	end

	self:_checkAndShowPpt()
end

function BGMSwitchEggView:_onSelectPlayGear()
	self:checkTrigger()
	self:_hideEasterEggType1()
	self:_updateEggBtnsAndShowPpt()
end

function BGMSwitchEggView:checkTrigger()
	if BGMSwitchModel.instance:getEggIsTrigger() then
		for i = 1, 4 do
			BGMSwitchModel.instance:setEggType2State(i, false)
		end

		BGMSwitchModel.instance:setEggIsTrigger(false)
		BGMSwitchModel.instance:setPPtEffectEgg2Id(nil)
		self._controlHandleAni:Play("flashing", 0, 1)
	end
end

function BGMSwitchEggView:_updateEggBtnsAndShowPpt()
	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear == BGMSwitchEnum.Gear.OFF then
		self._controlHandleAni:Play("flashing", 0, 1)
	else
		self:_startCheckEasterEgg()
	end

	self:_checkAndShowPpt()
	self:_refreshBottomEggBtns()
end

function BGMSwitchEggView:_onBgmItemSelected(beforeBgmId)
	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear ~= BGMSwitchEnum.Gear.On1 then
		return
	end

	local bgmId = BGMSwitchModel.instance:getCurBgm()

	if BGMSwitchModel.instance:isValidBgmId(bgmId) then
		TaskDispatcher.runDelay(self._refreshBottomEggBtns, self, 0.67)
	else
		self:_refreshBottomEggBtns()
	end
end

function BGMSwitchEggView:_egg2itemBtnOnclick(index)
	if BGMSwitchModel.instance:getEggIsTrigger() and self:_isHaveEggShowConfig(BGMSwitchModel.instance:getPPtEffectEgg2Id()) then
		GameFacade.showToast(ToastEnum.KeepStableNoEggControl)

		return
	end

	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear ~= BGMSwitchEnum.Gear.OFF then
		self._controlHandleAni:Play("flashing", 0, 0)
	end

	local state = BGMSwitchModel.instance:getEggType2SateByIndex(index)

	BGMSwitchModel.instance:setEggType2State(index, not state)
	self:_refreshBottomEggBtns()
	self:_startCheckEasterEggType2()
	BGMSwitchAudioTrigger.play_ui_replay_buttonegg()
end

function BGMSwitchEggView:_btnbeatmechineOnClick()
	BGMSwitchAudioTrigger.play_ui_replay_flap()

	self._beatTime = self._beatTime or 0
	self._beatTime = self._beatTime + 1

	self._viewAni:Play("shaking", 0, 0)

	local eggCo = BGMSwitchConfig.instance:getBgmEasterEggCo(self._eggType1Id)

	if self._beatTime >= tonumber(eggCo.param2) then
		if not self._triggerEggType1Id or self._triggerEggType1Id == 0 then
			local isInBGMGuide = GuideModel.instance:isGuideRunning(BGMSwitchEnum.BGMGuideId)

			if isInBGMGuide then
				return
			end

			self._beatTime = 0

			local gear = BGMSwitchModel.instance:getMechineGear()

			if gear == BGMSwitchEnum.Gear.OFF then
				GameFacade.showToast(ToastEnum.MachineNoRun)
			end

			if gear == BGMSwitchEnum.Gear.On1 or BGMSwitchModel.instance:getEggIsTrigger() then
				GameFacade.showToast(ToastEnum.MachineIsOkNoBeat)
			end

			if BGMSwitchModel.instance:machineGearIsInSnowflakeScene() and not BGMSwitchModel.instance:getEggIsTrigger() then
				GameFacade.showToast(ToastEnum.MachineNotShowView)
			end
		else
			self:_hideEasterEggType1()
		end
	end
end

function BGMSwitchEggView:_startCheckEasterEgg()
	local gear = BGMSwitchModel.instance:getMechineGear()
	local eggCos = BGMSwitchConfig.instance:getBgmEasterEggCos()

	for _, v in pairs(eggCos) do
		if v.type == BGMSwitchEnum.EasterEggType.Beat then
			self._eggType1Id = v.id

			if gear ~= BGMSwitchEnum.Gear.OFF and BGMSwitchModel.instance:getPPtEffectEgg2Id() == nil then
				self:_startCheckEasterEggType1(v.id)
			end
		elseif v.type == BGMSwitchEnum.EasterEggType.Ppt and gear ~= BGMSwitchEnum.Gear.OFF and self._triggerEggType1Id == nil then
			self:_startCheckEasterEggType2(v.id)
		end
	end
end

function BGMSwitchEggView:_startCheckEasterEggType1(eggId)
	local eggCo = BGMSwitchConfig.instance:getBgmEasterEggCo(eggId)
	local randomNum = math.random(1, 1000)

	if self._lasttriggerEggType1Id then
		self._lasttriggerEggType1Id = nil

		return
	end

	if randomNum < tonumber(eggCo.param1) and self:needCheckRandomNum() then
		self._triggerEggType1Id = eggId
		self._lasttriggerEggType1Id = eggId

		self:_showEasterEggType1()
	end
end

function BGMSwitchEggView:needCheckRandomNum()
	return self._lasttriggerEggType1Id == nil
end

function BGMSwitchEggView:_showEasterEggType1()
	self._beatTime = 0

	gohelper.setActive(self._gointerface, true)

	local isInBGMGuide = GuideModel.instance:isGuideRunning(BGMSwitchEnum.BGMGuideId)

	if isInBGMGuide then
		return
	end

	local eggCo = BGMSwitchConfig.instance:getBgmEasterEggCo(self._eggType1Id)
	local delayTime = Mathf.Floor(tonumber(eggCo.param3) / 1000)

	TaskDispatcher.runDelay(self._hideEasterEggType1, self, delayTime)
end

function BGMSwitchEggView:_hideEasterEggType1()
	TaskDispatcher.cancelTask(self._hideEasterEggType1, self)
	gohelper.setActive(self._gointerface, false)

	self._triggerEggType1Id = nil
	self._beatTime = 0
end

function BGMSwitchEggView:_startCheckEasterEggType2(eggId)
	gohelper.setActive(self._goppt, false)

	local eggStates = BGMSwitchModel.instance:getEggType2Sates()
	local str = eggStates[1] and "2" or "1"

	for i = 2, 4 do
		local result = eggStates[i] and "#2" or "#1"

		str = str .. result
	end

	if eggId then
		local eggCo = BGMSwitchConfig.instance:getBgmEasterEggCo(eggId)

		if eggCo.param1 == str then
			self:_startEgg2Effect(eggId)
		end

		return
	end

	local egg2Cos = BGMSwitchConfig.instance:getBgmEasterEggCosByType(BGMSwitchEnum.EasterEggType.Ppt)

	for _, v in pairs(egg2Cos) do
		if v.param1 == str then
			self:_startEgg2Effect(v.id)

			return
		end
	end

	BGMSwitchModel.instance:setPPtEffectEgg2Id(nil)
end

function BGMSwitchEggView:_startEgg2Effect(eggId)
	local gear = BGMSwitchModel.instance:getMechineGear()

	if self:_isHaveEggShowConfig(eggId) then
		BGMSwitchModel.instance:setPPtEffectEgg2Id(eggId)

		if gear ~= BGMSwitchEnum.Gear.OFF then
			self._controlHandleAni:Play("marquee", 0, 0)
		end

		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ToggleEggForGuide)
	else
		BGMSwitchModel.instance:setPPtEffectEgg2Id(nil)

		if gear ~= BGMSwitchEnum.Gear.OFF then
			self._controlHandleAni:Play("loop", 0, 0)
		end
	end
end

function BGMSwitchEggView:_isHaveEggShowConfig(eggId, showType)
	local eggCo = BGMSwitchConfig.instance:getBgmEasterEggCo(eggId)

	if eggCo then
		local pptCos = string.split(eggCo.param2, "|")

		if showType then
			return pptCos[showType] and pptCos[showType] ~= ""
		end

		return eggCo.param2 ~= "" and eggCo.param3 ~= ""
	end

	return false
end

function BGMSwitchEggView:_checkAndShowPpt()
	TaskDispatcher.cancelTask(self._pptUpdate, self)

	local eggId = BGMSwitchModel.instance:getPPtEffectEgg2Id()

	self._pptRepeatCount = 0

	if not eggId or not BGMSwitchModel.instance:machineGearIsInSnowflakeScene() then
		gohelper.setActive(self._goppt, false)

		return
	end

	BGMSwitchModel.instance:setEggIsTrigger(true)

	if not self:_isHaveEggShowConfig(eggId, BGMSwitchModel.instance:getAudioCurShowType()) then
		gohelper.setActive(self._goppt, false)

		return
	end

	local eggCo = BGMSwitchConfig.instance:getBgmEasterEggCo(BGMSwitchModel.instance:getPPtEffectEgg2Id())
	local showType = BGMSwitchModel.instance:getAudioCurShowType()
	local pptCos = string.split(string.split(eggCo.param2, "|")[showType], "#")

	self._simagepptpic1:LoadImage(ResUrl.getBgmEggIcon(pptCos[1]))
	self._simagepptpic2:LoadImage(ResUrl.getBgmEggIcon(pptCos[1]))
	TaskDispatcher.runRepeat(self._pptUpdate, self, tonumber(eggCo.param3) / 1000)
	gohelper.setActive(self._goppt, true)
end

function BGMSwitchEggView:_pptUpdate()
	self._pptAni:Play("swicth", 0, 0)

	self._pptRepeatCount = self._pptRepeatCount + 1

	local eggCo = BGMSwitchConfig.instance:getBgmEasterEggCo(BGMSwitchModel.instance:getPPtEffectEgg2Id())
	local showType = BGMSwitchModel.instance:getAudioCurShowType()
	local pptCos = string.split(string.split(eggCo.param2, "|")[showType], "#")
	local tarImg = pptCos[self._pptRepeatCount % #pptCos + 1]

	self._imagepptpic1.sprite = self._imagepptpic2.sprite

	self._simagepptpic2:LoadImage(ResUrl.getBgmEggIcon(tarImg))
end

function BGMSwitchEggView:_refreshBottomEggBtns()
	local states = BGMSwitchModel.instance:getEggType2Sates()

	for i = 1, 4 do
		gohelper.setActive(self._egg2Items[i].goup, not states[i])
		gohelper.setActive(self._egg2Items[i].godown, states[i])
	end
end

function BGMSwitchEggView:_playShakingAniByGuide()
	self._viewAni:Play("shaking", 0, 0)
end

function BGMSwitchEggView:onDestroyView()
	TaskDispatcher.cancelTask(self._pptUpdate, self)

	if self._egg2Items then
		for _, v in pairs(self._egg2Items) do
			v.btn:RemoveClickListener()
		end

		self._egg2Items = nil
	end
end

return BGMSwitchEggView
