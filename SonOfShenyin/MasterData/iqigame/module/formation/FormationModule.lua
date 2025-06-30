-- chunkname: @IQIGame\\Module\\Formation\\FormationModule.lua

FormationModule = {
	TeamIndex = 0,
	NormalFormationCount = 0,
	MaxFormationCount = 5,
	FormationTypeIsMaze = false,
	FormationInTheMaze = false,
	HelpHeroIndex = -1,
	IsQuickFormation = false,
	FormationDataList = {},
	CurFormationDataList = {},
	ExChangeBoxData = {}
}

function FormationModule.Reload(pod)
	FormationModule.NormalFormationCount = table.len(pod)

	for k, v in pairs(pod) do
		FormationModule.FormationDataList[v.cid] = v
	end

	FormationModule.InitLocalRedDotData()
end

function FormationModule.GetFixFormationData(formationCid)
	local formationCfg = CfgFormationTable[formationCid]
	local formationData = {}

	for i = 1, #formationCfg.SeatValue do
		if formationCfg.SeatValue[i] == 0 then
			formationData[i] = nil
		else
			formationData[i] = FormationModule.CreateHeroByMonster(formationCfg.SeatValue[i])
		end
	end

	return formationData
end

function FormationModule.CreateHeroByMonster(monsterCid)
	local WarlockData = WarlockData.New()
	local skills = {}
	local cfgSkills = CfgMonsterTable[monsterCid].Skill

	for j = 1, #cfgSkills do
		local skillData = SkillData.New()

		skillData.virtual = true

		local itemCid = cfgSkills[j]
		local data = {
			strengLv = 1,
			lv = 1,
			skillCid = itemCid
		}

		skillData:UpdateData(data)

		skillData.heroPos = j
		skills[j] = skillData
	end

	local attrs = {}
	local cfgAttrs = CfgMonsterTable[monsterCid].Attribute

	for j = 1, #cfgAttrs, 2 do
		attrs[cfgAttrs[j]] = cfgAttrs[j + 1]
	end

	local data = {
		cid = monsterCid,
		lv = CfgMonsterTable[monsterCid].Level,
		SkillGroups = skills,
		AttributeGroups = attrs
	}

	WarlockData:CreateTemporaryData(data)

	WarlockData.isTempHeroData = true
	WarlockData.MonsterId = monsterCid

	return WarlockData
end

function FormationModule.GetGointoListMaxLv()
	local heros = FormationModule.CurFormationDataList
	local maxLv = 0

	for k, v in pairs(heros) do
		maxLv = math.max(maxLv, v.lv)
	end

	return maxLv
end

function FormationModule.GetCurFormationHeroData(heroCid)
	local result

	ForPairs(FormationModule.CurFormationDataList, function(k, v)
		if v.cid ~= heroCid then
			return
		end

		result = v

		return true
	end)

	return result
end

function FormationModule.GetIsMaxGointo()
	return table.len(FormationModule.CurFormationDataList) >= FormationModule.MaxFormationCount
end

function FormationModule.CheckEndDragGridIndex(eventData_go)
	if eventData_go == nil then
		return -1
	end

	local gameObjectName = eventData_go.transform.parent.name
	local index = -1

	if string.find(gameObjectName, "Box_") ~= nil then
		local str = string.gsub(gameObjectName, "Box_", "")

		index = tonumber(str)
	end

	return index
end

function FormationModule.GetFormationTerrainData(dupStage, friendly)
	local monsterTeamData = CfgMonsterTeamTable[dupStage.MonsterTeam[1]]
	local mapId = friendly and monsterTeamData.MapIdFriendly or monsterTeamData.MapIdEnemy
	local map = CfgMapTable[mapId]

	return map
end

function FormationModule.GetFormationEnvironmentBuff(dupStage, friendly)
	return dupStage.EnvironmentBuff
end

function FormationModule.GetAllTerrainType(mapType)
	local types = {}

	for k, v in pairs(mapType) do
		if v ~= 0 and table.indexOf(types, v) == -1 then
			table.insert(types, v)
		end
	end

	return types
end

function FormationModule.GetTerrainIsCanGointo(index, friendly)
	if FormationModule.FormationInTheMaze or FormationModule.FormationTypeIsMaze then
		return {
			Used = Constant.FormationGointoBattleType.NORMAL
		}
	end

	local monsterTeamData = CfgMonsterTeamTable[FormationModule.CfgDupStageOrStoryBattleCfg.MonsterTeam[1]]

	if friendly then
		return CfgTerrainTable[CfgMapTable[monsterTeamData.MapIdFriendly].MapType[index]]
	else
		local idx = index

		if index < 4 then
			idx = index + 6
		elseif index > 6 then
			idx = index - 6
		end

		return CfgTerrainTable[CfgMapTable[monsterTeamData.MapIdEnemy].MapType[idx]]
	end
end

function FormationModule.GetIsInPresetListByHeroCid(formationCid, heroCid)
	local presetFormationList = FormationModule.FormationDataList[formationCid].presetHcid

	for k, v in pairs(presetFormationList) do
		if v == heroCid then
			return k
		end
	end

	return -1
end

function FormationModule.InitCurFormationData()
	FormationModule.CurFormationDataList = {}

	if FormationModule.FormationTypeIsMaze then
		local heros = MazeModule.GetCurStagePOD().formationPOD.heros
		local heroDataList = FormationModule.GetHeroDataList()

		for k, v in pairs(heros) do
			FormationModule.CurFormationDataList[k] = heroDataList[v]
		end
	elseif FormationModule.TeamIndex <= FormationModule.NormalFormationCount then
		local heros = FormationModule.FormationDataList[FormationModule.TeamIndex].heros

		for k, v in pairs(heros) do
			FormationModule.CurFormationDataList[k] = WarlockModule.WarlockDataDic[v]
		end

		local helpHeros = FormationModule.FormationDataList[FormationModule.TeamIndex].helpHeros

		for k, v in pairs(helpHeros) do
			local heroData = WarlockData.New()

			heroData:CreateTemporaryData(v, true)

			heroData.pid = v.pid
			heroData.serverId = v.serverId
			heroData.SkillGroups = v.skill
			heroData.AttributeGroups = v.attr
			FormationModule.CurFormationDataList[k] = heroData
		end
	else
		local fixedFormationData = FormationModule.GetFixFormationData(FormationModule.TeamIndex)

		for k, v in pairs(fixedFormationData) do
			FormationModule.CurFormationDataList[k] = v
		end
	end

	EventDispatcher.Dispatch(EventID.NotifyFormationDataChangeEvent)
end

function FormationModule.UpdateCurFormationData(index, data)
	FormationModule.CurFormationDataList[index] = data
end

function FormationModule.ClearCacheHelpHero()
	for k, v in pairs(FormationModule.CurFormationDataList) do
		if v.isHelpHeroData then
			FormationModule.CurFormationDataList[k] = nil
		end
	end
end

function FormationModule.NotifyFormationChange()
	local heros = {}
	local helpHeros = {}
	local attackOrder = {}
	local agentSkill = {}
	local isNotifity = false

	if FormationModule.FormationTypeIsMaze then
		isNotifity = true

		for k, v in pairs(FormationModule.CurFormationDataList) do
			if not v.isTempHeroData and not v.isHelpHeroData then
				heros[k] = v.cid
			end
		end

		attackOrder = FormationModule.AllAttackOrder
		agentSkill = MazeModule.GetCurStagePOD().formationPOD.agentSkill
	else
		if FormationModule.TeamIndex <= FormationModule.NormalFormationCount then
			isNotifity = true

			for k, v in pairs(FormationModule.CurFormationDataList) do
				if not v.isTempHeroData and not v.isHelpHeroData then
					heros[k] = v.cid
				end

				if v.isHelpHeroData then
					helpHeros[k] = v
				end
			end

			if table.len(helpHeros) > 0 then
				for k, v in pairs(helpHeros) do
					if FormationModule.GetHelpHeroIndex(k) == false then
						FormationModule.ClearHelpHero(FormationModule.TeamIndex)
						FormationModule.ChooseHelpHero(FormationModule.TeamIndex, k, v)
					end
				end
			elseif FormationModule.GetIsGointoHelpHero() then
				FormationModule.ClearHelpHero(FormationModule.TeamIndex)
			end
		end

		attackOrder = FormationModule.FormationDataList[FormationModule.TeamIndex].attackOrder
		agentSkill = FormationModule.FormationDataList[FormationModule.TeamIndex].agentSkill
	end

	if isNotifity then
		FormationModule.SaveFormation(FormationModule.TeamIndex, heros, helpHeros, attackOrder, agentSkill)
	end

	EventDispatcher.Dispatch(EventID.NotifyFormationDataChangeEvent)
end

function FormationModule.GetIsGointoHelpHero()
	if FormationModule.FormationDataList[FormationModule.TeamIndex].helpHeros == nil then
		return false
	end

	return table.len(FormationModule.FormationDataList[FormationModule.TeamIndex].helpHeros) > 0
end

function FormationModule.GetHelpHeroIndex(index)
	return FormationModule.FormationDataList[FormationModule.TeamIndex].helpHeros[index] ~= nil
end

function FormationModule.CheckIsHasSameCid(heroCid)
	for k, v in pairs(FormationModule.CurFormationDataList) do
		if v.cid == heroCid then
			return true, k
		end
	end

	return false, -1
end

function FormationModule.RefreshExChangeBoxData(index, heroData)
	if FormationModule.ExChangeBoxData[1] == nil then
		if heroData == nil then
			return
		end

		FormationModule.ExChangeBoxData[1] = {
			index = index,
			heroData = heroData
		}

		EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, index)
	else
		if FormationModule.ExChangeBoxData[2] == nil then
			local var_21_0 = FormationModule.ExChangeBoxData
			local var_21_1 = {
				index = index
			}

			if heroData == nil then
				-- block empty
			end

			var_21_1.heroData = heroData
			var_21_0[2] = var_21_1
		end

		EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, false)

		if FormationModule.ExChangeBoxData[1].index == FormationModule.ExChangeBoxData[2].index then
			FormationModule.InitExChangeBoxData()

			return
		end

		FormationModule.UpdateCurFormationData(FormationModule.ExChangeBoxData[1].index, FormationModule.ExChangeBoxData[2].heroData)
		FormationModule.UpdateCurFormationData(FormationModule.ExChangeBoxData[2].index, FormationModule.ExChangeBoxData[1].heroData)

		if FormationModule.TeamIndex <= FormationModule.NormalFormationCount then
			FormationModule.NotifyFormationChange()
		end

		FormationModule.InitExChangeBoxData()
	end
end

function FormationModule.InitExChangeBoxData()
	FormationModule.ExChangeBoxData = {}
end

function FormationModule.CreateFightData()
	local List = {}

	for k, v in pairs(FormationModule.CurFormationDataList) do
		local AttackUnitPOD = {}

		if v.isTempHeroData then
			AttackUnitPOD.type = 2
			AttackUnitPOD.val = v.MonsterId
		elseif v.isHelpHeroData then
			AttackUnitPOD.type = 3
			AttackUnitPOD.val = v.cid
		else
			AttackUnitPOD.type = 1
			AttackUnitPOD.val = v.cid
		end

		AttackUnitPOD.pos = k

		if not v.isHelpHeroData then
			AttackUnitPOD.pid = PlayerModule.PlayerInfo.baseInfo.pid
			AttackUnitPOD.serverId = PlayerModule.PlayerInfo.baseInfo.serverId
		else
			AttackUnitPOD.pid = v.pid
			AttackUnitPOD.serverId = v.serverId
		end

		table.insert(List, AttackUnitPOD)
	end

	return List
end

function FormationModule.GetChapterConfigByType(chapterType, stageId, storyBattleId)
	local config

	if chapterType == Constant.ChapterPassType.TYPE_MAINLINE then
		config = CfgStoryBattleTable[storyBattleId]
	elseif chapterType == Constant.ChapterPassType.TYPE_RESOURCES then
		config = CfgDailyDupStageTable[stageId]
	elseif chapterType == Constant.ChapterPassType.TYPE_EQUIP then
		config = CfgEquipDupStageTable[stageId]
	elseif chapterType == Constant.ChapterPassType.TYPE_BOSS or chapterType == Constant.ChapterPassType.Type_GhostBoss then
		config = CfgBossStageTable[stageId]
	elseif chapterType == Constant.ChapterPassType.TYPE_CLIMB_TOWER then
		config = CfgTowerStageTable[stageId]
	elseif chapterType == Constant.ChapterPassType.TYPE_RANDOMDAILY then
		config = CfgDailyStageTable[stageId]
	elseif chapterType == Constant.ChapterPassType.TYPE_Favor then
		config = CfgWorldMapItemTable[stageId]
	elseif chapterType == Constant.ChapterPassType.TYPE_BattleActivity then
		config = CfgUtil.GetCfgActivityStageDataWithID(stageId)
	elseif chapterType == Constant.ChapterPassType.TYPE_Challenge or chapterType == Constant.ChapterPassType.TYPE_SummerActivity or chapterType == Constant.ChapterPassType.TYPE_Ghost then
		local cfgWorldMapItem = CfgUtil.GetCfgWorldMapItemDataWithID(stageId)
		local showStoryBattleID = TryToNumber(cfgWorldMapItem.ShowStoryBattleID, 0)

		if showStoryBattleID > 0 then
			config = CfgUtil.GetCfgStoryBattleDataWithID(cfgWorldMapItem.ShowStoryBattleID)
		end
	elseif chapterType == Constant.ChapterPassType.TYPE_Maze then
		config = CfgStoryBattleTable[storyBattleId]
	elseif chapterType == Constant.ChapterPassType.Type_ChallengeWorldBoss then
		config = CfgWorldBossStageTable[stageId]
		config.PlayerTeam = 1
	elseif chapterType == Constant.ChapterPassType.Type_RPGHunt then
		config = CfgCrusadeDupStageTable[stageId]
		config.PlayerTeam = 1
	end

	return config
end

function FormationModule.GetCurFormationIsHasHelpHero()
	for k, v in pairs(FormationModule.CurFormationDataList) do
		if v.isHelpHeroData then
			return true, k
		end
	end

	return false, -1
end

function FormationModule.ChangeFormationName(cid, name)
	net_formation.changeFormationName(cid, name)
end

function FormationModule.SaveFormation(cid, formationHeros, helpHeros, attackOrder, agentSkill)
	local heroPositionList = {}

	for position, heroCid in pairs(formationHeros) do
		table.insert(heroPositionList, {
			heroCid = heroCid,
			position = position,
			order = attackOrder[heroCid]
		})
	end

	table.sort(heroPositionList, function(a, b)
		if a.order ~= nil and b.order ~= nil then
			return a.order < b.order
		elseif a.order == nil and b.order ~= nil then
			return false
		elseif a.order ~= nil and b.order == nil then
			return true
		else
			return a.position < b.position
		end
	end)

	attackOrder = {}

	for order, heroPosition in pairs(heroPositionList) do
		attackOrder[heroPosition.heroCid] = order
	end

	for position, heroCid in pairs(formationHeros) do
		if FormationModule.GetAllAttackOrderDict()[heroCid] == nil then
			FormationModule.AddAllFightOrder(heroCid)
		end
	end

	for position, heroData in pairs(helpHeros) do
		if FormationModule.GetAllAttackOrderDict()[heroData.cid] == nil then
			FormationModule.AddAllFightOrder(heroData.cid)
		end
	end

	local allHeroCids = {}

	for position, heroCid in pairs(formationHeros) do
		table.insert(allHeroCids, heroCid)
	end

	for position, heroData in pairs(helpHeros) do
		table.insert(allHeroCids, heroData.cid)
	end

	for heroCid, _ in pairs(FormationModule.GetAllAttackOrderDict()) do
		if not FormationModule.ContainsHero(allHeroCids, heroCid) then
			FormationModule.RemoveFightOrder(heroCid)
		end
	end

	if agentSkill == nil or getTableLength(agentSkill) == 0 then
		agentSkill = {}
	end

	if FormationModule.FormationTypeIsMaze then
		local mazeFormationPod = MazeModule.GetCurStagePOD().formationPOD
		local formationPod = {
			cid = cid,
			name = mazeFormationPod.name,
			sync = mazeFormationPod.sync,
			heros = formationHeros,
			helpHeros = {},
			presetHcid = mazeFormationPod.presetHcid,
			attackOrder = attackOrder,
			agentSkill = agentSkill
		}

		MazeModule.OnChangeFormationPOD(formationPod)
	else
		net_formation.saveFormation(cid, formationHeros, attackOrder, agentSkill)
	end
end

function FormationModule.ContainsHero(list, heroCid)
	for i, cid in pairs(list) do
		if cid == heroCid then
			return true
		end
	end

	return false
end

function FormationModule.ChooseHelpHero(cid, pos, heroPod)
	net_formation.chooseHelpHero(cid, pos, heroPod)
end

function FormationModule.ClearHelpHero(cid)
	net_formation.clearHelpHero(cid)
end

function FormationModule.PresetFormation(cid, heros, isQuick)
	net_formation.presetFormation(cid, heros, isQuick)
end

function FormationModule.CanclePresetFormation(cid, presetPos)
	net_formation.canclePresetFormation(cid, presetPos)
end

function FormationModule.GetFormation(cid)
	FormationModule.FormationDataList[cid].helpHeros = {}

	net_formation.getFormation(cid)
end

function FormationModule.SyncFormation(cid, isSync)
	net_formation.syncPresetFormation(cid, isSync)
end

function FormationModule.ChangeFormationNameResult(name)
	EventDispatcher.Dispatch(EventID.FormationChangeNameEvent, name)
end

function FormationModule.SaveFormationResult()
	EventDispatcher.Dispatch(EventID.GoIntoBattleSuccessEvent)
end

function FormationModule.NotifyFormationUpdate(formationPod)
	FormationModule.FormationDataList[formationPod.cid] = formationPod

	EventDispatcher.Dispatch(EventID.NotifyFormationDataChangeEvent)
end

function FormationModule.ChooseHelpHeroResult(formationPod)
	EventDispatcher.Dispatch(EventID.GoIntoBattleSuccessEvent)
	EventDispatcher.Dispatch(EventID.HelpHeroGoIntoEvent)
end

function FormationModule.ClearHelpHeroResult(formationPod)
	EventDispatcher.Dispatch(EventID.GoIntoBattleSuccessEvent)
	EventDispatcher.Dispatch(EventID.HelpHeroGoDownEvent)
end

function FormationModule.PresetFormationResult()
	return
end

function FormationModule.CanclePresetFormationResult()
	return
end

function FormationModule.GetFormationResult()
	EventDispatcher.Dispatch(EventID.GetFormationSuccessEvent)
end

function FormationModule.SyncPresetFormationResult(cid, isSync)
	return
end

function FormationModule.GetFormationAttackOrder(attackOrderList)
	local attackOrder = attackOrderList

	if attackOrder == nil or getTableLength(attackOrder) == 0 then
		attackOrder = FormationModule.GetDefaultAttackOrder()
	end

	return attackOrder
end

function FormationModule.GetDefaultAttackOrder()
	local attackOrder = {}
	local order = 1
	local position2warlockData = FormationModule.CurFormationDataList

	for _, warlockData in pairs(position2warlockData) do
		attackOrder[warlockData.cid] = order
		order = order + 1
	end

	return attackOrder
end

function FormationModule.GetAgentSkill()
	if FormationModule.FormationTypeIsMaze then
		return MazeModule.GetCurStagePOD().formationPOD.agentSkill
	end

	return FormationModule.FormationDataList[FormationModule.TeamIndex].agentSkill
end

function FormationModule.IsAgentSkillCharged(id)
	return FormationModule.FormationDataList[FormationModule.TeamIndex].agentSkill[id] ~= nil
end

FormationModule.AllAttackOrder = {}

function FormationModule.InitAllFightOrder()
	local attackOrder = {}

	if FormationModule.FormationTypeIsMaze then
		attackOrder = MazeModule.GetCurStagePOD().formationPOD.attackOrder
	else
		attackOrder = FormationModule.FormationDataList[FormationModule.TeamIndex].attackOrder
	end

	FormationModule.AllAttackOrder = FormationModule.GetFormationAttackOrder(attackOrder)
end

function FormationModule.GetAllAttackOrderDict()
	return FormationModule.AllAttackOrder
end

function FormationModule.GetAllAttackOrderList()
	local allAttackOrder = {}

	for heroCid, order in pairs(FormationModule.AllAttackOrder) do
		table.insert(allAttackOrder, {
			heroCid = heroCid,
			order = order
		})
	end

	table.sort(allAttackOrder, function(a, b)
		return a.order < b.order
	end)

	local attackOrderList = {}

	for i, heroData in pairs(allAttackOrder) do
		table.insert(attackOrderList, {
			heroCid = heroData.heroCid
		})
	end

	return attackOrderList
end

function FormationModule.SetAllAttackOrderList(allAttackOrderList)
	local attackOrderDict = {}

	for order, heroData in pairs(allAttackOrderList) do
		attackOrderDict[heroData.heroCid] = order
	end

	FormationModule.AllAttackOrder = attackOrderDict
end

function FormationModule.RemoveFightOrder(heroCid)
	FormationModule.AllAttackOrder[heroCid] = nil

	local allAttackOrderDict = {}
	local allAttackOrderList = FormationModule.GetAllAttackOrderList()

	for order, heroData in pairs(allAttackOrderList) do
		allAttackOrderDict[heroData.heroCid] = order
	end

	FormationModule.AllAttackOrder = allAttackOrderDict
end

function FormationModule.AddAllFightOrder(heroCid)
	local order = getTableLength(FormationModule.AllAttackOrder) + 1

	FormationModule.AllAttackOrder[heroCid] = order
end

function FormationModule:GetChargedAgentSkillDataList()
	local type = 0

	if FormationModule.FormationInTheMaze or FormationModule.FormationTypeIsMaze then
		type = 1
	elseif FormationModule.ChapterType == Constant.ChapterPassType.TYPE_RESOURCES then
		type = CfgMonsterTeamTable[FormationModule.CfgDupStageOrStoryBattleCfg.MonsterTeam[1][1]].Type
	else
		type = CfgMonsterTeamTable[FormationModule.CfgDupStageOrStoryBattleCfg.MonsterTeam[1]].Type
	end

	local chargedAgentSkillDataList = {}

	for id, index in pairs(FormationModule.GetAgentSkill()) do
		local skillData = Clone(WarehouseModule.FindItem(id).skillData)

		if type == 1 then
			skillData.skillCid = skillData:GetCfg().SubSkills[1]
		elseif type == 2 then
			skillData.skillCid = skillData:GetCfg().SubSkills[2]
		end

		chargedAgentSkillDataList[index], _ = skillData
	end

	return chargedAgentSkillDataList
end

function FormationModule.InitLocalRedDotData()
	FormationModule.heroNewRecord = {}
end

function FormationModule.ClickFormationHeroHeadInitRedDot(heroCid)
	if table.indexOf(FormationModule.heroNewRecord, heroCid) == -1 then
		table.insert(FormationModule.heroNewRecord, heroCid)
	end
end

function FormationModule.IsNewRole(heroCid)
	return false
end

function FormationModule.ChangeAllNewTag()
	return
end

function FormationModule.ChangeIsNewTag(heroCid, isNew)
	return
end

function FormationModule.InitAboutMazeData()
	FormationModule.FormationInTheMaze = MazeModule.InTheMaze
end

function FormationModule.GetHeroDataList()
	if FormationModule.FormationTypeIsMaze then
		local heroPODList = MazeModule.GetCurStagePOD().heros
		local heroDataList = {}

		for k, v in pairs(heroPODList) do
			local WarlockData = WarlockData.New()

			WarlockData:Initialize(v)

			heroDataList[v.cid] = WarlockData
		end

		return heroDataList
	else
		return WarlockModule.WarlockDataDic
	end
end
