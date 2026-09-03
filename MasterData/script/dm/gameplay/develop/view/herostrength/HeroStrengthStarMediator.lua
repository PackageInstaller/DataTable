-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStrengthStarMediator.lua

HeroStrengthStarMediator = class("HeroStrengthStarMediator", DmAreaViewMediator, _M)

HeroStrengthStarMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local kBtnHandlers = {
	["mainpanel.starNode.costPanel.debrisbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onDebrisClicked"
	},
	["mainpanel.starNode.staruppanel.skillPanel.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickSkill"
	},
	["mainpanel.starNode.staruppanel.boxPanel.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBox"
	},
	["mainpanel.starNode.costPanel.starbtn"] = {
		ignoreClickAudio = true,
		func = "onUpStarClicked"
	},
	["mainpanel.starNode.costPanel.btn_translate"] = {
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
local kStarPanelPosX = {
	150,
	150,
	150,
	120,
	70,
	0
}
local Hero_GeneralFragmentLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_GeneralFragmentLimit", "content")

function HeroStrengthStarMediator:initialize()
	super.initialize(self)
end

function HeroStrengthStarMediator:dispose()
	if self._main.timer then
		self._main.timer:stop()

		self._main.timer = nil
	end

	super.dispose(self)
end

function HeroStrengthStarMediator:onRegister()
	super.onRegister(self)

	self._developSystem = self:getInjector():getInstance("DevelopSystem")
	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
end

function HeroStrengthStarMediator:setupView(parentMedi, data)
	self._mediator = parentMedi

	self:refreshData(data.id)
	self:initNodes()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_PUSH_PACAKGE_DONE, self, self.createPushBackBoxIcon)
end

function HeroStrengthStarMediator:refreshData(heroId)
	self._heroId = heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._isLittleStar = self._heroData:getLittleStar()
	self._maxStar = self._heroData:getMaxStar()

	local nameStr, nameColor = self._heroData:getName()

	self._preHeroInfo = {
		id = self._heroData:getId(),
		level = self._heroData:getLevel(),
		star = self._heroData:getStar(),
		quality = self._heroData:getQuality(),
		nameStr = nameStr,
		nameColor = nameColor,
		combat = self._heroData:getCombat(),
		speed = self._heroData:getSpeed()
	}
	self._starUpViewData = {
		star = 0,
		rarityData = 0,
		heroId = self._heroId,
		attr = {}
	}
end

function HeroStrengthStarMediator:initNodes()
	self._main = self:getView():getChildByFullName("mainpanel")
	self._mainPanel = self:getView():getChildByFullName("mainpanel.starNode")
	self._starPanel = self._mainPanel:getChildByFullName("staruppanel")
	self._topPanel = self._mainPanel:getChildByFullName("topPanel")
	self._shopBtn = self._topPanel:getChildByFullName("shopBtn")
	self._descBg = self._starPanel:getChildByFullName("descBg")
	self._skillPanel = self._starPanel:getChildByFullName("skillPanel")
	self._boxPanel = self._starPanel:getChildByFullName("boxPanel")
	self._costPanel = self._mainPanel:getChildByFullName("costPanel")
	self._debrisBtn = self._costPanel:getChildByFullName("debrisbtn")
	self._translteBtn = self._costPanel:getChildByFullName("btn_translate")
	self._upStarBtn = self._costPanel:getChildByFullName("starbtn")
	self._title = self._mainPanel:getChildByFullName("text")

	self._title:setString(Strings:get("HEROS_UI5"))

	local goldAddImg = self._costPanel:getChildByFullName("costNode2.costBg.addImg")
	local touchPanel = goldAddImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kGold)
	end)

	local addImg = self._costPanel:getChildByFullName("costNode1.costBg.addImg")
	local touchPanel = addImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		self:onClickItem()
	end)
	self._shopBtn:addClickEventListener(function()
		self._shopSystem:tryEnterDebris()
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
end

function HeroStrengthStarMediator:refreshStarPanel(showAnim)
	self:refreshStarNodes(showAnim)
end

function HeroStrengthStarMediator:refreshStarNodes(showAnim)
	local starData = self:checkIsShowAttr()
	local star = self._heroData:getStar()
	local nextIsMiniStar = self._heroData:getNextIsMiniStar()
	local starBgPanel = self._starPanel:getChildByFullName("panel")

	starBgPanel:setPositionX(kStarPanelPosX[self._maxStar])

	for i = 1, HeroStarCountMax do
		local starBg = self._starPanel:getChildByFullName("panel.starBg" .. i)

		starBg:setVisible(i <= self._maxStar)

		local posX = starBg:getChildByFullName("bg"):getPositionX()
		local posY = starBg:getChildByFullName("bg"):getPositionY()

		starBg:removeChildByName("StarImage")

		local anim1

		if i <= star then
			anim1 = cc.MovieClip:create("yh_aa_yinghunshengxing")

			anim1:addEndCallback(function()
				anim1:gotoAndPlay(11)
			end)
			anim1:gotoAndPlay(1)
			anim1:addTo(starBg):posite(posX + 2, posY + 12)
		elseif i == star + 1 then
			if self._isLittleStar then
				if self._heroSystem:hasRedPointByStar(self._heroId) then
					anim1 = cc.MovieClip:create("bankexing_yinghunshengxing")

					anim1:addEndCallback(function()
						anim1:gotoAndPlay(18)
					end)
					anim1:gotoAndPlay(1)
					anim1:addTo(starBg):posite(posX, posY)
				else
					anim1 = cc.MovieClip:create("shengdaobanxing_yinghunshengxing")

					anim1:addEndCallback(function()
						anim1:gotoAndPlay(20)
					end)
					anim1:gotoAndPlay(1)
					anim1:addTo(starBg):posite(posX, posY)
				end
			elseif self._heroSystem:hasRedPointByStar(self._heroId) then
				if nextIsMiniStar then
					anim1 = cc.MovieClip:create("keshengbanxing_yinghunshengxing")

					anim1:gotoAndPlay(1)
					anim1:addTo(starBg):posite(posX, posY)
				else
					anim1 = cc.MovieClip:create("daxing_yinghunshengxing")

					anim1:gotoAndPlay(1)
					anim1:addTo(starBg):posite(posX, posY)
				end
			end
		end

		if anim1 then
			anim1:setName("StarImage")
		end
	end

	self._starUpViewData.star = self._heroData:getStar()
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

	local nextStarId = self._heroData:getNextStarId()
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

	local isMaxStar = self._heroData:isMaxStar()

	if not isMaxStar then
		self:refreshStarUpCostPanel()
		self._topPanel:setVisible(false)
		self._title:setString(Strings:get("HEROS_UI5"))
		self._costPanel:setVisible(true)
		self._skillPanel:setVisible(true)

		if starData then
			self._skillPanel:setVisible(true)

			local exSkillNode = self._skillPanel:getChildByFullName("exSkillNode")
			local attrNode = self._skillPanel:getChildByFullName("attrNode")
			local skillNode = self._skillPanel:getChildByFullName("skillNode")
			local hasExSkill = not starData.lockTip and starData.attrType == "skill"
			local hasAttr = not starData.lockTip and starData.attrType == "attr"
			local hasSkill = not not starData.lockTip

			exSkillNode:setVisible(false)
			attrNode:setVisible(false)
			skillNode:setVisible(false)

			if hasExSkill then
				exSkillNode:setVisible(true)
				self._skillPanel:getChildByFullName("text"):setString(Strings:get("Hero_Star_UI_Skill"))

				local node1 = exSkillNode:getChildByFullName("node1")

				node1:removeAllChildren()

				local node2 = exSkillNode:getChildByFullName("node2")

				node2:removeAllChildren()

				local name = exSkillNode:getChildByFullName("name")

				name:setString(starData.name)

				local newSkillNode = IconFactory:createHeroSkillIcon({
					id = starData.skillId
				}, {
					hideLevel = true
				})

				newSkillNode:addTo(node1):center(node1:getContentSize())
				newSkillNode:setScale(0.6)

				local newSkillNode = IconFactory:createHeroSkillIcon({
					id = starData.skillId
				}, {
					hideLevel = true
				})

				newSkillNode:addTo(node2):center(node2:getContentSize())
				newSkillNode:setScale(0.68)

				if starData.isEXSkill then
					local str = cc.Label:createWithTTF(Strings:get("Hero_Star_UI_Ex"), TTF_FONT_FZYH_R, 18)

					str:addTo(node2):center(node2:getContentSize()):offset(-2, -16)
					str:enableOutline(cc.c4b(0, 0, 0, 255), 2)
				end
			elseif hasAttr then
				attrNode:setVisible(true)
				self._skillPanel:getChildByFullName("text"):setString(Strings:get("Hero_Star_UI_Attr"))

				local text = attrNode:getChildByFullName("text")

				text:removeAllChildren()
				text:setString("")

				local width = text:getContentSize().width
				local height = text:getContentSize().height
				local label = ccui.RichText:createWithXML(starData.desc, {})

				label:addTo(text)
				label:setAnchorPoint(cc.p(0, 0.5))
				label:setPosition(cc.p(0, height / 2))
				label:renderContent(width, 0)
			elseif hasSkill then
				skillNode:setVisible(true)
				self._skillPanel:getChildByFullName("text"):setString(Strings:get("Hero_Star_UI_Skill"))

				local node = skillNode:getChildByFullName("node")

				node:removeAllChildren()

				local name = skillNode:getChildByFullName("name")

				name:setString(Strings:get(starData.name))

				local desc = skillNode:getChildByFullName("desc")

				desc:setString(starData.lockTip)

				local newSkillNode = IconFactory:createHeroSkillIcon({
					id = starData.skillId
				}, {
					hideLevel = true
				})

				newSkillNode:addTo(node):center(node:getContentSize())
				newSkillNode:setScale(0.68)

				if starData.isEXSkill then
					local str = cc.Label:createWithTTF(Strings:get("Hero_Star_UI_Ex"), TTF_FONT_FZYH_R, 18)

					str:addTo(node):center(node:getContentSize()):offset(-2, -16)
					str:enableOutline(cc.c4b(0, 0, 0, 255), 2)
				end
			else
				self._skillPanel:setVisible(false)
			end
		else
			self._skillPanel:setVisible(false)
		end
	else
		self._topPanel:setVisible(false)
		self._costPanel:setVisible(false)
		self._skillPanel:setVisible(true)
		self._skillPanel:getChildByFullName("text"):setString(Strings:get("Hero_Star_UI_Attr"))

		local exSkillNode = self._skillPanel:getChildByFullName("exSkillNode")
		local attrNode = self._skillPanel:getChildByFullName("attrNode")
		local skillNode = self._skillPanel:getChildByFullName("skillNode")

		exSkillNode:setVisible(false)
		skillNode:setVisible(false)
		attrNode:setVisible(true)

		local text = attrNode:getChildByFullName("text")

		text:removeAllChildren()
		text:setString(Strings:get("Hero_Star_UI_Remind5"))
	end
end

function HeroStrengthStarMediator:checkIsShowAttr()
	local starAttrsMap = self._heroData:getStarAttrsMap()
	local starAttrs = self._heroData:getStarAttrs()
	local nextIsMiniStar = self._heroData:getNextIsMiniStar()
	local attr
	local star = self._heroData:getStar()

	local function callback()
		for i = 1, #starAttrs do
			local value = starAttrs[i]

			if value.star > star then
				local infos = value.info

				for index = 1, #infos do
					if infos[index].attrType == "skill" and infos[index].isEXSkill then
						attr = infos[index]

						if attr.isMiniStar then
							local var_16_0 = Strings:get("Hero_Star_UI_SkillEx", {
								star = value.star
							})

							if not var_16_0 then
								var_16_0 = Strings:get("Hero_Star_UI_SkillEx_1", {
									star = value.star
								})
								attr.lockTip = var_16_0

								return attr
							end
						end
					end
				end
			end
		end

		return nil
	end

	if not self._isLittleStar then
		if nextIsMiniStar then
			local data = starAttrsMap[star]

			if data then
				for i = 1, #data do
					if data[i].isMiniStar then
						attr = data[i]

						return data[i]
					end
				end
			end
		else
			local data = starAttrsMap[star + 1]

			if data and data[1] and not data[1].isMiniStar then
				attr = data[1]

				return data[1]
			end
		end
	else
		local data = starAttrsMap[star + 1]

		if data and data[1] and not data[1].isMiniStar then
			attr = data[1]

			return data[1]
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

function HeroStrengthStarMediator:refreshStarUpCostPanel()
	if self._heroData:isMaxStar() then
		return
	end

	self._upStarBtn:setVisible(true)

	local heroPrototype = self._heroData:getHeroPrototype()
	local costNum = heroPrototype:getStarCostGoldByStar(self._heroData:getNextStarId())
	local scourcePanel = self._costPanel:getChildByFullName("costNode2.costBg")
	local iconpanel = scourcePanel:getChildByFullName("iconpanel")

	iconpanel:removeAllChildren()

	local icon = IconFactory:createResourcePic({
		scaleRatio = 0.7,
		id = CurrencyIdKind.kGold
	}, {
		largeIcon = true
	})

	icon:addTo(iconpanel):center(iconpanel:getContentSize())

	local addImg = scourcePanel:getChildByFullName("addImg")
	local iconpanel = scourcePanel:getChildByFullName("iconpanel")
	local enoughImg = scourcePanel:getChildByFullName("bg.enoughImg")
	local costNumLabel = scourcePanel:getChildByFullName("cost")

	costNumLabel:setVisible(true)
	costNumLabel:setString(costNum)

	self._costNum = costNum
	self._goldEngouh = costNum <= self._developSystem:getGolds()

	enoughImg:setVisible(self._goldEngouh)
	addImg:setVisible(not self._goldEngouh)
	iconpanel:setGray(not self._goldEngouh)

	local colorNum = self._goldEngouh and 1 or 7

	costNumLabel:setTextColor(GameStyle:getColor(colorNum))

	local hasNum = 0
	local needNum = 0

	self._debrisEngouh = false

	local iconpanel = self._costPanel:getChildByFullName("costNode1.costBg.iconpanel")

	iconpanel:removeAllChildren()

	local nextIsMiniStar = self._heroData:getNextIsMiniStar()

	if self._isLittleStar and not nextIsMiniStar then
		hasNum = self._heroSystem:getHeroStarUpItem().stiveNum
		needNum = self._heroData:getStarStive()
		self._debrisEngouh = needNum <= stiveNum

		local icon = ccui.ImageView:create("occupation_all.png", 1)

		icon:addTo(iconpanel):center(iconpanel:getContentSize())
	else
		hasNum = self._heroSystem:getHeroDebrisCount(self._heroId)
		needNum = heroPrototype:getStarCostFragByStar(self._heroData:getNextStarId())
		self._debrisEngouh = needNum <= hasNum

		local icon = IconFactory:createIcon({
			id = self._heroData:getFragId()
		}, {
			showAmount = false
		})

		icon:setScale(0.46)
		icon:addTo(iconpanel):center(iconpanel:getContentSize())
	end

	local colorNum1 = self._debrisEngouh and 1 or 7

	enoughImg = self._costPanel:getChildByFullName("costNode1.costBg.bg.enoughImg")

	enoughImg:setVisible(self._debrisEngouh)

	local costPanel = self._costPanel:getChildByFullName("costNode1.costBg.costPanel")

	costPanel:setVisible(true)

	local cost = costPanel:getChildByFullName("cost")
	local costLimit = costPanel:getChildByFullName("costLimit")

	cost:setString(hasNum)
	costLimit:setString("/" .. needNum)
	costLimit:setPositionX(cost:getContentSize().width)
	costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width, 40))
	cost:setTextColor(GameStyle:getColor(colorNum1))
	costLimit:setTextColor(GameStyle:getColor(colorNum1))

	addImg = self._costPanel:getChildByFullName("costNode1.costBg.addImg.Image_1")

	addImg:setVisible(not self._debrisEngouh)
	iconpanel:setGray(not self._debrisEngouh)
end

function HeroStrengthStarMediator:refreshView(heroId)
	local canExchange = not table.indexof(Hero_GeneralFragmentLimit, self._heroId)

	self._translteBtn:setVisible(canExchange)
	self._shopBtn:setVisible(self._shopSystem:isShopFragmentOpen())

	local hasStarBoxReward = self._heroData:getHasStarBoxReward()

	self._boxPanel:getChildByFullName("button.red"):setVisible(hasStarBoxReward)
	self:refreshViewState()
end

function HeroStrengthStarMediator:refreshViewState(showAnim)
	local isMaxStar = self._heroData:isMaxStar()

	self._descBg:setVisible(not isMaxStar)
	self._skillPanel:setVisible(not isMaxStar)
	self._title:setString((isMaxStar or nil) and (Strings:get("HEROS_UI6") or Strings:get("HEROS_UI5")))
	self:refreshStarPanel(showAnim)
end

function HeroStrengthStarMediator:refreshAllView()
	self:refreshView()
	self:createPushBackBoxIcon()
end

function HeroStrengthStarMediator:onUpStarClicked()
	if self._heroData:isMaxStar() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Strenghten_Star7")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._debrisEngouh then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010029")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self._developSystem:requstNotEnoughItem("HERO_STAR", CurrencyIdKind.kGold)

		return
	end

	if not self._goldEngouh then
		CurrencySystem:checkEnoughGold(self, self._costNum)
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self._developSystem:requstNotEnoughItem("HERO_STAR", CurrencyIdKind.kGold)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._mediator:stopHeroEffect()

	local param = {}

	for key, value in pairs(self._starUpViewData) do
		param[key] = value
	end

	local function callback()
		local view = self:getInjector():getInstance("HeroStarUpTipView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, param))
	end

	local nextIsMiniStar = self._heroData:getNextIsMiniStar()

	if self._isLittleStar and not nextIsMiniStar then
		local items = self._heroSystem:getHeroStarUpItem().items
		local params = {
			heroId = self._heroId,
			items = items
		}

		self._heroSystem:requestHeroStarUp(params, callback)
	else
		local params = {
			heroId = self._heroId,
			items = {}
		}

		self._heroSystem:requestHeroStarUp(params, callback)
	end
end

function HeroStrengthStarMediator:onDebrisClicked()
	local debrisItemId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_GeneralFragment", "content")
	local debrisItemNum = self._bagSystem:getItemCount(debrisItemId)

	if debrisItemNum == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("HEROS_UI52")
		}))

		return
	end

	if self._debrisEngouh then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("HEROS_UI53")
		}))

		return
	end

	local debrisChangeTipView = self:getInjector():getInstance("DebrisChangeTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, self._heroId, nil))
end

function HeroStrengthStarMediator:onTranslateClicked()
	local data = self:getIsHaveFragmentFlag()
	local hasFragmentNum = self._bagSystem:getItemCount(data.id)

	if hasFragmentNum <= 0 then
		local heroPrototype = self._heroData:getHeroPrototype()
		local needNum = heroPrototype:getStarCostFragByStar(self._heroData:getNextStarId())
		local hasCount = self._heroSystem:getHeroDebrisCount(self._heroId)
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
		kind = 1,
		heroId = self._heroId
	}, nil))
end

function HeroStrengthStarMediator:getIsHaveFragmentFlag()
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

function HeroStrengthStarMediator:onClickSkill()
	local debrisChangeTipView = self:getInjector():getInstance("HeroStarSkillView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		heroId = self._heroId
	}, nil))
end

function HeroStrengthStarMediator:onClickBox()
	local debrisChangeTipView = self:getInjector():getInstance("HeroStarBoxView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		heroId = self._heroId
	}, nil))
end

function HeroStrengthStarMediator:onClickItem()
	local nextIsMiniStar = self._heroData:getNextIsMiniStar()

	if self._isLittleStar and not nextIsMiniStar then
		local debrisChangeTipView = self:getInjector():getInstance("HeroStarLevelView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			heroId = self._heroId,
			needNum = self._heroData:getStarStive(),
			callback = function()
				self:refreshStarUpCostPanel()
			end
		}, nil))

		return
	end

	local heroPrototype = self._heroData:getHeroPrototype()
	local needNum = heroPrototype:getStarCostFragByStar(self._heroData:getNextStarId())
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

function HeroStrengthStarMediator:runStartAction()
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/StrengthenStar.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 30, false)
	action:setTimeSpeed(1.2)

	local star = self._heroData:getStar()

	for i = 1, HeroStarCountMax do
		local starBg = self._starPanel:getChildByFullName("panel.starBg" .. i)

		if starBg:getChildByName("StarImage") then
			starBg:getChildByName("StarImage"):setVisible(false)
		end
	end

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

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "IconAnim1" then
			self:showStarAnim(star, 1)
		end

		if str == "IconAnim2" then
			self:showStarAnim(star, 2)
		end

		if str == "IconAnim3" then
			self:showStarAnim(star, 3)
		end

		if str == "IconAnim4" then
			self:showStarAnim(star, 4)
		end

		if str == "IconAnim5" then
			self:showStarAnim(star, 5)
		end

		if str == "IconAnim6" then
			self:showStarAnim(star, 6)
		end

		if str == "IconAnim7" then
			self:showStarAnim(star, 7)
		end

		if str == "BgAnim1" then
			bgAnim1:getChildByFullName("BgAnim"):gotoAndPlay(1)
			bgAnim3:getChildByFullName("BgAnim"):gotoAndPlay(1)
		end

		if str == "CostAnim1" then
			GameStyle:runCostAnim(costNode0)
			GameStyle:runCostAnim(costNode1)
		end

		if str == "CostAnim2" then
			GameStyle:runCostAnim(costNode2)
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

function HeroStrengthStarMediator:showStarAnim(star, index)
	if index > HeroStarCountMax then
		return
	end

	local starBg = self._starPanel:getChildByFullName("panel.starBg" .. index)
	local starAnim = starBg:getChildByName("StarImage")

	if starAnim then
		starAnim:setVisible(true)
		starAnim:gotoAndPlay(1)
	end
end

function HeroStrengthStarMediator:createPushBackBoxIcon(parentNode, pos, sceneId)
	local sceneId = KShopPushPackageScene.KHeroStarUp

	IconFactory:createPushBackBoxIcon(self._main, {
		960,
		460
	}, sceneId)
end
