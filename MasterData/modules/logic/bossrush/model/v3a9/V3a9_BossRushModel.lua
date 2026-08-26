-- chunkname: @modules/logic/bossrush/model/v3a9/V3a9_BossRushModel.lua

module("modules.logic.bossrush.model.v3a9.V3a9_BossRushModel", package.seeall)

local V3a9_BossRushModel = class("V3a9_BossRushModel", BaseModel)

function V3a9_BossRushModel:init()
	self:reInit()
end

function V3a9_BossRushModel:reInit()
	self._openMode = V3a9BossRushEnum.Mode.Act
	self._bossMosList = nil
	self._heroUIds = {}
	self._equipUIds = {}
	self._bossdetailMos = nil
	self._editorHeroList = nil
	self._edtiorAssistMo = nil
	self._stage = nil
	self._actId = nil
	self._maxTotalLatestPoint = nil
end

function V3a9_BossRushModel:isActOnLine()
	local actIds = BossRushConfig.instance:getActivityIds()

	for _, actId in ipairs(actIds) do
		if ActivityHelper.isOpen(actId) then
			return true
		end
	end
end

function V3a9_BossRushModel:refreshBossDetailMos(msg)
	self._bossdetailMos = self._bossdetailMos or {}

	local activityId = msg.activityId

	self._bossdetailMos[activityId] = self._bossdetailMos[activityId] or {}

	for _, v in ipairs(msg.bossDetail) do
		local stage = v.bossId
		local mo = self._bossdetailMos[activityId][stage]

		if not mo then
			mo = BossRushBossDetailMO.New()
			self._bossdetailMos[activityId][stage] = mo
		end

		mo:initInfo(activityId, v)
	end

	self:refreshBoss(activityId)

	self._maxTotalLatestPoint = self._maxTotalLatestPoint or {}
	self._maxTotalLatestPoint[activityId] = msg.maxTotalLatestPoint
end

function V3a9_BossRushModel:getBossDetailMos(activityId)
	if not self._bossdetailMos then
		return
	end

	return self._bossdetailMos[activityId]
end

function V3a9_BossRushModel:getStageMo(actId, stage)
	local bossDetailMos = self:getBossDetailMos(actId)

	return bossDetailMos and bossDetailMos[stage]
end

function V3a9_BossRushModel:onRefresh128InfosReply(msg)
	local isActivityModeOpen = msg and msg.isActivityModeOpen

	if isActivityModeOpen then
		local actId = BossRushConfig.instance:getActivityId(V3a9BossRushEnum.Mode.Act)

		if actId and ActivityHelper.isOpen(actId) then
			self._openMode = V3a9BossRushEnum.Mode.Act

			return
		end
	end

	self._openMode = V3a9BossRushEnum.Mode.Normal
end

function V3a9_BossRushModel:defaultMode()
	local actId = BossRushConfig.instance:getActivityId(V3a9BossRushEnum.Mode.Act)

	if actId and ActivityHelper.isOpen(actId) then
		return V3a9BossRushEnum.Mode.Act
	end

	return V3a9BossRushEnum.Mode.Normal
end

function V3a9_BossRushModel:getMode()
	return self._openMode or self:defaultMode()
end

function V3a9_BossRushModel:refreshBoss(actId)
	local bossDetailMos = self:getBossDetailMos(actId)

	self._bossMosList = self._bossMosList or {}
	self._bossMosList[actId] = {}
	self._bossMosList[actId].detailMoList = {}

	local detailMoList = self._bossMosList[actId].detailMoList
	local totalScore = 0

	if bossDetailMos then
		for _, mo in pairs(bossDetailMos) do
			table.insert(detailMoList, mo)

			totalScore = totalScore + mo.latestPoint

			local stage = mo.stage

			self:refreshShowHeroEquips(stage)
		end

		table.sort(detailMoList, function(a, b)
			return a.stage < b.stage
		end)
	end

	self._bossMosList[actId].totalScore = totalScore
end

function V3a9_BossRushModel:getStageMos(actId)
	if not self._bossMosList then
		return
	end

	if self._bossMosList[actId] and self._bossMosList[actId].detailMoList then
		return self._bossMosList[actId].detailMoList
	end
end

function V3a9_BossRushModel:getTotalScore(actId)
	if not self._bossMosList then
		return 0
	end

	if self._bossMosList[actId] then
		return self._bossMosList[actId].totalScore
	end

	return 0
end

function V3a9_BossRushModel:getHeightScore(actId)
	return (self._maxTotalLatestPoint or nil) and (self._maxTotalLatestPoint[actId] or 0)
end

function V3a9_BossRushModel:getActModeActId()
	return (BossRushConfig.instance:getActivityId(V3a9BossRushEnum.Mode.Act))
end

function V3a9_BossRushModel:getHeroGroupSnapshotType()
	return ModuleEnum.HeroGroupSnapshotType.BossRushActMode
end

function V3a9_BossRushModel:setSelectGroupIndex(index)
	local heroGroupSnapshotType = self:getHeroGroupSnapshotType()

	HeroGroupSnapshotModel.instance:setSelectIndex(heroGroupSnapshotType, index)
end

function V3a9_BossRushModel:getSelectGroupIndex()
	local heroGroupSnapshotType = self:getHeroGroupSnapshotType()

	return HeroGroupSnapshotModel.instance:getSelectIndex(heroGroupSnapshotType) or 1
end

function V3a9_BossRushModel:getCurGroupMO()
	local heroGroupSnapshotType = self:getHeroGroupSnapshotType()
	local groupIndex = self:getSelectGroupIndex()
	local heroGroupMO = HeroGroupSnapshotModel.instance:getHeroGroupInfo(heroGroupSnapshotType, groupIndex)

	if not heroGroupMO then
		HeroGroupSnapshotModel.instance:addHeroGroup(heroGroupSnapshotType, groupIndex, HeroGroupMO.New())

		heroGroupMO = HeroGroupSnapshotModel.instance:getHeroGroupInfo(heroGroupSnapshotType)
	end

	return heroGroupMO
end

function V3a9_BossRushModel:refreshShowHeroEquips(stage)
	self:setSelectGroupIndex(stage)

	self._heroUIds = self._heroUIds or {}
	self._equipUIds = self._equipUIds or {}
	self._heroUIds[stage] = {}
	self._equipUIds[stage] = {}

	local heroGroupMO = self:getCurGroupMO()
	local actModeTeam = self:getActModeTeam(stage)

	for i = 1, V3a9BossRushEnum.HeroCount do
		local info = actModeTeam and actModeTeam:getHeroInfo(i)

		if info then
			self._heroUIds[stage][i] = info.uid or "0"
		end
	end

	self:refreshShowEquips(stage)
	self:refreshDeathHeros(stage)
	V3a9_BossRushExpandBondModel.instance:refreshExpandBondGroup(stage)
end

function V3a9_BossRushModel:refreshShowEquips(stage)
	local heroGroupMO = self:getCurGroupMO()
	local equips = heroGroupMO.equips

	for i = 0, #equips do
		local info = equips[i]

		if info and info.equipUid then
			if not info.equipUid[1] then
				self._equipUIds[stage][i + 1] = "0"
			end
		end
	end
end

function V3a9_BossRushModel:modifyHeroGroup(stage, uid, index)
	for i, _uid in pairs(self._heroUIds[stage]) do
		if index ~= i and _uid == uid then
			self._heroUIds[stage][i] = "0"
		end
	end

	self._heroUIds[stage][index] = uid

	V3a9_BossRushExpandBondModel.instance:refreshExpandBondGroup(stage)
	self:_saveTeamHero()
end

function V3a9_BossRushModel:quickModifyHeroGroup(stage, list)
	self._heroUIds[stage] = {}

	for i, uid in pairs(list) do
		self._heroUIds[stage][i] = uid
	end

	V3a9_BossRushExpandBondModel.instance:refreshExpandBondGroup(stage)
	self:_saveTeamHero()
end

function V3a9_BossRushModel:replaceFrontHeroGroup(heroUids, equiplist)
	self._heroUIds = self._heroUIds or {}

	local stage, actId = self:getEnterActStage()

	self._heroUIds[stage] = self._heroUIds[stage] or {}

	local actModeTeam = self:getActModeTeam(stage, actId)

	for i, uid in ipairs(heroUids) do
		local heroMo = HeroModel.instance:getById(uid)
		local heroPos = heroMo and actModeTeam:isBackHero(heroMo.heroId)

		if heroPos then
			uid = "0"
		end

		self._heroUIds[stage][i] = uid
	end

	V3a9_BossRushExpandBondModel.instance:refreshExpandBondGroup(stage)
	self:quickModifyHeroEquip(stage, heroUids, equiplist)
	self:_saveTeamHero()
end

function V3a9_BossRushModel:quickModifyHeroEquip(stage, heroUids, equiplist)
	local heroGroupMo = self:getCurGroupMO()
	local heroMo
	local heroGroupEquipMoList = heroGroupMo.equips

	if equiplist then
		heroGroupMo.equips = tabletool.copy(equiplist)
	else
		for index, heroUid in ipairs(heroUids) do
			heroMo = HeroModel.instance:getById(heroUid)

			if heroMo and heroMo:hasDefaultEquip() then
				for _, heroGroupEquipMo in pairs(heroGroupEquipMoList) do
					if heroGroupEquipMo.equipUid[1] == heroMo.defaultEquipUid then
						heroGroupEquipMo.equipUid[1] = "0"

						break
					end
				end

				if heroGroupEquipMoList[index - 1] and heroGroupEquipMoList[index - 1].equipUid then
					heroGroupEquipMoList[index - 1].equipUid[1] = heroMo.defaultEquipUid
				end
			end
		end
	end

	self:refreshShowEquips(self._stage)
end

function V3a9_BossRushModel:getDeathHeros()
	return self._deathHeroDict
end

function V3a9_BossRushModel:isDeathHero(heroId)
	return self._deathHeroDict[heroId]
end

function V3a9_BossRushModel:refreshDeathHeros(stage, isIgnoreChallenge)
	self._deathHeroDict = {}

	local actId = self:getActModeActId()

	if not actId then
		return
	end

	local stageMo = self:getStageMo(actId, stage)

	if not stageMo then
		return
	end

	for _stage, uids in pairs(self._heroUIds) do
		local _stageMo = self:getStageMo(actId, _stage)

		if _stage ~= stage and _stageMo then
			local assistMo = self:getAssistMo(_stage, actId)

			if _stageMo:isChallenge() then
				for i, uid in pairs(uids) do
					if tonumber(uid) > 0 and i > 4 then
						if assistMo and assistMo.heroUid == uid then
							self._deathHeroDict[assistMo.heroId] = true
						else
							local heroMo = HeroModel.instance:getById(uid)

							if heroMo then
								self._deathHeroDict[heroMo.heroId] = true
							end
						end
					end
				end
			end
		end
	end
end

function V3a9_BossRushModel:addTeamHero(stage, index, uid)
	self._heroUIds[stage] = self._heroUIds[stage] or {}
	self._heroUIds[stage][index] = uid

	V3a9_BossRushExpandBondModel.instance:refreshExpandBondGroup(stage)
	self:_saveTeamHero()
end

function V3a9_BossRushModel:exchangeHero(stage, a, b)
	self._heroUIds[stage][a] = self._heroUIds[stage][b]
	self._heroUIds[stage][b] = self._heroUIds[stage][a]

	V3a9_BossRushExpandBondModel.instance:refreshExpandBondGroup(stage)
	self:_saveTeamHero()
end

function V3a9_BossRushModel:_saveTeamHero(callback, callbackobj)
	local stage, actId = self:getEnterActStage()
	local uids = self._heroUIds[stage]
	local stageMos = self:getBossDetailMos(actId)
	local actModeTeam = self:getActModeTeam(stage)

	actModeTeam:saveHeroList(uids, self._edtiorAssistMo)

	local heroIds = self:getHeroIds(stage)
	local otherBoss = {}

	for i = 5, 8 do
		local heroId = heroIds[i]

		if heroId then
			for _stage, mo in pairs(stageMos) do
				if _stage ~= stage and not mo:isChallenge() then
					local _actModeTeam = mo.actModeTeam
					local backHeroIndex = _actModeTeam:isBackHero(heroId)

					if backHeroIndex ~= nil then
						_actModeTeam:removeHero(backHeroIndex)

						otherBoss[_stage] = true
					end
				end
			end
		end
	end

	if LuaUtil.tableNotEmpty(otherBoss) then
		for _stage in pairs(otherBoss) do
			BossRushRpc.instance:sendSetAct128TeamRequest(actId, _stage)
		end

		GameFacade.showToast(ToastEnum.BossRushHeroRestrict3)
	end

	BossRushRpc.instance:sendSetAct128TeamRequest(actId, stage, callback, callbackobj)

	local heroGroupMO = self:getCurGroupMO()

	heroGroupMO.heroList = uids

	V3a9_BossRushController.instance:saveCurGroupData(heroGroupMO)
end

function V3a9_BossRushModel:_saveEquips(stage, callback, callbackObj)
	local heroGroupMO = self:getCurGroupMO()

	heroGroupMO.equips = {}

	for i = 1, 4 do
		heroGroupMO.equips[i - 1] = {}

		local var_32_0 = {}

		var_32_0[1] = self._equipUIds[stage][i] or "0"
		heroGroupMO.equips[i - 1].equipUid = var_32_0
	end

	V3a9_BossRushController.instance:saveCurGroupData(heroGroupMO, callback, callbackObj)
end

function V3a9_BossRushModel:exchangeEquips(stage, a, b)
	self._equipUIds[stage][a] = self._equipUIds[stage][b]
	self._equipUIds[stage][b] = self._equipUIds[stage][a]

	self:_saveEquips(stage)
end

function V3a9_BossRushModel:replaceEquips(stage, uid, index)
	if not stage or not index then
		return
	end

	self._equipUIds[stage] = self._equipUIds[stage] or {}

	for i, _uid in pairs(self._equipUIds[stage]) do
		if index == i then
			self._equipUIds[stage][index] = uid
		elseif _uid == uid then
			self._equipUIds[stage][i] = "0"
		end
	end

	self._equipUIds[stage][index] = uid

	self:_saveEquips(stage)
end

function V3a9_BossRushModel:getHeroUIds(stage)
	return self._heroUIds[stage]
end

function V3a9_BossRushModel:getEquipUIds(stage)
	return self._equipUIds[stage]
end

function V3a9_BossRushModel:getActModeTeam(stage, actId)
	local _stage, _, _actId = BossRushModel.instance:getBattleStageAndLayer()

	stage = stage or _stage
	actId = actId or _actId or self:getActModeActId()

	local stageMo = self:getStageMo(actId, stage)

	return stageMo and stageMo.actModeTeam
end

function V3a9_BossRushModel:onRefreshActModeTeam(msg)
	local activityId = msg.activityId
	local bossId = msg.bossId
	local stageMo = self:getStageMo(activityId, bossId)

	stageMo:onRefresh(msg)
	self:refreshEdtiorAssistMo()
	V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.onRefreshV3a9ModeTeamInfo)
	V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.OnModifyHeroGroup)
end

function V3a9_BossRushModel:onResetActModeTeam(msg)
	self:onRefreshActModeTeam(msg)
	self:refreshBoss(msg.activityId)
end

function V3a9_BossRushModel:setFightHeroGroup(actId)
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return false
	end

	local curGroupMO = self:getCurGroupMO()

	if not curGroupMO then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local main, mainCount = curGroupMO:getMainList()
	local sub, subCount = curGroupMO:getSubList()

	if (not curGroupMO.aidDict or #curGroupMO.aidDict <= 0) and mainCount + subCount == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local battleId = fightParam.battleId
	local battleConfig = battleId and lua_battle.configDict[battleId]

	if battleConfig and battleConfig.noClothSkill == 0 then
		if not curGroupMO.clothId then
			local clothId = 0
			local seasonEquips = SeasonFightHandler.getSeasonEquips(curGroupMO, fightParam)
			local assistMo = self:getAssistMo()

			if assistMo then
				for _, uid in ipairs(main) do
					if uid == assistMo.heroUid then
						fightParam:setAssistHeroInfo(assistMo.heroUid, assistMo.userId)
					end
				end
			end

			fightParam:setMySide(clothId, main, curGroupMO:getSubList(), curGroupMO:getAllHeroEquips(), seasonEquips, nil, nil, curGroupMO:getAssistBossId(), curGroupMO:getSaveParams())

			return true
		end
	end
end

function V3a9_BossRushModel:getGroupName()
	local list = {}
	local heroGroupSnapshotType = self:getHeroGroupSnapshotType()
	local teamCo = lua_hero_team.configDict[heroGroupSnapshotType]

	table.insert(list, teamCo.name)

	return list
end

function V3a9_BossRushModel:getGroupTypeName()
	local heroGroupSnapshotType = self:getHeroGroupSnapshotType()
	local heroGroupTypeCo = lua_hero_group_type.configDict[heroGroupSnapshotType]

	if not heroGroupTypeCo or heroGroupTypeCo.saveGroup == 0 then
		return
	end

	return heroGroupTypeCo.name
end

function V3a9_BossRushModel:getEnterActStage()
	if not self._stage or not self._actId then
		local episodeId = DungeonModel.instance.curSendEpisodeId
		local stage, _, actId = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

		self._actId = actId
		self._stage = stage
	end

	return self._stage, self._actId
end

function V3a9_BossRushModel:setEnterActStage(actId, stage)
	self._stage = stage
	self._actId = actId
end

function V3a9_BossRushModel:resetEditorHeroList()
	local stage = BossRushModel.instance:getBattleStageAndLayer()

	self._editorHeroList = self:getHeroUIds(stage)

	V3a9_BossRushExpandBondModel.instance:refreshExpandBondGroup()
end

function V3a9_BossRushModel:setEditorHeroList(heroList)
	self._editorHeroList = heroList

	local _heroIdList = self:getEditorHeroIdList()

	V3a9_BossRushExpandBondModel.instance:refreshEditorExpandBondGroup(_heroIdList)
end

function V3a9_BossRushModel:getEditorHeroList()
	local stage = BossRushModel.instance:getBattleStageAndLayer()

	return self._editorHeroList or self:getHeroUIds(stage)
end

function V3a9_BossRushModel:getEditorHeroIdList()
	local stage = BossRushModel.instance:getBattleStageAndLayer()

	if self._editorHeroList then
		return self:getHeroIds(stage, self._editorHeroList)
	end
end

function V3a9_BossRushModel:getHeroIds(stage, heroList)
	heroList = heroList or self:getHeroUIds(stage)

	local list = {}

	if heroList then
		for i, uid in pairs(heroList) do
			if uid and uid ~= "0" then
				local actId = self:getActModeActId()
				local assistMo = self:getAssistMo(stage, actId)
				local heroId

				if assistMo and assistMo.heroUid == uid then
					heroId = assistMo.heroId
				else
					local heroMo = HeroModel.instance:getById(uid)

					heroId = heroMo and heroMo.heroId
				end

				list[i] = heroId
			end
		end
	end

	return list
end

function V3a9_BossRushModel:getEditorEmptyPos()
	local heroList = self:getEditorHeroList()

	return self:getEmptyPos(heroList)
end

function V3a9_BossRushModel:getEmptyPos(heroList)
	local stage = BossRushModel.instance:getBattleStageAndLayer()

	heroList = heroList or self:getHeroUIds(stage)

	for i = 1, V3a9BossRushEnum.HeroCount do
		local uid = heroList and heroList[i]

		if not uid or tonumber(uid) == 0 then
			return i
		end
	end
end

function V3a9_BossRushModel:checkEmptyPos(heroId)
	local stage = BossRushModel.instance:getBattleStageAndLayer()
	local heroList = self:getHeroIds(stage)

	for i = 1, V3a9BossRushEnum.HeroCount do
		local _heroId = heroList and heroList[i]

		if not _heroId or _heroId == heroId then
			return i
		end
	end
end

function V3a9_BossRushModel:getEditorAssistPos(heroId)
	if not heroId then
		return
	end

	local stage = BossRushModel.instance:getBattleStageAndLayer()
	local heroList = self:getEditorHeroList()
	local heroIdList = self:getHeroIds(stage, heroList)

	for i, id in pairs(heroIdList) do
		if id == heroId then
			return i
		end
	end

	return self:getEditorEmptyPos()
end

function V3a9_BossRushModel:setAssistMo(assistMo)
	local emptyPos = self:getEditorAssistPos(assistMo and assistMo.heroId)
	local stage = BossRushModel.instance:getBattleStageAndLayer()
	local heroList = self:getHeroIds(stage)

	if emptyPos then
		heroList[emptyPos] = assistMo.heroId
	end

	self._edtiorAssistMo = assistMo

	V3a9_BossRushExpandBondModel.instance:refreshHeroList(heroList)
end

function V3a9_BossRushModel:clearAssistMo()
	local stage, actId = V3a9_BossRushModel.instance:getEnterActStage()

	if self._edtiorAssistMo then
		local editorList = self:getEditorHeroList()

		if editorList then
			for i, uid in pairs(editorList) do
				if uid == self._edtiorAssistMo.heroUid then
					editorList[i] = "0"
				end
			end
		end

		local actModeTeam = self:getActModeTeam()

		if actModeTeam then
			actModeTeam:clearAssistMo()
		end

		local uids = self:getHeroUIds(stage)

		if uids then
			for i, uid in ipairs(uids) do
				if self._edtiorAssistMo.heroUid == uid then
					uids[i] = "0"

					break
				end
			end
		end
	end

	BossRushRpc.instance:sendSetAct128TeamRequest(actId, stage)

	self._edtiorAssistMo = nil
end

function V3a9_BossRushModel:refreshEdtiorAssistMo()
	local stage, actId = self:getEnterActStage()

	self._edtiorAssistMo = self:getAssistMo(stage, actId)
end

function V3a9_BossRushModel:getEditorAssistMo(stage, actId)
	if not self._edtiorAssistMo then
		local actModeTeam = self:getActModeTeam(stage, actId)

		if actModeTeam then
			self._edtiorAssistMo = actModeTeam:getAssistMo()
		end
	end

	return self._edtiorAssistMo
end

function V3a9_BossRushModel:getAssistMo(stage, actId)
	local actModeTeam = self:getActModeTeam(stage, actId)

	if actModeTeam then
		return actModeTeam:getAssistMo()
	end
end

function V3a9_BossRushModel:getTeamHeroMo(index, stage)
	local _stage, actId = self:getEnterActStage()

	stage = stage or _stage

	if self._heroUIds[stage] then
		local uid = self._heroUIds[stage][index]

		if uid and uid ~= "0" then
			local assistMo = self:getAssistMo(stage, actId)

			if assistMo and assistMo.heroUid == uid then
				return assistMo, true
			else
				return (HeroModel.instance:getById(uid))
			end
		end
	end
end

function V3a9_BossRushModel:replaceCloth(clothId)
	local curGroupMO = self:getCurGroupMO()

	if curGroupMO then
		curGroupMO:replaceClothId(clothId)
	end
end

function V3a9_BossRushModel:getBonusProgress()
	local actId = self:getActModeActId()

	return V3a9_BossRushModel.instance:getHeightScore(actId)
end

function V3a9_BossRushModel:refreshSingleHasGetBonusIds(activityId, stage, rewardId)
	local stageMo = self:getStageMo(activityId, stage)

	stageMo:refreshHasGetBonusIds(rewardId)
end

function V3a9_BossRushModel:refreshHasGetBonusIds(activityId, stage, hasGetBonusIds)
	local stageMo = self:getStageMo(activityId, stage)

	for _, id in ipairs(hasGetBonusIds) do
		stageMo:refreshHasGetBonusIds(id)
	end
end

function V3a9_BossRushModel:isRestrict(heroId, index)
	if not heroId then
		return false
	end

	if index then
		if index < 5 then
			return
		end

		return self:isDeathHero(heroId)
	end

	local heroList = self:getEditorHeroIdList()

	if not heroList then
		local stage = self:getEnterActStage()
		local uids = self:getHeroUIds(stage)

		heroList = self:getHeroIds(stage, uids)
	end

	if heroList then
		for i = 1, V3a9BossRushEnum.HeroCount do
			local id = heroList[i]

			if not id and i < 5 then
				return false
			end

			if heroId == id then
				if i < 5 then
					return false
				else
					return self:isDeathHero(heroId)
				end
			end
		end
	end

	return self:isDeathHero(heroId)
end

function V3a9_BossRushModel:isCanAssist(mo)
	if self:isRestrict(mo.heroId) then
		return false
	end

	return true
end

function V3a9_BossRushModel:getHeightScoreEffect(score)
	score = score or self:getHeightScore()

	if not self._heightScoreEffect then
		local _, value = BossRushConfig.instance:getConst(V3a9BossRushEnum.HeightScoreEffectConst)

		self._heightScoreEffect = string.splitToNumber(value, "#")
	end

	for i = #self._heightScoreEffect, 1, -1 do
		if score >= self._heightScoreEffect[i] then
			return i
		end
	end

	return 0
end

V3a9_BossRushModel.instance = V3a9_BossRushModel.New()

return V3a9_BossRushModel
