-- chunkname: @modules/logic/versionactivity1_4/act129/view/Activity129HeroView.lua

module("modules.logic.versionactivity1_4.act129.view.Activity129HeroView", package.seeall)

local Activity129HeroView = class("Activity129HeroView", BaseView)

function Activity129HeroView:onInitView()
	self._goRole = gohelper.findChild(self.viewGO, "#goRole")
	self._golightspinecontrol = gohelper.findChild(self._goRole, "#go_lightspinecontrol")
	self._gospinescale = gohelper.findChild(self._goRole, "#go_spine_scale")
	self._golightspine = gohelper.findChild(self._goRole, "#go_spine_scale/lightspine/#go_lightspine")
	self._txtanacn = gohelper.findChildText(self.viewGO, "bottom/#txt_Dialouge")
	self._txtanaen = gohelper.findChildText(self.viewGO, "bottom/#txt_Dialouge/#txt_DialougeEn")
	self._gocontentbg = gohelper.findChild(self.viewGO, "bottom")
	self.clickcd = 5

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity129HeroView:addEvents()
	self.addEventCb(self, Activity129Controller.instance, Activity129Event.OnEnterPool, self.onEnterPool, self)
	self.addEventCb(self, Activity129Controller.instance, Activity129Event.OnClickEmptyPool, self.onClickEmptyPool, self)
	self.addEventCb(self, Activity129Controller.instance, Activity129Event.OnShowReward, self.onLotterySuccess, self)
end

function Activity129HeroView:removeEvents()
	self.removeEventCb(self, Activity129Controller.instance, Activity129Event.OnEnterPool, self.onEnterPool, self)
	self.removeEventCb(self, Activity129Controller.instance, Activity129Event.OnClickEmptyPool, self.onClickEmptyPool, self)
	self.removeEventCb(self, Activity129Controller.instance, Activity129Event.OnShowReward, self.onLotterySuccess, self)
end

function Activity129HeroView:onOpen()
	self:_updateHero(306601)
end

function Activity129HeroView:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self._golightspinecontrol)

	self._click:AddClickListener(self._onClick, self)
end

function Activity129HeroView:_updateHero(skinId)
	self._skinId = skinId

	local heroConfig = HeroConfig.instance:getHeroCO(self._heroId)
	local skinCo = SkinConfig.instance:getSkinCo(self._skinId)

	self._heroId = skinCo.characterId
	self._heroSkinConfig = skinCo
	self._uiSpine = self._uiSpine or GuiModelAgent.Create(self._golightspine, true)

	self._uiSpine:setResPath(skinCo, self._onLightSpineLoaded, self)
end

function Activity129HeroView:_onLightSpineLoaded()
	self._uiSpine:setModelVisible(true)

	self._l2d = self._uiSpine:_getLive2d()

	local voice = Activity129HeroView.getShopVoice(Activity129Enum.VoiceType.EnterShop, self._heroId, self._skinId)

	self:playVoice(voice)
	self._l2d:setActionEventCb(self._onAnimEnd, self)
end

function Activity129HeroView:_onAnimEnd()
	return
end

function Activity129HeroView:isPlayingVoice()
	if not self._uiSpine then
		return false
	end

	return self._uiSpine:isPlayingVoice()
end

function Activity129HeroView:_onClick()
	if not self._interactionStartTime or Time.time - self._interactionStartTime > self.clickcd then
		self._interactionStartTime = Time.time

		local voice = Activity129HeroView.getShopVoice(Activity129Enum.VoiceType.ClickHero, self._heroId, self._skinId)

		self:playVoice(voice)
	end
end

function Activity129HeroView:onEnterPool()
	local selectPoolId = Activity129Model.instance:getSelectPoolId()

	if not selectPoolId then
		return
	end

	local function checkFunc(config)
		local list = string.splitToNumber(config.param, "#")

		for k, v in pairs(list) do
			if v == selectPoolId then
				return true
			end
		end

		return false
	end

	local voice = Activity129HeroView.getShopVoice(Activity129Enum.VoiceType.ClickPool, self._heroId, self._skinId, checkFunc)

	self:playVoice(voice)
end

function Activity129HeroView:onClickEmptyPool()
	local voice = Activity129HeroView.getShopVoice(Activity129Enum.VoiceType.ClickEmptyPool, self._heroId, self._skinId)

	self:playVoice(voice)
end

function Activity129HeroView:onLotterySuccess(list)
	if not list then
		return
	end

	local goodsDict = {}
	local rareDict = {}

	for i = 1, #list do
		local reward = list[i]

		goodsDict[reward[1]] = goodsDict[reward[1]] or {}
		goodsDict[reward[1]][reward[2]] = true

		local co = ItemModel.instance:getItemConfigAndIcon(reward[1], reward[2])

		rareDict[co.rare] = true
	end

	local function checkFunc1(config)
		if config.type ~= Activity129Enum.VoiceType.DrawGoosById then
			return true
		end

		local param = string.splitToNumber(config.param, "#")

		return not not (goodsDict[param[1]] and goodsDict[param[1]][param[2]])
	end

	local function checkFunc2(config)
		if config.type ~= Activity129Enum.VoiceType.DrawGoodsByRare then
			return true
		end

		local list = string.splitToNumber(config.param, "#")

		for k, v in pairs(list) do
			if rareDict[v] then
				return true
			end
		end

		return false
	end

	local voices = Activity129HeroView.getShopVoices({
		Activity129Enum.VoiceType.DrawGoosById,
		Activity129Enum.VoiceType.DrawGoodsByRare
	}, self._heroId, self._skinId, {
		checkFunc1,
		checkFunc2
	})
	local orderList = {}

	if voices then
		for i, v in ipairs(voices) do
			local order = 4

			if v.type == Activity129Enum.VoiceType.DrawGoosById then
				local param = string.splitToNumber(v.param, "#")
				local itemCo = ItemModel.instance:getItemConfig(param[1], param[2])

				order = itemCo.rare > 3 and 1 or 3
			elseif v.type == Activity129Enum.VoiceType.DrawGoodsByRare then
				local param = string.splitToNumber(v.param, "#")
				local maxRare

				for _, rare in ipairs(param) do
					if not maxRare or maxRare < rare then
						maxRare = rare
					end
				end

				order = maxRare > 3 and 2 or 4
			end

			table.insert(orderList, {
				order = order,
				voice = v
			})
		end
	end

	local voice

	if #orderList > 1 then
		table.sort(orderList, SortUtil.keyLower("order"))
	end

	voice = orderList[1]

	if orderList[1] then
		local sameOrderList = {}

		for i, v in ipairs(orderList) do
			if v.order == voice.order then
				table.insert(sameOrderList, v)
			end
		end

		voice = Activity129HeroView.getHeightWeight(sameOrderList)
	end

	if voice then
		self:playVoice(voice.voice)
	end
end

function Activity129HeroView:playVoice(config)
	if not self._uiSpine then
		return
	end

	if not config then
		return
	end

	self:stopVoice()
	self._uiSpine:playVoice(config, nil, self._txtanacn, self._txtanaen, self._gocontentbg)
end

function Activity129HeroView.getShopVoice(type, heroId, skinId, checkFun, sortFun)
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
				if Activity129HeroView._checkTime(param, zeroTime, nowTime) then
					return true
				end
			end

			return false
		end

		return true
	end

	local voices = Activity129Model.instance:getShopVoiceConfig(heroId, type, verifyCallback, skinId)

	if checkFun then
		local list = {}

		if voices then
			for i, v in ipairs(voices) do
				if checkFun(v) then
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

	return (Activity129HeroView.getHeightWeight(voices))
end

function Activity129HeroView.getShopVoices(types, heroId, skinId, checkFuncs)
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
				if Activity129HeroView._checkTime(param, zeroTime, nowTime) then
					return true
				end
			end

			return false
		end

		return true
	end

	local list = {}

	for _, v in ipairs(types) do
		local voices = Activity129Model.instance:getShopVoiceConfig(heroId, v, verifyCallback, skinId)

		if voices then
			local t = {}

			for _, voice in ipairs(voices) do
				local canCheck = true

				if checkFuncs then
					for _, checkFunc in ipairs(checkFuncs) do
						if not checkFunc(voice) then
							canCheck = false

							break
						end
					end
				end

				if canCheck then
					table.insert(t, voice)
				end
			end

			tabletool.addValues(list, t)
		end
	end

	return list
end

function Activity129HeroView.getHeightWeight(configs)
	local index = math.random(1, #configs)

	return configs[index]
end

function Activity129HeroView._checkTime(param, zeroTime, nowTime)
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

function Activity129HeroView:onClose()
	self._click:RemoveClickListener()
	self:stopVoice()
end

function Activity129HeroView:stopVoice()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_system_voc)

	if self._uiSpine then
		self._uiSpine:stopVoice()
	end
end

function Activity129HeroView:onDestroyView()
	return
end

return Activity129HeroView
