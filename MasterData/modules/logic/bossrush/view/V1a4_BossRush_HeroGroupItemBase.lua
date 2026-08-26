-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_HeroGroupItemBase.lua

module("modules.logic.bossrush.view.V1a4_BossRush_HeroGroupItemBase", package.seeall)

local V1a4_BossRush_HeroGroupItemBase = class("V1a4_BossRush_HeroGroupItemBase", LuaCompBase)

function V1a4_BossRush_HeroGroupItemBase:_initGoList(prefix)
	local list = self:getUserDataTb_()
	local i = 1
	local goName = prefix .. tostring(i)
	local go = self[goName]

	while not gohelper.isNil(go) do
		list[i] = go
		i = i + 1
		goName = prefix .. tostring(i)
		go = self[goName]
	end

	return list
end

function V1a4_BossRush_HeroGroupItemBase:setData(heroMo, equipMo)
	self._heroMo = heroMo
	self._equipMo = equipMo

	self:onSetData()
end

function V1a4_BossRush_HeroGroupItemBase:refreshShowLevel(textCmp)
	if not textCmp then
		return
	end

	local heroMo = self._heroMo

	if heroMo then
		if not heroMo.level then
			local level = 0
			local showLevel, _ = HeroConfig.instance:getShowLevel(level)

			textCmp.text = tostring(showLevel)
		end
	end
end

function V1a4_BossRush_HeroGroupItemBase:refreshLevelList(levelGoList)
	if not levelGoList then
		return
	end

	local heroMo = self._heroMo

	if heroMo then
		if not heroMo.level then
			local level = 0
			local _, rank = HeroConfig.instance:getShowLevel(level)

			for i, go in ipairs(levelGoList) do
				gohelper.setActive(go, i == rank - 1)
			end
		end
	end
end

function V1a4_BossRush_HeroGroupItemBase:refreshStarList(starGoList)
	if not starGoList then
		return
	end

	local heroMo = self._heroMo
	local heroCO = heroMo and heroMo.config

	if heroMo then
		if not heroCO.rare then
			local rare = -1

			for i, go in ipairs(starGoList) do
				gohelper.setActive(go, i <= rare + 1)
			end
		end
	end
end

function V1a4_BossRush_HeroGroupItemBase:getHeadIconMiddleResUrl()
	local heroMo = self._heroMo

	if not heroMo then
		return
	end

	local skinCO = FightConfig.instance:getSkinCO(heroMo.skin)

	return ResUrl.getHeadIconMiddle(skinCO.retangleIcon)
end

function V1a4_BossRush_HeroGroupItemBase:getCareerSpriteName()
	local heroMo = self._heroMo

	if not heroMo then
		return
	end

	local heroCO = heroMo.config

	return "lssx_" .. tostring(heroCO.career)
end

function V1a4_BossRush_HeroGroupItemBase:getEquipIconSpriteName()
	local equipMo = self._equipMo

	if not equipMo then
		return
	end

	local equipCO = equipMo.config

	return equipCO.icon
end

function V1a4_BossRush_HeroGroupItemBase:getEquipRareSprite()
	local equipMo = self._equipMo

	if not equipMo then
		return
	end

	local equipCO = equipMo.config

	return "bianduixingxian_" .. tostring(equipCO.rare)
end

function V1a4_BossRush_HeroGroupItemBase:onDestroyView()
	self:onDestroy()
end

function V1a4_BossRush_HeroGroupItemBase:_refreshHeroByDefault()
	local heroMo = self._heroMo

	if not heroMo then
		gohelper.setActive(self._gohero, false)

		return
	end

	local headIconMiddleResUrl = self:getHeadIconMiddleResUrl()

	self._simageheroicon:LoadImage(headIconMiddleResUrl)

	local careerSpriteName = self:getCareerSpriteName()

	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, careerSpriteName)
	gohelper.setActive(self._goTrialTag, not heroMo:isOwnHero())
end

function V1a4_BossRush_HeroGroupItemBase:onSetData()
	assert(false, "please override this function")
end

function V1a4_BossRush_HeroGroupItemBase:onDestroy()
	return
end

return V1a4_BossRush_HeroGroupItemBase
