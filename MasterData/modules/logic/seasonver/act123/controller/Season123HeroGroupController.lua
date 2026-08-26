-- chunkname: @modules/logic/seasonver/act123/controller/Season123HeroGroupController.lua

module("modules.logic.seasonver.act123.controller.Season123HeroGroupController", package.seeall)

local Season123HeroGroupController = class("Season123HeroGroupController", BaseController)

function Season123HeroGroupController:onOpenView(actId, layer, episodeId, stage)
	Season123Controller.instance:registerCallback(Season123Event.HeroGroupIndexChanged, self.handleHeroGroupIndexChanged, self)
	FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, self.handleGetFightRecordGroupReply, self)

	local battleContext = Season123Model.instance:getBattleContext()

	if battleContext then
		local episodeCO = DungeonConfig.instance:getEpisodeCO(battleContext.episodeId)

		if episodeCO then
			HeroGroupTrialModel.instance:setTrialByBattleId(episodeCO.battleId)
		end
	end

	CharacterModel.instance:setAppendHeroMOs(nil)
	Season123HeroGroupModel.instance:init(actId, layer, episodeId, stage)
	Season123HeroGroupEditModel.instance:init(actId, layer, episodeId, stage)
	Season123HeroGroupQuickEditModel.instance:init(actId, layer, episodeId, stage)
end

function Season123HeroGroupController:onCloseView()
	Season123Controller.instance:unregisterCallback(Season123Event.HeroGroupIndexChanged, self.handleHeroGroupIndexChanged, self)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self.handleGetFightRecordGroupReply, self)
	self:saveCurrentHeroGroup()
	CharacterModel.instance:setAppendHeroMOs(nil)
end

function Season123HeroGroupController:checkSeason123HeroGroup()
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local actId, stage, layer = Season123HeroGroupModel.instance.activityId, Season123HeroGroupModel.instance.stage, Season123HeroGroupModel.instance.layer

		Season123HeroGroupController.checkHeroGroupAvailable(actId, stage, layer)
	end
end

function Season123HeroGroupController:changeReplayMode2Manual()
	HeroGroupModel.instance:setParam(HeroGroupModel.instance.battleId, HeroGroupModel.instance.episodeId, HeroGroupModel.instance.adventure)

	local heroGroupId = HeroGroupModel.instance:getCurGroupMO().id

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, heroGroupId)

	local actId, stage, layer = Season123HeroGroupModel.instance.activityId, Season123HeroGroupModel.instance.stage, Season123HeroGroupModel.instance.layer

	Season123HeroGroupController.instance:checkSeason123HeroGroup(actId, stage, layer)
end

function Season123HeroGroupController:switchHeroGroup(groupIndex)
	self:saveCurrentHeroGroup()

	local actId = Season123HeroGroupModel.instance.activityId

	Activity123Rpc.instance:sendAct123ChangeFightGroupRequest(actId, groupIndex)
end

function Season123HeroGroupController:saveCurrentHeroGroup()
	local actId = Season123HeroGroupModel.instance.activityId

	if not actId then
		return
	end

	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	Season123HeroGroupController.saveHeroGroup(actId, seasonMO.heroGroupSnapshotSubId)
end

function Season123HeroGroupController.saveHeroGroup(actId, groupIndex)
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if not heroGroupMO then
		return
	end

	Season123HeroGroupController.instance:syncHeroGroup(heroGroupMO, seasonMO.heroGroupSnapshotSubId, actId)
end

function Season123HeroGroupController:openHeroGroupView(battleId, episodeId)
	local context = Season123Model.instance:getBattleContext()

	if not context then
		return
	end

	self:initHeroGroupModel(context.actId, context.stage, context.layer, battleId, episodeId)

	local hasUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.star == DungeonEnum.StarType.Advanced and userDungeonMO.hasRecord
	local pass_model_record = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if hasUnlock and hasRecord and not string.nilorempty(pass_model_record) then
		pass_model_record = cjson.decode(pass_model_record)

		if pass_model_record[tostring(episodeId)] then
			FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, self.handleGetFightRecordGroupReply, self)
			FightRpc.instance:sendGetFightRecordGroupRequest(episodeId)

			return
		end
	end

	Season123Controller.instance:openHeroGroupFightView({
		actId = context.actId,
		layer = context.layer,
		episodeId = context.episodeId,
		stage = context.stage
	})
end

function Season123HeroGroupController:initHeroGroupModel(actId, stage, layer, battleId, episodeId)
	Season123HeroGroupModel.instance:init(actId, layer, episodeId, stage)
	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(battleId, episodeId)
end

function Season123HeroGroupController:handleGetFightRecordGroupReply(fightGroupMO)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self.handleGetFightRecordGroupReply, self)
	HeroGroupModel.instance:setReplayParam(fightGroupMO)

	local context = Season123Model.instance:getBattleContext()

	if context then
		Season123Controller.instance:openHeroGroupFightView({
			actId = context.actId,
			layer = context.layer,
			episodeId = context.episodeId,
			stage = context.stage
		})
	end
end

function Season123HeroGroupController.changeEquipFromSelect(groupId, index, equipUid)
	local equipInfo = {
		index = index,
		equipUid = {}
	}

	for i, v in ipairs(equipUid) do
		table.insert(equipInfo.equipUid, v)
	end

	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()

	heroGroupMO.equips[index].equipUid = equipUid

	heroGroupMO:updatePosEquips(equipInfo)
	Season123HeroGroupController.instance:syncHeroGroup(heroGroupMO, groupId)
end

function Season123HeroGroupController.checkUnloadHero(actId, stage, layer, removeNow)
	do return false end

	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if not heroGroupMO.heroList then
		return
	end

	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local isDirty = false
	local unloadHeroUidDict

	for pos, heroUid in ipairs(heroGroupMO.heroList) do
		if heroUid ~= Activity123Enum.EmptyUid then
			local seasonHeroMO = Season123Model.instance:getSeasonHeroMO(actId, stage, layer, heroUid)

			if seasonHeroMO == nil or seasonHeroMO.hpRate == nil or seasonHeroMO.hpRate <= 0 then
				if removeNow then
					heroGroupMO.heroList[pos] = Activity123Enum.EmptyUid
				end

				unloadHeroUidDict = unloadHeroUidDict or {}
				unloadHeroUidDict[heroUid] = true
				isDirty = true
			end
		end
	end

	return isDirty, unloadHeroUidDict
end

function Season123HeroGroupController.checkUnlockLockPos(actId, stage, layer)
	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local curUnlockIndexSet = Season123HeroGroupUtils.getUnlockSlotSet(actId)
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return false
	end

	local stageMO = seasonMO:getStageMO(stage)

	if not stageMO then
		return false
	end

	local isDirty = false
	local unloadIndexList

	for i, equips in pairs(heroGroupMO.activity104Equips) do
		if equips.equipUid then
			for slot, equipUid in pairs(equips.equipUid) do
				local equipIndex = Season123Model.instance:getUnlockCardIndex(equips.index, slot)

				if not curUnlockIndexSet[equipIndex] and not string.nilorempty(equipUid) and equipUid ~= Activity123Enum.EmptyUid then
					equips.equipUid[slot] = Activity123Enum.EmptyUid
					unloadIndexList = unloadIndexList or {}

					table.insert(unloadIndexList, equipIndex)

					isDirty = true
				end
			end
		end
	end

	return isDirty
end

function Season123HeroGroupController.checkHeroGroupAvailable(actId, stage, layer)
	local clothFix = Season123HeroGroupController.checkEquipClothSkill()
	local unloadRole = Season123HeroGroupController.checkUnloadHero(actId, stage, layer, true)
	local unloadSeasonCard = Season123HeroGroupController.checkUnlockLockPos(actId, stage, layer)

	if unloadRole or unloadSeasonCard or clothFix then
		local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
		local seasonMO = Season123Model.instance:getActInfo(actId)

		if not seasonMO or not heroGroupMO then
			return
		end

		logNormal(string.format("season heroGroupId = [%s] role need unload.", seasonMO.heroGroupSnapshotSubId))
		Season123HeroGroupController.instance:syncHeroGroup(heroGroupMO, seasonMO.heroGroupSnapshotSubId, actId)
	end
end

function Season123HeroGroupController:syncHeroGroup(heroGroupMO, groupIndex, actId)
	Season123HeroGroupModel.instance.lastSyncGroupActId = actId or Season123HeroGroupModel.instance.activityId

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if curGroupMO == heroGroupMO then
		HeroSingleGroupModel.instance:setSingleGroup(curGroupMO, true)
	end

	local extraData = {}

	extraData.groupIndex = groupIndex
	extraData.heroGroup = heroGroupMO

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season123, DungeonModel.instance.curSendEpisodeId, true, extraData)
	elseif Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season123Retail, DungeonModel.instance.curSendEpisodeId, true, extraData)
	end
end

function Season123HeroGroupController:handleHeroGroupIndexChanged()
	local actId, stage, layer = Season123HeroGroupModel.instance.activityId, Season123HeroGroupModel.instance.stage, Season123HeroGroupModel.instance.layer

	self:checkSeason123HeroGroup()

	local seasonMO = Season123Model.instance:getActInfo(actId)

	if seasonMO and HeroGroupModel.instance:getCurGroupMO() == seasonMO:getCurHeroGroup() then
		HeroGroupModel.instance:setCurGroupId(HeroGroupModel.instance:getCurGroupId())
	end
end

function Season123HeroGroupController:sendStartAct123Battle(chapterId, episodeId, fightParam, multiplication, endAdventure, useRecord, isRestart, callback, callbackObj)
	local actId = Season123HeroGroupModel.instance.activityId

	Activity123Rpc.instance:sendStartAct123BattleRequest(actId, (Season123HeroGroupModel.instance:isEpisodeSeason123Retail() or nil) and -1, chapterId, episodeId, fightParam, multiplication, endAdventure, useRecord, isRestart, callback, callbackObj)
end

function Season123HeroGroupController:replaceHeroesDefaultEquip(heroUids)
	local actId = Season123HeroGroupModel.instance.activityId
	local heroGroupMo = HeroGroupModel.instance:getCurGroupMO()
	local heroGroupEquipMoList = heroGroupMo.equips
	local heroMo

	for index, heroUid in ipairs(heroUids) do
		heroMo = Season123HeroUtils.getHeroMO(actId, heroUid, Season123HeroGroupModel.instance.stage)

		if heroMo and heroMo:hasDefaultEquip() then
			for _, heroGroupEquipMo in pairs(heroGroupEquipMoList) do
				if heroGroupEquipMo.equipUid[1] == heroMo.defaultEquipUid then
					heroGroupEquipMo.equipUid[1] = "0"

					break
				end
			end

			heroGroupEquipMoList[index - 1].equipUid[1] = heroMo.defaultEquipUid
		end
	end
end

function Season123HeroGroupController:setMultiplication(times)
	local ticketNum = Season123HeroGroupModel.instance:getMultiplicationTicket()

	if times <= ticketNum then
		Season123HeroGroupModel.instance.multiplication = times

		Season123HeroGroupModel.instance:saveMultiplication()
	end
end

function Season123HeroGroupController.checkEquipClothSkill()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(curGroupMO.clothId) then
		return
	end

	local list = PlayerClothModel.instance:getList()

	for _, clothMO in ipairs(list) do
		if PlayerClothModel.instance:hasCloth(clothMO.id) then
			HeroGroupModel.instance:replaceCloth(clothMO.id)

			return true
		end
	end
end

function Season123HeroGroupController.processReplayGroupMO(heroGroupMO)
	if heroGroupMO.isReplay then
		local mainCards = heroGroupMO.replay_activity104Equip_data["-100000"]
		local heroGroup104Equip = heroGroupMO.activity104Equips[Activity123Enum.MainCharPos]

		if mainCards and heroGroup104Equip then
			for i = 1, #mainCards do
				heroGroup104Equip.equipUid[i] = mainCards[i].equipUid
			end
		end

		Season123HeroGroupUtils.formation104Equips(heroGroupMO)
	end
end

Season123HeroGroupController.instance = Season123HeroGroupController.New()

return Season123HeroGroupController
