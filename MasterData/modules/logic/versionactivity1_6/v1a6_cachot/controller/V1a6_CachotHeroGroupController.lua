-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/controller/V1a6_CachotHeroGroupController.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotHeroGroupController", package.seeall)

local V1a6_CachotHeroGroupController = class("V1a6_CachotHeroGroupController", BaseController)

function V1a6_CachotHeroGroupController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
end

function V1a6_CachotHeroGroupController:reInit()
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
end

function V1a6_CachotHeroGroupController:_onGetInfoFinish()
	HeroGroupModel.instance:setParam()
end

function V1a6_CachotHeroGroupController:openGroupFightView(battleId, episodeId, adventure)
	self._groupFightName = self:_getGroupFightViewName(episodeId)

	V1a6_CachotHeroGroupModel.instance:clear()
	V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(V1a6_CachotEnum.HeroCountInGroup)
	V1a6_CachotHeroGroupModel.instance:onGetHeroGroupList(V1a6_CachotModel.instance:getTeamInfo():getGroupInfos())
	V1a6_CachotHeroGroupModel.instance:setReplayParam(nil)
	V1a6_CachotHeroGroupModel.instance:setParam(battleId, episodeId, adventure)
	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(battleId, episodeId, adventure)
	ViewMgr.instance:openView(self._groupFightName)

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if rogueInfo then
		V1a6_CachotController.instance.heartNum = rogueInfo.heart
	end
end

function V1a6_CachotHeroGroupController:_getGroupFightViewName(episodeId)
	return ViewName.V1a6_CachotHeroGroupFightView
end

function V1a6_CachotHeroGroupController:changeToDefaultEquip()
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

function V1a6_CachotHeroGroupController:_checkEquipInBehindEquip(startIndex, equipUid, equipMoList)
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

function V1a6_CachotHeroGroupController:_checkEquipInPreviousEquip(endIndex, equipUid, equipMoList)
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

function V1a6_CachotHeroGroupController:_onGetFightRecordGroupReply(fightGroupMO)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
	HeroGroupModel.instance:setReplayParam(fightGroupMO)
	ViewMgr.instance:openView(self._groupFightName)
end

function V1a6_CachotHeroGroupController:onReceiveHeroGroupSnapshot(msg)
	return
end

function V1a6_CachotHeroGroupController.removeEquip(teamPos, dontSend)
	if HeroSingleGroupModel.instance:isTemp() or dontSend then
		local _, index, equips = EquipTeamListModel.instance:_getRequestData(teamPos, "0")
		local equipTable = {}

		equipTable.index = index
		equipTable.equipUid = equips

		V1a6_CachotHeroGroupModel.instance:replaceEquips(equipTable, EquipTeamListModel.instance:getCurGroupMo())

		if not dontSend then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, index)
		end
	else
		V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()
	end
end

function V1a6_CachotHeroGroupController.replaceEquip(teamPos, equipUid, dontSend)
	if HeroSingleGroupModel.instance:isTemp() or dontSend then
		local _, index, equips = EquipTeamListModel.instance:_getRequestData(teamPos, equipUid)
		local equipTable = {}

		equipTable.index = index
		equipTable.equipUid = equips

		V1a6_CachotHeroGroupModel.instance:replaceEquips(equipTable, EquipTeamListModel.instance:getCurGroupMo())

		if not dontSend then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, index)
		end
	else
		V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()
	end
end

function V1a6_CachotHeroGroupController:getFightFocusEquipInfo(param)
	local posIndex = param.posIndex
	local equipMO = param.equipMO
	local seatLevel = V1a6_CachotTeamModel.instance:getSeatLevel(posIndex)

	if not seatLevel then
		return equipMO
	end

	local level = V1a6_CachotTeamModel.instance:getEquipMaxLevel(equipMO, seatLevel)

	if level == equipMO.level then
		return equipMO
	end

	local newEquipMo = EquipMO.New()

	newEquipMo:initByConfig(nil, equipMO.equipId, level, equipMO.refineLv)

	return newEquipMo
end

function V1a6_CachotHeroGroupController:getCharacterTipEquipInfo(param)
	local seatLevel = param.seatLevel
	local equipMO = param.equipMO
	local level = V1a6_CachotTeamModel.instance:getEquipMaxLevel(equipMO, seatLevel)

	if level == equipMO.level then
		return equipMO
	end

	local newEquipMo = EquipMO.New()

	newEquipMo:initByConfig(nil, equipMO.equipId, level, equipMO.refineLv)

	return newEquipMo
end

V1a6_CachotHeroGroupController.instance = V1a6_CachotHeroGroupController.New()

return V1a6_CachotHeroGroupController
