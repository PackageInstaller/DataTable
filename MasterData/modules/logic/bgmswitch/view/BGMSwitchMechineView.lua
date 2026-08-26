-- chunkname: @modules/logic/bgmswitch/view/BGMSwitchMechineView.lua

module("modules.logic.bgmswitch.view.BGMSwitchMechineView", package.seeall)

local BGMSwitchMechineView = class("BGMSwitchMechineView", BaseView)

function BGMSwitchMechineView:onInitView()
	self._gomechine = gohelper.findChild(self.viewGO, "#go_mechine")
	self._mechineAni = self._gomechine:GetComponent(typeof(UnityEngine.Animator))
	self._simagemechine = gohelper.findChildSingleImage(self.viewGO, "#go_mechine/#simage_mechine")
	self._btnoff = gohelper.findChildButton(self.viewGO, "#go_mechine/#simage_mechine/#btn_off")
	self._btnon1 = gohelper.findChildButton(self.viewGO, "#go_mechine/#simage_mechine/#btn_on1")
	self._btnon2 = gohelper.findChildButton(self.viewGO, "#go_mechine/#simage_mechine/#btn_on2")
	self._btnon3 = gohelper.findChildButton(self.viewGO, "#go_mechine/#simage_mechine/#btn_on3")
	self._btnmid = gohelper.findChildButton(self.viewGO, "#go_mechine/#simage_mechine/#btn_mid")
	self._goturnOn = gohelper.findChild(self.viewGO, "#go_mechine/#go_turnOn")
	self._gochatwindow = gohelper.findChild(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow")
	self._goplay = gohelper.findChild(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play")
	self._playAni = self._goplay:GetComponent(typeof(UnityEngine.Animator))
	self._txtplaytitle = gohelper.findChildText(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#txt_playtitle")
	self._goplayname = gohelper.findChild(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#go_playname")
	self._txtplayname = gohelper.findChildText(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#go_playname/#txt_playname")
	self._txtplaynameen = gohelper.findChildText(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#go_playname/#txt_playname/#txt_playnameen")
	self._sliderplay = gohelper.findChildSlider(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#slider_play")
	self._imgEffect = gohelper.findChildImage(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#playeffect")
	self._txtplayprogresstime = gohelper.findChildText(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#slider_play/#txt_playprogresstime")
	self._txtplayprogresslength = gohelper.findChildText(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#slider_play/#txt_playprogresslength")
	self._golike = gohelper.findChild(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/like/#go_playlike")
	self._golikeBg = gohelper.findChild(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/like/image_LikeBG")
	self._godesc = gohelper.findChild(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc")
	self._descAni = self._godesc:GetComponent(typeof(UnityEngine.Animator))
	self._txtdesctitle = gohelper.findChildText(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#txt_desctitle")
	self._txtdescname = gohelper.findChildText(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#txt_descname")
	self._txtdescnameen = gohelper.findChildText(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#txt_descname/#txt_descnameen")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#scroll_desc")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#scroll_desc/Viewport/#txt_Descr")
	self._gocomment = gohelper.findChild(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_comment")
	self._commentAni = self._gocomment:GetComponent(typeof(UnityEngine.Animator))
	self._scrollcomment = gohelper.findChildScrollRect(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_comment/#scroll_comment")
	self._gocommentItem = gohelper.findChild(self.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_comment/#scroll_comment/Viewport/commentitem")
	self._goxuehuaping = gohelper.findChild(self.viewGO, "#go_mechine/#go_xuehuaping")
	self._gointerface = gohelper.findChild(self.viewGO, "#go_mechine/#go_interference")
	self._goturnOnEffect = gohelper.findChild(self.viewGO, "#go_mechine/turnon_effect")
	self._gocontrol = gohelper.findChild(self.viewGO, "#go_mechine/#go_control")
	self._gopowerlight = gohelper.findChild(self.viewGO, "#go_mechine/#btn_power/light")
	self._gochannelbtns = gohelper.findChild(self.viewGO, "#go_mechine/#go_channelbtns")
	self._sliderChannel = gohelper.findChildSlider(self.viewGO, "#go_mechine/#slider_Channel")
	self._goswtichbtns = gohelper.findChild(self.viewGO, "#go_mechine/#go_swtichbtns")
	self._btnswitchleft = gohelper.findChildButton(self.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchleft")
	self._goswitchleftselected = gohelper.findChild(self.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchleft/#go_switchleftselected")
	self._goswitchleftunselected = gohelper.findChild(self.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchleft/#go_switchleftunselected")
	self._btnswitchright = gohelper.findChildButton(self.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchright")
	self._goswitchrightselected = gohelper.findChild(self.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchright/#go_switchrightselected")
	self._goswitchrightunselected = gohelper.findChild(self.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchright/#go_switchrightunselected")
	self._gotap = gohelper.findChild(self.viewGO, "#go_mechine/#go_tap")
	self._tapAni = self._gotap:GetComponent(typeof(UnityEngine.Animator))
	self._gotapicon = gohelper.findChild(self.viewGO, "#go_mechine/#go_tap/#go_tapicon")
	self._imagetape1 = gohelper.findChildImage(self.viewGO, "#go_mechine/#go_tap/#go_tapicon/#image_tap1")
	self._imagetape2 = gohelper.findChildImage(self.viewGO, "#go_mechine/#go_tap/#go_tapicon/#image_tap2")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._sliderChannel.gameObject)
	self._click = SLFramework.UGUI.UIClickListener.Get(self._sliderChannel.gameObject)
	self._controlAni = self._gocontrol:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BGMSwitchMechineView:addEvents()
	self._btnoff:AddClickListener(self._btnoffOnClick, self)
	self._btnon1:AddClickListener(self._btnon1OnClick, self)
	self._btnon2:AddClickListener(self._btnon2OnClick, self)
	self._btnon3:AddClickListener(self._btnon3OnClick, self)
	self._btnmid:AddClickListener(self._btnmidOnClick, self)
	self._btnswitchleft:AddClickListener(self._btnswitchleftOnClick, self)
	self._btnswitchright:AddClickListener(self._btnswitchrightOnClick, self)
	self._drag:AddDragEndListener(self._onSliderEnd, self)
	self._click:AddClickUpListener(self._onSlideClick, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmDevicePlayNoise, self._showNoiseViewByGuide, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BGMDeviceShowNormalView, self._showNormalViewByGuide, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.ItemSelected, self._onBgmItemSelected, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmProgressEnd, self._progressFinished, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, self._onBgmSwitched, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, self._onBgmFavorite, self)
end

function BGMSwitchMechineView:removeEvents()
	self._btnoff:RemoveClickListener()
	self._btnon1:RemoveClickListener()
	self._btnon2:RemoveClickListener()
	self._btnon3:RemoveClickListener()
	self._btnmid:RemoveClickListener()
	self._btnswitchleft:RemoveClickListener()
	self._btnswitchright:RemoveClickListener()
	self._drag:RemoveDragEndListener()
	self._click:RemoveClickUpListener()
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmDevicePlayNoise, self._showNoiseViewByGuide, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BGMDeviceShowNormalView, self._showNormalViewByGuide, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.ItemSelected, self._onBgmItemSelected, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmProgressEnd, self._progressFinished, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, self._onBgmSwitched, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, self._onBgmFavorite, self)
end

local sliderReference = {
	0.15,
	0.5,
	0.85
}

function BGMSwitchMechineView:_btnoffOnClick()
	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear == BGMSwitchEnum.Gear.OFF then
		return
	end

	self:_switchGearTo(gear, BGMSwitchEnum.Gear.OFF)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.OFF)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")

	local delayTime = 0.267 * (BGMSwitchEnum.Gear.OFF + (4 - gear))

	TaskDispatcher.runDelay(self._switchGearAniFinished, self, delayTime)
end

function BGMSwitchMechineView:_btnon1OnClick()
	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear == BGMSwitchEnum.Gear.On1 then
		return
	end

	self._beforeGear = gear

	self:_switchGearTo(gear, BGMSwitchEnum.Gear.On1)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.On1)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")

	if gear < BGMSwitchEnum.Gear.On1 then
		if not (0.267 * (BGMSwitchEnum.Gear.On1 - gear)) then
			local delayTime = 0.267 * (BGMSwitchEnum.Gear.On1 + (4 - gear))

			TaskDispatcher.runDelay(self._switchGearAniFinished, self, delayTime)
		end
	end
end

function BGMSwitchMechineView:_btnon2OnClick()
	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear == BGMSwitchEnum.Gear.On2 then
		return
	end

	self._beforeGear = gear

	self:_switchGearTo(gear, BGMSwitchEnum.Gear.On2)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.On2)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")

	if gear < BGMSwitchEnum.Gear.On2 then
		if not (0.267 * (BGMSwitchEnum.Gear.On2 - gear)) then
			local delayTime = 0.267 * (BGMSwitchEnum.Gear.On2 + (4 - gear))

			TaskDispatcher.runDelay(self._switchGearAniFinished, self, delayTime)
		end
	end
end

function BGMSwitchMechineView:_btnon3OnClick()
	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear == BGMSwitchEnum.Gear.On3 then
		return
	end

	self._beforeGear = gear

	self:_switchGearTo(gear, BGMSwitchEnum.Gear.On3)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.On3)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")

	local delayTime = 0.267 * (BGMSwitchEnum.Gear.On3 - gear)

	TaskDispatcher.runDelay(self._switchGearAniFinished, self, delayTime)
end

function BGMSwitchMechineView:_btnmidOnClick()
	local isInBGMGuide = GuideModel.instance:isGuideRunning(BGMSwitchEnum.BGMGuideId)

	if isInBGMGuide then
		local audioId = BGMSwitchController.instance:getBgmAudioId()

		self._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(audioId)
	end

	local gear = BGMSwitchModel.instance:getMechineGear()

	self._beforeGear = gear

	if gear >= BGMSwitchEnum.Gear.On3 then
		if not BGMSwitchEnum.Gear.OFF then
			local afterGear = gear + 1

			self:_switchGearTo(gear, afterGear)
			BGMSwitchModel.instance:setMechineGear(afterGear)
			UIBlockMgrExtend.setNeedCircleMv(false)

			if isInBGMGuide then
				return
			end

			UIBlockMgr.instance:startBlock("gearswitch")
			TaskDispatcher.runDelay(self._switchGearAniFinished, self, 0.267)
		end
	end
end

function BGMSwitchMechineView:_switchGearAniFinished()
	if self._beforeGear == BGMSwitchEnum.Gear.OFF then
		self._mechineAni:Play("turnon")
	end

	self._beforeGear = nil

	UIBlockMgr.instance:endBlock("gearswitch")

	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear == BGMSwitchEnum.Gear.OFF then
		self._mechineAni:Play("turnoff")
	end

	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.SelectPlayGear)
	self:setOnlyUpdateInfo(false)
	self:_refreshView()
end

function BGMSwitchMechineView:_switchGearTo(beforeGear, afterGear)
	if beforeGear == afterGear then
		return
	end

	local isRandom = BGMSwitchModel.instance:isRandomMode()
	local isInBGMGuide = GuideModel.instance:isGuideRunning(BGMSwitchEnum.BGMGuideId)

	if not isInBGMGuide then
		StatController.instance:track(StatEnum.EventName.Tuning, {
			[StatEnum.EventProperties.AudioId] = tostring(self._bgmCo.id),
			[StatEnum.EventProperties.AudioName] = self._bgmCo.audioName,
			[StatEnum.EventProperties.BeforeGearPosition] = tostring(beforeGear),
			[StatEnum.EventProperties.AfterGearPosition] = tostring(afterGear),
			[StatEnum.EventProperties.PlayMode] = isRandom and "Random" or "LoopOne",
			[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getUnfilteredAllBgmsSorted())
		})
	end

	if beforeGear == BGMSwitchEnum.Gear.OFF then
		self._controlAni:Play("left")
	elseif beforeGear == BGMSwitchEnum.Gear.On1 then
		self._controlAni:Play("up")
	elseif beforeGear == BGMSwitchEnum.Gear.On2 then
		self._controlAni:Play("right")
	elseif beforeGear == BGMSwitchEnum.Gear.On3 then
		self._controlAni:Play("down")
	end

	if afterGear == BGMSwitchEnum.Gear.On1 then
		self._tapAni:Play("idle", 0, 0)
		self:resetBgmProgressShow()
	else
		self:_stopProgressTask()
	end

	if beforeGear < afterGear then
		for i = 1, 4 do
			if beforeGear < i and i <= afterGear then
				self._controlAni:SetBool("unlock" .. tostring(i), true)
			else
				self._controlAni:SetBool("unlock" .. tostring(i), false)
			end
		end
	else
		for i = 1, 4 do
			if i <= afterGear or beforeGear < i then
				self._controlAni:SetBool("unlock" .. tostring(i), true)
			else
				self._controlAni:SetBool("unlock" .. tostring(i), false)
			end
		end
	end

	BGMSwitchAudioTrigger.switchGearTo(beforeGear, afterGear)
end

function BGMSwitchMechineView:_btnswitchleftOnClick()
	local prevBgmId = BGMSwitchModel.instance:getCurBgm()

	BGMSwitchModel.instance:nextBgm(-1, false)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, prevBgmId)

	local isRandom = BGMSwitchModel.instance:isRandomMode()
	local currSelBgmList = BGMSwitchModel.instance:getCurrentUsingBgmList()

	StatController.instance:track(StatEnum.EventName.SwitchBGM, {
		[StatEnum.EventProperties.AudioId] = tostring(self._bgmCo.id),
		[StatEnum.EventProperties.AudioName] = self._bgmCo.audioName,
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(prevBgmId),
		[StatEnum.EventProperties.OperationType] = "click Last",
		[StatEnum.EventProperties.PlayMode] = isRandom and "Random" or "LoopOne",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(currSelBgmList)
	})
	BGMSwitchAudioTrigger.play_ui_replay_buttoncut()
	BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
end

function BGMSwitchMechineView:_btnswitchrightOnClick()
	local prevBgmId = BGMSwitchModel.instance:getCurBgm()

	BGMSwitchModel.instance:nextBgm(1, false)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, prevBgmId)

	local isRandom = BGMSwitchModel.instance:isRandomMode()
	local currSelBgmList = BGMSwitchModel.instance:getCurrentUsingBgmList()

	StatController.instance:track(StatEnum.EventName.SwitchBGM, {
		[StatEnum.EventProperties.AudioId] = tostring(self._bgmCo.id),
		[StatEnum.EventProperties.AudioName] = self._bgmCo.audioName,
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(prevBgmId),
		[StatEnum.EventProperties.OperationType] = "click Next",
		[StatEnum.EventProperties.PlayMode] = isRandom and "Random" or "LoopOne",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(currSelBgmList)
	})
	BGMSwitchAudioTrigger.play_ui_replay_buttoncut()
	BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
end

function BGMSwitchMechineView:setOnlyUpdateInfo(state)
	self._onlyUpdateInfo = state
end

function BGMSwitchMechineView:getOnlyUpdateInfo()
	return self._onlyUpdateInfo
end

function BGMSwitchMechineView:_onBgmSwitched(refreshBgmId)
	if refreshBgmId and self._bgmCo and refreshBgmId ~= self._bgmCo.id then
		return
	end

	self:_refreshView()
end

function BGMSwitchMechineView:_onBgmFavorite(bgmId)
	if bgmId == self._bgmCo.id then
		self:_refreshView()
	end
end

function BGMSwitchMechineView:_onBgmItemSelected(beforeBgmId)
	self:setOnlyUpdateInfo(false)

	local bgmId = BGMSwitchModel.instance:getCurBgm()
	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear ~= BGMSwitchEnum.Gear.On1 then
		self._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(bgmId)

		self:_refreshBottom()

		return
	end

	if BGMSwitchModel.instance:isValidBgmId(bgmId) then
		self._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(bgmId)

		UISpriteSetMgr.instance:setBgmSwitchToggleSprite(self._imagetape2, self._bgmCo.audioicon)

		if beforeBgmId then
			self._tapAni:Play("switch", 0, 0)
		else
			self._tapAni:Play("loop", 0, 0)
		end

		self:_stopProgressTask()
		TaskDispatcher.runDelay(self._refreshView, self, 0.67)
	else
		bgmId = BGMSwitchModel.instance:getNextBgm(1, false)

		if BGMSwitchModel.instance:isValidBgmId(bgmId) then
			self._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(bgmId)

			self:_refreshView()
		end
	end
end

function BGMSwitchMechineView:_onSlideClick()
	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear == BGMSwitchEnum.Gear.OFF then
		return
	end

	self:calAndSetShowTypeBySliderProgress()
end

function BGMSwitchMechineView:_onSliderEnd()
	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear == BGMSwitchEnum.Gear.OFF then
		return
	end

	self:calAndSetShowTypeBySliderProgress()
end

function BGMSwitchMechineView:calAndSetShowTypeBySliderProgress()
	local showType = BGMSwitchEnum.BGMDetailShowType.Progress
	local value = self._sliderChannel:GetValue()

	showType = value < sliderReference[BGMSwitchEnum.BGMDetailShowType.Progress] + 0.5 * (sliderReference[BGMSwitchEnum.BGMDetailShowType.Introduce] - sliderReference[BGMSwitchEnum.BGMDetailShowType.Progress]) and BGMSwitchEnum.BGMDetailShowType.Progress or value < sliderReference[BGMSwitchEnum.BGMDetailShowType.Introduce] + 0.5 * (sliderReference[BGMSwitchEnum.BGMDetailShowType.Comment] - sliderReference[BGMSwitchEnum.BGMDetailShowType.Introduce]) and BGMSwitchEnum.BGMDetailShowType.Introduce or BGMSwitchEnum.BGMDetailShowType.Comment

	BGMSwitchModel.instance:setAudioCurShowType(showType)
	self:updateSliderChannelByShowType()

	if BGMSwitchModel.instance:machineGearIsInSnowflakeScene() then
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.SlideValueUpdate)
	end

	BGMSwitchAudioTrigger.play_ui_replay_buttonsilp()

	if not BGMSwitchModel.instance:machineGearIsNeedPlayBgm() then
		return
	end

	gohelper.setActive(self._goturnOn, showType ~= BGMSwitchEnum.BGMDetailShowType.None)
	gohelper.setActive(self._goplay, showType == BGMSwitchEnum.BGMDetailShowType.Progress)
	gohelper.setActive(self._godesc, showType == BGMSwitchEnum.BGMDetailShowType.Introduce)
	gohelper.setActive(self._gocomment, showType == BGMSwitchEnum.BGMDetailShowType.Comment)
end

function BGMSwitchMechineView:onOpen()
	local gear = BGMSwitchModel.instance:getMechineGear()

	if gear == BGMSwitchEnum.Gear.OFF then
		self._controlAni:Play("left")
	elseif gear == BGMSwitchEnum.Gear.On1 then
		self._controlAni:Play("up")
	elseif gear == BGMSwitchEnum.Gear.On2 then
		self._controlAni:Play("right")
	elseif gear == BGMSwitchEnum.Gear.On3 then
		self._controlAni:Play("down")
	end

	local showType = BGMSwitchEnum.BGMDetailShowType.Progress

	BGMSwitchModel.instance:setAudioCurShowType(showType)

	local audioId = BGMSwitchController.instance:getMainBgmAudioId()

	self._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(audioId)

	self:setOnlyUpdateInfo(true)
	self:_refreshView()
end

function BGMSwitchMechineView:_refreshView()
	self._commentAni:Play("switch", 0, 0)
	self._descAni:Play("switch", 0, 0)
	self._playAni:Play("switch", 0, 0)
	self:_refreshTop()
	self:_refreshBottom()
end

function BGMSwitchMechineView:_refreshTop()
	self._commentCount = 0

	local gear = BGMSwitchModel.instance:getMechineGear()

	gohelper.setActive(self._goturnOnEffect, true)

	if gear == BGMSwitchEnum.Gear.OFF then
		self:_showGearOff()
	elseif gear == BGMSwitchEnum.Gear.On1 then
		self:_showGearOn1()
	elseif gear == BGMSwitchEnum.Gear.On2 then
		self:_showGearOn2()
	elseif gear == BGMSwitchEnum.Gear.On3 then
		self:_showGearOn3()
	end

	self:updateSliderChannelByShowType()
end

function BGMSwitchMechineView:_showGearOff()
	self:_stopBgm()
	gohelper.setActive(self._goturnOn, false)
	gohelper.setActive(self._goxuehuaping, false)
end

function BGMSwitchMechineView:_showGearOn1()
	if self._bgmCo then
		self._lastBgmId = self._bgmCo.id
	end

	local showType = BGMSwitchModel.instance:getAudioCurShowType()

	gohelper.setActive(self._goxuehuaping, false)
	self:_showAudioProgress()
	self:_showAudioIntroduce()
	self:_showAudioComment()
	self:_showAudioLike()
	gohelper.setActive(self._goturnOn, showType ~= BGMSwitchEnum.BGMDetailShowType.None)
	gohelper.setActive(self._goplay, showType == BGMSwitchEnum.BGMDetailShowType.Progress)
	gohelper.setActive(self._godesc, showType == BGMSwitchEnum.BGMDetailShowType.Introduce)
	gohelper.setActive(self._gocomment, showType == BGMSwitchEnum.BGMDetailShowType.Comment)
end

function BGMSwitchMechineView:updateSliderChannelByShowType()
	self._sliderChannel:SetValue(sliderReference[BGMSwitchModel.instance:getAudioCurShowType()])
end

function BGMSwitchMechineView:_showAudioProgress()
	local isRandom = BGMSwitchModel.instance:isRandomMode()
	local bgmIdFromServer = BGMSwitchModel.instance:getUsedBgmIdFromServer()

	self._txtplaytitle.text = isRandom and (BGMSwitchModel.instance:isRandomBgmId(bgmIdFromServer) and luaLang("bgmswitchview_randomplay") or luaLang("bgmswitchview_randomplisten")) or self._bgmCo.id == bgmIdFromServer and luaLang("bgmswitchview_play") or luaLang("bgmswitchview_listentest")

	self:_playNameAnim()

	if not self:getOnlyUpdateInfo() then
		self:setOnlyUpdateInfo(true)
		self:_forcePlayBgm()
	end

	local audioLength = BGMSwitchModel.instance:getReportBgmAudioLength(self._bgmCo)
	local min = Mathf.Floor(audioLength / 60)
	local sec = Mathf.Floor(audioLength % 60)

	self:_processUpdate(0)

	self._txtplayprogresslength.text = string.format("%d:%02d", min, sec)

	self:_stopProgressTask()
	TaskDispatcher.runRepeat(self._progressUpdate, self, 0.03)
end

function BGMSwitchMechineView:_playNameAnim()
	self._txtplayname.text = self._bgmCo.audioName
	self._txtplaynameen.text = self._bgmCo.audioNameEn

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	TaskDispatcher.cancelTask(self._playNameAnimOnce, self)
	TaskDispatcher.runDelay(self._playNameAnimOnce, self, 0.01)
end

function BGMSwitchMechineView:_playNameAnimOnce()
	local nameWidth = recthelper.getWidth(self._txtplayname.transform)
	local contentWidth = recthelper.getWidth(self._goplayname.transform)
	local _, y, _ = transformhelper.getLocalPos(self._txtplayname.transform)

	if contentWidth <= nameWidth then
		local startPos = 0.5 * (nameWidth + contentWidth)
		local endPos = -0.5 * (nameWidth + contentWidth)
		local duration = 0.01 * (startPos - endPos)

		transformhelper.setLocalPos(self._txtplayname.transform, startPos, y, 0)

		self._moveTweenId = ZProj.TweenHelper.DOLocalMoveX(self._txtplayname.transform, endPos, duration, self._playNameAnimFinished, self, nil, EaseType.Linear)
	else
		transformhelper.setLocalPos(self._txtplayname.transform, 0, y, 0)
	end
end

function BGMSwitchMechineView:_playNameAnimFinished()
	TaskDispatcher.runDelay(self._playNameAnimOnce, self, 0.5)
end

function BGMSwitchMechineView:resetBgmProgressShow()
	self:_processUpdate(0)

	self._txtplayprogresstime.text = string.format("%d:%02d", 0, 0)
end

function BGMSwitchMechineView:_processUpdate(value)
	self._sliderplay:SetValue(value)

	self._imgEffect.fillAmount = value
end

function BGMSwitchMechineView:_progressUpdate()
	local playTime = BGMSwitchController.instance:getProgress()

	if playTime and playTime >= 0 then
		local audioLength = BGMSwitchModel.instance:getReportBgmAudioLength(self._bgmCo)
		local value = playTime / audioLength

		self:_processUpdate(value)

		local min = Mathf.Floor(playTime / 60)
		local sec = Mathf.Floor(playTime % 60)

		self._txtplayprogresstime.text = string.format("%d:%02d", min, sec)
	else
		self._txtplayprogresstime.text = string.format("%d:%02d", 0, 0)
	end
end

function BGMSwitchMechineView:_stopBgm()
	BGMSwitchController.instance:stopMainBgm()
end

function BGMSwitchMechineView:_pauseBgm()
	BGMSwitchController.instance:pauseMainBgm()
end

function BGMSwitchMechineView:_playBgm(bStopPrevBgmImmediately)
	BGMSwitchController.instance:playMainBgm(self._bgmCo.audio, false, bStopPrevBgmImmediately)
end

function BGMSwitchMechineView:_forcePlayBgm()
	BGMSwitchController.instance:playMainBgm(self._bgmCo.audio, true, true)
end

function BGMSwitchMechineView:_progressFinished()
	local isRandom = BGMSwitchModel.instance:isRandomMode()

	if isRandom then
		local prevBgmId = BGMSwitchModel.instance:getCurBgm()
		local nextBgm = BGMSwitchModel.instance:nextBgm(1, false)

		self._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(nextBgm)

		self:_playBgm(true)
		self:_refreshView()
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.RandomFinished)

		local isRandom = BGMSwitchModel.instance:isRandomMode()
		local currSelBgmList = BGMSwitchModel.instance:getCurrentUsingBgmList()

		StatController.instance:track(StatEnum.EventName.SwitchBGM, {
			[StatEnum.EventProperties.AudioId] = tostring(self._bgmCo.id),
			[StatEnum.EventProperties.AudioName] = self._bgmCo.audioName,
			[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(prevBgmId),
			[StatEnum.EventProperties.OperationType] = "playing complete, auto next",
			[StatEnum.EventProperties.PlayMode] = isRandom and "Random" or "LoopOne",
			[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(currSelBgmList)
		})
	end
end

function BGMSwitchMechineView:_showAudioIntroduce()
	self._txtdescname.text = self._bgmCo.audioName
	self._txtdescnameen.text = self._bgmCo.audioNameEn
	self._txtDescr.text = self._bgmCo.audioIntroduce
end

function BGMSwitchMechineView:_showAudioLike()
	local isLove = BGMSwitchModel.instance:isBgmFavorite(self._bgmCo.id)

	gohelper.setActive(self._golike, isLove)
	gohelper.setActive(self._golikeBg, not isLove)
end

function BGMSwitchMechineView:_showAudioComment()
	self._commentItems = self._commentItems or {}

	local comments = string.split(self._bgmCo.audioEvaluates, "|")

	for _, item in pairs(self._commentItems) do
		gohelper.setActive(item.go, false)
	end

	for index, comment in ipairs(comments) do
		local evaluates = string.split(comment, "#")

		if not self._commentItems[index] then
			local item = {}

			item.go = gohelper.cloneInPlace(self._gocommentItem, index)
			item.txtName = gohelper.findChildText(item.go, "name")
			item.txtDesc = gohelper.findChildText(item.go, "desc")
			self._commentItems[index] = item
		end

		gohelper.setActive(self._commentItems[index].go, true)

		self._commentItems[index].txtName.text = evaluates[1]
		self._commentItems[index].txtDesc.text = evaluates[2]
	end
end

function BGMSwitchMechineView:_showGearOn2()
	self:_stopBgm()
	gohelper.setActive(self._goturnOn, false)
	gohelper.setActive(self._goxuehuaping, true)
end

function BGMSwitchMechineView:_showGearOn3()
	self:_stopBgm()
	gohelper.setActive(self._goturnOn, false)
	gohelper.setActive(self._goxuehuaping, true)
end

function BGMSwitchMechineView:_showNormalViewByGuide()
	local audioId = BGMSwitchController.instance:getBgmAudioId()

	self._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(audioId)

	local gear = BGMSwitchModel.instance:getMechineGear()

	self:_switchGearTo(gear, BGMSwitchEnum.Gear.On1)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.On1)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")

	if gear < BGMSwitchEnum.Gear.On2 then
		if not (0.267 * (BGMSwitchEnum.Gear.On2 - gear)) then
			local delayTime = 0.267 * (BGMSwitchEnum.Gear.On2 + (4 - gear))

			TaskDispatcher.runDelay(self._switchGearAniFinished, self, delayTime)
		end
	end
end

function BGMSwitchMechineView:_showNoiseViewByGuide()
	self:_pauseBgm()
	gohelper.setActive(self._goturnOn, false)
	gohelper.setActive(self._goxuehuaping, false)
	gohelper.setActive(self._gointerface, true)
end

function BGMSwitchMechineView:_refreshBottom()
	local gear = BGMSwitchModel.instance:getMechineGear()

	gohelper.setActive(self._gopowerlight, gear ~= BGMSwitchEnum.Gear.OFF)

	if not self:getOnlyUpdateInfo() then
		if gear == BGMSwitchEnum.Gear.On1 and self._bgmCo then
			self._tapAni:Play("loop", 0, 0)
		else
			self._tapAni:Play("idle", 0, 0)
		end
	end

	if self._bgmCo then
		gohelper.setActive(self._gotapicon, true)
		UISpriteSetMgr.instance:setBgmSwitchToggleSprite(self._imagetape1, self._bgmCo.audioicon)
		UISpriteSetMgr.instance:setBgmSwitchToggleSprite(self._imagetape2, self._bgmCo.audioicon)
	else
		gohelper.setActive(self._gotap, false)
	end
end

function BGMSwitchMechineView:onClose()
	BGMSwitchController.instance:backMainBgm()
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BGMSwitchClose)
	TaskDispatcher.cancelTask(self._refreshView, self)
	TaskDispatcher.cancelTask(self._switchGearAniFinished, self)
	self:_stopProgressTask()
end

function BGMSwitchMechineView:_stopProgressTask()
	TaskDispatcher.cancelTask(self._progressUpdate, self)
end

function BGMSwitchMechineView:onDestroyView()
	if self._beforeBgm then
		self._beforeBgm = nil
	end
end

return BGMSwitchMechineView
