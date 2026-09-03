-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroIdentityAwakeMediator.lua

HeroIdentityAwakeMediator = class("HeroIdentityAwakeMediator", DmAreaViewMediator, _M)

HeroIdentityAwakeMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.infoPanel.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onAwakenDetailClicked"
	},
	["main.infoPanel.boxPanel.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBox"
	},
	["main.reviewBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAwakenReplaceBtn"
	},
	["main.costPanel.starbtn"] = {
		ignoreClickAudio = true,
		func = "onUpStarClicked"
	},
	["main.costPanel.btn_translate"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onTranslateClicked"
	}
}
local kHeroRarityAnim = {
	[15] = {
		35
	},
	[14] = {
		35
	},
	[13] = {
		10
	},
	[12] = {
		0
	},
	[11] = {
		0
	}
}
local kAttrType = {
	"ATK",
	"HP",
	"DEF"
}
local AWAKEN_STAR_ICON = "jx_img_star.png"
local IDENTITY_AWAKEN_STAR_ICON = "yinghun_img_awake_star.png"

function HeroIdentityAwakeMediator:initialize()
	super.initialize(self)
end

function HeroIdentityAwakeMediator:dispose()
	super.dispose(self)
end

function HeroIdentityAwakeMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function HeroIdentityAwakeMediator:initNodes()
	self._main = self:getView():getChildByFullName("main")
	self._nodeAnim = self._main:getChildByFullName("animNode")
	self._infoPanel = self._main:getChildByFullName("infoPanel")
	self._infoNode = self._main:getChildByFullName("infoPanel.infoNode")
	self._starNode = self._main:getChildByFullName("infoPanel.starBg")
	self._ssrNode = self._main:getChildByFullName("infoPanel.infoNode.rarityIcon")
	self._nameNode = self._main:getChildByFullName("infoPanel.infoNode.nameLabel")
	self._occNode = self._main:getChildByFullName("infoPanel.infoNode.occupation")
	self._diNode = self._main:getChildByFullName("infoPanel.infoNode.nameBg")
	self._awakeBtn = self._main:getChildByFullName("costPanel.starbtn")
	self._awakeReplaceBtn = self._main:getChildByFullName("reviewBtn")
	self._awakeRoleNode = self._main:getChildByFullName("heropanel")
	self._awakeAreaRoleNode = self._main:getChildByFullName("Panel_59.Role")
	self._attrPanel = self._main:getChildByFullName("Panel_59")
	self._costPanel = self._main:getChildByFullName("costPanel")
	self._combat = self._main:getChildByFullName("infoPanel.combatNode.combat")
	self._combatDi = self._main:getChildByFullName("infoPanel.combatNode.Image_90")
	self._seekBtn = self._main:getChildByFullName("infoPanel.button")
	self._boxBtn = self._main:getChildByFullName("infoPanel.boxPanel.button")
	self._boxBg = self._main:getChildByFullName("infoPanel.boxPanel.BG")
	self._topinfo_node = self:getView():getChildByFullName("topinfo_node")

	self._topinfo_node:setVisible(false)

	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._touchPanel:setVisible(false)
	self._touchPanel:setLocalZOrder(10)
	self._touchPanel:addClickEventListener(function()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._touchPanel:setVisible(false)
	end)
	self._touchPanel:changeParent(self:getView():getParent():getParent())

	for i = 1, 4 do
		self._attrPanel:getChildByFullName("attr_" .. i):addClickEventListener(function()
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:onClickAttrTip()
		end)
	end
end

function HeroIdentityAwakeMediator:setupView(parent, data)
	self._heroAwakeFinished = false

	self:initNodes()
	self:resetView()
end

function HeroIdentityAwakeMediator:resetView()
	return
end

function HeroIdentityAwakeMediator:runStartAction()
	return
end

function HeroIdentityAwakeMediator:refreshData(heroId)
	self._heroId = heroId
	self._heroSystem = self._developSystem:getHeroSystem()
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._heroAwakeFinished = self._heroData:heroAwaked()
	self._starUpViewData = {
		star = 0,
		rarityData = 0,
		heroId = self._heroId,
		attr = {},
		skillData = {}
	}
end

function HeroIdentityAwakeMediator:refreshAllView(hideAnim)
	self._touchPanel:setVisible(false)
	self:refreshInfoNode()
	self:refreshAwakeRole()
	self:refreshStarUpCostPanel()
end

function HeroIdentityAwakeMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function HeroIdentityAwakeMediator:refreshInfoNode()
	local nameBg = self._infoNode:getChildByFullName("nameBg.nameBg")
	local name = self._infoNode:getChildByFullName("nameLabel.nameLabel")
	local nameString = self._heroData:getName()
	local qualityLevel = self._heroData:getQualityLevel() == 0 and "" or "+" .. self._heroData:getQualityLevel()

	name:setString(nameString .. qualityLevel)
	GameStyle:setHeroNameByQuality(name, self._heroData:getQuality(), 1)
	nameBg:setScaleX((name:getContentSize().width + 90) / nameBg:getContentSize().width)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(self._heroData:getType())
	local occupation = self._infoNode:getChildByFullName("occupation.occupation")

	occupation:loadTexture(occupationImg)

	local rarityIcon = self._infoNode:getChildByFullName("rarityIcon.rarityIcon")

	rarityIcon:removeAllChildren()

	local rarity = IconFactory:getHeroRarityAnim(self._heroData:getRarity())

	rarity:addTo(rarityIcon):offset(kHeroRarityAnim[self._heroData:getRarity()][1], 30)

	local partyType = self._infoNode:getChildByFullName("partyType.partyType")
	local partyData = GameStyle:getHeroPartyBgData(self._heroData:getParty())

	if partyData then
		partyType:setVisible(true)
		partyType:loadTexture(partyData[3])
	else
		partyType:setVisible(false)
	end

	for i = 1, HeroStarCountMax do
		local node = self._starNode:getChildByFullName("star_" .. i)

		if not node:getChildByName("star") and i <= self._heroData:getStar() then
			if i <= self._heroData:getIdentityAwakenLevel() then
				if not IDENTITY_AWAKEN_STAR_ICON then
					local name = AWAKEN_STAR_ICON
					local star = ccui.ImageView:create(name, 1)

					star:ignoreContentAdaptWithSize(true)
					star:setName("star")
					star:addTo(node)
					star:setScale(0.4)
				end
			end
		end
	end

	local combatNode = self._infoPanel:getChildByFullName("combatNode.combat")
	local label = combatNode:getChildByFullName("CombatLabel")

	if not label then
		local fntFile = "asset/font/heroLevel_font.fnt"

		label = ccui.TextBMFont:create("", fntFile)

		label:addTo(combatNode)
		label:setName("CombatLabel")
	end

	local combat = self._heroData:getSceneCombatByType(SceneCombatsType.kAll)

	label:setString(combat)

	local hasStarBoxReward = self._heroData:getHasStarBoxReward()

	self._infoPanel:getChildByFullName("boxPanel.button.red"):setVisible(hasStarBoxReward)
	self._infoPanel:getChildByFullName("boxPanel"):setVisible(not self._heroData:getStarBoxGetOver())
	self._awakeReplaceBtn:setVisible(self._heroAwakeFinished)
	GameStyle:runCostAnim(self._costPanel:getChildByFullName("costNode1.costBg"))
	GameStyle:runCostAnim(self._costPanel:getChildByFullName("costNode2.costBg"))
	GameStyle:runCostAnim(self._costPanel:getChildByFullName("costNode3.costBg"))
end

function HeroIdentityAwakeMediator:refreshAwakeRole()
	if self._heroAwakeFinished then
		local var_14_0 = self._heroData:getAwakenStarConfig().ModelId

		if not var_14_0 then
			var_14_0 = self._heroData:getAwakenStarConfig().Portrait

			local roleModel = var_14_0
			local masterIcon = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe9",
				id = roleModel,
				useAnim = self._heroAwakeFinished
			})

			self._awakeRoleNode:removeAllChildren()

			local nextStarId = self._heroData:getNextIdentityStarId()
			local posX = nextStarId == "" and -100 or 100

			masterIcon:addTo(self._awakeRoleNode):setPosition(posX, -150)
		end
	end
end

function HeroIdentityAwakeMediator:refreshStarUpCostPanel()
	self._starUpViewData.star = self._heroData:getStar()
	self._starUpViewData.rarityData = self._heroData:getRarity()
	self._starUpViewData.attr = {
		ATK = {
			0,
			0
		},
		HP = {
			0,
			0
		},
		DEF = {
			0,
			0
		}
	}
	self._starUpViewData.attr.ATK[1] = self._heroData:getAttack()
	self._starUpViewData.attr.HP[1] = self._heroData:getHp()
	self._starUpViewData.attr.DEF[1] = self._heroData:getDefense()

	for i = 1, #kAttrType do
		local node = self._attrPanel:getChildByFullName("attr_" .. i)
		local image = node:getChildByFullName("Image_59")

		image:loadTexture(AttrTypeImage[kAttrType[i]], 1)
	end

	local nextStarId = self._heroData:getNextIdentityStarId()

	if nextStarId == "" then
		self._costPanel:setVisible(false)
		self._attrPanel:setVisible(false)

		return
	end

	self._costPanel:setVisible(true)
	self._attrPanel:setVisible(true)

	local a, b, c, d, e = self._heroData:getNextStarEffect({
		starId = nextStarId
	})

	self._attrPanel:getChildByFullName("attr_1.Text_85"):setString(getAttrNameByType(kAttrType[1]) .. "+" .. a - self._heroData:getAttack())
	self._attrPanel:getChildByFullName("attr_2.Text_85"):setString(getAttrNameByType(kAttrType[2]) .. "+" .. c - self._heroData:getHp())
	self._attrPanel:getChildByFullName("attr_3.Text_85"):setString(getAttrNameByType(kAttrType[3]) .. "+" .. b - self._heroData:getDefense())

	self._starUpViewData.attr.ATK[2] = a - self._heroData:getAttack()
	self._starUpViewData.attr.HP[2] = c - self._heroData:getHp()
	self._starUpViewData.attr.DEF[2] = b - self._heroData:getDefense()

	local SpecialEffect = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", nextStarId, "SpecialEffect") or {}
	local Effect = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", nextStarId, "Effect") or {}

	if #SpecialEffect > 0 then
		for i = 1, #SpecialEffect do
			local effectId = SpecialEffect[i]
			local config = ConfigReader:getRecordById("SkillSpecialEffect", effectId)

			if config.EffectType == SpecialEffectType.kChangeSkill then
				local style = {
					fontSize = 18,
					fontName = TTF_FONT_FZYH_M
				}
				local skillId = config.Parameter.after
				local skillName = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Name")
				local isEXSkill = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "IsEXSkill") == 1
				local desc = Strings:get(config.Desc, style)
				local icon = self._attrPanel:getChildByFullName("attr_4.Image_59")

				icon:removeAllChildren()

				local image = IconFactory:createHeroSkillIcon({
					levelHide = true,
					id = skillId
				})

				image:addTo(icon):center(icon:getContentSize())
				image:setScale(0.6)

				if isEXSkill then
					local str = cc.Label:createWithTTF(Strings:get("Hero_Star_UI_Ex"), TTF_FONT_FZYH_R, 16)

					str:addTo(icon):center(icon:getContentSize()):offset(-2, -16)
					str:enableOutline(cc.c4b(0, 0, 0, 255), 2)
				end

				self._starUpViewData.skillData = {
					attrType = "skill",
					desc = desc,
					skillId = skillId,
					isEXSkill = isEXSkill,
					name = Strings:get("Hero_IA_UI_1")
				}

				break
			end
		end
	elseif #Effect > 0 then
		for i = 1, #Effect do
			local effectId = Effect[i]
			local style = {
				fontSize = 18,
				fontName = TTF_FONT_FZYH_M
			}
			local desc = SkillPrototype:getAttrEffectDesc(effectId, 1, style)

			self._starUpViewData.skillData = {
				path = "icon_yinghun_attr_up.png",
				attrType = "attr",
				desc = desc,
				name = Strings:get("HEROS_UI42")
			}

			break
		end

		local icon = self._attrPanel:getChildByFullName("attr_4.Image_59")

		icon:removeAllChildren()

		local image = ccui.ImageView:create(self._starUpViewData.skillData.path, 1)

		image:addTo(icon):center(icon:getContentSize())
		image:setScale(0.6)
	end

	self._attrPanel:getChildByFullName("attr_4.Text_85"):setString(self._starUpViewData.skillData.name)

	local heroPrototype = self._heroData:getHeroPrototype()
	local loveNeed = self._heroData:getIdentityAwakenNeedLove()
	local hasloveLevel = self._heroData:getLoveLevel()
	local lovePanel = self._costPanel:getChildByFullName("costNode2.costBg")
	local loveiconpanel = lovePanel:getChildByFullName("iconpanel")

	loveiconpanel:removeAllChildren()

	local loveIcon = ccui.ImageView:create("album_bg_archives_amount_hgd.png", 1)

	loveIcon:addTo(loveiconpanel):center(loveiconpanel:getContentSize())

	local loveEngouh = loveNeed <= hasloveLevel

	self._loveEngouh = loveEngouh

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
	enoughImg:setVisible(loveEngouh)
	addImg:setVisible(not loveEngouh)
	loveiconpanel:setGray(not loveEngouh)

	local colorNum = loveEngouh and 1 or 7

	costNumLabel:setTextColor(GameStyle:getColor(colorNum))
	addImg:getChildByFullName("touchPanel"):addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:onClickLoveItem()
		end
	end)

	local iconpanel = self._costPanel:getChildByFullName("costNode1.costBg.iconpanel")

	iconpanel:removeAllChildren()

	local hasDebrisNum = self._heroSystem:getHeroDebrisCount(self._heroId)
	local needDebrisNum = heroPrototype:getStarCostFragByStar(self._heroData:getNextIdentityStarId())
	local debrisEngouh = needDebrisNum <= hasDebrisNum

	self._debrisEngouh = debrisEngouh

	local icon = IconFactory:createIcon({
		id = self._heroData:getFragId()
	}, {
		showAmount = false
	})

	icon:setScale(0.46)
	icon:addTo(iconpanel):center(iconpanel:getContentSize())

	local colorNum1 = debrisEngouh and 1 or 7

	enoughImg = self._costPanel:getChildByFullName("costNode1.costBg.bg.enoughImg")

	enoughImg:setVisible(debrisEngouh)

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

	addImg:setVisible(not debrisEngouh)
	iconpanel:setGray(not debrisEngouh)
	addImg:getChildByFullName("touchPanel"):addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:onClickItem()
		end
	end)

	local iconpanel = self._costPanel:getChildByFullName("costNode3.costBg.iconpanel")

	iconpanel:removeAllChildren()

	local needItem = self._heroData:getIdentityAwakenNeedItem()
	local needItemNum, itemId

	for k, v in pairs(needItem) do
		itemId = k
		needItemNum = v

		break
	end

	local bagSystem = self._developSystem:getBagSystem()
	local itemNum = bagSystem:getItemCount(itemId)
	local itemEnough = needItemNum <= itemNum

	self._itemEnough = itemEnough

	local icon = IconFactory:createIcon({
		id = itemId
	}, {
		showAmount = false
	})

	icon:setScale(0.46)
	icon:addTo(iconpanel):center(iconpanel:getContentSize())

	local colorNum1 = itemEnough and 1 or 7

	enoughImg = self._costPanel:getChildByFullName("costNode3.costBg.bg.enoughImg")

	enoughImg:setVisible(itemEnough)

	local costPanel = self._costPanel:getChildByFullName("costNode3.costBg.costPanel")

	costPanel:setVisible(true)

	local cost = costPanel:getChildByFullName("cost")
	local costLimit = costPanel:getChildByFullName("costLimit")

	cost:setString(itemNum)
	costLimit:setString("/" .. needItemNum)
	costLimit:setPositionX(cost:getContentSize().width)
	costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width, 40))
	cost:setTextColor(GameStyle:getColor(colorNum1))
	costLimit:setTextColor(GameStyle:getColor(colorNum1))

	addImg = self._costPanel:getChildByFullName("costNode3.costBg.addImg")

	addImg:setVisible(not itemEnough)
	iconpanel:setGray(not itemEnough)
	addImg:getChildByFullName("touchPanel"):addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			local data = {
				id = itemId,
				hasCount = itemNum,
				needNum = needItemNum
			}

			self:onClickItem(data)
		end
	end)

	local heroId = self._heroData:getAwakenStarConfig().ShowHero
	local model = IconFactory:getRoleModelByKey("HeroBase", heroId)

	model = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Model")

	local role = RoleFactory:createRoleAnimation(model, "stand1")

	self._awakeAreaRoleNode:removeAllChildren()
	role:addTo(self._awakeAreaRoleNode):setScale(0.7):posite(80, 0)
end

function HeroIdentityAwakeMediator:onClickAwakenReplaceBtn()
	local view = self:getInjector():getInstance("HeroStrengthAwakenSuccessView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		close = true,
		heroId = self._heroId,
		oldStarId = self._heroData:getStarId()
	}))
end

function HeroIdentityAwakeMediator:onClickBox()
	local debrisChangeTipView = self:getInjector():getInstance("HeroStarBoxView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		heroId = self._heroId
	}, nil))
end

function HeroIdentityAwakeMediator:onUpStarClicked()
	local nextStarId = self._heroData:getNextIdentityStarId()

	if nextStarId == "" then
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

		return
	end

	if not self._loveEngouh then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("HERO_AWAKE_LOVE_NOT_ENOUGH")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._itemEnough then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Hero_IA_UI_5")
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
		local view = self:getInjector():getInstance("HeroIdentityAwakeSuccessView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, {
			maskOpacity = 0
		}, param))
	end

	local items = {}

	self._heroSystem:requestHeroIdentityAwake(self._heroId, items, callback)
end

function HeroIdentityAwakeMediator:onTranslateClicked()
	local data = self:getIsHaveFragmentFlag()
	local bagSystem = self._developSystem:getBagSystem()
	local hasFragmentNum = bagSystem:getItemCount(data.id)

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
		fromIdentityAwake = true,
		heroId = self._heroId
	}, nil))
end

function HeroIdentityAwakeMediator:getIsHaveFragmentFlag()
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

function HeroIdentityAwakeMediator:onAwakenDetailClicked()
	local debrisChangeTipView = self:getInjector():getInstance("HeroStarSkillView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		heroId = self._heroId
	}, nil))
end

function HeroIdentityAwakeMediator:onClickItem(data)
	data = data or {}

	local heroPrototype = self._heroData:getHeroPrototype()
	local needNum = heroPrototype:getStarCostFragByStar(self._heroData:getNextStarId(true))
	local hasCount = self._heroSystem:getHeroDebrisCount(self._heroId)
	local var_26_0 = {
		isNeed = true,
		hasWipeTip = true
	}

	var_26_0.itemId = data.id or self._heroData:getFragId()
	var_26_0.hasNum = data.hasCount or hasCount
	var_26_0.needNum = data.needNum or needNum

	local param = var_26_0
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param))
end

function HeroIdentityAwakeMediator:onClickLoveItem()
	self._heroSystem:tryEnterDate(self._heroId, GalleryFuncName.kGift)
end

function HeroIdentityAwakeMediator:onClickAttrTip()
	self._touchPanel:setVisible(true)

	local animNode1 = self._touchPanel:getChildByFullName("nodeAttr.animNode")

	if not animNode1:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(animNode1)
		anim:setName("BgAnim")
		anim:offset(0, -5)
	end

	animNode1:getChildByFullName("BgAnim"):gotoAndPlay(1)

	local animNode2 = self._touchPanel:getChildByFullName("nodeSkill.animNode")

	if not animNode2:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(animNode2)
		anim:setName("BgAnim")
		anim:offset(0, -5)
	end

	animNode2:getChildByFullName("BgAnim"):gotoAndPlay(1)

	local icon = self._touchPanel:getChildByFullName("node")

	icon:removeAllChildren()

	local petNode = IconFactory:createHeroIcon({
		id = self._heroId
	}, {
		hideAll = true
	})

	petNode:setScale(0.6)
	petNode:addTo(icon):center(icon:getContentSize()):offset(10, 0)

	local name, color = self._heroData:getName()

	self._touchPanel:getChildByFullName("name"):setString(name .. (self._heroData:getQualityLevel() == 0 and "" or "+" .. self._heroData:getQualityLevel()))
	GameStyle:setHeroNameByQuality(self._touchPanel:getChildByFullName("name"), self._heroData:getQuality())
	self._touchPanel:getChildByFullName("level"):setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. self._heroData:getLevel())

	local nodeAttr = self._touchPanel:getChildByFullName("nodeAttr")

	for i = 1, #kAttrType do
		local node = nodeAttr:getChildByFullName("des_" .. i)
		local image = node:getChildByFullName("image")
		local name = node:getChildByFullName("name")

		name:setString(getAttrNameByType(kAttrType[i]))
		image:loadTexture(AttrTypeImage[kAttrType[i]], 1)

		local text = node:getChildByFullName("text")

		text:setString(self._starUpViewData.attr[kAttrType[i]][1])

		local extandText = node:getChildByFullName("extandText")

		extandText:setString("+" .. self._starUpViewData.attr[kAttrType[i]][2])
	end

	local listView = self._touchPanel:getChildByFullName("nodeSkill.listView")

	listView:setScrollBarEnabled(false)
	listView:removeAllChildren()

	local width = listView:getContentSize().width
	local label = ccui.RichText:createWithXML(self._starUpViewData.skillData.desc, {})

	label:renderContent(width, 0)
	listView:removeAllChildren()
	label:setAnchorPoint(cc.p(0, 0))
	label:setPosition(cc.p(0, 0))

	local height = label:getContentSize().height
	local newPanel = ccui.Layout:create()

	newPanel:setContentSize(cc.size(width, height))
	label:addTo(newPanel)
	listView:pushBackCustomItem(newPanel)
	self._touchPanel:getChildByFullName("nodeSkill.text"):setString(self._starUpViewData.skillData.name)
end

function HeroIdentityAwakeMediator:onClickBack(sender, eventType)
	self:dismiss()
end
