-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ReturnHeroChangeMediator.lua

ReturnHeroChangeMediator = class("ReturnHeroChangeMediator", PopupViewMediator, _M)

ReturnHeroChangeMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {}
local kRoleRarityAnim = {
	[12] = {
		"r_choukajieguokapai",
		0.6,
		"img_chouka_new_r.png"
	},
	[13] = {
		"sr_choukajieguokapai",
		0.66,
		"img_chouka_new_sr.png"
	},
	[14] = {
		"ssr_choukajieguokapai",
		0.78,
		"img_chouka_new_ssr.png"
	}
}
local kRoleRarityNameBg = {
	[12] = "asset/heroRect/heroRarity/img_chouka_front_r.png",
	[13] = "asset/heroRect/heroRarity/img_chouka_front_sr.png",
	[14] = "asset/heroRect/heroRarity/img_chouka_front_ssr.png"
}

function ReturnHeroChangeMediator:initialize()
	super.initialize(self)
end

function ReturnHeroChangeMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:initUI()
end

function ReturnHeroChangeMediator:enterWithData(data)
	self._activity = data.activity
	self._developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
	self._heroSystem = self._developSystem:getHeroSystem()
	self._activityConfig = self._activity:getConfig().ActivityConfig
	self._selectTaskId = nil

	self:setupList()
end

function ReturnHeroChangeMediator:initUI()
	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("list")

	self._listView:setScrollBarEnabled(false)

	self._itemCell = self:getView():getChildByName("cardCell")
	self._title = self._main:getChildByFullName("BG.title_node")

	self._title:getChildByName("Text_1"):setString(Strings:get("Activity_Return_Hero_Choose3"))
	self._title:getChildByName("Text_2"):setString(Strings:get("Activity_Return_ENTitle01"))

	self._choiceBtn = self:bindWidget("main.rewardBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onChoiceBtnClick, self)
		}
	})

	self._choiceBtn:setButtonName(Strings:get("Activity_Return_Hero_Choose5"), Strings:get("Activity_Return_ENTitle02"))
end

function ReturnHeroChangeMediator:setupList()
	local initPosX = 222

	self._listView:removeAllChildren()

	local len = 0

	for k, v in pairs(self._activityConfig.Choice) do
		local item = self._itemCell:clone()

		self:setupCardById(item, k, v)
		self._listView:pushBackCustomItem(item)

		len = len + 1
	end

	local offsetX = (self._listView:getContentSize().width - len * self._itemCell:getContentSize().width) / (len + 1)

	self._listView:setItemsMargin(math.max(0, offsetX))
	self._listView:setPositionX(initPosX + math.max(0, offsetX))
end

function ReturnHeroChangeMediator:onChoiceBtnClick()
	if self._selectTaskId == nil or self._selectTaskId == "" then
		local tips = Strings:get("Activity_Return_Hero_Choose6")

		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	local data = {
		doActivityType = 102,
		selectIndex = self._selectTaskId
	}
	local baseActivity = self._activitySystem:getActivityByComplexUI(ActivityType.KReturn)

	self._activitySystem:requestDoChildActivity(baseActivity:getId(), self._activity:getId(), data, function(response)
		if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
			return
		end

		local rewards = response.data.reward

		if rewards then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = rewards
			}))
		end

		self:dispatch(Event:new(EVT_RETURN_ACTIVITY_REFRESH))
		self:close()
	end)
end

function ReturnHeroChangeMediator:setupCardById(node, idx, info)
	node:setName(idx)

	local cardId = ConfigReader:getDataByNameIdAndKey("RoleModel", info.ModelId, "Hero")
	local heroConfig = ConfigReader:getRecordById("HeroBase", cardId)
	local rarityAnimName = kRoleRarityAnim[heroConfig.Rareity][1]

	node:getChildByFullName("bg"):removeAllChildren()

	local anim = cc.MovieClip:create(rarityAnimName)

	anim:addTo(node:getChildByFullName("bg")):center(node:getChildByFullName("bg"):getContentSize()):offset(0, 0)
	anim:setScale(0.6)

	local nameBg = node:getChildByFullName("nameBg")

	nameBg:loadTexture(kRoleRarityNameBg[heroConfig.Rareity])

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", cardId)
	local roleAnim = anim:getChildByFullName("roleAnim")
	local roleNode = roleAnim:getChildByFullName("roleNode")
	local realImage = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe7_1",
		id = roleModel
	})

	realImage:addTo(roleNode):offset(0, 0)

	local starPanel = node:getChildByFullName("starPanel")

	for i = 1, 3 do
		local starIcon = starPanel:getChildByFullName("star" .. i)

		starIcon:setVisible(i <= heroConfig.BaseStar)
	end

	starPanel:setContentSize(cc.size(32 * heroConfig.BaseStar, 67))

	local name = node:getChildByFullName("name")

	name:setString(Strings:get(heroConfig.Name))

	local rarityNode = node:getChildByFullName("rarity")

	rarityNode:loadTexture(GameStyle:getHeroRarityImage(heroConfig.Rareity), 1)
	rarityNode:ignoreContentAdaptWithSize(true)

	local occupationNode = node:getChildByFullName("occupation")
	local occupationName, occupationImg = GameStyle:getHeroOccupation(heroConfig.Type)

	occupationNode:loadTexture(occupationImg)
	node:getChildByFullName("select"):setVisible(false)
	node:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			if self._selectTaskId then
				local oldCell = self._listView:getChildByName(self._selectTaskId)

				oldCell:getChildByFullName("select"):setVisible(false)
			end

			self._selectTaskId = sender:getName()

			sender:getChildByFullName("select"):setVisible(true)
		end
	end)
end
