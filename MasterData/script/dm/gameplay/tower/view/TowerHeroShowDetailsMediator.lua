-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerHeroShowDetailsMediator.lua

TowerHeroShowDetailsMediator = class("TowerHeroShowDetailsMediator", DmAreaViewMediator, _M)

TowerHeroShowDetailsMediator:has("_mainPanel", {
	is = "rw"
})
TowerHeroShowDetailsMediator:has("_heroData", {
	is = "rw"
})
TowerHeroShowDetailsMediator:has("_heroId", {
	is = "rw"
})
TowerHeroShowDetailsMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TowerHeroShowDetailsMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {}
local kHeroRarityAnim = {
	[15] = {
		-20
	},
	[14] = {
		-20
	},
	[13] = {
		-10
	},
	[12] = {
		0
	},
	[11] = {
		0
	}
}

function TowerHeroShowDetailsMediator:initialize()
	super.initialize(self)
end

function TowerHeroShowDetailsMediator:dispose()
	super.dispose(self)
end

function TowerHeroShowDetailsMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()

	self:setupTopInfoWidget()
end

function TowerHeroShowDetailsMediator:enterWithData(data)
	self._heroId = data.heroId

	if self._heroId and self._heroSystem:hasHero(self._heroId) then
		self._heroData = self._heroSystem:getHeroById(data.heroId)
	else
		self._heroData = data.hero
		self._heroId = self._heroData:getId()

		local heroData = Hero:new(self._heroId, self._developSystem:getPlayer())

		heroData:rCreateEffect()

		self._heroData = heroData
	end

	self:initView()
	self:showAnimByType()
end

function TowerHeroShowDetailsMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onBackBtn, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function TowerHeroShowDetailsMediator:initView()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._mainPanel:setTouchEnabled(false)
	self._touchPanel:addTouchEventListener(function(sender, eventType)
		return
	end)

	self._roleNode = self._mainPanel:getChildByName("roleNode")

	local realImage = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = self._heroData:getModel()
	})

	realImage:setPosition(cc.p(125, -155))
	self._roleNode:addChild(realImage)

	self._image3 = self._mainPanel:getChildByName("image3")
	self._image5 = self._mainPanel:getChildByName("image5")
	self._image6 = self._mainPanel:getChildByName("image6")
	self._image7 = self._mainPanel:getChildByName("image7")

	local combat, attrData = self._heroData:getCombat()

	self._namePanel = self._mainPanel:getChildByFullName("namePanel")

	local name, _ = self._heroData:getName()
	local qualityLevel = self._heroData:getQualityLevel() == 0 and "" or "+" .. self._heroData:getQualityLevel()
	local nameText = self._namePanel:getChildByFullName("nameText")
	local nameBg = self._namePanel:getChildByFullName("nameBg")

	nameText:setString(name .. qualityLevel)
	GameStyle:setHeroNameByQuality(nameText, self._heroData:getQuality())
	self._namePanel:getChildByFullName("costBg.costnumlabel"):setString(self._heroData:getCost())
	nameBg:setScaleX((nameText:getContentSize().width + 30) / nameBg:getContentSize().width)

	self._combatPanel = self._mainPanel:getChildByFullName("combatPanel")

	local combatLabel = self._combatPanel:getChildByFullName("combatLabel")

	combatLabel:setString(combat)

	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(120, 120, 120, 255)
		}
	}

	combatLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))

	self._attibutePanel = self._mainPanel:getChildByFullName("descPanel")

	self._attibutePanel:getChildByFullName("des_1.text"):setString(self._heroData:getAttack())
	self._attibutePanel:getChildByFullName("des_2.text"):setString(self._heroData:getDefense())
	self._attibutePanel:getChildByFullName("des_3.text"):setString(self._heroData:getHp())
	self._attibutePanel:getChildByFullName("des_4.text"):setString(self._heroData:getSpeed())

	self._ralityPanel = self._mainPanel:getChildByFullName("ralityPanel")

	local rarityIcon = self._ralityPanel:getChildByFullName("rarityIcon")

	rarityIcon:removeAllChildren()

	local rarity = IconFactory:getHeroRarityAnim(self._heroData:getRarity())

	rarity:addTo(rarityIcon):offset(kHeroRarityAnim[self._heroData:getRarity()][1] + 50, 20)

	self._starPanel1 = self._ralityPanel:getChildByFullName("starPanel_1")

	self._starPanel1:removeAllChildren()

	local mc = cc.MovieClip:create("xx_yinghunxinxi")

	mc:addTo(self._starPanel1)
	mc:setName("StarAnim")
	mc:addCallbackAtFrame(15, function()
		mc:stop()
	end)
	mc:setPosition(cc.p(86, 270))

	for i = 1, self._heroData:getMaxStar() do
		if i <= self._heroData:getStar() then
			local animName
			local anim1 = cc.MovieClip:create(self._heroData:getAwakenStar() > 0 and "juexingxingxing_yinghunshengxing" or "yh_aa_yinghunshengxing")

			anim1:addTo(mc:getChildByName("star_" .. i))
			anim1:addEndCallback(function()
				anim1:gotoAndPlay(30)
			end)
			anim1:gotoAndPlay(1)
			anim1:setRotation(10)
			anim1:setScale(0.9)
		elseif i == self._heroData:getStar() + 1 and self._heroData:getLittleStar() then
			local anim1 = cc.MovieClip:create("shengdaobanxing_yinghunshengxing")

			anim1:addTo(mc:getChildByName("star_" .. i))
			anim1:addEndCallback(function()
				anim1:gotoAndPlay(20)
			end)
			anim1:gotoAndPlay(1)
			anim1:setRotation(10)
			anim1:setScale(0.9)
			anim1:offset(-2, -12)
		else
			break
		end
	end

	self._typePanel = self._mainPanel:getChildByFullName("typePanel")

	self._typePanel:getChildByFullName("heroType"):setString(self._heroData:getPosition())

	local occupationName, occupationImg = GameStyle:getHeroOccupation(self._heroData:getType())

	self._typePanel:getChildByFullName("typeImg"):loadTexture(occupationImg)

	self._skillPanel = self._mainPanel:getChildByFullName("skillPanel")

	self._skillPanel:setSwallowTouches(true)
	self._skillPanel:addClickEventListener(function()
		return
	end)
	self:initSkill()
end

function TowerHeroShowDetailsMediator:initSkill()
	local skillIds = self._heroSystem:getShowSkillIds(self._heroId)

	for i = 1, 6 do
		local panel = self._skillPanel:getChildByFullName("skill_" .. i)

		if i >= 5 then
			panel:setVisible(false)
		else
			panel:getChildByName("node"):removeAllChildren()
			panel:getChildByName("node"):setScale(0.7)

			local skillId = skillIds[i]
			local skill

			if self._heroId and self._heroSystem:hasHero(self._heroId) then
				skill = self._heroSystem:getSkillById(self._heroId, skillId)
			else
				skill = HeroSkill:new(skillId)
				skill._level = 1
				skill._enable = true
			end

			local skillName = skill:getName()
			local isLock = not skill:getEnable()
			local newSkillNode = IconFactory:createHeroSkillIcon({
				id = skillId,
				isLock = isLock
			}, {
				hideLevel = true,
				isWidget = true
			})

			panel:getChildByName("node"):addChild(newSkillNode)
			newSkillNode:setPosition(cc.p(45, 45))
			panel:getChildByName("level"):setString("")
			panel:getChildByName("name"):setString(skillName)

			local iconNode = panel:getChildByName("node")

			iconNode:setTouchEnabled(true)
			iconNode:addClickEventListener(function()
				self:onClickSkill(skill)
			end)
		end
	end
end

function TowerHeroShowDetailsMediator:onClickSkill(skill)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if not self._skillWidget then
		self._skillWidget = self:autoManageObject(self:getInjector():injectInto(SkillDescWidget:new(SkillDescWidget:createWidgetNode(), {
			skill = skill,
			mediator = self
		})))

		self._skillWidget:getView():addTo(self:getView()):posite(819, 117)
	end

	self._skillWidget:refreshInfo(skill, self._heroData)
	self._skillWidget:show()
end

function TowerHeroShowDetailsMediator:createEquipRelationPanel(data, parent)
	local equipData = data.equip
	local panel = parent:getChildByFullName("node.bg")

	panel:removeAllChildren()

	local info = {
		clipType = 1,
		star = equipData.star,
		id = equipData.id
	}
	local icon = IconFactory:createEquipPic(info)

	icon = IconFactory:addStencilForIcon(icon, info.clipType, cc.size(100, 100))

	icon:setScale(0.64)
	icon:addTo(panel):center(panel:getContentSize())
end

function TowerHeroShowDetailsMediator:createBasicPanel(data, parent)
	local unlockNum = data.unlockNum

	for i = 1, 7 do
		local panel = parent:getChildByName("icon_" .. i)

		panel:getChildByName("image"):setVisible(i <= unlockNum)
	end
end

function TowerHeroShowDetailsMediator:refreshDescPanel(level, config, parent)
	parent:getChildByName("text"):setString("")
	parent:getChildByName("text"):removeAllChildren()

	local function createShortCondDesc(level, config, developSystem, parent, width, offsetY)
		local maxLevel = config.EffectLevel

		level = maxLevel < level and maxLevel or level

		local color = Relation:getFontColorByLevel(level, 1)

		level = level == 0 and 1 or level
		config.highlightColor = level == 0 and "#AAF014" or "#AAF014"

		local descLabel = ccui.RichText:createWithXML(Relation:getShortEffectDesc(level, config, {
			fontColor = color,
			developSystem = developSystem
		}, 1), {})

		descLabel:addTo(parent, 1):offset(0, offsetY)
		descLabel:renderContent(width, 0)
		descLabel:setAnchorPoint(cc.p(0, 1))

		return descLabel
	end

	local width = 210
	local offsetY = 45

	if config.Type == RelationType.kGlobal then
		width = 430
		offsetY = 35
	elseif config.Type == RelationType.kHero then
		width = 330
		offsetY = 35
	end

	createShortCondDesc(level, config, self._developSystem, parent:getChildByName("text"), width, offsetY)
end

function TowerHeroShowDetailsMediator:showAnimByType()
	self:playAnim1()
end

function TowerHeroShowDetailsMediator:playAnim1()
	self._roleNode:setScale(1)
	self._roleNode:setPosition(cc.p(1573, 300))

	local moveto = cc.MoveTo:create(0.12, cc.p(700, 300))
	local moveto1 = cc.MoveTo:create(0.08, cc.p(750, 300))
	local seq = cc.Sequence:create(moveto, moveto1)

	self._roleNode:runAction(seq)
	self._starPanel1:setVisible(false)
	self._namePanel:getChildByName("costBg"):setVisible(false)
	self._namePanel:getChildByName("nameText"):setVisible(false)
	self._combatPanel:setPosition(cc.p(333, 522))
	self._combatPanel:setOpacity(0)
	self._attibutePanel:setPosition(cc.p(231, 412))
	self._attibutePanel:setOpacity(0)
	self._typePanel:setPosition(cc.p(340, 303))
	self._typePanel:setOpacity(0)
	self._starPanel1:setPosition(cc.p(0, 0))
	self._image3:setPosition(cc.p(840, -532))

	local delaytime = cc.DelayTime:create(0.2)

	moveto = cc.MoveTo:create(0.2, cc.p(387, 240))

	local callfunc = cc.CallFunc:create(function()
		self._namePanel:getChildByName("costBg"):setVisible(true)
		self._namePanel:getChildByName("nameText"):setVisible(true)
		self._combatPanel:fadeIn({
			time = 0.1
		})

		local delaytime1 = cc.DelayTime:create(0.1)
		local fadeIn = cc.FadeIn:create(0.1)

		seq = cc.Sequence:create(delaytime1, fadeIn)

		self._attibutePanel:runAction(seq)

		delaytime1 = cc.DelayTime:create(0.2)
		fadeIn = cc.FadeIn:create(0.1)
		seq = cc.Sequence:create(delaytime1, fadeIn)

		self._typePanel:runAction(seq)
	end)

	seq = cc.Sequence:create(delaytime, moveto, callfunc)

	self._image3:runAction(seq)
	self._namePanel:setPosition(cc.p(-12, 895))

	moveto = cc.MoveTo:create(0.4, cc.p(130, 666))
	seq = cc.Sequence:create(delaytime, moveto)

	self._namePanel:runAction(seq)
	self._image6:setPosition(cc.p(-378, 1068))

	moveto = cc.MoveTo:create(0.2, cc.p(85, 287))
	seq = cc.Sequence:create(delaytime, moveto)

	self._image6:runAction(seq)
	self._image7:setPosition(cc.p(756, -579))

	moveto = cc.MoveTo:create(0.4, cc.p(233, 257))
	seq = cc.Sequence:create(delaytime, moveto)

	self._image7:runAction(seq)

	delaytime = cc.DelayTime:create(0.6)

	self._ralityPanel:getChildByFullName("rarityIcon"):setScale(0)

	local scale1 = cc.ScaleTo:create(0.2, 1.3)
	local scale2 = cc.ScaleTo:create(0.1, 1)

	seq = cc.Sequence:create(delaytime, scale1, scale2)

	self._ralityPanel:getChildByFullName("rarityIcon"):runAction(seq)

	callfunc = cc.CallFunc:create(function()
		self._starPanel1:setVisible(true)
		self._starPanel1:getChildByName("StarAnim"):gotoAndPlay(0)
	end)
	seq = cc.Sequence:create(delaytime, callfunc)

	self._starPanel1:runAction(seq)

	delaytime = cc.DelayTime:create(0.5)

	self._skillPanel:setOpacity(0)
	self._skillPanel:setPosition(cc.p(158, 17))

	local fadeIn = cc.FadeIn:create(0.1)

	seq = cc.Sequence:create(delaytime, fadeIn)

	self._skillPanel:runAction(seq)

	for i = 1, 6 do
		local panel = self._skillPanel:getChildByFullName("skill_" .. i)

		panel:setScale(0)

		local time = 0.5 + (i - 1) * 0.08

		delaytime = cc.DelayTime:create(time)
		scale1 = cc.ScaleTo:create(0.1, 1.1)
		scale2 = cc.ScaleTo:create(0.05, 1)
		seq = cc.Sequence:create(delaytime, scale1, scale2)

		panel:runAction(seq)
	end
end

function TowerHeroShowDetailsMediator:onBackBtn(sender, eventType)
	self._mainPanel:stopAllActions()
	self:dismiss()
end
