-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/heroshow/HeroShowDetailsMediator.lua

HeroShowDetailsMediator = class("HeroShowDetailsMediator", DmAreaViewMediator, _M)

HeroShowDetailsMediator:has("_mainPanel", {
	is = "rw"
})
HeroShowDetailsMediator:has("_heroData", {
	is = "rw"
})
HeroShowDetailsMediator:has("_heroPrototype", {
	is = "rw"
})
HeroShowDetailsMediator:has("_heroId", {
	is = "rw"
})
HeroShowDetailsMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HeroShowDetailsMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {}
local kBgAnimAndImage = {
	[GalleryPartyType.kBSNCT] = "asset/ui/gallery/party_icon_businiao.png",
	[GalleryPartyType.kXD] = "asset/ui/gallery/party_icon_xide.png",
	[GalleryPartyType.kMNJH] = "asset/ui/gallery/party_icon_monv.png",
	[GalleryPartyType.kDWH] = "asset/ui/gallery/party_icon_dongwenhui.png",
	[GalleryPartyType.kWNSXJ] = "asset/ui/gallery/party_icon_weinasi.png",
	[GalleryPartyType.kSSZS] = "asset/ui/gallery/party_icon_she.png"
}
local kHeroRarityAnim = {
	[15] = {
		0
	},
	[14] = {
		10
	},
	[13] = {
		0
	},
	[12] = {
		0
	},
	[11] = {
		0
	}
}

function HeroShowDetailsMediator:initialize()
	super.initialize(self)
end

function HeroShowDetailsMediator:dispose()
	super.dispose(self)
end

function HeroShowDetailsMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()

	self:setupTopInfoWidget()
end

function HeroShowDetailsMediator:enterWithData(data)
	self._heroId = data.heroId
	self._heroInfoData = self._heroSystem:getHeroInfoById(self._heroId)
	self._heroData = self._heroSystem:getHeroById(data.heroId)
	self._heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(data.heroId)
	self._config = PrototypeFactory:getInstance():getHeroPrototype(self._heroId):getConfig()

	if self._heroData == nil then
		local heroData = Hero:new(self._heroId, self._developSystem:getPlayer())

		heroData:rCreateEffect()

		self._heroData = heroData
	end

	self:setUpView()
	self:initAnim()
end

function HeroShowDetailsMediator:setupTopInfoWidget()
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

function HeroShowDetailsMediator:setUpView()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._rightPanel = self._mainPanel:getChildByFullName("rightPanel")
	self._namePanel = self._mainPanel:getChildByFullName("namePanel")
	self._skillPanel = self._rightPanel:getChildByFullName("skillPanel")
	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._touchPanel:setVisible(false)

	self._roleNode = self._mainPanel:getChildByName("roleNode")
	self._listView = self._rightPanel:getChildByFullName("listView")
	self._bg = self._mainPanel:getChildByFullName("bg")

	self._bg:loadTexture("asset/scene/scene_main_heropreview.jpg", ccui.TextureResType.localType)

	local partyImgNode = self._mainPanel:getChildByName("partyImgNode")

	if kBgAnimAndImage[self._config.Party] then
		partyImgNode:setVisible(true)
		partyImgNode:removeAllChildren()

		local partyImg = ccui.ImageView:create(kBgAnimAndImage[self._config.Party])

		partyImg:setOpacity(153)
		partyImg:addTo(partyImgNode)
	else
		partyImgNode:setVisible(false)
	end

	local realImage = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = self._heroInfoData.roleModel
	})

	realImage:setPosition(cc.p(100, -155))
	self._roleNode:addChild(realImage)

	local realImage = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = self._heroInfoData.roleModel
	})

	realImage:setPosition(cc.p(100, -155))

	local oldRole = self._mainPanel:getChildByName("roleNode_0")

	oldRole:addChild(realImage)

	local retAttr = self:initAttrData()
	local combatText = self._rightPanel:getChildByFullName("combatNode.combat")
	local label = combatText:getChildByFullName("CombatLabel")

	if not label then
		local fntFile = "asset/font/heroLevel_font.fnt"

		label = ccui.TextBMFont:create("", fntFile)

		label:addTo(combatText)
		label:setName("CombatLabel")
	end

	label:setString(tostring(retAttr.combat))

	local atkText = self._rightPanel:getChildByFullName("attr_atk.text")

	atkText:setString(tostring(retAttr.ATK))

	local hpText = self._rightPanel:getChildByFullName("attr_hp.text")

	hpText:setString(tostring(retAttr.HP))

	local defText = self._rightPanel:getChildByFullName("attr_def.text")

	defText:setString(tostring(retAttr.DEF))

	local speedText = self._rightPanel:getChildByFullName("attr_speed.text")

	speedText:setString(tostring(retAttr.speed))
	self._rightPanel:getChildByFullName("heroType"):setString(Strings:get(self._config.Position))

	local occupationName, occupationImg = GameStyle:getHeroOccupation(self._heroInfoData.type)

	self._rightPanel:getChildByFullName("typeImg"):loadTexture(occupationImg)

	self._skillAnim = self._skillPanel:getChildByFullName("skillAnim")

	self._skillAnim:setVisible(false)
	self._skillAnim:setScale(0.86)

	local skillIds = self:getSkillIds()
	local num = math.min(4, #skillIds)
	local skills = {}

	for i = 1, num do
		local skillId = skillIds[i].id
		local skill = {}

		skill = HeroSkill:new(skillId)

		skill:setLevel(1)
		skill:setEnable(true)
		skill:setLock(false)
		table.insert(skills, skill)
	end

	for index = 1, num do
		local panel = self._skillPanel:getChildByFullName("Node_" .. index)

		if panel:getChildByName("Name_skillIcon") then
			panel:removeChildByName("Name_skillIcon")
		end

		local skill = skills[index]
		local skillId = skill:getSkillId()
		local isLock = not skill:getEnable()
		local skillType = skill:getType()
		local touchPanel = panel:getChildByName("Panel")

		touchPanel:setTouchEnabled(true)
		touchPanel:addClickEventListener(function()
			self:onClickSkill(skill, skillIds[index].star, skillIds.skillRate)
		end)

		local skillIcon = IconFactory:createHeroSkillIcon({
			levelHide = true,
			id = skillId
		})

		skillIcon:addTo(panel):center(panel:getContentSize())
		skillIcon:setScale(0.9)
		skillIcon:setName("Name_skillIcon")

		for i = 1, 2 do
			if i == 1 then
				if not ("skill_" .. index) then
					local n = "skill_" .. index .. "_0"
					local skillNode = self._skillPanel:getChildByFullName(n)

					skillNode:setVisible(false)

					local icon = IconFactory:createHeroSkillIcon({
						levelHide = true,
						id = skillId
					})

					icon:setScale(0.9)
					icon:addTo(skillNode):center(skillNode:getContentSize())
				end
			end
		end

		local skillAnimPanel = self._skillAnim:clone()

		skillAnimPanel:addTo(skillIcon)
		skillAnimPanel:setVisible(true)
		skillAnimPanel:removeChildByName("SkillAnim")

		local skillPanel1 = skillAnimPanel:getChildByFullName("skillTypeIcon")

		skillPanel1:setVisible(true)

		local skillPanel2 = skillAnimPanel:getChildByFullName("skillTypeBg")

		skillPanel2:setVisible(true)

		local icon1, icon2 = self._heroSystem:getSkillTypeIcon(skillType)
		local skillTypeIcon = skillPanel1:getChildByFullName("icon")

		skillTypeIcon:loadTexture(icon1)

		local skillTypeBg = skillPanel2:getChildByFullName("bg")

		skillTypeBg:loadTexture(icon2)
		skillTypeBg:setCapInsets(cc.rect(4, 15, 6, 16))

		local typeNameLabel = skillPanel2:getChildByFullName("skillType")

		typeNameLabel:setString(self._heroSystem:getSkillTypeName(skillType))
		typeNameLabel:setTextColor(GameStyle:getSkillTypeColor(skillType))

		local width = typeNameLabel:getContentSize().width + 30

		skillTypeBg:setContentSize(cc.size(width, 38))

		width = width + 25

		skillAnimPanel:setContentSize(cc.size(width, 46))
		skillAnimPanel:setPosition(cc.p(50, 8))

		if panel:getChildByName("Name_lockImg") then
			panel:removeChildByName("Name_lockImg")
		end

		if isLock then
			local lockImg = ccui.ImageView:create("asset/common/common_icon_lock_new.png")

			lockImg:addTo(panel):posite(22, 20)
			lockImg:setName("Name_lockImg")
		end

		if self:checkIsKeySkill(skillId) then
			local icon1, icon2 = self._heroSystem:getSkillTypeIcon(skillType)
			local image = ccui.ImageView:create(icon1)

			image:addTo(skillIcon):posite(90, 82)
		end
	end

	local name = self._namePanel:getChildByName("nameText")

	name:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	name:setString(Strings:get(self._heroInfoData.name))

	local namebg = self._mainPanel:getChildByFullName("nameBg")
	local cost = self._namePanel:getChildByFullName("costBg.costnumlabel")

	cost:setString(tostring(self._heroInfoData.cost))

	local length = utf8.len(Strings:get(self._heroInfoData.name))

	length = math.min(333, length * 50 + 80)

	namebg:setContentSize(length, namebg:getContentSize().height)

	local costBg = self._namePanel:getChildByFullName("costBg")

	costBg:setPosition(namebg:getPositionX() + namebg:getContentSize().width - 50, namebg:getPositionY() - 10)

	local namebg_0 = self._mainPanel:getChildByFullName("nameBg_0")

	namebg_0:setContentSize(length, namebg:getContentSize().height)

	local rarityIcon = self._namePanel:getChildByFullName("rarityIcon")

	rarityIcon:removeAllChildren()

	local r = self._config.Rareity
	local rarity = IconFactory:getHeroRarityAnim(r)

	rarity:addTo(rarityIcon):offset(kHeroRarityAnim[r][1], 24)
	self._listView:removeAllChildren()
	self._listView:setScrollBarEnabled(false)

	local f = string.format("<font face='%s' size='%d' color='#000000'>%s</font>", TTF_FONT_FZYH_M, 20, Strings:get("HeroPreview_UI06", {
		desc = Strings:get(self._config.Desc)
	}))
	local newPanel = self:createDescPanel(f)

	self._listView:pushBackCustomItem(newPanel)

	local text_party = self._rightPanel:getChildByFullName("heroType_0")
	local titleArray = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroPartyName", "content")

	text_party:setString(Strings:get("HeroPreview_UI05", {
		name = Strings:get(titleArray[self._config.Party])
	}))
end

function HeroShowDetailsMediator:getSkillIds()
	local rsks = {}
	local skills = {}
	local type = ConfigReader:getDataByNameIdAndKey("Skill", self._config.NormalSkill, "Type")

	skills[type] = {
		star = 0,
		id = self._config.NormalSkill
	}

	local starId = self._config.StarId

	while true do
		local heroStarBase = ConfigReader:getRecordById("HeroStarEffect", starId)

		if heroStarBase then
			for i, v in ipairs(heroStarBase.SpecialEffect) do
				local factorParameter = ConfigReader:getDataByNameIdAndKey("SkillSpecialEffect", v, "Parameter")

				if factorParameter.after and factorParameter.after ~= "" then
					local type = ConfigReader:getDataByNameIdAndKey("Skill", factorParameter.after, "Type")

					skills[type] = {
						id = factorParameter.after,
						star = heroStarBase.Star
					}
				end
			end

			starId = heroStarBase.NextId

			if heroStarBase.NextId == nil or heroStarBase.NextId == "" then
				if heroStarBase.Effect then
					skills.starEffectId = heroStarBase.Effect[1] or ""
				end

				break
			end
		else
			break
		end
	end

	local skillShowType = ConfigReader:getRecordById("ConfigValue", "Hero_Skill_Show").content

	for i = 1, #skillShowType do
		local skillType = skillShowType[i]

		if skills[skillType] then
			table.insert(rsks, skills[skillType])
		end
	end

	local rate = self._config.SkillRate

	if skills.starEffectId ~= "" then
		local value = ConfigReader:getDataByNameIdAndKey("SkillAttrEffect", skills.starEffectId, "Value")

		rate = rate + value[1]
	end

	rsks.skillRate = rate * 100 .. "%"

	return rsks
end

function HeroShowDetailsMediator:initAnim()
	local Image_133 = self._rightPanel:getChildByFullName("Image_133")

	Image_133:setOpacity(0)
	performWithDelay(self:getView(), function()
		local fadeIn = cc.FadeIn:create(0.2)

		Image_133:runAction(fadeIn)
	end, 0.3)

	local scale = cc.ScaleTo:create(0.2, 0.64)
	local fadeIn = cc.FadeIn:create(0.2)
	local animNode = self._mainPanel:getChildByFullName("animNode")
	local anim = cc.MovieClip:create("juesexiangqing_choukajuesexiangqing")

	anim:addTo(animNode)

	local mc_mingzi = anim:getChildByFullName("mc_mingzi2")
	local mc_di = mc_mingzi:getChildByFullName("mc_di")
	local mc_icon = mc_mingzi:getChildByFullName("mc_di")
	local namebg_0 = self._mainPanel:getChildByFullName("nameBg_0")

	namebg_0:changeParent(mc_di):posite(-150, 0)
	self._namePanel:changeParent(mc_icon):center(mc_icon:getContentSize()):offset(-88, -56)

	local mc_mingzi = anim:getChildByFullName("mc_mingzi1")
	local mc_di = mc_mingzi:getChildByFullName("mc_di")
	local mc_icon = mc_mingzi:getChildByFullName("mc_di")
	local nameBg = self._mainPanel:getChildByFullName("nameBg")

	nameBg:changeParent(mc_di):posite(-150, 0)

	local namep = self._namePanel:clone()

	namep:addTo(mc_icon):center(mc_icon:getContentSize()):offset(-88, -56)

	local nodeToActionMap = {}
	local mc_bg = anim:getChildByFullName("mc_bg")
	local mc_jianjie = anim:getChildByFullName("mc_jianjie")
	local mc_dong = anim:getChildByFullName("mc_dong")
	local mc_title0 = anim:getChildByFullName("mc_title0")
	local mc_combat = anim:getChildByFullName("mc_combat")
	local mc_dingwei = anim:getChildByFullName("mc_dingwei")

	mc_dingwei:offset(20, 0)
	mc_title0:offset(-10, 0)

	local title0 = self._rightPanel:getChildByFullName("text_title")
	local jianjie = self._rightPanel:getChildByFullName("heroType_0")
	local dong = self._mainPanel:getChildByName("partyImgNode")
	local combatText = self._rightPanel:getChildByFullName("combatNode")
	local dingwei1 = self._rightPanel:getChildByFullName("heroType")
	local dingwei2 = self._rightPanel:getChildByFullName("typeImg")

	nodeToActionMap[self._bg] = mc_bg
	nodeToActionMap[jianjie] = mc_jianjie
	nodeToActionMap[self._listView] = mc_jianjie
	nodeToActionMap[dong] = mc_dong
	nodeToActionMap[title0] = mc_title0
	nodeToActionMap[combatText] = mc_combat
	nodeToActionMap[dingwei1] = mc_dingwei
	nodeToActionMap[dingwei2] = mc_dingwei

	for i = 1, 3 do
		local mc_title = anim:getChildByFullName("mc_title" .. i)
		local mc_xian = anim:getChildByFullName("mc_xian" .. i)
		local xian = self._rightPanel:getChildByFullName("Image_xian" .. i)
		local title = self._rightPanel:getChildByFullName("Image_108_" .. i)

		if i < 3 then
			mc_title:offset(10, 0)
		end

		nodeToActionMap[xian] = mc_xian
		nodeToActionMap[title] = mc_title
	end

	local mc_attr1 = anim:getChildByFullName("m_attr1")
	local atk = self._rightPanel:getChildByFullName("attr_atk")

	nodeToActionMap[atk] = mc_attr1

	local mc_attr2 = anim:getChildByFullName("m_attr1")
	local atk = self._rightPanel:getChildByFullName("attr_hp")

	nodeToActionMap[atk] = mc_attr2

	local mc_attr3 = anim:getChildByFullName("m_attr1")
	local atk = self._rightPanel:getChildByFullName("attr_def")

	nodeToActionMap[atk] = mc_attr3

	local mc_attr4 = anim:getChildByFullName("m_attr1")
	local atk = self._rightPanel:getChildByFullName("attr_speed")

	nodeToActionMap[atk] = mc_attr4
	nodeToActionMap[self._roleNode] = anim:getChildByFullName("mc_role" .. 1)

	local mc_role = anim:getChildByFullName("mc_role" .. 2)
	local roleNode = self._mainPanel:getChildByName("roleNode_0")

	roleNode:offset(-200, 0)

	nodeToActionMap[roleNode] = mc_role

	for i = 1, 4 do
		local skillNode = self._skillPanel:getChildByFullName("Node_" .. i)

		skillNode:setVisible(false)
	end

	local animName = {
		"jinengtubiao01",
		"jinengtubiao02",
		"jinengtubiao03",
		"jinengtubiao04"
	}

	local function addSkillAnim(index)
		local skillAnim = cc.MovieClip:create(animName[index] .. "_choukajuesexiangqing")
		local skillNode = self._skillPanel:getChildByFullName("Node_" .. index)

		skillNode:setVisible(true)
		skillAnim:addTo(skillNode):center(skillNode:getContentSize()):offset(20, 0)

		local mcIcon = skillAnim:getChildByFullName("icon2")
		local skillicon = skillNode:getChildByFullName("Name_skillIcon")

		skillicon:setVisible(true)
		skillicon:changeParent(mcIcon):center(mcIcon:getContentSize())

		local mcIcon = skillAnim:getChildByFullName("icon1")
		local skillNode = self._skillPanel:getChildByFullName("skill_" .. index)

		skillNode:setVisible(true)
		skillNode:changeParent(mcIcon):center(mcIcon:getContentSize())

		local mcIcon = skillAnim:getChildByFullName("icon3")
		local skillNode = self._skillPanel:getChildByFullName("skill_" .. index .. "_0")

		skillNode:setScale(0.9)
		skillNode:setVisible(true)
		skillNode:changeParent(mcIcon):center(mcIcon:getContentSize())
		skillAnim:addEndCallback(function()
			skillAnim:stop()
		end)
	end

	anim:addCallbackAtFrame(30, function(cid, mc)
		addSkillAnim(1)
	end)
	anim:addCallbackAtFrame(32, function(cid, mc)
		addSkillAnim(2)
	end)
	anim:addCallbackAtFrame(34, function(cid, mc)
		addSkillAnim(3)
	end)
	anim:addCallbackAtFrame(36, function(cid, mc)
		addSkillAnim(4)
	end)

	local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, animNode)

	startFunc()
	anim:addEndCallback(function()
		anim:stop()
		stopFunc()
	end)
end

function HeroShowDetailsMediator:initAttrData()
	local maxLevel = self._config.MaxLevel
	local maxQualityId = self._config.MaxQuality
	local maxStarId = self._config.MaxStarEffect
	local rarity = self._config.Rareity
	local cost = self._config.Cost
	local maxStar = self._config.MaxStar
	local type = self._config.Type
	local retAtrr = {}

	for attrType, _ in pairs(AttrBaseType) do
		local data = {
			starId = maxStarId,
			qualityId = maxQualityId,
			lvl = maxLevel,
			attrType = attrType,
			cost = cost,
			heroId = self._heroId,
			rarity = rarity
		}
		local effectConfig = HeroAttribute:getBaseAttEffectConfig(data, nil)

		retAtrr[attrType] = math.floor(effectConfig.attrNum)
	end

	retAtrr.speed = self:getSpeedRatio(maxQualityId, maxStarId)

	local attrData = {
		uncritRate = 0,
		uniqueSkillLevel = 0,
		blockRate = 0,
		hurtRate = 0,
		blockStrg = 0,
		skillLevel = 0,
		poundSkillLevel = 0,
		critRate = 0,
		unhurtRate = 0,
		critStrg = 0,
		effectStrg = 0,
		reflection = 0,
		battleSkillLevel = 0,
		unEffectRate = 0,
		effectRate = 0,
		unblockRate = 0,
		absorption = 0,
		normalSkillLevel = 0,
		attack = retAtrr.ATK,
		defense = retAtrr.DEF,
		hp = retAtrr.HP,
		star = maxStar,
		speed = retAtrr.speed,
		rarity = rarity,
		occupation = type
	}
	local combat = HeroAttribute:getMaxHeroCombat(attrData)

	retAtrr.combat = math.floor(combat)

	return retAtrr
end

function HeroShowDetailsMediator:getSpeedRatio(qualityId, starId)
	local speedBase = self._config.Speed
	local quaConfig = ConfigReader:getRecordById("HeroQuality", qualityId)
	local starConfig = ConfigReader:getRecordById("HeroStarEffect", starId)

	return speedBase + quaConfig.Speed + starConfig.Speed
end

function HeroShowDetailsMediator:createDescPanel(desc)
	local layout = ccui.Layout:create()
	local strWidth = self._listView:getContentSize().width
	local label = ccui.RichText:createWithXML(desc, {})

	label:setVerticalSpace(1)
	label:renderContent(strWidth, 0)
	label:setAnchorPoint(cc.p(0, 1))

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(strWidth, height + 8))
	label:addTo(layout)
	label:setPosition(cc.p(0, height + 8))

	return layout
end

function HeroShowDetailsMediator:checkIsKeySkill(skillId)
	local skillShowType = ConfigReader:getRecordById("ConfigValue", "Hero_SkillShowType").content
	local config = ConfigReader:getRecordById("HeroBase", tostring(self._heroId))

	if config.KeyPassiveSkill and config.KeyPassiveSkill == "" then
		return false
	end

	for i = 1, #skillShowType do
		local skillType = skillShowType[i]

		if config[skillType] and skillId == config[skillType] and skillType and skillType == "BattlePassiveSkill" then
			return true
		end
	end

	return false
end

function HeroShowDetailsMediator:onClickSkill(skill, starId, skillRate)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if not self._skillWidget then
		local skillInfoNode = self._mainPanel:getChildByFullName("skillInfoNode")

		self._skillWidget = self:autoManageObject(self:getInjector():injectInto(SkillMaxDescWidget:new(SkillMaxDescWidget:createWidgetNode(), {
			skill = skill,
			starId = starId,
			skillRate = skillRate,
			mediator = self
		})))

		self._skillWidget:getView():addTo(skillInfoNode)
	end

	self._skillWidget:refreshInfo(skill, starId, skillRate, self._heroData)
	self._skillWidget:show()
end

function HeroShowDetailsMediator:onBackBtn(sender, eventType)
	self._mainPanel:stopAllActions()
	self:dismiss()
end
