-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/character/StoreCharacterView.lua

module("logic.extensions.store.view.character.StoreCharacterView", package.seeall)

local M = class("StoreCharacterView", ViewComponent)
local timeInterval = 30

function M:buildUI()
	self._CharacterImgObj = self:getGo("store_main_view_copy_-1262696785")
	self._photoCenterPointGo = self:getGo("store_main_view_copy_-1301875345")
	self._ragRole = self:getUIComponent("store_main_view_copy_2033833526", UIComponentType.RawImage)
	self._photoUnit = PhotoUnit.Get(self:getGo("store_main_view_copy_2033833526"))

	self._photoUnit:clear()

	self._btnPhotoUnit = self:getBtn("store_main_view_copy_2004036443")
	self._talkGo = self:getGo("store_main_view_copy_1727525105")
	self._txtTalk = self:getText("store_main_view_copy_1945691902")
	self._uiglobalTouchTrigger = Astral.UIGlobalTouchTrigger.Get(self.mainGO)
end

function M:destroyUI()
	self._photoCenterPointGo = nil
	self._btnPhotoUnit = nil
	self._talkGo = nil
	self._txtTalk = nil
	self._bubbleInterval = nil
	self._canShowBubble = nil
	self._min = nil
	self._max = nil
	self._rate = nil
	self._noClickCount = nil
	self._uiglobalTouchTrigger = nil
	self._beginTime = nil
	self._duration = nil
	self._canShowBubble = nil
	self._bubbleVoice = nil
	self._oldAction = nil
	self._photoUnit = nil
end

function M:bindEvents()
	self._uiglobalTouchTrigger:AddGlobalListener(self._onDoClickScreen, self)
	self._btnPhotoUnit:AddClickListener(self._onClickModel, self)
	GlobalDispatcher:addEventListener(EventType.STORE_SHOW_BUBBLE, self._showBubbleEvent, self)
end

function M:unbindEvents()
	self._btnPhotoUnit:RemoveClickListener()
	self._uiglobalTouchTrigger:RemoveGlobalListener()
	GlobalDispatcher:removeEventListener(EventType.STORE_SHOW_BUBBLE, self._showBubbleEvent, self)
end

function M:onEnter()
	StoreMainFacade.instance:registerView(self)
end

function M:onExit()
	removetimer(self._updateTimer, self)
	goutil.setActive(self._talkGo, false)

	if not string.nilorempty(self._bubbleVoice) then
		CriwareAudioFacade.instance:stopSoundByName(self._bubbleVoice)

		self._bubbleVoice = nil
	end

	if self._photoUnit then
		self._photoUnit:clear()
	end

	self:_stopBubbleCounter()

	self._isInit = false
end

function M:_showBubbleEvent(evt, actionType, tips)
	self:showBubble(actionType, tips)
end

function M:setVisible(visble)
	self._isActive = visble

	goutil.setActive(self._CharacterImgObj, visble)
	goutil.setActive(self._talkGo, visble)

	if visble then
		self:showBubble(StoreEnum.BubbleFactor.Enter)
	end
end

function M:_onDoClickScreen()
	self._noClickCount = 0
end

function M:_onClickModel()
	if self._canShowBubble then
		self:showBubble(StoreEnum.BubbleFactor.Click)
	end
end

function M:_initBubble()
	self._isInit = true

	local transform = self._photoCenterPointGo.transform
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local storeModleId = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.StoreModleId)
	local paramTable = {
		isShowEgg = false,
		isShowEnter = false,
		photo = self._photoUnit,
		modelId = storeModleId,
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharaterBust
	}

	SpineCutShowLoader.showSpineLihuiPhoto(paramTable)
	RawImageUtil.SetColor(self._ragRole, "#FFFFFF00")
	self._ragRole:DOFade(1, 0.6)
	goutil.setActive(self._talkGo, false)

	self._bubbleInterval = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.BubbleInterval) or 5
	self._canShowBubble = true
	self._min = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.BubbleMin) or 1
	self._max = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.BubbleMax) or 5
	self._rate = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.BubbleRate) or 1
	self._noClickCount = 0

	self:_startBubbleCounter()
end

function M:_startBubbleCounter()
	self:_stopBubbleCounter()
	Scheduler.addListener(1, self._onBubbleSecond, self, true)
end

function M:_stopBubbleCounter()
	Scheduler.removeListener(self._onBubbleSecond, self)
end

function M:_onBubbleSecond()
	self._noClickCount = self._noClickCount + 1

	if self._noClickCount >= timeInterval then
		self._noClickCount = 0

		self:showBubble(StoreEnum.BubbleFactor.NoAction)
	end
end

function M:showBubble(factor, newText)
	if not self._isInit then
		self:_initBubble()
	end

	if not self._isActive then
		return
	end

	self._noClickCount = 0

	local bubbleCo = StoreConfig.instance:getBubbleByFactor(factor)

	self._beginTime = Time.time

	if bubbleCo then
		goutil.setActive(self._talkGo, true)

		local text = bubbleCo.content

		if factor == StoreEnum.BubbleFactor.OpenRecommend then
			text = newText
		end

		self._txtTalk.text = text
		self._duration = Mathf.Clamp(self._rate * (string.utf8len(text) / 10), self._min, self._max)
		self._canShowBubble = false
		self._bubbleVoice = bubbleCo.voice
		self._oldAction = self._photoUnit:getAnimState()

		if not string.nilorempty(bubbleCo.animationName) then
			self._photoUnit:playOnce(bubbleCo.animationName)
		end

		if not string.nilorempty(self._bubbleVoice) then
			self._duration = -1

			CriwareAudioFacade.instance:playVoiceByName(self._bubbleVoice, nil, self.playVoiceFinish, self)
		end

		settimer(0, self._updateTimer, self)
	end
end

function M:playVoiceFinish()
	self:hideBubble()
end

function M:_updateTimer()
	if not self._beginTime then
		return
	end

	local time = Time.time - self._beginTime

	if self._bubbleInterval and self._bubbleInterval ~= 0 and time >= self._bubbleInterval then
		removetimer(self._updateTimer, self)

		self._canShowBubble = true
	elseif time >= self._duration and self._duration > 0 then
		self:hideBubble()
	end
end

function M:hideBubble()
	goutil.setActive(self._talkGo, false)

	if not string.nilorempty(self._bubbleVoice) then
		CriwareAudioFacade.instance:stopSoundByName(self._bubbleVoice)
	end

	if self._photoUnit then
		local curAction = self._photoUnit:getAnimState()

		if curAction ~= self._oldAction then
			self._photoUnit:play(self._oldAction)
		end
	end

	settimer(0, self._updateTimer, self)
end

return M
