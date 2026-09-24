-- chunkname: @modules/logic/abyss/view/AbyssHeroGroupHeroItem.lua

module("modules.logic.abyss.view.AbyssHeroGroupHeroItem", package.seeall)

local AbyssHeroGroupHeroItem = class("AbyssHeroGroupHeroItem", HeroGroupHeroItem)

function AbyssHeroGroupHeroItem:init(go)
	AbyssHeroGroupHeroItem.super.init(self, go)

	self.goAssistLock = gohelper.findChild(go, "heroitemani/hero/#assist_lock")
	self.simageAssistLock = gohelper.findChildSingleImage(go, "heroitemani/hero/#assist_lock/character")
	self.imageAssistCareer = gohelper.findChildImage(go, "heroitemani/hero/#assist_lock/career")
end

function AbyssHeroGroupHeroItem:checkAbyss()
	if HeroGroupModel.instance.heroGroupType ~= ModuleEnum.HeroGroupType.General then
		return
	end

	if self._heroMO ~= nil and self.monsterCO == nil then
		if AbyssModel.instance:isCurHeroLocked(self._heroMO.config.id) then
			self._playDeathAnim = true

			self:playAnim("herogroup_hero_deal")

			self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)

			return self._heroMO.id
		else
			self._commonHeroCard:setGrayScale(false)
		end
	end
end

function AbyssHeroGroupHeroItem:onUpdateMO(mo)
	AbyssHeroGroupHeroItem.super.onUpdateMO(self, mo)
	self:checkAssist()
end

function AbyssHeroGroupHeroItem:checkAssist()
	local curStageMo = AbyssModel.instance:getCurStageMo()
	local haveChallenge = curStageMo:isChallenged()

	if not haveChallenge then
		gohelper.setActive(self.goAssistLock, false)
		gohelper.setActive(self._charactericon, true)

		return
	end

	local heroIds = curStageMo.heroList
	local heroId = heroIds[self._index]
	local isAssist = curStageMo:isHeroAssist(heroId)

	gohelper.setActive(self._trialTagGO, isAssist)
	gohelper.setActive(self.goAssistLock, isAssist)
	gohelper.setActive(self._charactericon, not isAssist)

	if not isAssist then
		return
	end

	local skinId = curStageMo.skinDic[heroId]
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)
	local skinConfig = FightConfig.instance:getSkinCO(skinId)

	gohelper.setActive(self._noneGO, not isAssist)
	gohelper.setActive(self._heroGO, isAssist)
	self.simageAssistLock:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))
	gohelper.setActive(self._lvnum, not isAssist)
	UISpriteSetMgr.instance:setCommonSprite(self.imageAssistCareer, "lssx_" .. tostring(heroConfig.career))
end

function AbyssHeroGroupHeroItem:checkUsed()
	local curStageMo = AbyssModel.instance:getCurStageMo()
	local haveChallenge = curStageMo:isChallenged()

	if haveChallenge then
		return
	end

	local actInfoMo = AbyssModel.instance:getCurInfoMo()

	if actInfoMo:isHeroUsed(self._heroMO.config.id, curStageMo.lastUpdateTime) then
		return self._heroMO.id
	end
end

return AbyssHeroGroupHeroItem
