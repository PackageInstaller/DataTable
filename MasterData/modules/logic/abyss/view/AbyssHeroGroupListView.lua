-- chunkname: @modules/logic/abyss/view/AbyssHeroGroupListView.lua

module("modules.logic.abyss.view.AbyssHeroGroupListView", package.seeall)

local AbyssHeroGroupListView = class("AbyssHeroGroupListView", HeroGroupListView)

function AbyssHeroGroupListView:addEvents()
	AbyssHeroGroupListView.super.addEvents(self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnResetStage, self.onResetStage, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._checkRestrictHero, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._checkRestrictHero, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnReadPreset, self.onReadPreset, self)
end

function AbyssHeroGroupListView:removeEvents()
	AbyssHeroGroupListView.super.removeEvents(self)
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnResetStage, self.onResetStage, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._checkRestrictHero, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._checkRestrictHero, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnReadPreset, self.onReadPreset, self)
end

function AbyssHeroGroupListView:_getHeroItemCls()
	return AbyssHeroGroupHeroItem
end

function AbyssHeroGroupListView:onOpen()
	self:checkReplaceHeroList()
	AbyssHeroGroupListView.super.onOpen(self)
	self:_checkRestrictHero()
end

function AbyssHeroGroupListView:onResetStage()
	return
end

function AbyssHeroGroupListView:onReadPreset()
	HeroSingleGroupModel.instance:setSingleGroup(HeroGroupModel.instance:getCurGroupMO(), true)
	self:checkReplaceHeroList()
	self:_updateHeroList()
	self:_checkRestrictHero()
end

function AbyssHeroGroupListView:checkReplaceHeroList()
	local infoMo = AbyssModel.instance:getCurStageMo()

	if infoMo:isChallenged() then
		if not infoMo.heroList then
			local heroIds = {}

			if not infoMo.equipDic then
				local equipUid = {}

				if not infoMo.trialHeros then
					local trialHeros = {}
					local heroList = {}

					for i = 1, #heroIds do
						local heroMo = HeroModel.instance:getByHeroId(heroIds[i] or 0)

						if heroMo then
							local trialId = trialHeros[i]

							if trialId and trialId > 0 then
								local trialCo = lua_hero_trial.configDict[trialId][0]
								local heroId = tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776)

								table.insert(heroList, {
									heroUid = heroId,
									equipUid = {
										tostring(trialCo.equipId)
									}
								})
							else
								local equipUids

								table.insert(heroList, {
									heroUid = heroMo.uid,
									equipUid = (equipUid[heroIds[i]] or nil) and equipUid[heroIds[i]]
								})
							end
						else
							for _, trialHeroId in ipairs(trialHeros) do
								if trialHeroId > 0 then
									local trialCo = lua_hero_trial.configDict[trialHeroId][0]

									if trialCo and trialCo.heroId == heroIds[i] then
										local heroId = tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776)

										table.insert(heroList, {
											heroUid = heroId,
											equipUid = {
												tostring(trialCo.equipId)
											}
										})

										break
									end
								end
							end
						end
					end

					local groupMO = HeroGroupModel.instance:getCurGroupMO()

					groupMO:replaceTowerHeroList(heroList)
					HeroSingleGroupModel.instance:setSingleGroup(groupMO, #heroList > 0)
				end
			end
		end
	else
		local groupMO = HeroGroupModel.instance:getCurGroupMO()
		local actInfoMo = AbyssModel.instance:getCurInfoMo()
		local removeList = {}

		for _, heroUid in ipairs(groupMO.heroList) do
			local heroMo = HeroModel.instance:getById(heroUid)

			if heroMo and actInfoMo:isHeroUsed(heroMo.heroId, infoMo.lastUpdateTime) then
				table.insert(removeList, heroUid)
			end
		end

		if removeList and next(removeList) then
			for i, id in ipairs(removeList) do
				HeroSingleGroupModel.instance:remove(id)
			end
		end
	end
end

function AbyssHeroGroupListView:_checkRestrictHero()
	local curStageMo = AbyssModel.instance:getCurStageMo()
	local haveChallenge = curStageMo:isChallenged()

	if haveChallenge then
		return
	end

	local list = {}

	for i, heroItem in ipairs(self._heroItemList) do
		local id = heroItem:checkAbyss()

		if id then
			table.insert(list, id)
		end
	end

	if #list == 0 then
		return
	end

	UIBlockMgr.instance:startBlock("removeTowerHero")

	self._heroInCdList = list

	TaskDispatcher.runDelay(self._removeAbyssHero, self, 1.5)
end

function AbyssHeroGroupListView:_removeAbyssHero()
	UIBlockMgr.instance:endBlock("removeTowerHero")

	if not self._heroInCdList then
		return
	end

	local list = self._heroInCdList

	self._heroInCdList = nil

	for i, id in ipairs(list) do
		HeroSingleGroupModel.instance:remove(id)
	end

	for _, heroItem in ipairs(self._heroItemList) do
		heroItem:resetGrayFactor()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:replaceSingleGroup()
end

function AbyssHeroGroupListView:canDrag(param, isWrap)
	if not AbyssHeroGroupListView.super.canDrag(self, param, isWrap) then
		return false
	end

	local infoMo = AbyssModel.instance:getCurStageMo()

	return not infoMo:isChallenged()
end

function AbyssHeroGroupListView:onDestroyView()
	UIBlockMgr.instance:endBlock("removeTowerHero")
	TaskDispatcher.cancelTask(self._removeAbyssHero, self)
	AbyssHeroGroupListView.super.onDestroyView(self)
end

return AbyssHeroGroupListView
