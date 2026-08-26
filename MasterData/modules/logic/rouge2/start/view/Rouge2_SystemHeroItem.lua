-- chunkname: @modules/logic/rouge2/start/view/Rouge2_SystemHeroItem.lua

module("modules.logic.rouge2.start.view.Rouge2_SystemHeroItem", package.seeall)

local Rouge2_SystemHeroItem = class("Rouge2_SystemHeroItem", ListScrollCell)

Rouge2_SystemHeroItem.ExSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function Rouge2_SystemHeroItem:init(go)
	self.go = go
	self._goHas = gohelper.findChild(self.go, "go_Has")
	self._simageHeroIcon1 = gohelper.findChildSingleImage(self.go, "go_Has/simage_HeroIcon")
	self._imageRare1 = gohelper.findChildImage(self.go, "go_Has/image_Rare")
	self._imageCareer = gohelper.findChildImage(self.go, "go_Has/image_Career")
	self._goExSkill = gohelper.findChild(self.go, "go_Has/#go_ExSkill")
	self._imageExSkill = gohelper.findChildImage(self.go, "go_Has/#go_ExSkill/#image_ExSkill")
	self._goRankLayout = gohelper.findChild(self.go, "go_Has/go_RankLayout")
	self._goRank = gohelper.findChild(self.go, "go_Has/go_RankLayout/layout/go_Rank")
	self._imageRank = gohelper.findChildImage(self.go, "go_Has/go_RankLayout/layout/go_Rank/image_Rank")
	self._txtLevel = gohelper.findChildText(self.go, "go_Has/go_RankLayout/layout/txt_Level")
	self._goTag = gohelper.findChild(self.go, "go_Tag")
	self._goTagBg = gohelper.findChild(self.go, "go_Tag/bg")
	self._txtTag = gohelper.findChildText(self.go, "go_Tag/txt_Tag")
	self._goEmpty = gohelper.findChild(self.go, "go_Empty")
	self._simageHeroIcon2 = gohelper.findChildSingleImage(self.go, "go_Empty/simage_HeroIcon")
	self._imageRare2 = gohelper.findChildImage(self.go, "go_Empty/image_Rare")

	self:initTagBgTab()
	self:initRankIconTab()
end

function Rouge2_SystemHeroItem:addEventListeners()
	return
end

function Rouge2_SystemHeroItem:removeEventListeners()
	return
end

function Rouge2_SystemHeroItem:initTagBgTab()
	self._goTagBgTab = self:getUserDataTb_()

	for i = 1, math.huge do
		local goTagBg = gohelper.findChild(self._goTagBg, "type" .. i)

		if gohelper.isNil(goTagBg) then
			break
		end

		self._goTagBgTab[i] = goTagBg
	end
end

function Rouge2_SystemHeroItem:showTagBg(tagType)
	for type, goTagBg in pairs(self._goTagBgTab) do
		gohelper.setActive(goTagBg, type == tagType)
	end
end

function Rouge2_SystemHeroItem:initRankIconTab()
	self._goRankIconTab = self:getUserDataTb_()

	for i = 1, math.huge do
		local goRankIcon = gohelper.findChild(self._goRank, "rank" .. i)

		if gohelper.isNil(goRankIcon) then
			break
		end

		self._goRankIconTab[i] = goRankIcon
	end
end

function Rouge2_SystemHeroItem:showRank(rank)
	if rank and rank > 1 then
		local tmpRank = rank - 1

		gohelper.setActive(self._goRank, true)

		for i, goRankIcon in pairs(self._goRankIconTab) do
			gohelper.setActive(goRankIcon, i == tmpRank)
		end
	else
		gohelper.setActive(self._goRank, false)
	end
end

function Rouge2_SystemHeroItem:onUpdateMO(heroCo, index)
	self._index = index
	self._heroCo = heroCo
	self._heroId = heroCo and heroCo.id
	self._heroMo = Rouge2_SystemController.instance:getHeroMo(self._heroId)
	self._hasHero = self._heroMo ~= nil

	self:refreshUI()
end

function Rouge2_SystemHeroItem:refreshUI()
	gohelper.setActive(self._goHas, self._hasHero)
	gohelper.setActive(self._goEmpty, not self._hasHero)
	self:refreshUI_Common()

	if self._hasHero then
		self:refreshUI_HasHero()
	else
		self:refreshUI_Empty()
	end
end

function Rouge2_SystemHeroItem:refreshUI_Common()
	if self._heroMo then
		if not self._heroMo.skin then
			local skinId = self._heroCo.skinId
			local skinConfig = SkinConfig.instance:getSkinCo(skinId)
			local heroIconPath = ResUrl.getRoomHeadIcon(skinConfig.headIcon)

			self._simageHeroIcon1:LoadImage(heroIconPath)
			self._simageHeroIcon2:LoadImage(heroIconPath)

			local rareIconName = "equipbar" .. CharacterEnum.Color[self._heroCo.rare]

			UISpriteSetMgr.instance:setCommonSprite(self._imageRare1, rareIconName)
			UISpriteSetMgr.instance:setCommonSprite(self._imageRare2, rareIconName)
			self:refreshHeroTag()
		end
	end
end

function Rouge2_SystemHeroItem:refreshUI_Empty()
	return
end

function Rouge2_SystemHeroItem:refreshUI_HasHero()
	UISpriteSetMgr.instance:setCommonSprite(self._imageCareer, "lssx_" .. self._heroCo.career)

	local showLevel, rank = HeroConfig.instance:getShowLevel(self._heroMo.level)

	self:showRank(rank)

	self._txtLevel.text = string.format("LV.%s", showLevel)

	local exSkillLevel = self._heroMo.exSkillLevel

	gohelper.setActive(self._goExSkill, exSkillLevel and exSkillLevel > 0)

	if exSkillLevel and exSkillLevel > 0 then
		if not Rouge2_SystemHeroItem.ExSkillFillAmount[self._heroMo.exSkillLevel] then
			self._imageExSkill.fillAmount = Rouge2_SystemHeroItem.ExSkillFillAmount[self._heroMo.exSkillLevel]
		end
	end
end

function Rouge2_SystemHeroItem:refreshHeroTag()
	local battleTagList = HeroConfig.instance:getHeroBattleTagList(self._heroId)
	local hasMatchTag = false
	local showBattleTagCo, showTagType

	if battleTagList then
		for _, battleTag in ipairs(battleTagList) do
			local battleTagCo = HeroConfig.instance:getBattleTagConfigCO(battleTag)
			local systemId = tonumber(battleTag)
			local systemCo = Rouge2_CareerConfig.instance:getSystemConfig(systemId, true)
			local visible = systemCo and systemCo.visible

			if visible and visible ~= 0 then
				showBattleTagCo = battleTagCo
				showTagType = visible
				hasMatchTag = true

				break
			end
		end
	end

	gohelper.setActive(self._goTag, hasMatchTag)

	if not hasMatchTag then
		return
	end

	if showBattleTagCo then
		self._txtTag.text = showBattleTagCo.tagName or ""
	end

	self:showTagBg(showTagType)
end

function Rouge2_SystemHeroItem:onDestroy()
	self._simageHeroIcon1:UnLoadImage()
	self._simageHeroIcon2:UnLoadImage()
end

return Rouge2_SystemHeroItem
