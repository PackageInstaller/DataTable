-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/heroshow/HeroRarityTipMediator.lua

HeroRarityTipMediator = class("HeroRarityTipMediator", DmPopupViewMediator, _M)

HeroRarityTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function HeroRarityTipMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
end

function HeroRarityTipMediator:enterWithData(data)
	self._heroData = data.data

	local rarityTip = self:getView()
	local rarity = self._heroData:getRarity()
	local star = self._heroData:getStar()
	local starAttr = self:checkIsShowSkill()

	if starAttr then
		rarity = starAttr.rarity or rarity
		star = starAttr.star or star
	end

	local node = rarityTip:getChildByFullName("panel.node")

	node:removeAllChildren()

	local anim, jsonPath = RoleFactory:createHeroAnimation(self._heroData:getModel())

	node:addChild(anim)
	anim:setPosition(cc.p(0, -45))
	anim:setScale(0.46)

	local function createStar(panel, star)
		panel:removeAllChildren()

		local width = 0

		for i = 1, star do
			local image = ccui.ImageView:create("common_icon_star.png", 1)

			image:setScale(0.25)
			image:setAnchorPoint(cc.p(0, 0))
			image:setPosition(cc.p(width, -3))
			image:addTo(panel)

			width = width + image:getContentSize().width * 0.18
		end

		panel:setContentSize(cc.size(width, 10))
	end

	local star1 = rarityTip:getChildByFullName("panel.star1")

	createStar(star1, self._heroData:getStar())

	local star2 = rarityTip:getChildByFullName("panel.star2")

	createStar(star2, star)

	local rarity1 = rarityTip:getChildByFullName("panel.rarity1")
	local rarity2 = rarityTip:getChildByFullName("panel.rarity2")

	rarity1:ignoreContentAdaptWithSize(true)
	rarity2:ignoreContentAdaptWithSize(true)
	rarity1:loadTexture(GameStyle:getHeroRarityImage(self._heroData:getRarity()), 1)
	rarity2:loadTexture(GameStyle:getHeroRarityImage(rarity), 1)
end

function HeroRarityTipMediator:checkIsShowSkill()
	local list = self._heroSystem:getSkillShowList(self._heroData:getId())

	for i = 1, #list do
		local data = list[i]

		if data and self._heroData:getStar() < data.star and data.effectType and data.effectType == SpecialEffectType.kChangeRarity then
			return {
				rarity = data.parameter.value,
				star = data.star
			}
		end
	end

	return nil
end
