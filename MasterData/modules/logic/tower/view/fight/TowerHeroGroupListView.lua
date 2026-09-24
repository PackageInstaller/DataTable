-- chunkname: @modules/logic/tower/view/fight/TowerHeroGroupListView.lua

module("modules.logic.tower.view.fight.TowerHeroGroupListView", package.seeall)

local TowerHeroGroupListView = class("TowerHeroGroupListView", HeroGroupListView)

function TowerHeroGroupListView:addEvents()
	TowerHeroGroupListView.super.addEvents(self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnLoadTeamSuccess, self._checkRestrictHero, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnTowerResetSubEpisode, self._updateHeroList, self)
end

function TowerHeroGroupListView:removeEvents()
	TowerHeroGroupListView.super.removeEvents(self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnLoadTeamSuccess, self._checkRestrictHero, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnTowerResetSubEpisode, self._updateHeroList, self)
end

function TowerHeroGroupListView:_getHeroItemCls()
	return TowerHeroGroupHeroItem
end

function TowerHeroGroupListView:onOpen()
	self:checkReplaceHeroList()
	TowerHeroGroupListView.super.onOpen(self)
end

function TowerHeroGroupListView:checkReplaceHeroList()
	local param = TowerModel.instance:getRecordFightParam()

	if param.isHeroGroupLock then
		if not param.heros then
			if not param.equipUids then
				local equipUids = {}
				local assistBoss = param.assistBoss

				if not param.trialHeros then
					local trialHeros = {}
					local heroList = {}

					if not param.assistSkinIds then
						for i = 1, #param.heros do
							if not param.assistSkinIds[i] then
								local heroInfo = {
									heroUid = "0",
									equipUid = equipUids[i]
								}

								heroList[i] = heroInfo

								if param.assistSkinIds[i] == 0 then
									local heroMo = HeroModel.instance:getByHeroId(param.heros[i] or 0)

									if heroMo then
										local trialId = trialHeros[i]

										if trialId and trialId > 0 then
											local trialCo = lua_hero_trial.configDict[trialId][0]

											heroInfo.heroUid = tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776)
											heroInfo.equipUid = {
												tostring(trialCo.equipId)
											}
										else
											heroInfo.heroUid = heroMo.uid
										end
									else
										for _, trialHeroId in ipairs(trialHeros) do
											if trialHeroId > 0 then
												local trialCo = lua_hero_trial.configDict[trialHeroId][0]

												if trialCo and trialCo.heroId == param.heros[i] then
													heroInfo.heroUid = tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776)
													heroInfo.equipUid = {
														tostring(trialCo.equipId)
													}

													break
												end
											end
										end
									end
								end
							end
						end

						local groupMO = HeroGroupModel.instance:getCurGroupMO()

						groupMO:replaceTowerHeroList(heroList, true)
						groupMO:setAssistBossId(assistBoss)
						HeroSingleGroupModel.instance:setSingleGroup(groupMO, #heroList > 0)
					end
				end
			end
		end
	end
end

function TowerHeroGroupListView:_checkRestrictHero()
	local param = TowerModel.instance:getRecordFightParam()

	if param.isHeroGroupLock then
		return
	end

	local list = {}

	for i, heroItem in ipairs(self._heroItemList) do
		local id = heroItem:checkTower()

		if id then
			table.insert(list, id)
		end
	end

	if #list == 0 then
		return
	end

	UIBlockMgr.instance:startBlock("removeTowerHero")

	self._heroInCdList = list

	TaskDispatcher.runDelay(self._removeTowerHero, self, 1.5)
end

function TowerHeroGroupListView:_removeTowerHero()
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

function TowerHeroGroupListView:canDrag(param, isWrap)
	if not TowerHeroGroupListView.super.canDrag(self, param, isWrap) then
		return false
	end

	return true
end

function TowerHeroGroupListView:onDestroyView()
	UIBlockMgr.instance:endBlock("removeTowerHero")
	TaskDispatcher.cancelTask(self._removeTowerHero, self)
	TowerHeroGroupListView.super.onDestroyView(self)
end

return TowerHeroGroupListView
