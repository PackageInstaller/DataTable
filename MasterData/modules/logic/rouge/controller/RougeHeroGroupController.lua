-- chunkname: @modules/logic/rouge/controller/RougeHeroGroupController.lua

module("modules.logic.rouge.controller.RougeHeroGroupController", package.seeall)

local RougeHeroGroupController = class("RougeHeroGroupController", BaseController)

function RougeHeroGroupController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
end

function RougeHeroGroupController:reInit()
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
end

function RougeHeroGroupController:_onGetInfoFinish()
	return
end

function RougeHeroGroupController:openGroupFightView(battleId, episodeId, adventure)
	self._groupFightName = self:_getGroupFightViewName(episodeId)

	RougeTeamListModel.addAssistHook()
	RougeHeroGroupModel.instance:clear()
	RougeHeroSingleGroupModel.instance:setMaxHeroCount(RougeEnum.FightTeamHeroNum)
	RougeHeroGroupModel.instance:onGetHeroGroupList(RougeModel.instance:getTeamInfo():getGroupInfos())
	RougeHeroGroupModel.instance:setReplayParam(nil)
	RougeHeroGroupModel.instance:setParam(battleId, episodeId, adventure)
	HeroGroupModel.instance:setReplayParam(nil)

	HeroGroupModel.instance.battleId = battleId
	HeroGroupModel.instance.episodeId = episodeId
	HeroGroupModel.instance.adventure = adventure

	local hasUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.star == DungeonEnum.StarType.Advanced and userDungeonMO.hasRecord
	local pass_model_record = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if hasUnlock and hasRecord and not string.nilorempty(pass_model_record) then
		pass_model_record = cjson.decode(pass_model_record)

		if pass_model_record[tostring(episodeId)] then
			FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
			FightRpc.instance:sendGetFightRecordGroupRequest(episodeId)

			return
		end
	end

	local currentGroupMo = HeroGroupModel.instance:getCurGroupMO()

	if self:changeToDefaultEquip() and not currentGroupMo.temp then
		HeroGroupModel.instance:saveCurGroupData(function()
			ViewMgr.instance:openView(self._groupFightName)
		end)

		return
	end

	if HeroGroupModel.instance.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		currentGroupMo:saveData()
	end

	ViewMgr.instance:openView(self._groupFightName)
end

function RougeHeroGroupController:_getGroupFightViewName(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig then
		::label_6_0::

		local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

		if chapterConfig then
			if chapterConfig.actId == VersionActivity1_2Enum.ActivityId.Dungeon then
				return ViewName.VersionActivity_1_2_HeroGroupView
			end

			if chapterConfig.type == DungeonEnum.ChapterType.RoleStoryChallenge then
				return ViewName.RoleStoryHeroGroupFightView
			end
		end

		return ViewName.RougeHeroGroupFightView
	end
end

function RougeHeroGroupController:changeToDefaultEquip()
	local groupMo = HeroGroupModel.instance:getCurGroupMO()
	local equipMoList = groupMo.equips
	local heroUidList = groupMo.heroList
	local heroMo, equipIndex
	local changed = false

	for index, heroUid in ipairs(heroUidList) do
		heroMo = HeroModel.instance:getById(heroUid)
		equipIndex = index - 1

		if heroMo and heroMo:hasDefaultEquip() and heroMo.defaultEquipUid ~= equipMoList[equipIndex].equipUid[1] then
			local preFindIndex = self:_checkEquipInPreviousEquip(equipIndex - 1, heroMo.defaultEquipUid, equipMoList)

			if equipIndex <= preFindIndex then
				local findIndex = self:_checkEquipInBehindEquip(equipIndex + 1, heroMo.defaultEquipUid, equipMoList)

				if findIndex > 0 then
					equipMoList[findIndex].equipUid[1] = equipMoList[equipIndex].equipUid[1]
				end

				equipMoList[equipIndex].equipUid[1] = heroMo.defaultEquipUid
			elseif equipMoList[equipIndex].equipUid[1] == heroMo.defaultEquipUid then
				equipMoList[equipIndex].equipUid[1] = "0"
			end

			changed = true
		end
	end

	return changed
end

function RougeHeroGroupController:_checkEquipInBehindEquip(startIndex, equipUid, equipMoList)
	if not EquipModel.instance:getEquip(equipUid) then
		return -1
	end

	for i = startIndex, #equipMoList do
		if equipUid == equipMoList[i].equipUid[1] then
			return i
		end
	end

	return -1
end

function RougeHeroGroupController:_checkEquipInPreviousEquip(endIndex, equipUid, equipMoList)
	if not EquipModel.instance:getEquip(equipUid) then
		return endIndex + 1
	end

	for i = endIndex, 0, -1 do
		if equipUid == equipMoList[i].equipUid[1] then
			return i
		end
	end

	return endIndex + 1
end

function RougeHeroGroupController:_onGetFightRecordGroupReply(fightGroupMO)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
	HeroGroupModel.instance:setReplayParam(fightGroupMO)
	ViewMgr.instance:openView(self._groupFightName)
end

function RougeHeroGroupController:onReceiveHeroGroupSnapshot(msg)
	return
end

function RougeHeroGroupController:setFightHeroSingleGroup()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return false
	end

	local curGroupMO = RougeHeroGroupModel.instance:getCurGroupMO()

	if not curGroupMO then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local teamInfo = RougeModel.instance:getTeamInfo()
	local main, mainCount = curGroupMO:getMainList()
	local sub, subCount = curGroupMO:getSubList()
	local alreadyList = RougeHeroSingleGroupModel.instance:getList()
	local equips, equipMiss = curGroupMO:getAllHeroEquips()

	for i = 1, #main do
		if main[i] ~= alreadyList[i].heroUid then
			main[i] = "0"
			mainCount = mainCount - 1

			if equips[i] then
				equips[i].heroUid = "0"
			end
		end
	end

	for i = #main + 1, math.min(#main + #sub, #alreadyList) do
		if sub[i - #main] ~= alreadyList[i].heroUid then
			sub[i - #main] = "0"
			subCount = subCount - 1

			if equips[i] then
				equips[i].heroUid = "0"
			end
		end
	end

	for i, v in ipairs(alreadyList) do
		local assistHeroMo = teamInfo:getAssistHeroMoByUid(v.heroUid)

		if assistHeroMo then
			fightParam:setAssistHeroInfo(v.heroUid)

			break
		end
	end

	for i, v in ipairs(equips) do
		if i > RougeEnum.FightTeamNormalHeroNum then
			rawset(equips, i, nil)
		end
	end

	if (not curGroupMO.aidDict or #curGroupMO.aidDict <= 0) and mainCount + subCount == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local seasonEquips = Season123Controller.isEpisodeFromSeason123(fightParam.episodeId) and Season123HeroGroupUtils.getAllHeroActivity123Equips(curGroupMO) or curGroupMO:getAllHeroActivity104Equips()
	local battleId = fightParam.battleId
	local battleConfig = battleId and lua_battle.configDict[battleId]

	if battleConfig and battleConfig.noClothSkill == 0 then
		if not curGroupMO.clothId then
			local clothId = 0
			local extraList = teamInfo:getSupportSkillStrList()

			fightParam:setMySide(clothId, main, sub, equips, seasonEquips, nil, extraList)

			if equipMiss then
				RougeHeroGroupModel.instance:rougeSaveCurGroup()
			end

			return true
		end
	end
end

function RougeHeroGroupController.removeEquip(teamPos, dontSend)
	if HeroSingleGroupModel.instance:isTemp() or dontSend then
		local _, index, equips = EquipTeamListModel.instance:_getRequestData(teamPos, "0")
		local equipTable = {}

		equipTable.index = index
		equipTable.equipUid = equips

		HeroGroupModel.instance:replaceEquips(equipTable, EquipTeamListModel.instance:getCurGroupMo())

		if not dontSend then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, index)
		end
	else
		RougeHeroGroupModel.instance:rougeSaveCurGroup()
	end
end

function RougeHeroGroupController.replaceEquip(teamPos, equipUid, dontSend)
	if HeroSingleGroupModel.instance:isTemp() or dontSend then
		local _, index, equips = EquipTeamListModel.instance:_getRequestData(teamPos, equipUid)
		local equipTable = {}

		equipTable.index = index
		equipTable.equipUid = equips

		HeroGroupModel.instance:replaceEquips(equipTable, EquipTeamListModel.instance:getCurGroupMo())

		if not dontSend then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, index)
		end
	else
		RougeHeroGroupModel.instance:rougeSaveCurGroup()
	end
end

RougeHeroGroupController.instance = RougeHeroGroupController.New()

return RougeHeroGroupController
