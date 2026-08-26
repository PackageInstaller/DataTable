-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186HeroView.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186HeroView", package.seeall)

local Activity186HeroView = class("Activity186HeroView", BaseView)

function Activity186HeroView:onInitView()
	self._goRole = gohelper.findChild(self.viewGO, "root/#goRole")
	self._golightspinecontrol = gohelper.findChild(self._goRole, "#go_lightspinecontrol")
	self._gospinescale = gohelper.findChild(self._goRole, "#go_spine_scale")
	self._golightspine = gohelper.findChild(self._goRole, "#go_spine_scale/lightspine/#go_lightspine")
	self._txtanacn = gohelper.findChildText(self._goRole, "bottom/#txt_Dialouge")
	self._txtanaen = gohelper.findChildText(self._goRole, "bottom/#txt_Dialouge/#txt_DialougeEn")
	self._txtnamecn = gohelper.findChildTextMesh(self.viewGO, "root/#goRole/bottom/#go_name/#txt_namecn")
	self._txtnameen = gohelper.findChildTextMesh(self.viewGO, "root/#goRole/bottom/#go_name/#txt_namecn/#txt_nameen")
	self._gocontentbg = gohelper.findChild(self._goRole, "bottom")

	gohelper.setActive(self._gocontentbg, false)

	self.clickcd = 5

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186HeroView:addEvents()
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.PlayTalk, self.onPlayTalk, self)
end

function Activity186HeroView:removeEvents()
	return
end

function Activity186HeroView:onPlayTalk(talkId)
	if not talkId then
		return
	end

	local voice = lua_actvity186_voice.configDict[talkId]

	self:playVoice(voice)
end

function Activity186HeroView:onOpen()
	self:refreshParam()
	self:_updateHero()
end

function Activity186HeroView:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self._golightspinecontrol)

	self._click:AddClickListener(self._onClick, self)
end

function Activity186HeroView:refreshParam()
	self.actId = self.viewParam and self.viewParam.actId
end

function Activity186HeroView:_updateHero()
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

	self._uiSpine:setResPath(Activity186Enum.RolePath, self._onLightSpineLoaded, self)

	self._txtnamecn.text = luaLang("act186_hero_name")
	self._txtnameen.text = "Han Zhang"
end

function Activity186HeroView:_onLightSpineLoaded()
	self._uiSpine:showModel()

	local voice = Activity186HeroView.getShopVoice(Activity186Enum.VoiceType.EnterView, Activity186HeroView.checkParam, self.actId)

	self:playVoice(voice)
	self._uiSpine:setActionEventCb(self._onAnimEnd, self)
end

function Activity186HeroView:_onAnimEnd()
	return
end

function Activity186HeroView:isPlayingVoice()
	if not self._uiSpine then
		return false
	end

	return self._uiSpine:isPlayingVoice()
end

function Activity186HeroView:_onClick()
	if not self._interactionStartTime or Time.time - self._interactionStartTime > self.clickcd then
		self._interactionStartTime = Time.time

		local voice = Activity186HeroView.getShopVoice(Activity186Enum.VoiceType.ClickSkin, Activity186HeroView.checkParam, self.actId)

		self:playVoice(voice)
	end
end

function Activity186HeroView:playVoice(config)
	if not self._uiSpine then
		return
	end

	if not config then
		return
	end

	self:stopVoice()
	self._uiSpine:playVoice(config, nil, self._txtanacn, self._txtanaen, self._gocontentbg)
	self:playUIEffect(config)
end

function Activity186HeroView:playUIEffect(config)
	local viewEffect = config.viewEffect

	if viewEffect and viewEffect > 0 then
		ViewMgr.instance:openView(ViewName.Activity186EffectView, {
			effectId = viewEffect
		})
	end
end

function Activity186HeroView:onVoiceStop()
	ViewMgr.instance:closeView(ViewName.Activity186EffectView)
end

function Activity186HeroView.getShopVoice(type, checkFun, actId, sortFun)
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
				if Activity186HeroView._checkTime(param, zeroTime, nowTime) then
					return true
				end
			end

			return false
		end

		return true
	end

	local voices = Activity186Config.instance:getVoiceConfig(type, verifyCallback)

	if checkFun then
		local mo = Activity186Model.instance:getById(actId)
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

	return (Activity186HeroView.getHeightWeight(voices))
end

function Activity186HeroView.getHeightWeight(configs)
	local index = math.random(1, #configs)

	return configs[index]
end

function Activity186HeroView._checkTime(param, zeroTime, nowTime)
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

function Activity186HeroView.checkParam(config, actMo)
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
		return actMo:hasActivityReward()
	elseif type == 3 then
		return actMo:hasCanRewardTask()
	elseif type == 4 then
		local value = arr[2]

		return actMo:checkLikeEqual(value)
	end

	return true
end

function Activity186HeroView:onClose()
	self._click:RemoveClickListener()
	self:stopVoice()
end

function Activity186HeroView:stopVoice()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_system_voc)

	if self._uiSpine then
		self._uiSpine:stopVoice()
	end
end

function Activity186HeroView:onDestroyView()
	return
end

return Activity186HeroView
