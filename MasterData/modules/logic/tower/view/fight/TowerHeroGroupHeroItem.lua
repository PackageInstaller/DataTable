-- chunkname: @modules/logic/tower/view/fight/TowerHeroGroupHeroItem.lua

module("modules.logic.tower.view.fight.TowerHeroGroupHeroItem", package.seeall)

local TowerHeroGroupHeroItem = class("TowerHeroGroupHeroItem", HeroGroupHeroItem)

function TowerHeroGroupHeroItem:init(go)
	TowerHeroGroupHeroItem.super.init(self, go)

	self.goAssistLock = gohelper.findChild(go, "heroitemani/hero/#assist_lock")
	self.simageAssistLock = gohelper.findChildSingleImage(go, "heroitemani/hero/#assist_lock/character")
end

function TowerHeroGroupHeroItem:checkTower()
	if HeroGroupModel.instance.heroGroupType ~= ModuleEnum.HeroGroupType.General then
		return
	end

	if self._heroMO ~= nil and self.monsterCO == nil then
		if TowerModel.instance:isHeroLocked(self._heroMO.config.id) then
			self._commonHeroCard:setGrayScale(false)
		elseif TowerModel.instance:isHeroBan(self._heroMO.config.id) then
			self._playDeathAnim = true

			self:playAnim("herogroup_hero_deal")

			self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)

			return self._heroMO.id
		else
			self._commonHeroCard:setGrayScale(false)
		end
	elseif self.trialCO ~= nil then
		if TowerModel.instance:isHeroLocked(self.trialCO.heroId) then
			self._commonHeroCard:setGrayScale(false)
		elseif TowerModel.instance:isHeroBan(self.trialCO.heroId) then
			self._playDeathAnim = true

			self:playAnim("herogroup_hero_deal")

			self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)

			return tostring(tonumber(self.trialCO.id .. "." .. self.trialCO.trialTemplate) - 1099511627776)
		else
			self._commonHeroCard:setGrayScale(false)
		end
	end
end

function TowerHeroGroupHeroItem:onUpdateMO(mo)
	TowerHeroGroupHeroItem.super.onUpdateMO(self, mo)

	self.heroIndex = self.heroIndex or self.mo.id

	local param = TowerModel.instance:getRecordFightParam()
	local curPermanentMo = TowerModel.instance:getCurPermanentMo()
	local subEpisodeMo = curPermanentMo:getSubEpisodeMoByEpisodeId(param.episodeId)

	if param and param.isHeroGroupLock then
		if not param.assistSkinIds then
			local assistSkinIds = {}

			if assistSkinIds[self.heroIndex] and assistSkinIds[self.heroIndex] > 0 then
				local skinId = assistSkinIds[self.heroIndex]
				local skinConfig = FightConfig.instance:getSkinCO(skinId)

				self._commonHeroCard:setGrayFactor(1)
				self._commonHeroCard:onUpdateMO(skinConfig)
				gohelper.setActive(self._commonHeroCard._go, false)
				gohelper.setActive(self.goAssistLock, true)
				self.simageAssistLock:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))
				gohelper.setActive(self._goStars, false)

				for i = 1, 3 do
					local rankGO = self._goRankList[i]

					gohelper.setActive(rankGO, false)
				end

				gohelper.setActive(self._heroGO, true)
				gohelper.setActive(self._noneGO, false)
				gohelper.setActive(self._trialTagGO, true)

				self._lvnum.text = ""

				local heroId = param.heros[self.heroIndex]
				local heroCo = HeroConfig.instance:getHeroCO(heroId)

				UISpriteSetMgr.instance:setCommonSprite(self._careericon, "lssx_" .. tostring(heroCo.career))
			elseif subEpisodeMo and subEpisodeMo.heros and subEpisodeMo.heros[self.heroIndex] and subEpisodeMo.heros[self.heroIndex].trialId > 0 then
				local trialId = subEpisodeMo.heros[self.heroIndex].trialId
				local trialConfig = lua_hero_trial.configDict[trialId][0]
				local heroCo = HeroConfig.instance:getHeroCO(trialConfig.heroId)
				local skinConfig = trialConfig.skin > 0 and SkinConfig.instance:getSkinCo(trialConfig.skin) or SkinConfig.instance:getSkinCo(heroCo.skinId)

				self._commonHeroCard:setGrayFactor(1)
				self._commonHeroCard:onUpdateMO(skinConfig)
				gohelper.setActive(self._commonHeroCard._go, false)
				gohelper.setActive(self.goAssistLock, true)
				self.simageAssistLock:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))
				gohelper.setActive(self._goStars, false)

				for i = 1, 3 do
					local rankGO = self._goRankList[i]

					gohelper.setActive(rankGO, false)
				end

				gohelper.setActive(self._heroGO, true)
				gohelper.setActive(self._noneGO, false)
				gohelper.setActive(self._trialTagGO, true)
				UISpriteSetMgr.instance:setCommonSprite(self._careericon, "lssx_" .. tostring(heroCo.career))

				local showLevel, rank = HeroConfig.instance:getShowLevel(trialConfig.level)

				self._lvnum.text = showLevel
			end
		end
	else
		gohelper.setActive(self._commonHeroCard._go, true)

		if self.goAssistLock then
			gohelper.setActive(self.goAssistLock, false)
		end
	end
end

function TowerHeroGroupHeroItem:onDestroy()
	TowerHeroGroupHeroItem.super.onDestroy(self)

	if self.simageAssistLock then
		self.simageAssistLock:UnLoadImage()
	end
end

return TowerHeroGroupHeroItem
