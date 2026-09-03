-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/heroshow/HeroShowNotOwnMediator.lua

HeroShowNotOwnMediator = class("HeroShowNotOwnMediator", DmPopupViewMediator, _M)

HeroShowNotOwnMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local EquipPositionToType = _G.EquipPositionToType
local kBgAnimAndImage = {
	[GalleryPartyType.kBSNCT] = "asset/ui/gallery/party_icon_businiao.png",
	[GalleryPartyType.kXD] = "asset/ui/gallery/party_icon_xide.png",
	[GalleryPartyType.kMNJH] = "asset/ui/gallery/party_icon_monv.png",
	[GalleryPartyType.kDWH] = "asset/ui/gallery/party_icon_dongwenhui.png",
	[GalleryPartyType.kWNSXJ] = "asset/ui/gallery/party_icon_weinasi.png",
	[GalleryPartyType.kSSZS] = "asset/ui/gallery/party_icon_she.png",
	[GalleryPartyType.kUNKNOWN] = "asset/ui/gallery/party_icon_unknown.png"
}
local kEquipTypeToName = {
	[HeroEquipType.kWeapon] = Strings:get("Equip_Name_Weapon"),
	[HeroEquipType.kDecoration] = Strings:get("Equip_Name_Decoration"),
	[HeroEquipType.kTops] = Strings:get("Equip_Name_Tops"),
	[HeroEquipType.kShoes] = Strings:get("Equip_Name_Shoes")
}
local kShowType = {
	kStarBoxHasHero = 3,
	kNotHasHero = 1,
	kHasHero = 2
}
local kHeroRarityAnim = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"r_yingxiongxuanze",
	"r_yingxiongxuanze",
	"sr_yingxiongxuanze",
	"ssr_yingxiongxuanze",
	"sp_xiao_urequipeff"
}
local kBtnHandlers = {
	["main.backBtn"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onBackClicked"
	},
	["main.rightPanel.combatNode.Button_9"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onStrongClicked"
	}
}

function HeroShowNotOwnMediator:initialize()
	super.initialize(self)
end

function HeroShowNotOwnMediator:dispose()
	self._viewClose = true

	if self._equipInfoView then
		self._equipInfoView:dispose()

		self._equipInfoView = nil
	end

	super.dispose(self)
end

function HeroShowNotOwnMediator:onRemove()
	super.onRemove(self)
end

function HeroShowNotOwnMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshViewAndData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_LOCK_SUCC, self, self.refreshViewByLock)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._equipSystem = self._developSystem:getEquipSystem()
end

function HeroShowNotOwnMediator:refreshViewAndData()
	self._heroInfoData = self._heroSystem:getHeroInfoById(self._heroId)
	self._heroData = self._heroSystem:getHeroById(self._heroId)

	local refrshHero = self._showType == kShowType.kNotHasHero and self._heroData ~= nil

	if self._showType == kShowType.kStarBoxHasHero and self._heroInfoData.showType ~= HeroShowType.kHas then
		self._showType = kShowType.kNotHasHero
	end

	if self._heroData == nil then
		local heroData = Hero:new(self._heroId, self._developSystem:getPlayer())

		heroData:rCreateEffect()

		self._heroData = heroData
	else
		self._showType = self._showOrginType == kShowType.kStarBoxHasHero and kShowType.kStarBoxHasHero or kShowType.kHasHero
	end

	self:refreshView(refrshHero)
end

function HeroShowNotOwnMediator:enterWithData(data)
	self._heroId = data.id
	self._modelId = data.modelId
	self._showType = data.showType or kShowType.kNotHasHero
	self._showOrginType = data.showType or kShowType.kNotHasHero
	self._hideLeftPanel = data.hideLeftPanel
	self._attrAdds = data.attrAdds or {}
	self._config = PrototypeFactory:getInstance():getHeroPrototype(self._heroId):getConfig()
	self._heroInfoData = self._heroSystem:getHeroInfoById(self._heroId)
	self._heroData = self._heroSystem:getHeroById(self._heroId)

	if self._heroData == nil then
		local heroData = Hero:new(self._heroId, self._developSystem:getPlayer())

		heroData:rCreateEffect()

		self._heroData = heroData
	end

	if self._showType == kShowType.kStarBoxHasHero and self._heroInfoData.showType ~= HeroShowType.kHas then
		self._showType = kShowType.kNotHasHero
	end

	self:initView()
end

function HeroShowNotOwnMediator:initView()
	self._main = self:getView():getChildByName("main")

	self._main:getChildByName("maskLayer"):setSwallowTouches(false)
	self._main:getChildByName("maskLayer"):addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended and self._equipInfo and self._equipInfo:isVisible() then
			self._equipInfo:setVisible(false)
		end
	end)

	local rightPanel = self._main:getChildByFullName("rightPanel")
	local heroIcon = self._main:getChildByFullName("heroView.heroIcon")
	local var_7_0 = {
		frameId = "bustframe9"
	}

	var_7_0.id = self._modelId or self._heroInfoData.roleModel

	local img = IconFactory:createRoleIconSpriteNew(var_7_0)

	img:setPosition(cc.p(0, -110))
	img:addTo(heroIcon)

	local heroRarity = self._main:getChildByFullName("heroView.rarity")

	heroRarity:removeAllChildren()

	local rarityAnim = cc.MovieClip:create(kHeroRarityAnim[self._heroInfoData.rareity])

	rarityAnim:addTo(heroRarity):center(heroRarity:getContentSize())
	rarityAnim:offset(0, 2)

	if self._showType == kShowType.kNotHasHero then
		img:setSaturation(-100)
		img:setOpacity(204)
	end

	local partyImgNode = self._main:getChildByName("partyImgNode")

	if kBgAnimAndImage[self._config.Party] then
		partyImgNode:setVisible(true)
		partyImgNode:removeAllChildren()

		local partyImg = ccui.ImageView:create(kBgAnimAndImage[self._config.Party])

		partyImg:setOpacity(153)
		partyImg:addTo(partyImgNode)
	else
		partyImgNode:setVisible(false)
	end

	self._leftPanel = self._main:getChildByFullName("heroView.leftPanel")
	self._icon = self._leftPanel:getChildByName("icon")
	self._addPanel = self._leftPanel:getChildByName("addImg")
	self._starPanel = self._leftPanel:getChildByName("starPanel")
	self._starPanelBg = self._leftPanel:getChildByName("Image_37")

	self._icon:removeAllChildren()
	self._starPanel:removeAllChildren()
	self._addPanel:getChildByFullName("touchPanel"):addTouchEventListener(function(sender, eventType)
		self:onClickHero(sender, eventType)
	end)

	local progress = self._leftPanel:getChildByFullName("progress")

	GameStyle:setCommonOutlineEffect(progress, 109.64999999999999, 2)

	local occupation = rightPanel:getChildByName("type")
	local occupationName, occupationImg = GameStyle:getHeroOccupation(self._heroInfoData.type)

	occupation:loadTexture(occupationImg)

	local cost = rightPanel:getChildByFullName("costBg.cost")

	cost:setString(tostring(self._heroInfoData.cost))

	local name = rightPanel:getChildByName("name")
	local nameBg = rightPanel:getChildByName("nameBg")

	name:setString(Strings:get(self._heroInfoData.name))
	nameBg:setScaleX(math.min(name:getContentSize().width + 120, 410) / nameBg:getContentSize().width)

	local goToStrongButton = rightPanel:getChildByFullName("combatNode.Button_9")

	if self._heroInfoData.showType ~= HeroShowType.kHas then
		goToStrongButton:setVisible(false)
	end

	local label1 = rightPanel:getChildByFullName("nichePanel.label_1")
	local label2 = rightPanel:getChildByFullName("nichePanel.label_2")
	local positions = string.split(Strings:get(self._config.Position), " ")

	label1:setString(positions[1] or "")
	label2:setString(positions[2] or "")
	label2:setPositionX(label1:getPositionX() + label1:getContentSize().width + 18)

	local p = rightPanel:getChildByFullName("nichePanel.nichePanel")

	p:setScale9Enabled(true)
	p:setCapInsets(cc.rect(100, 30, 1, 1))
	p:setContentSize(cc.size(label1:getContentSize().width + label2:getContentSize().width + 110, 60))

	self._effectCell = self:getView():getChildByName("effectCellClone")

	self._effectCell:setVisible(false)

	local heroView = self._main:getChildByName("heroView")
	local rightPanel = self._main:getChildByName("rightPanel")
	local effectPanel = self._main:getChildByName("effectPanel")
	local effectNum = #self._attrAdds

	if effectNum <= 0 then
		effectPanel:setVisible(false)
		self._leftPanel:setPositionX(88.82)
		self._starPanel:setPositionX(-20.75)
	else
		self._leftPanel:setPositionX(-100)
		self._starPanel:setPositionX(20)
		self._starPanelBg:setPositionX(140)
		effectPanel:setVisible(true)

		local effectCell = self._effectCell
		local effectList = effectPanel:getChildByName("effectList")

		effectList:removeAllChildren()
		effectList:setScrollBarEnabled(false)

		for i = 1, effectNum do
			local cell = effectCell:clone()

			cell:setVisible(true)
			cell:getChildByName("name"):setString(self._attrAdds[i].title)

			local descLabel = cell:getChildByName("desc")

			descLabel:setString(self._attrAdds[i].desc)

			if self._attrAdds[i].richTextType then
				local richText = ccui.RichText:createWithXML("", {})

				richText:setAnchorPoint(descLabel:getAnchorPoint())
				richText:setPosition(cc.p(descLabel:getPosition()))
				richText:addTo(descLabel:getParent())
				richText:renderContent(descLabel:getContentSize().width, 0, true)
				richText:setString(self._attrAdds[i].desc)
				descLabel:setVisible(false)
			end

			local awakenBuff = cell:getChildByFullName("icon.awakenBuff")
			local starBuff = cell:getChildByFullName("icon.starBuff")
			local head = cell:getChildByFullName("icon.Head")
			local skill = cell:getChildByFullName("icon.skill")

			if self._attrAdds[i].type == StageAttrAddType.HERO then
				head:setVisible(true)

				local info = {
					id = self._heroInfoData.roleModel
				}
				local heroImg = IconFactory:createRoleIconSpriteNew(info)

				heroImg:addTo(head):center(head:getContentSize()):setScale(0.27):offset(-1, 0)
			elseif self._attrAdds[i].type == StageAttrAddType.HERO_TYPE then
				head:setVisible(true)

				local pic = ccui.ImageView:create(occupationImg)

				pic:addTo(head):center(head:getContentSize()):setScale(0.8):offset(-2, -4)
			elseif self._attrAdds[i].type == StageAttrAddType.HERO_BUFF then
				head:setVisible(true)
				head:loadTexture(self._attrAdds[i].icon)
				head:setScale(0.8)
			elseif self._attrAdds[i].type == StageAttrAddType.HERO_FULL_STAR then
				starBuff:setVisible(true)
			elseif self._attrAdds[i].type == StageAttrAddType.HERO_AWAKE then
				awakenBuff:setVisible(true)
			end

			effectList:pushBackCustomItem(cell)
		end

		local listHeight = math.max(effectNum * 91, 91)

		effectPanel:setContentSize(cc.size(342, listHeight + 40))
		effectPanel:setPositionY(listHeight + 162.86 - 91)
		effectPanel:getChildByName("bg"):setContentSize(cc.size(342, listHeight + 40))
		effectPanel:getChildByName("bg"):setPositionY(listHeight + 40)
		effectPanel:getChildByName("title"):setPositionY(listHeight + 52)
		effectPanel:getChildByName("effectList"):setContentSize(cc.size(330, listHeight))
		effectPanel:getChildByName("effectList"):setPositionY(listHeight + 28.5)
	end

	self:initSkillView()
	self:initEquipView()
	self:refreshView()
end

function HeroShowNotOwnMediator:refreshBaseInfo(refrshHero)
	local rightPanel = self._main:getChildByName("rightPanel")
	local combatText = rightPanel:getChildByFullName("combatNode.combat")
	local label = combatText:getChildByFullName("CombatLabel")

	if not label then
		local fntFile = "asset/font/heroLevel_font.fnt"

		label = ccui.TextBMFont:create("", fntFile)

		label:addTo(combatText)
		label:setName("CombatLabel")
	end

	label:setString(tostring(self._heroInfoData.combat))

	local atkText = rightPanel:getChildByFullName("attr_atk.text")

	atkText:setString(tostring(self._heroInfoData.atk))

	local hpText = rightPanel:getChildByFullName("attr_hp.text")

	hpText:setString(tostring(self._heroInfoData.hp))

	local defText = rightPanel:getChildByFullName("attr_def.text")

	defText:setString(tostring(self._heroInfoData.def))

	local speedText = rightPanel:getChildByFullName("attr_speed.text")

	speedText:setString(tostring(self._heroInfoData.speed))

	if refrshHero then
		local heroIcon = self._main:getChildByFullName("heroView.heroIcon")

		heroIcon:removeAllChildren()

		local var_10_0 = {
			frameId = "bustframe9"
		}

		var_10_0.id = self._modelId or self._heroInfoData.roleModel

		local img = IconFactory:createRoleIconSpriteNew(var_10_0)

		img:setPosition(cc.p(0, -110))
		img:addTo(heroIcon)
	end
end

function HeroShowNotOwnMediator:initSkillView()
	self._skillPanel = self._main:getChildByFullName("rightPanel.skillPanel")
	self._skillAnim = self._skillPanel:getChildByFullName("skillAnim")

	self._skillAnim:setVisible(false)
	self._skillAnim:setScale(0.86)
end

function HeroShowNotOwnMediator:refreshSkill()
	self._skillNode = {}

	local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(self._heroId)
	local skillIds = heroPrototype:getShowSkillIds()
	local num = math.min(4, #skillIds)
	local skills = {}

	for i = 1, num do
		local skillId = skillIds[num - i + 1]
		local skill = {}

		if self._heroInfoData.showType ~= HeroShowType.kHas then
			skill = HeroSkill:new(skillId)

			skill:setLevel(1)
		else
			skill = self._heroData:getSkillById(skillId)
		end

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
			self:onClickSkill(skill)
		end)

		local skillIcon = IconFactory:createHeroSkillIcon({
			levelHide = true,
			id = skillId
		})

		skillIcon:addTo(panel):center(panel:getContentSize())
		skillIcon:setScale(0.7)
		skillIcon:setName("Name_skillIcon")

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

		self._skillNode[index] = skillIcon
	end
end

function HeroShowNotOwnMediator:checkIsKeySkill(skillId)
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

function HeroShowNotOwnMediator:initEquipView()
	self._equipPanel = self._main:getChildByFullName("rightPanel.equipPanel")
	self._equipInfo = self._main:getChildByFullName("equipInfo")

	self._equipInfo:setVisible(false)

	local infoViewData = {
		mediator = self,
		mainNode = self._equipInfo
	}

	self._equipInfoView = self._heroSystem:enterEquipInfoView(infoViewData)

	local strengthenBtn = self._equipInfoView:getView():getChildByFullName("equipPanel.btnPanel.strengthenBtn")
	local changeBtn = self._equipInfoView:getView():getChildByFullName("equipPanel.btnPanel.changeBtn")

	self:bindWidget(strengthenBtn, ThreeLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickStrengthen, self)
		}
	})
	self:bindWidget(changeBtn, ThreeLevelMainButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickChange, self)
		}
	})

	self._equipList = {}

	for i = 1, #EquipPositionToType do
		local equipType = EquipPositionToType[i]
		local equipPanel = self._equipPanel:getChildByFullName("Node" .. i)

		equipPanel:setTouchEnabled(true)
		equipPanel:addClickEventListener(function()
			self:onClickEquipIcon(i)
		end)

		self._equipList[i] = {
			equipPanel = equipPanel,
			equipType = equipType
		}
	end
end

function HeroShowNotOwnMediator:refreshEquipView()
	self._equipInfo:setVisible(false)

	local equips = {}

	for index = 1, #EquipPositionToType do
		local equipPanel = self._equipList[index].equipPanel
		local panel = equipPanel:getChildByFullName("Node")
		local equipType = self._equipList[index].equipType
		local image_empty = panel:getChildByFullName("Image_empty")
		local nameLabel = panel:getChildByFullName("name")
		local levelLabel = panel:getChildByFullName("level")
		local levelBg = panel:getChildByFullName("title_bg")
		local redPoint = panel:getChildByFullName("redPoint")
		local node = panel:getChildByFullName("node")

		node:removeAllChildren()

		if self._heroInfoData.showType == HeroShowType.kHas then
			local equipId = self._heroData:getEquipIdByType(equipType)
			local hasEquip = not not equipId

			image_empty:setVisible(not hasEquip)

			if hasEquip then
				local equipData = self._equipSystem:getEquipById(equipId)

				equips[equipType] = equipData

				local name = equipData:getName()
				local rarity = equipData:getRarity()
				local level = equipData:getLevel()
				local levelMax = equipData:getMaxLevel()
				local star = equipData:getStar()
				local param = {
					id = equipData:getEquipId(),
					level = level,
					star = star,
					rarity = rarity
				}
				local equipIcon = IconFactory:createEquipIcon(param, {
					hideLevel = true
				})

				equipIcon:addTo(node):center(node:getContentSize())
				equipIcon:setScale(0.64)

				local levelStr = Strings:get("Strenghten_Text78", {
					level = level
				})

				nameLabel:setString(name)
				levelLabel:setString(levelStr)
				nameLabel:setVisible(true)
				levelLabel:setVisible(true)
				node:setVisible(true)
				levelBg:setVisible(true)
			else
				nameLabel:setVisible(false)
				levelLabel:setVisible(false)
				node:setVisible(false)
				levelBg:setVisible(false)
			end

			local hasRed1 = self._heroSystem:hasRedPointByEquipStarUp(self._heroId, equipType)
			local hasRed2 = self._heroSystem:hasRedPointByEquipReplace(self._heroId, equipType)

			redPoint:setVisible(hasRed2)
			redPoint:setLocalZOrder(2)

			local starUpMark = equipPanel:getChildByName("StarUpMark")

			if starUpMark then
				starUpMark:setVisible(hasRed1)
			elseif hasRed1 then
				self:createCanStarUpMark(equipPanel)
			end
		else
			nameLabel:setVisible(false)
			levelLabel:setVisible(false)
			node:setVisible(false)
			levelBg:setVisible(false)
			redPoint:setVisible(false)
		end
	end
end

function HeroShowNotOwnMediator:refreshView(refrshHero)
	self:refreshBaseInfo(refrshHero)
	self:refreshSkill()
	self:refreshEquipView()

	self._heroInfoData = self._heroSystem:getHeroInfoById(self._heroId)

	local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(self._heroId)
	local progress = self._leftPanel:getChildByFullName("progress")

	if self._showType == kShowType.kNotHasHero then
		self._leftPanel:setVisible(true)
		self._leftPanel:setPositionY(-22)
		self._addPanel:setVisible(true)
		self._starPanel:setVisible(false)
		self._starPanelBg:setVisible(false)
		self._icon:removeAllChildren()

		local hasNum = self._heroSystem:getHeroDebrisCount(self._heroId)
		local needNum = heroPrototype:getStarNumByCompose()

		progress:setString(hasNum .. "/" .. needNum)

		local icon = IconFactory:createIcon({
			id = self._heroInfoData.fragId
		}, {
			showAmount = false
		})

		icon:setScale(0.5)
		icon:addTo(self._icon)
	elseif self._showType == kShowType.kHasHero then
		self._leftPanel:setVisible(false)
	elseif self._showType == kShowType.kStarBoxHasHero then
		local hero = self._heroSystem:getHeroById(self._heroId)

		self._leftPanel:setVisible(true)
		self._leftPanel:getChildByFullName("image1"):setVisible(not hero:isMaxStar())
		progress:setVisible(not hero:isMaxStar())
		self._addPanel:setVisible(not hero:isMaxStar())
		self._icon:removeAllChildren()
		self._starPanel:setVisible(true)
		self._starPanelBg:setVisible(true)
		self._starPanel:removeAllChildren()

		local offsetX = 15

		for i = 1, self._heroInfoData.maxStar do
			local path, zOrder

			if i <= self._heroInfoData.star then
				path = "img_yinghun_img_star_full.png"
				zOrder = 105
			elseif i == self._heroInfoData.star + 1 and self._heroInfoData.littleStar then
				path = "img_yinghun_img_star_half.png"
				zOrder = 100
			else
				path = "img_yinghun_img_star_empty.png"
				zOrder = 99
			end

			if hero:getAwakenStar() > 0 then
				path = "jx_img_star.png"
				zOrder = 100
			end

			if i <= hero:getIdentityAwakenLevel() then
				path = "yinghun_img_awake_star.png"
				zOrder = 100
			end

			local star = cc.Sprite:createWithSpriteFrameName(path)

			star:addTo(self._starPanel)
			star:setGlobalZOrder(zOrder)
			star:setPosition(cc.p(offsetX + 46 * (i - 1), -3))
			star:setScale(0.8)
		end

		if not hero:isMaxStar() then
			local nextIsMiniStar = hero:getNextIsMiniStar()

			if self._heroInfoData.littleStar and not nextIsMiniStar then
				self._addPanel:setVisible(false)

				local hasNum = 0
				local needNum = hero:getStarStive()

				progress:setString(hasNum .. "/" .. needNum)

				local icon = ccui.ImageView:create("occupation_all.png", 1)

				icon:addTo(self._icon):posite(0, 0)
			else
				local hasNum = self._heroSystem:getHeroDebrisCount(self._heroId)
				local needNum = heroPrototype:getStarCostFragByStar(hero:getNextStarId())
				local icon = IconFactory:createIcon({
					id = self._heroInfoData.fragId
				}, {
					showAmount = false
				})

				icon:setScale(0.5)
				icon:addTo(self._icon):posite(0, 7)
				progress:setString(hasNum .. "/" .. needNum)
			end
		end
	end
end

function HeroShowNotOwnMediator:onClickHero(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._heroInfoData.showType == HeroShowType.kCanComp then
			local function callBack(data)
				local view = self:getInjector():getInstance("newHeroView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
					ignoreNewRed = true,
					heroId = data.id
				}))
				self:close()
			end

			self._bagSystem:requestHeroCompose(self._config.ItemId, callBack)
		elseif self._heroInfoData.showType == HeroShowType.kNotOwn then
			local needCount = self._heroSystem:getHeroComposeFragCount(self._heroId)
			local hasCount = self._heroSystem:getHeroDebrisCount(self._heroId)
			local param = {
				itemId = self._config.ItemId,
				hasNum = hasCount,
				needNum = needCount
			}
			local view = self:getInjector():getInstance("sourceView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, param))
		elseif self._heroInfoData.showType == HeroShowType.kHas then
			local hasCount = self._heroSystem:getHeroDebrisCount(self._heroId)
			local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(self._heroId)
			local hero = self._heroSystem:getHeroById(self._heroId)
			local needCount = heroPrototype:getStarCostFragByStar(hero:getNextStarId())
			local param = {
				itemId = self._heroInfoData.fragId,
				hasNum = hasCount,
				needNum = needCount
			}
			local view = self:getInjector():getInstance("sourceView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, param))
		end
	end
end

function HeroShowNotOwnMediator:onBackClicked()
	self:close()
end

function HeroShowNotOwnMediator:onClickSkill(skill)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if not self._skillWidget then
		local skillInfoNode = self._main:getChildByFullName("skillInfoNode")

		skillInfoNode:offset(0, -130)

		self._skillWidget = self:autoManageObject(self:getInjector():injectInto(SkillDescWidget:new(SkillDescWidget:createWidgetNode(), {
			skill = skill,
			mediator = self
		})))

		self._skillWidget:getView():addTo(skillInfoNode)
	end

	self._skillWidget:refreshInfo(skill, self._heroData)
	self._skillWidget:show()
end

function HeroShowNotOwnMediator:onClickEquipIcon(index)
	if self._heroInfoData.showType ~= HeroShowType.kHas then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("NewHeroPage_LockTip")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local equipType = EquipPositionToType[index]

	if self._heroData:getEquipIdByType(equipType) then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if self._equipInfo:isVisible() and self._equipType == equipType then
			self._equipInfo:setVisible(false)
		else
			self._equipType = equipType

			self._equipInfo:setVisible(true)
			self:refreshEquipInfo()
		end
	else
		self._equipInfo:setVisible(false)

		self._equipType = equipType

		local param = {
			position = self._equipType,
			occupation = self._heroData:getType(),
			heroId = self._heroId
		}
		local equipList = self._equipSystem:getEquipList(EquipsShowType.kReplace, param)

		if #equipList <= 0 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Equip_UI45", {
					name = kEquipTypeToName[self._equipType]
				})
			}))
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

			return
		end

		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local view = self:getInjector():getInstance("HeroEquipDressedView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			heroId = self._heroId,
			equipType = equipType
		}))
	end
end

function HeroShowNotOwnMediator:refreshEquipInfo()
	if self._equipInfo:isVisible() then
		local equipId = self._heroData:getEquipIdByType(self._equipType)

		self._equipInfoView:refreshEquipInfo({
			heroId = self._heroId,
			equipType = self._equipType,
			equipId = equipId
		})
	end
end

function HeroShowNotOwnMediator:refreshViewByLock(event)
	if self._equipInfoView then
		self._equipInfoView:refreshData()
		self._equipInfoView:refreshLock()

		local data = event:getData()

		if data.viewtype == 1 then
			self._equipInfoView:showLockTip()
		end
	end
end

function HeroShowNotOwnMediator:onClickStrengthen()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local equipId = self._heroData:getEquipIdByType(self._equipType)
	local param = {
		equipId = equipId
	}

	self._equipSystem:tryEnter(param)
end

function HeroShowNotOwnMediator:onClickChange()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("HeroEquipDressedView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		heroId = self._heroId,
		equipType = self._equipType
	}))
end

function HeroShowNotOwnMediator:onClickEquipLock()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local equipId = self._heroData:getEquipIdByType(self._equipType)

	if equipId then
		local params = {
			viewtype = 1,
			equipId = equipId
		}

		self._equipSystem:requestEquipLock(params)
	end
end

function HeroShowNotOwnMediator:createCanStarUpMark(parent)
	local image = ccui.ImageView:create("zhuangbei_img_ketupo.png", 1)

	image:addTo(parent):posite(53, 57)
	image:setName("StarUpMark")
	image:setScale(0.55)

	local str = cc.Label:createWithTTF(Strings:get("heroshow_UI34"), TTF_FONT_FZYH_M, 18)

	str:addTo(image):posite(38, 23)
end

function HeroShowNotOwnMediator:onStrongClicked()
	local view = self:getInjector():getInstance("HeroShowMainView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		id = self._heroId
	}))
end

function HeroShowNotOwnMediator:onTouchMaskLayer()
	return
end
