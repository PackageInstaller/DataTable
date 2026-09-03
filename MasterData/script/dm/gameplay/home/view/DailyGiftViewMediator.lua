-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/DailyGiftViewMediator.lua

DailyGiftViewMediator = class("DailyGiftViewMediator", DmAreaViewMediator)

DailyGiftViewMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.reward.tips"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onShowTips"
	},
	["main.reward.accept"] = {
		func = "onAcceptGift"
	}
}

function DailyGiftViewMediator:initialize()
	super.initialize(self)
end

function DailyGiftViewMediator:dispose()
	super.dispose(self)
end

function DailyGiftViewMediator:onRegister()
	super.onRegister(self)
	self:setupTopInfoWidget()
end

function DailyGiftViewMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("main.topNode")
	local config = {
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}

	self._topInfoWidget = self:autoManageObject(self:getInjector():injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
	self._topInfoWidget:hideTitle()
end

function DailyGiftViewMediator:onClickBack()
	self:dismiss()
end

function DailyGiftViewMediator:enterWithData()
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._anim = self:getView():getChildByName("anim")

	self:enableSceneEffect()

	self._tipsView = self._main:getChildByName("showTips")

	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	local heroId = customDataSystem:getValue(PrefixType.kGlobal, "BoardHeroId", -1)

	self:initHeroAnim(heroId)
	self:refreshRolesState()
	self:initVisualEffect()
end

function DailyGiftViewMediator:initHeroAnim(heroId)
	local heroName = Strings:get(ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "Name"))
	local nameLabel = self._main:getChildByName("name_left")

	nameLabel:setString(heroName)

	local heroPanel = self._main:getChildByName("hero")
	local roleModelId = ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "RoleModel")
	local heroBust = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = roleModelId
	})

	heroBust:addTo(heroPanel)
	heroBust:setPosition(cc.p(580, 200))

	local rewardPanel = self._main:getChildByName("reward")
	local heroWord = rewardPanel:getChildByName("nameStr")

	heroWord:setString(Strings:get("Daily_Gift_Admire", {
		name = heroName
	}))

	local heroFreeStaminaDesc = Strings:get(ConfigReader:getDataByNameIdAndKey("HeroLove", heroId, "FreeStaminaDesc"))
	local freeStaminaDescLabel = self._main:getChildByName("content_text")

	freeStaminaDescLabel:getVirtualRenderer():setMaxLineWidth(843)
	freeStaminaDescLabel:getVirtualRenderer():setLineSpacing(8)
	freeStaminaDescLabel:setString(heroFreeStaminaDesc)

	local heroImg = IconFactory:createRoleIconSprite({
		stencil = 1,
		iconType = "Bust2",
		id = roleModelId,
		size = cc.size(498.1, 279.02)
	})
	local heroImagePanel = self._anim:getChildByName("imagePanel")

	heroImg:addTo(heroImagePanel):center(heroImagePanel:getContentSize())
end

function DailyGiftViewMediator:refreshRolesState()
	self._timeFragmentIndex = 0

	local activity = self._activitySystem:getActivityById("FreeStamina")
	local curList = activity:getActivityConfig().FreeStamina

	for i = 1, #curList do
		local status = self._activitySystem:isCanGetStamina(curList[i].Time, curList[i].Order)

		if status == StaminaRewardTimeStatus.kNow then
			self._timeFragmentIndex = i
		end

		local timeText = self._tipsView:getChildByName("time" .. i)
		local str1 = curList[i].Time[1]
		local str2 = curList[i].Time[2]
		local splite1 = string.split(str1, ":")

		str1 = splite1[1] .. ":" .. splite1[2]

		local splite2 = string.split(str2, ":")

		str2 = splite2[1] .. ":" .. splite2[2]

		timeText:setString(str1 .. "-" .. splite2[1] .. ":" .. splite2[2])
	end

	if curList[self._timeFragmentIndex] then
		local iconPanel = self._main:getChildByFullName("reward.rewardIcon")
		local rewardIconId = curList[self._timeFragmentIndex].Icon
		local _icon = ccui.ImageView:create("asset/items/" .. rewardIconId .. ".png", ccui.TextureResType.localType)

		_icon:addTo(iconPanel):center(iconPanel:getContentSize())
	end

	local dataLabel = self._anim:getChildByName("data")

	dataLabel:setAdditionalKerning(2)

	local timeStemp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
	local data = TimeUtil:localDate("*t", timeStemp)
	local year = data.year
	local month = data.month
	local day = data.day

	if tonumber(month) < 10 then
		month = "0" .. tostring(month)
	end

	if tonumber(day) < 10 then
		day = "0" .. tostring(day)
	end

	local dataStrTab = {}

	dataStrTab[#dataStrTab + 1] = year
	dataStrTab[#dataStrTab + 1] = "."
	dataStrTab[#dataStrTab + 1] = month
	dataStrTab[#dataStrTab + 1] = "."
	dataStrTab[#dataStrTab + 1] = day

	local dataStr = table.concat(dataStrTab)

	dataLabel:setString(dataStr)
end

function DailyGiftViewMediator:onShowTips(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._tipsView:setVisible(true)
	elseif eventType == ccui.TouchEventType.ended then
		self._tipsView:setVisible(false)
	elseif eventType == ccui.TouchEventType.canceled then
		self._tipsView:setVisible(false)
	end
end

function DailyGiftViewMediator:onAcceptGift()
	local param = {
		doActivityType = 101,
		index = self._timeFragmentIndex
	}

	self._activitySystem:requestDoActivity(DailyGift, param, function(response)
		local dispatcher = DmGame:getInstance()
		local view = dispatcher:getInjector():getInstance("getRewardView")

		dispatcher:dispatch(ShowTipEvent({
			tip = Strings:get("Daily_Gift_Get")
		}))
		dispatcher:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			rewards = response.data.reward
		}))
	end)
	self:dismiss()
end

function DailyGiftViewMediator:enableSceneEffect()
	local target = self:getView():getChildByName("scene")

	target:setLocalZOrder(-1)
	CommonUtils.convertToBlurSprite(target, 8, 4, 0.5)
end

function DailyGiftViewMediator:initVisualEffect()
	self._anim:setVisible(true)
	self._main:setVisible(false)

	local function closeFunc()
		self._anim:setVisible(false)
		self._main:setVisible(true)
	end

	mapButtonHandlerClick(nil, self._anim, {
		ignoreClickAudio = true,
		func = closeFunc
	})
end
