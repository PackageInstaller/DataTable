-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/SetHeroShowDetailMediator.lua

SetHeroShowDetailMediator = class("SetHeroShowDetailMediator", DmPopupViewMediator, _M)

SetHeroShowDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	},
	["main.leftBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onLeftClicked"
	},
	["main.rightBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onRightClicked"
	}
}

function SetHeroShowDetailMediator:initialize()
	super.initialize(self)
end

function SetHeroShowDetailMediator:dispose()
	super.dispose(self)
end

function SetHeroShowDetailMediator:userInject()
	self._heroSystem = self._developSystem:getHeroSystem()
end

function SetHeroShowDetailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function SetHeroShowDetailMediator:enterWithData(data)
	self._data = data.heros
	self._index = data.index or 1

	self:setUpView()
end

function SetHeroShowDetailMediator:setUpView()
	self._curData = self._data[self._index]
	self._main = self:getView():getChildByFullName("main")

	local heroData = self._heroSystem:getHeroInfoById(self._curData.heroId)
	local leftBtn = self._main:getChildByFullName("leftBtn")
	local rightBtn = self._main:getChildByFullName("rightBtn")
	local nameLabel = self._main:getChildByFullName("nameLabel")
	local occupation = self._main:getChildByFullName("occupation")
	local textLevel = self._main:getChildByFullName("Text_level")
	local loveLevel = self._main:getChildByFullName("loveLevel")
	local starBg = self._main:getChildByFullName("starBg")

	starBg:removeAllChildren()

	local rarityIcon = self._main:getChildByFullName("rarityIcon")

	rarityIcon:removeAllChildren()

	local Panel_role = self._main:getChildByFullName("Panel_role")

	Panel_role:removeAllChildren()

	local combat = self._main:getChildByFullName("combatNode.combat")
	local attrPanel = self._main:getChildByFullName("descBg")
	local equipPanel = self._main:getChildByFullName("Panel_equip")

	equipPanel:removeAllChildren()

	if #self._data == 1 then
		leftBtn:setVisible(false)
		rightBtn:setVisible(false)
	end

	nameLabel:setString(heroData.name)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(heroData.type)

	occupation:loadTexture(occupationImg)
	textLevel:setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. self._curData.level)
	textLevel:setPositionX(nameLabel:getPositionX() + nameLabel:getContentSize().width + 10)
	loveLevel:setString(self._curData.loveLevel)
	combat:setString(self._curData.combat or 0)

	for i = 1, heroData.maxStar do
		local path = i <= self._curData.star and "img_yinghun_img_star_full.png" or i == self._curData.star + 1 and self._curData.litterStar and "img_yinghun_img_star_half.png" or "img_yinghun_img_star_empty.png"

		if self._curData.awakenLevel > 0 then
			path = "jx_img_star.png"
		end

		local star = cc.Sprite:createWithSpriteFrameName((i <= (self._curData.identityAwakenLevel or 0) or nil) and "yinghun_img_awake_star.png")

		star:addTo(starBg)
		star:setPosition(cc.p(10 + (i - 1) * 30, 22))
		star:setScale(0.4)
	end

	local rarityAnim = IconFactory:getHeroRarityAnim(self._curData.rarity)

	rarityAnim:addTo(rarityIcon):posite(20, 34)
	rarityAnim:setScale(0.8)

	local mid = ConfigReader:getDataByNameIdAndKey("Surface", self._curData.surfaceId, "Model")
	local heroIcon = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		id = mid
	})

	heroIcon:addTo(Panel_role):posite(500, 100)

	local attrKey = {
		"atk",
		"hp",
		"def",
		"speed"
	}

	for i, v in ipairs(attrKey) do
		local icon = attrPanel:getChildByFullName("des_" .. i .. ".image")
		local value = attrPanel:getChildByFullName("des_" .. i .. ".text")

		icon:loadTexture(AttrTypeImage[string.upper(v)], 1)
		value:setString(math.floor(self._curData[v]))
	end

	for i = 1, #EquipPositionToType do
		local equipType = EquipPositionToType[i]
		local equips = self._curData.equips

		if equips[equipType] then
			local param = {
				id = equips[equipType].configId,
				level = equips[equipType].level,
				star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", equips[equipType].starId, "StarLevel"),
				rarity = equips[equipType].rarity
			}
			local icon = IconFactory:createEquipIcon(param)

			icon:addTo(equipPanel):posite(50 + (i - 1) * 100, 50)
			icon:setScale(0.8)
		else
			local icon = IconFactory:createEquipEmpty(equipType)

			icon:addTo(equipPanel):posite(50 + (i - 1) * 100, 50)
			icon:setScale(1.2)
		end
	end
end

function SetHeroShowDetailMediator:onLeftClicked()
	self._index = self._index - 1

	if self._index < 1 then
		self._index = #self._data
	end

	self:setUpView()
end

function SetHeroShowDetailMediator:onRightClicked()
	self._index = self._index + 1

	if self._index > #self._data then
		self._index = 1
	end

	self:setUpView()
end

function SetHeroShowDetailMediator:onClickClose()
	self:close()
end
