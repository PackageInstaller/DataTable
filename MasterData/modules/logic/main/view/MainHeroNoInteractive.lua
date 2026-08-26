-- chunkname: @modules/logic/main/view/MainHeroNoInteractive.lua

module("modules.logic.main.view.MainHeroNoInteractive", package.seeall)

local MainHeroNoInteractive = class("MainHeroNoInteractive", BaseView)

function MainHeroNoInteractive:onInitView()
	self._txtanacn = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_cn")
	self._txtanaen = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_en")
	self._gocontentbg = gohelper.findChild(self.viewGO, "bottom/#go_contentbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainHeroNoInteractive:addEvents()
	return
end

function MainHeroNoInteractive:removeEvents()
	return
end

function MainHeroNoInteractive:init()
	self._heroView = self.viewContainer:getMainHeroView()
	self._heroId = self._heroView._heroId
	self._skinId = self._heroView._skinId

	self:_initNoInteraction()
	self:_initSpecialIdle()

	if not self._touchEventMgr then
		self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self.viewGO)

		self._touchEventMgr:SetIgnoreUI(true)
		self._touchEventMgr:SetOnlyTouch(true)
		self._touchEventMgr:SetOnTouchUp(self.touchUpHandler, self)
		self.addEventCb(self, MainController.instance, MainEvent.ClickDown, self.touchDownHandler, self)
	end

	TaskDispatcher.runRepeat(self._checkNoInteraction, self, 1)
end

function MainHeroNoInteractive:_clearSpecialIdleVars()
	self._inSpecialIdle = nil
	self._playSpecialIdle1 = nil
	self._specialIdleStartTime = nil
	self._specialCDStartTime = nil
end

function MainHeroNoInteractive:_initSpecialIdle()
	self:_clearSpecialIdleVars()

	self._specialIdleTime = nil
	self._specialIdleCD = nil
	self._specialIdle1 = nil
	self._specialIdle2 = nil

	local voices = HeroModel.instance:getVoiceConfig(self._heroId, CharacterEnum.VoiceType.SpecialIdle1, nil, self._skinId)

	if not voices or #voices <= 0 then
		return
	end

	self._specialIdleStartTime = Time.time

	local voiceCo = voices[1]
	local paramList = string.split(voiceCo.param, "#")

	self._specialIdleTime = tonumber(paramList[1])
	self._specialIdleCD = tonumber(paramList[2])
	self._specialIdle1 = voiceCo
	self._specialIdle2 = HeroModel.instance:getVoiceConfig(self._heroId, CharacterEnum.VoiceType.SpecialIdle2, nil, self._skinId)
end

function MainHeroNoInteractive:_initNoInteraction()
	self._interactionStartTime = Time.time

	local voiceCo = self:_getNoInteractionVoice()

	if voiceCo then
		local paramList = string.split(voiceCo.param, "#")

		self._noInteractionTime = tonumber(paramList[1])
		self._noInteractionCD = tonumber(paramList[2])
		self._noInteractionConfig = voiceCo
	else
		self._noInteractionTime = nil
		self._noInteractionCD = nil
	end
end

function MainHeroNoInteractive:_getNoInteractionVoice()
	local voices = HeroModel.instance:getVoiceConfig(self._heroId, CharacterEnum.VoiceType.MainViewNoInteraction, nil, self._skinId)

	if voices and #voices > 0 then
		return voices[1]
	end
end

function MainHeroNoInteractive:_checkNoInteraction()
	self:_checkMainViewNoInteraction()
	self:_checkSpecialIdle()
end

function MainHeroNoInteractive:_checkSpecialIdle()
	if not self._heroView:isShowInScene() then
		self._inSpecialIdle = nil

		return
	end

	if not self._specialIdleTime or not self._specialIdleStartTime then
		self._inSpecialIdle = nil

		return
	end

	if self:isPlayingVoice() then
		return
	end

	self._inSpecialIdle = nil

	local num = #ViewMgr.instance:getOpenViewNameList()

	num = num - (ViewMgr.instance:isOpen(ViewName.ToastView) and 1 or 0)
	num = num - (ViewMgr.instance:isOpen(ViewName.WaterMarkView) and 1 or 0)

	if num > 1 then
		return
	end

	if Time.time - self._specialIdleStartTime < self._specialIdleTime then
		return
	end

	self._inSpecialIdle = true

	if not self._playSpecialIdle1 then
		self._playSpecialIdle1 = true

		self:playVoice(self._specialIdle1)

		self._specialCDStartTime = Time.time

		return
	end

	if self._specialCDStartTime and Time.time - self._specialCDStartTime < self._specialIdleCD then
		return
	end

	local count = 0
	local idleNum = #self._specialIdle2

	while true do
		count = count + 1

		local index = math.random(idleNum)

		if index ~= self._specialRandomIndex or idleNum <= count then
			self._specialRandomIndex = index

			local config = self._specialIdle2[index]

			self:playVoice(config)

			break
		end
	end

	self._specialCDStartTime = Time.time
end

function MainHeroNoInteractive:_checkMainViewNoInteraction()
	if not self._noInteractionTime or not self._interactionStartTime or not self._noInteractionConfig then
		return
	end

	if Time.time - self._interactionStartTime < self._noInteractionTime then
		return
	end

	if self._interactionCDStartTime and Time.time - self._interactionCDStartTime < self._noInteractionCD then
		return
	end

	local lightSpine = self._heroView:getLightSpine()
	local voiceStartTime = lightSpine and lightSpine:getPlayVoiceStartTime()

	if voiceStartTime and Time.time - voiceStartTime < 10 then
		return
	end

	local num = #ViewMgr.instance:getOpenViewNameList()

	num = num - (ViewMgr.instance:isOpen(ViewName.ToastView) and 1 or 0)

	if num > 1 then
		return
	end

	self._noInteractionConfig = self:_getNoInteractionVoice()

	if not self._noInteractionConfig then
		return
	end

	self:playVoice(self._noInteractionConfig)

	self._interactionCDStartTime = Time.time
end

function MainHeroNoInteractive:touchUpHandler()
	self._interactionStartTime = Time.time
	self._specialIdleStartTime = Time.time
end

function MainHeroNoInteractive:touchDownHandler()
	self._interactionStartTime = nil

	if self._inSpecialIdle then
		self._inSpecialIdle = nil

		local lightSpine = self._heroView:getLightSpine()

		if lightSpine then
			lightSpine:stopVoice()
		end
	end

	self:_clearSpecialIdleVars()
end

function MainHeroNoInteractive:isPlayingVoice()
	return self._heroView:isPlayingVoice()
end

function MainHeroNoInteractive:playVoice(config)
	local lightSpine = self._heroView:getLightSpine()

	if not lightSpine then
		return
	end

	lightSpine:playVoice(config, nil, self._txtanacn, self._txtanaen, self._gocontentbg)
end

function MainHeroNoInteractive:onClose()
	if self._touchEventMgr then
		TouchEventMgrHepler.remove(self._touchEventMgr)

		self._touchEventMgr = nil
	end

	TaskDispatcher.cancelTask(self._checkNoInteraction, self)
end

return MainHeroNoInteractive
