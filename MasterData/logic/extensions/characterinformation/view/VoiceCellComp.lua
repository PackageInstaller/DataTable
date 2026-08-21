-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/VoiceCellComp.lua

module("logic.extensions.characterinformation.view.VoiceCellComp", package.seeall)

local M = class("VoiceCellComp")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self._isPlayingVoice = false
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	local registry = self._viewElementsRegistry

	self._txtName = registry:findUIElement("role_other_item_1611802402", UIComponentType.Text)
	self._btnPlayGo = registry:findUIElement("role_other_item_-456218792")
	self._btnPasueGo = registry:findUIElement("role_other_item_1934000182")
	self._sliderVolume = UIComponentType.SliderAdapter(registry:findUIElement("role_voice_item_1764059559"))
	self._unlockObj = registry:findUIElement("role_voice_item_-283342702")
	self._lockObj = registry:findUIElement("role_other_item_-224568606")
	self._favorLvObj = registry:findUIElement("role_voice_item_721636073")
	self._txtName2 = registry:findUIElement("role_voice_item_261750538", UIComponentType.Text)
	self._txtLock = registry:findUIElement("role_other_item_1230130446", UIComponentType.Text)
	self._animation = self._go:GetComponent("Animation")
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("role_voice_item_-1098593722"))

	self._btnClick:AddClickListener(self._clickSelf, self)
	GlobalDispatcher:addEventListener(EventType.HERO_VOICE_DATA_CHANGE, self._onChangeSuc, self)
	GlobalDispatcher:addEventListener(EventType.CHARACTER_VIEW_SWITCH, self._refreshByHeroChange, self)
end

function M:_onChangeSuc(_, data)
	local isSelect = data.audioId == self._curData.audioId
	local showState = self._curData.isPlaying and isSelect

	if isSelect then
		goutil.setActive(self._btnPlayGo, not showState)
		goutil.setActive(self._btnPasueGo, showState)
	elseif self._curData.isPlaying then
		if self._tweenId then
			TweenUtil.killTween(self._tweenId)

			self._tweenId = false
		end

		if self._sliderVolume ~= nil and not showState then
			self._sliderVolume.slider:DOKill(false)
			self._sliderVolume:SetValue(0)
		end

		goutil.setActive(self._btnPlayGo, true)
		goutil.setActive(self._btnPasueGo, false)

		self._curData.isPlaying = false

		CriwareAudioFacade.instance:stopSoundByName(self._curData.voiceId)
	end
end

function M:_clickSelf()
	if not self._isUnlock then
		return
	end

	if self._tweenId then
		TweenUtil.killTween(self._tweenId)

		self._tweenId = false
	end

	if self._sliderVolume ~= nil then
		self._sliderVolume:SetValue(0)
	end

	if not string.nilorempty(self._voiceRes) then
		if self._curData.isPlaying then
			self._curData.isPlaying = false

			CriwareAudioFacade.instance:stopSoundByName(self._voiceRes)
		else
			self._curData.isPlaying = true

			CriwareAudioFacade.instance:playSEByName(self._voiceRes, self._go, self._playVoiceFinish, self)
		end

		if self._curData.isPlaying then
			local totalTime = CriwareAudioFacade.instance:getCueTotalTimeByName(self._voiceRes)

			self._sliderVolume.slider:DOValue(1, totalTime):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(self._sliderVolumeFinish, self)
		end

		if not self._isBlackBox then
			GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_TAB_CHANGE, self._curData.isPlaying, self._curData)
		end

		if self._clickCallBackFunc then
			self._clickCallBackFunc(self._clickCallBackHandler, self._curData)
		end
	else
		printError("voice resource is empty,check config")
	end
end

function M:_sliderVolumeFinish()
	GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_TAB_CHANGE, false)
end

function M:_playVoiceFinish()
	goutil.setActive(self._selectObj, false)
	goutil.setActive(self._btnPlayGo, true)
	goutil.setActive(self._btnPasueGo, false)

	self._curData.isPlaying = false

	GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_TAB_CHANGE, self._curData.isPlaying, nil)

	if self._sliderVolume ~= nil then
		self._sliderVolume:SetValue(0)
	end

	if self._tweenId then
		TweenUtil.killTween(self._tweenId)

		self._tweenId = false
	end
end

function M:setCellData(data, index, curSelectId, heroId)
	self._index = index
	data.isPlaying = false
	self._curData = data
	self._txtName.text = data.audioName
	self._txtName2.text = data.audioName

	local VoiceEnumRes = CharacterInfoEnum.VoiceRes[data.audioId]

	self._voiceRes = VoiceEnumRes and string.format(VoiceEnumRes, heroId) or data.voiceId
	self._isBlackBox = data.audioId == 41
	self._isUnlock = false

	local isCanUnlock = true
	local tacitLvLock = false
	local unlockCO = CharacterUnlockContentConfig.instance:getUnlockConfigByHeroIdAndVoiceId(heroId, data.audioId)
	local universallyUnlockCO = PastInfoConfig.instance:getUniversallyUnlockConfig(data.audioId + 3000)

	if universallyUnlockCO == nil then
		printWarn("找不到通用解锁信息声音id，角色ID，", data.audioId, heroId)
	end

	local condition = unlockCO ~= nil and unlockCO.condition or universallyUnlockCO and universallyUnlockCO.condition or {}

	condition = condition or {}

	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)
	local heroTacit = heroData and heroData:getTacit() or 0
	local heroPowerLv = heroData and heroData:getPowerLv() or 0
	local heroLv = heroData and heroData:getLevel() or 0

	for i, v in ipairs(condition) do
		if v.type == "tacitLv" then
			self._txtLock.text = string.format("%d解锁", v.value)

			if heroTacit < v.value then
				isCanUnlock = false
				tacitLvLock = true

				break
			end
		end

		if v.type == "powerLv" then
			self._txtLock.text = string.format("亲和度%d解锁", v.value)

			if heroPowerLv < v.value then
				isCanUnlock = false

				break
			end
		end

		if v.type == "heroLv" then
			self._txtLock.text = string.format("等级达到%d解锁", v.value)

			if heroLv < v.value then
				isCanUnlock = false

				break
			end
		end
	end

	local wwiseCo = CriwareAudioConfig.instance:getCOByName(self._voiceRes)

	if not wwiseCo then
		isCanUnlock = false
		tacitLvLock = false
		self._txtLock.text = lang("tip_not_online")
	end

	self._isUnlock = isCanUnlock

	goutil.setActive(self._lockObj, not self._isUnlock)
	goutil.setActive(self._unlockObj, self._isUnlock)
	goutil.setActive(self._favorLvObj, tacitLvLock)
	goutil.setActive(self._selectObj, curSelectId == data.audioId)
	goutil.setActive(self._btnPlayGo, curSelectId ~= data.audioId)
	goutil.setActive(self._btnPasueGo, curSelectId == data.audioId)
	self._sliderVolume:SetValue(0)

	local aniName = self._isBlackBox and "role_special_voice_open" or "role_voice_item_open"

	self._animation:Play(aniName)
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:_refreshByHeroChange()
	if self._curData and self._curData.isPlaying then
		goutil.setActive(self._selectObj, false)
		goutil.setActive(self._btnPlayGo, true)
		goutil.setActive(self._btnPasueGo, false)

		self._curData.isPlaying = false

		CriwareAudioFacade.instance:stopSoundByName(self._curData.voiceId)
	end
end

function M:OnDestroy()
	GlobalDispatcher:removeEventListener(EventType.HERO_VOICE_DATA_CHANGE, self._onChangeSuc, self)
	GlobalDispatcher:removeEventListener(EventType.CHARACTER_VIEW_SWITCH, self._refreshByHeroChange, self)
	self._btnClick:RemoveClickListener()

	self._btnClick = nil

	self._sliderVolume:RemoveOnValueChanged()

	self._sliderVolume = nil

	if not string.nilorempty(self._voiceRes) and self._curData.isPlaying then
		CriwareAudioFacade.instance:stopSoundByName(self._voiceRes)
	end

	self._voiceRes = nil
end

return M
