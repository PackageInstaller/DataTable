-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStrengthAwakenDetailMediator.lua

HeroStrengthAwakenDetailMediator = class("HeroStrengthAwakenDetailMediator", DmAreaViewMediator)

HeroStrengthAwakenDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HeroStrengthAwakenDetailMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	["mainpanel.starNode.staruppanel.skillPanel.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickSkill"
	},
	["mainpanel.starNode.costPanel.starbtn"] = {
		ignoreClickAudio = true,
		func = "onUpStarClicked"
	},
	["mainpanel.starNode.costPanel.translateBtn"] = {
		ignoreClickAudio = true,
		func = "onTranslateClicked"
	}
}
local kAttrType = {
	"ATK",
	"HP",
	"DEF",
	"SPEED"
}
local Hero_GeneralFragmentLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_GeneralFragmentLimit", "content")

function HeroStrengthAwakenDetailMediator:initialize()
	super.initialize(self)
end

function HeroStrengthAwakenDetailMediator:dispose()
	self:getView():stopAllActions()
	super.dispose(self)
end

function HeroStrengthAwakenDetailMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_GALLERY_SEND_GIFT_SUCC, self, self.refreshHero)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HERODEBRISCHANGE_SUCC, self, self.refreshStarUpCostPanel)

	self._developSystem = self:getInjector():getInstance("DevelopSystem")
	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
end

function HeroStrengthAwakenDetailMediator:enterWithData(data)
	self:refreshData(data.heroId)
	self:initNodes()
	self:setupTopInfoWidget()
	self:refreshView(data.heroId)
	self:runStartAction()
end

function HeroStrengthAwakenDetailMediator:initNodes()
	self._main = self:getView():getChildByFullName("mainpanel")
	self._mainPanel = self:getView():getChildByFullName("mainpanel.starNode")
	self._starPanel = self._mainPanel:getChildByFullName("staruppanel")
	self._topPanel = self._mainPanel:getChildByFullName("topPanel")
	self._shopBtn = self._topPanel:getChildByFullName("shopBtn")
	self._descBg = self._starPanel:getChildByFullName("descBg")
	self._skillPanel = self._starPanel:getChildByFullName("skillPanel")
	self._boxPanel = self._starPanel:getChildByFullName("boxPanel")
	self._costPanel = self._mainPanel:getChildByFullName("costPanel")
	self._upStarBtn = self._costPanel:getChildByFullName("starbtn")
	self._title = self._mainPanel:getChildByFullName("text")

	self._title:setString(Strings:get("HEROS_UI5"))

	self._awakeRoleNode = self._main:getChildByFullName("herobase.heropanel")
	self._awakeAreaRoleNode = self._starPanel:getChildByFullName("boxPanel.role")
	self._translateBtn = self._costPanel:getChildByFullName("translateBtn")

	local addImg = self._costPanel:getChildByFullName("costNode1.costBg.addImg")
	local touchPanel = addImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		self:onClickItem()
	end)

	local addImg2 = self._costPanel:getChildByFullName("costNode2.costBg.addImg")
	local touchPanel2 = addImg2:getChildByFullName("touchPanel")

	touchPanel2:setVisible(true)
	touchPanel2:setTouchEnabled(true)
	touchPanel2:addClickEventListener(function()
		self:onClickStiveItem()
	end)

	local AddImg3 = self._costPanel:getChildByFullName("costNode3.costBg.addImg")
	local touchPanel3 = AddImg3:getChildByFullName("touchPanel")

	touchPanel3:setVisible(true)
	touchPanel3:setTouchEnabled(true)
	touchPanel3:addClickEventListener(function()
		self:onClickLoveItem()
	end)

	for i = 1, #kAttrType do
		local node = self._descBg:getChildByFullName("des_" .. i)
		local image = node:getChildByFullName("image")
		local name = node:getChildByFullName("name")
		local text = node:getChildByFullName("text")

		name:setString(getAttrNameByType(kAttrType[i]))
		image:loadTexture(AttrTypeImage[kAttrType[i]], 1)
		GameStyle:setCommonOutlineEffect(name, 219.29999999999998)
		text:enableOutline(cc.c4b(68, 42, 25, 147.89999999999998), 1)
	end

	self._title:enableOutline(cc.c4b(53, 43, 41, 219.29999999999998), 1)
	GameStyle:setCostNodeEffect(self._costPanel:getChildByFullName("costNode1"))
	GameStyle:setCostNodeEffect(self._costPanel:getChildByFullName("costNode2"))
	GameStyle:setCostNodeEffect(self._costPanel:getChildByFullName("costNode3"))

	local roleModel = self._heroData:getAwakenStarConfig().Portrait
	local masterIcon = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe18",
		id = roleModel
	})

	self._awakeRoleNode:removeAllChildren()
	masterIcon:addTo(self._awakeRoleNode)
	masterIcon:setPosition(cc.p(0, 200))
	masterIcon:setRotation(15.5)
end

function HeroStrengthAwakenDetailMediator:refreshData(heroId)
	self._heroId = heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._isLittleStar = self._heroData:getLittleStar()
	self._maxStar = self._heroData:getMaxStar()
	self._curStarId = self._heroData:getStarId()

	local nameStr, nameColor = self._heroData:getName()

	self._starUpViewData = {
		star = 0,
		rarityData = 0,
		heroId = self._heroId,
		attr = {}
	}
end

function HeroStrengthAwakenDetailMediator:refreshHero()
	self:refreshData(self._heroId)
	self:refreshView(self._heroId)
end

function HeroStrengthAwakenDetailMediator:setupTopInfoWidget()
	local topInfoNode = self._main:getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Quality")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		stopAnim = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Strengthen_Title")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function HeroStrengthAwakenDetailMediator:refreshStarPanel(showAnim)
	self:refreshStarNodes(showAnim)
end

function HeroStrengthAwakenDetailMediator:refreshStarNodes(showAnim)
	local star = self._heroData:getAwakenStar()
	local nextIsMiniStar = self._heroData:getNextIsMiniStar()

	self._starUpViewData.star = self._heroData:getAwakenStar()
	self._starUpViewData.rarityData = self._heroData:getRarity()
	self._starUpViewData.attr = {
		attack = {
			0,
			0
		},
		hp = {
			0,
			0
		},
		defense = {
			0,
			0
		},
		speed = {
			0,
			0
		}
	}
	self._starUpViewData.attr.attack[1] = self._heroData:getAttack()
	self._starUpViewData.attr.hp[1] = self._heroData:getHp()
	self._starUpViewData.attr.defense[1] = self._heroData:getDefense()
	self._starUpViewData.attr.speed[1] = self._heroData:getSpeed()

	self._descBg:setVisible(true)

	local nextStarId = self._heroData:getNextStarId(true)
	local attrNum = {
		[kAttrType[1]] = self._heroData:getAttack(),
		[kAttrType[2]] = self._heroData:getHp(),
		[kAttrType[3]] = self._heroData:getDefense(),
		[kAttrType[4]] = self._heroData:getSpeed()
	}

	for i = 1, #kAttrType do
		local node = self._descBg:getChildByFullName("des_" .. i)
		local text = node:getChildByFullName("text")

		text:setString(attrNum[kAttrType[i]])
		node:getChildByFullName("extandText"):setVisible(nextStarId ~= "")
	end

	if nextStarId ~= "" then
		local a, b, c, d, e = self._heroData:getNextStarEffect({
			starId = nextStarId
		})

		self._descBg:getChildByFullName("des_1.extandText"):setString("+" .. a - self._heroData:getAttack())
		self._descBg:getChildByFullName("des_2.extandText"):setString("+" .. c - self._heroData:getHp())
		self._descBg:getChildByFullName("des_3.extandText"):setString("+" .. b - self._heroData:getDefense())
		self._descBg:getChildByFullName("des_4.extandText"):setString("+" .. d - self._heroData:getSpeed())

		self._starUpViewData.attr.attack[2] = a - self._heroData:getAttack()
		self._starUpViewData.attr.hp[2] = c - self._heroData:getHp()
		self._starUpViewData.attr.defense[2] = b - self._heroData:getDefense()
		self._starUpViewData.attr.speed[2] = d - self._heroData:getSpeed()
	end

	self:refreshStarUpCostPanel()
	self._topPanel:setVisible(false)
	self._title:setString(Strings:get("HEROS_UI5"))
	self._costPanel:setVisible(true)
	self._skillPanel:setVisible(true)

	local exSkillNode = self._skillPanel:getChildByFullName("exSkillNode")
	local attrNode = self._skillPanel:getChildByFullName("attrNode")
	local skillNode = self._skillPanel:getChildByFullName("skillNode")
	local specialEffect = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", self._heroData:getAwakenStarId(), "SpecialEffect") or {}
	local skillId = ConfigReader:getDataByNameIdAndKey("SkillSpecialEffect", specialEffect[1], "Parameter").after

	exSkillNode:setVisible(false)
	attrNode:setVisible(false)
	skillNode:setVisible(false)
	exSkillNode:setVisible(true)
	self._skillPanel:getChildByFullName("text"):setString(Strings:get("Hero_Star_UI_Skill"))

	local node1 = exSkillNode:getChildByFullName("node1")

	node1:removeAllChildren()

	local node2 = exSkillNode:getChildByFullName("node2")

	node2:removeAllChildren()

	local name = exSkillNode:getChildByFullName("name")
	local skillName = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Name")

	name:setString(Strings:get(skillName))

	local newSkillNode = IconFactory:createHeroSkillIcon({
		id = skillId
	}, {
		hideLevel = true
	})

	newSkillNode:addTo(node1):center(node1:getContentSize())
	newSkillNode:setScale(0.6)

	local newSkillNode = IconFactory:createHeroSkillIcon({
		id = skillId
	}, {
		hideLevel = true
	})

	newSkillNode:addTo(node2):center(node2:getContentSize())
	newSkillNode:setScale(0.68)

	local str = cc.Label:createWithTTF(Strings:get("Hero_Star_UI_Ex"), TTF_FONT_FZYH_R, 18)

	str:addTo(node2):center(node2:getContentSize()):offset(-2, -16)
	str:enableOutline(cc.c4b(0, 0, 0, 255), 2)
end

function HeroStrengthAwakenDetailMediator:checkIsShowAttr()
	local starAttrsMap = self._heroData:getStarAttrsMap()
	local starAttrs = self._heroData:getStarAttrs()
	local nextIsMiniStar = self._heroData:getNextIsMiniStar()
	local attr
	local star = self._heroData:getAwakenStar() + self._heroData:getMaxStar()

	local function callback()
		for i = 1, #starAttrs do
			local value = starAttrs[i]

			if value.star >= star then
				local infos = value.info

				for index = 1, #infos do
					if infos[index].attrType == "skill" and infos[index].isEXSkill then
						attr = infos[index]

						if attr.isMiniStar then
							local var_15_0 = Strings:get("Hero_Star_UI_SkillEx", {
								star = value.star
							})

							if not var_15_0 then
								var_15_0 = Strings:get("Hero_Star_UI_SkillEx_1", {
									star = value.star
								})
								attr.lockTip = var_15_0

								return attr
							end
						end
					end
				end
			end
		end

		return nil
	end

	local data = starAttrsMap[star]

	if data then
		for i = 1, #data do
			if data[i].isMiniStar then
				attr = data[i]

				return data[i]
			end
		end
	end

	if not attr then
		attr = callback()

		if attr then
			return attr
		end
	end

	return attr
end

function HeroStrengthAwakenDetailMediator:refreshStarUpCostPanel()
	if not self._heroData:isMaxStar() then
		-- block empty
	end

	self._upStarBtn:setVisible(true)

	local heroPrototype = self._heroData:getHeroPrototype()
	local loveNeed = self._heroData:getAwakenStarNeedLove()
	local hasloveLevel = self._heroData:getLoveLevel()
	local lovePanel = self._costPanel:getChildByFullName("costNode3.costBg")
	local loveiconpanel = lovePanel:getChildByFullName("iconpanel")

	loveiconpanel:removeAllChildren()

	local loveIcon = ccui.ImageView:create("album_bg_archives_amount_hgd.png", 1)

	loveIcon:addTo(loveiconpanel):center(loveiconpanel:getContentSize())
	loveIcon:setScale(1.2)

	self._loveEngouh = loveNeed <= hasloveLevel

	local addImg = lovePanel:getChildByFullName("addImg")
	local enoughImg = lovePanel:getChildByFullName("bg.enoughImg")
	local costPanel = lovePanel:getChildByFullName("costPanel")

	costPanel:setVisible(true)

	local costNumLabel = costPanel:getChildByFullName("cost")
	local costLimit = costPanel:getChildByFullName("costLimit")

	costNumLabel:setVisible(true)
	costNumLabel:setString(hasloveLevel)
	costLimit:setString("/" .. loveNeed)
	costLimit:setPositionX(costNumLabel:getContentSize().width)
	enoughImg:setVisible(self._loveEngouh)
	addImg:setVisible(not self._loveEngouh)
	loveiconpanel:setGray(not self._loveEngouh)

	local colorNum = self._loveEngouh and 1 or 7

	costNumLabel:setTextColor(GameStyle:getColor(colorNum))

	local costStiveNum = heroPrototype:getStarCostStarStiveByStar(self._heroData:getNextStarId(true))
	local stiveNum = self._heroSystem:getHeroStarUpItem().stiveNum
	local scourcePanel = self._costPanel:getChildByFullName("costNode2.costBg")
	local iconpanel = scourcePanel:getChildByFullName("iconpanel")

	iconpanel:removeAllChildren()

	local icon = ccui.ImageView:create("occupation_all.png", 1)

	icon:addTo(iconpanel):center(iconpanel:getContentSize())

	local addImg = scourcePanel:getChildByFullName("addImg")
	local iconpanel = scourcePanel:getChildByFullName("iconpanel")
	local enoughImg = scourcePanel:getChildByFullName("bg.enoughImg")
	local costPanel = scourcePanel:getChildByFullName("costPanel")

	costPanel:setVisible(true)

	local costNumLabel = costPanel:getChildByFullName("cost")
	local costLimit = costPanel:getChildByFullName("costLimit")

	costNumLabel:setVisible(true)
	costNumLabel:setString(stiveNum)
	costLimit:setString("/" .. costStiveNum)
	costLimit:setPositionX(costNumLabel:getContentSize().width)

	self._costNum = costStiveNum
	self._stiveEngouh = costStiveNum <= stiveNum

	enoughImg:setVisible(self._stiveEngouh)
	addImg:setVisible(not self._stiveEngouh)
	iconpanel:setGray(not self._stiveEngouh)

	local colorNum = self._stiveEngouh and 1 or 7

	costNumLabel:setTextColor(GameStyle:getColor(colorNum))

	local iconpanel = self._costPanel:getChildByFullName("costNode1.costBg.iconpanel")

	iconpanel:removeAllChildren()

	local hasDebrisNum = self._heroSystem:getHeroDebrisCount(self._heroId)
	local needDebrisNum = heroPrototype:getStarCostFragByStar(self._heroData:getNextStarId(true))

	self._debrisEngouh = needDebrisNum <= hasDebrisNum

	local icon = IconFactory:createIcon({
		id = self._heroData:getFragId()
	}, {
		showAmount = false
	})

	icon:setScale(0.46)
	icon:addTo(iconpanel):center(iconpanel:getContentSize())

	local colorNum1 = self._debrisEngouh and 1 or 7

	enoughImg = self._costPanel:getChildByFullName("costNode1.costBg.bg.enoughImg")

	enoughImg:setVisible(self._debrisEngouh)

	local costPanel = self._costPanel:getChildByFullName("costNode1.costBg.costPanel")

	costPanel:setVisible(true)

	local cost = costPanel:getChildByFullName("cost")
	local costLimit = costPanel:getChildByFullName("costLimit")

	cost:setString(hasDebrisNum)
	costLimit:setString("/" .. needDebrisNum)
	costLimit:setPositionX(cost:getContentSize().width)
	costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width, 40))
	cost:setTextColor(GameStyle:getColor(colorNum1))
	costLimit:setTextColor(GameStyle:getColor(colorNum1))

	addImg = self._costPanel:getChildByFullName("costNode1.costBg.addImg")

	addImg:setVisible(not self._debrisEngouh)
	iconpanel:setGray(not self._debrisEngouh)
end

function HeroStrengthAwakenDetailMediator:refreshView(heroId)
	local canExchange = not table.indexof(Hero_GeneralFragmentLimit, self._heroId)

	self._translateBtn:setVisible(canExchange)
	self._upStarBtn:setPositionX(canExchange and 647 or 500)
	self:refreshViewState()
end

function HeroStrengthAwakenDetailMediator:refreshViewState(showAnim)
	local isMaxStar = self._heroData:isMaxStar()

	self._descBg:setVisible(not isMaxStar)
	self._skillPanel:setVisible(not isMaxStar)
	self._title:setString((isMaxStar or nil) and (Strings:get("HEROS_UI6") or Strings:get("HEROS_UI5")))
	self:refreshStarPanel(showAnim)
end

function HeroStrengthAwakenDetailMediator:refreshAllView()
	self:refreshView()
end

function HeroStrengthAwakenDetailMediator:onUpStarClicked()
	if not self._debrisEngouh then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010029")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._stiveEngouh then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("HERO_AWAKE_STIVE_NOT_ENOUGH")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._loveEngouh then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("HERO_AWAKE_LOVE_NOT_ENOUGH")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local param = {}

	for key, value in pairs(self._starUpViewData) do
		param[key] = value
	end

	local function callback()
		self:dispatch(Event:new(EVT_HEROAWAKEN_SUCC))

		local view = self:getInjector():getInstance("HeroStrengthAwakenSuccessView")

		self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, nil, {
			heroId = self._heroId,
			oldStarId = self._curStarId
		}))
	end

	local items = self._heroSystem:getHeroStarUpItem().items

	self._heroSystem:requestHeroAwake(self._heroId, items, callback)
end

function HeroStrengthAwakenDetailMediator:onTranslateClicked()
	local data = self:getIsHaveFragmentFlag()
	local hasFragmentNum = self._bagSystem:getItemCount(data.id)

	if hasFragmentNum <= 0 then
		local heroPrototype = self._heroData:getHeroPrototype()
		local param = {
			needNum = 0,
			isNeed = true,
			hasNum = 0,
			hasWipeTip = true,
			itemId = data.id
		}
		local view = self:getInjector():getInstance("sourceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param))

		return
	end

	local debrisChangeTipView = self:getInjector():getInstance("HeroGeneralFragmentView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		kind = 2,
		heroId = self._heroId
	}, nil))
end

function HeroStrengthAwakenDetailMediator:getIsHaveFragmentFlag()
	local data
	local heroData = self._heroSystem:getHeroById(self._heroId)
	local quality = self._heroData:getRarity()
	local info = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_StarFragment", "content")

	for k, v in pairs(info) do
		if quality == tonumber(k) then
			data = {
				id = next(v),
				num = v[next(v)]
			}

			break
		end
	end

	assert(data, "no qualiy Hero_StarFragment ")

	return data
end

function HeroStrengthAwakenDetailMediator:onClickBack()
	self:dismiss()
end

function HeroStrengthAwakenDetailMediator:onClickSkill()
	local debrisChangeTipView = self:getInjector():getInstance("HeroStarSkillView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		heroId = self._heroId
	}, nil))
end

function HeroStrengthAwakenDetailMediator:onClickItem()
	local heroPrototype = self._heroData:getHeroPrototype()
	local needNum = heroPrototype:getStarCostFragByStar(self._heroData:getNextStarId(true))
	local hasCount = self._heroSystem:getHeroDebrisCount(self._heroId)
	local param = {
		isNeed = true,
		hasWipeTip = true,
		itemId = self._heroData:getFragId(),
		hasNum = hasCount,
		needNum = needNum
	}
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param))
end

function HeroStrengthAwakenDetailMediator:onClickStiveItem()
	local heroPrototype = self._heroData:getHeroPrototype()
	local costStiveNum = heroPrototype:getStarCostStarStiveByStar(self._heroData:getNextStarId(true))
	local debrisChangeTipView = self:getInjector():getInstance("HeroStarLevelView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		heroId = self._heroId,
		needNum = costStiveNum,
		callback = function()
			self:refreshStarUpCostPanel()
		end
	}, nil))
end

function HeroStrengthAwakenDetailMediator:onClickLoveItem()
	self._heroSystem:tryEnterDate(self._heroId, GalleryFuncName.kGift)
end

function HeroStrengthAwakenDetailMediator:runStartAction()
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/StrengthenAwakenDetail.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 30, false)

	local bgAnim1 = self._skillPanel:getChildByFullName("bgAnim1")

	if not bgAnim1:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(bgAnim1)
		anim:setName("BgAnim")
	end

	bgAnim1:getChildByFullName("BgAnim"):gotoAndStop(1)

	local model = IconFactory:getRoleModelByKey("HeroBase", self._heroId)

	if not model or model == "" then
		return
	end

	model = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Model")

	local role = RoleFactory:createRoleAnimation(model)

	self._roleSpine = role

	role:setName("RoleAnim")
	role:addTo(self._awakeAreaRoleNode):setScale(0.4):posite(35, 5)
	role:registerSpineEventHandler(handler(self, self.spineCompleteHandler), sp.EventType.ANIMATION_COMPLETE)

	local bgAnim3 = self._boxPanel:getChildByFullName("bgAnim1")

	if not bgAnim3:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(bgAnim3)
		anim:setName("BgAnim")
	end

	bgAnim3:getChildByFullName("BgAnim"):gotoAndStop(1)

	local bgAnim2 = self._descBg:getChildByFullName("bgAnim2")

	if not bgAnim2:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(bgAnim2)
		anim:setName("BgAnim")
	end

	bgAnim2:getChildByFullName("BgAnim"):gotoAndStop(1)

	local costNode0 = self._topPanel:getChildByFullName("costNode")
	local costNode1 = self._costPanel:getChildByFullName("costNode1")
	local costNode2 = self._costPanel:getChildByFullName("costNode2")
	local costNode3 = self._costPanel:getChildByFullName("costNode3")

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "BgAnim1" then
			bgAnim1:getChildByFullName("BgAnim"):gotoAndPlay(1)
			bgAnim3:getChildByFullName("BgAnim"):gotoAndPlay(1)
		end

		if str == "CostAnim1" then
			local posX = costNode1:getPositionX()
			local posY = costNode1:getPositionY()

			GameStyle:runCostAnim(costNode1)
		end

		if str == "CostAnim2" then
			GameStyle:runCostAnim(costNode2)
		end

		if str == "CostAnim3" then
			GameStyle:runCostAnim(costNode3)
		end

		if str == "BgAnim2" then
			bgAnim2:getChildByFullName("BgAnim"):gotoAndPlay(1)
		end

		if str == "EndAnim" then
			-- block empty
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function HeroStrengthAwakenDetailMediator:spineCompleteHandler(event)
	if event.type == "complete" and event.animation ~= "stand1" and self._roleSpine then
		self._roleSpine:playAnimation(0, "stand1", true)
	end
end
