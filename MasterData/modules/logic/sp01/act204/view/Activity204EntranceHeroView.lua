-- chunkname: @modules/logic/sp01/act204/view/Activity204EntranceHeroView.lua

module("modules.logic.sp01.act204.view.Activity204EntranceHeroView", package.seeall)

local Activity204EntranceHeroView = class("Activity204EntranceHeroView", BaseView)

function Activity204EntranceHeroView:onInitView()
	self._goRole = gohelper.findChild(self.viewGO, "#goRole")
	self._golightspinecontrol = gohelper.findChild(self._goRole, "#go_lightspinecontrol")
	self._golightspine = gohelper.findChild(self._goRole, "#go_spine_scale/lightspine/#go_lightspine")
	self._txtanacn = gohelper.findChildText(self.viewGO, "bottom/#txt_Dialouge")
	self._gocontentbg = gohelper.findChild(self.viewGO, "bottom")
	self._btnclick = gohelper.findChildButtonWithAudio(self._goRole, "#go_lightspinecontrol")

	gohelper.setActive(self._gocontentbg, false)

	self.clickcd = 5

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity204EntranceHeroView:addEvents()
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.PlayTalk, self.onPlayTalk, self)
	self.addEventCb(self, Activity204Controller.instance, Activity204Event.UpdateTask, self.onUpdateTask, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenViewCb, self)
	self._btnclick:AddClickListener(self._onClick, self)
end

function Activity204EntranceHeroView:removeEvents()
	self._btnclick:RemoveClickListener()
end

function Activity204EntranceHeroView:onPlayTalk(talkId)
	if not talkId then
		return
	end

	local voice = lua_actvity204_voice.configDict[talkId]

	self:playVoice(voice)
end

function Activity204EntranceHeroView:onOpen()
	self:refreshParam()
	self:_updateHero()
end

function Activity204EntranceHeroView:_editableInitView()
	return
end

function Activity204EntranceHeroView:refreshParam()
	self.actId = ActivityEnum.Activity.V2a9_Act204
end

function Activity204EntranceHeroView:_updateHero()
	if not self._uiSpine then
		self._uiSpine = GuiSpine.Create(self._golightspine, true)
		self._uiSpine._spineVoice = SpineVoice.New()

		function self._uiSpine._spineVoice._spineVoiceBody.setNormal(body)
			if body._appointIdleName then
				body:setBodyAnimation(body._appointIdleName, true, body._appointIdleMixTime)

				body._appointIdleMixTime = nil

				return
			end

			local name = "b_daoju"

			body:setBodyAnimation(name, true)
		end

		local onVoiceStop = self._uiSpine._spineVoice._spineVoiceText.onVoiceStop

		function self._uiSpine._spineVoice._spineVoiceText.onVoiceStop(text)
			onVoiceStop(text)
			self:onVoiceStop()
		end
	end

	self._uiSpine:setResPath(Activity204Enum.RolePath, self._onLightSpineLoaded, self)
end

function Activity204EntranceHeroView:_onLightSpineLoaded()
	self._isSpineLoadDone = true

	self._uiSpine:showModel()
	self:playVoiceOnOpenFinish()
end

function Activity204EntranceHeroView:onOpenFinish()
	self:playVoiceOnOpenFinish()
end

function Activity204EntranceHeroView:playVoiceOnOpenFinish()
	if not self._isSpineLoadDone or not self._has_onOpenFinish then
		return
	end

	local voice = Activity204EntranceHeroView.getShopVoice(Activity204Enum.VoiceType.EnterView, Activity204EntranceHeroView.checkParam, self.actId)

	self:playVoice(voice)
	self._uiSpine:setActionEventCb(self._onAnimEnd, self)
end

function Activity204EntranceHeroView:_onAnimEnd()
	return
end

function Activity204EntranceHeroView:isPlayingVoice()
	if not self._uiSpine then
		return false
	end

	return self._uiSpine:isPlayingVoice()
end

function Activity204EntranceHeroView:_onClick()
	self:interactHeroVoice(Activity204Enum.VoiceType.ClickSkin)
end

function Activity204EntranceHeroView:onUpdateTask()
	self:interactHeroVoice(Activity204Enum.VoiceType.UpdateMainTask)
end

function Activity204EntranceHeroView:interactHeroVoice(voiceType)
	if not self._interactionStartTime or Time.time - self._interactionStartTime > self.clickcd then
		self._interactionStartTime = Time.time

		local voice = Activity204EntranceHeroView.getShopVoice(voiceType, Activity204EntranceHeroView.checkParam, self.actId)

		self:playVoice(voice)
	end
end

function Activity204EntranceHeroView:playVoice(config)
	if not self._uiSpine then
		return
	end

	if not config then
		return
	end

	self:stopVoice()
	self._uiSpine:playVoice(config, nil, self._txtanacn, nil, self._gocontentbg)
end

function Activity204EntranceHeroView:onVoiceStop()
	return
end

function Activity204EntranceHeroView.getShopVoice(type, checkFun, actId, sortFun)
	local nowDate = WeatherModel.instance:getNowDate()

	nowDate.hour = 0
	nowDate.min = 0
	nowDate.sec = 0

	local zeroTime = os.time(nowDate)
	local nowTime = os.time()

	local function verifyCallback(config)
		local timeList = GameUtil.splitString2(config.time, false, "|", "#")

		if timeList and #timeList > 0 then
			for i, param in ipairs(timeList) do
				if Activity204EntranceHeroView._checkTime(param, zeroTime, nowTime) then
					return true
				end
			end

			return false
		end

		return true
	end

	local voices = Activity204Config.instance:getVoiceConfig(type, verifyCallback)

	if checkFun then
		local mo = Activity204Model.instance:getById(actId)
		local list = {}

		if voices then
			for i, v in ipairs(voices) do
				if checkFun(v, mo) then
					table.insert(list, v)
				end
			end
		end

		voices = list
	end

	if sortFun then
		table.sort(voices, sortFun)

		return voices[1]
	end

	return (Activity204EntranceHeroView.getHeightWeight(voices))
end

function Activity204EntranceHeroView.getHeightWeight(configs)
	local index = math.random(1, #configs)

	return configs[index]
end

function Activity204EntranceHeroView._checkTime(param, zeroTime, nowTime)
	local timeParam1 = string.splitToNumber(param[1], ":")

	if #timeParam1 == 5 then
		local timeParam2 = string.splitToNumber(param[2], ":")
		local y1, m1, d1, h1, min1 = unpack(timeParam1)
		local y2, m2, d2, h2, min2 = unpack(timeParam2)
		local startTime = os.time({
			year = y1,
			month = m1,
			day = d1,
			hour = h1,
			min = min1
		})
		local endTime = os.time({
			year = y2,
			month = m2,
			day = d2,
			hour = h2,
			min = min2
		})

		return startTime <= nowTime and nowTime <= endTime
	else
		local h = tonumber(timeParam1[1])
		local m = tonumber(timeParam1[2])
		local duration = tonumber(param[2])

		if not h or not m or not duration then
			return false
		end

		local startTime = zeroTime + (h * 60 + m) * 60
		local endTime = startTime + duration * 3600

		return startTime <= nowTime and nowTime <= endTime
	end
end

function Activity204EntranceHeroView.checkParam(config, actMo)
	local param = config.param

	if string.nilorempty(param) then
		return true
	end

	local arr = string.splitToNumber(param, "#")
	local type = arr[1]

	if type == 1 then
		local value = arr[2]

		return actMo.currentStage == value
	elseif type == 2 then
		return Activity204Controller.instance:isAnyActCanGetReward()
	elseif type == 3 then
		return actMo:hasCanRewardTask()
	elseif type == 4 then
		-- block empty
	end

	return true
end

function Activity204EntranceHeroView:onOpenViewCb(ViewName)
	if ViewName == self.viewName then
		return
	end

	self:stopVoice()
end

function Activity204EntranceHeroView:onClose()
	self:stopVoice()
end

function Activity204EntranceHeroView:stopVoice()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_system_voc)

	if self._uiSpine then
		self._uiSpine:stopVoice()
		self._uiSpine:play(StoryAnimName.B_IDLE, true)
	end
end

function Activity204EntranceHeroView:onDestroyView()
	return
end

return Activity204EntranceHeroView
